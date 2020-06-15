/**
 * @discripe: 直播间弹幕
 */
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../base.dart';
import '../service.dart';
import 'player.dart';
import 'chat.dart';

class DyRoomPage extends StatefulWidget {
  final arguments;
  DyRoomPage({Key key, this.arguments}) : super(key: key);

  @override
  _DyRoomPageState createState() => _DyRoomPageState(arguments);
}

class _DyRoomPageState extends State<DyRoomPage> with DYBase {
  Timer timerCloseSVGA;

  final _routeProp;    // 首页路由跳转传递的参数
  _DyRoomPageState(this._routeProp);

  @override
  void initState() {
    super.initState();
    timerCloseSVGA = Timer(Duration(milliseconds: 7600), () {
      setState(() {
        timerCloseSVGA = null;
      });
    });
  }

  @override
  void dispose() {
    timerCloseSVGA?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: DYBase.designWidth);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: DYBase.statusBarHeight,
                  color: Color(0xff333333),
                ),
                PlayerWidgets(_routeProp),
                _nav(),
                ChatWidgets(),
                _bottom(),
              ],
            ),
            timerCloseSVGA != null ? Container(
              height: dp(400),
              child: SVGASimpleImage(
                resUrl: '${DYBase.baseUrl}/static/angel.svga'
              ),
            ) : SizedBox(),
          ],
        )
      ),
    );
  }

  Widget _nav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: dp(40),
          padding: EdgeInsets.only(top: dp(9)),
          width: dp(60),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: DYBase.defaultColor, width: dp(3))),
          ),
          child: Text(
            '弹幕',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: DYBase.defaultColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => DYdialog.alert(context, text: '正在建设中~'),
          child: Container(
            height: dp(40),
            padding: EdgeInsets.only(top: dp(9)),
            width: dp(60),
            child: Text(
              '主播',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottom() {
    return SizedBox(
      height: dp(50),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: dp(12), right: dp(12)),
              padding: EdgeInsets.only(left: dp(10), right: dp(10)),
              height: dp(36),
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.all(
                  Radius.circular(dp(8)),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextField(
                      cursorColor: DYBase.defaultColor,
                      cursorWidth: 1.5,
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                        hintText: '吐个槽呗~',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => DYdialog.alert(context, text: '正在建设中~'),
                    child: Container(
                      width: dp(40),
                      height: dp(26),
                      padding: EdgeInsets.only(top: dp(2)),
                      margin: EdgeInsets.only(left: dp(10)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(dp(4))),
                        gradient: LinearGradient(
                          begin: Alignment(-1.2, 0.0),
                          end: Alignment(0.2, 0.0),
                          colors: <Color>[
                            Color(0xffff4e00),
                            Color(0xffff8b00),
                          ],
                        ),
                      ),
                      child: Text(
                        '发送',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => DYdialog.alert(context, text: '正在建设中~'),
            child: Image.asset(
              'images/gift.png',
              height: dp(36),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: dp(12)))
        ],
      ),
    );
  }
}