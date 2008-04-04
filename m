Return-Path: <liuxs226@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 7A11FDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Apr 2008 12:55:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so845660anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Apr 2008 18:55:49 -0700 (PDT)
Message-ID: <e81b2fb40804031855i6a9db808y365066c858079113@mail.gmail.com>
Date: Fri, 4 Apr 2008 09:55:41 +0800
From: "=?GB2312?B?wfXQocur?=" <liuxs226@gmail.com>
To: directfb-dev@directfb.org, linuxppc <linuxppc-embedded@ozlabs.org>
Subject: has anyone written gfxdriver for graphic controller mb86296??
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6697_17268726.1207274149477"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_6697_17268726.1207274149477
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,all

has anyone written gfxdriver for graphic controller mb86296??  I have a
problem when I'm writing the gfxdriver that refered to gfxdriver for
sm501. I want to enable the gfxdriver drawing line and filling rectangle and
so on .After finishing the gfxdriver, I run a test program to see if the
gfxdriver could draw a line in the center of the screen and fill a black
rectangle as background, I find there is nothing in display screen where
there should be a line in the center of the screen. here is some part of my
gfxdriver code about line and rectangle:

//draw line with with given coordinate point and color
void de_line(int x1,int y1,int x2,int y2,int c)
{

 MB86290WriteFifo(4, (GDC_TYPE_SETCOLORREGISTER << 24) |
(GDC_CMD_BODY_FORE_COLOR << 16), c,
                         (GDC_TYPE_SETMODEREGISTER << 24) | (GDC_CMD_MDR1 <<
16), (2 << 7));

 long cmd2 = (GDC_TYPE_DRAWLINE2I << 24) | 1;

    MB86290WriteFifo(6, GDC_TYPE_DRAWLINE2I << 24, x1 << 16, y1 << 16,
                         cmd2, x2 << 16, y2 << 16);

}

// fill rectangle with given coordinate point and color

void de_fillrect(int x1,int y1,int x2,int y2,int c)
{
int DeltaX;
int DeltaY;

 // Determine delta X
 if (x2 < x1) {
  DeltaX = x1 - x2 + 1;
  x1 = x2;
 }
 else {
  DeltaX = x2 - x1 + 1;
 }

 // Determine delta Y
 if (y2 <y1) {
  DeltaY = y1 - y2 + 1;
  y1 = y2;
 }
 else {
  DeltaY = y2 - y1 + 1;
 }

 MB86290WriteFifo(2,(GDC_TYPE_SETCOLORREGISTER << 24) |
(GDC_CMD_BODY_FORE_COLOR << 16),c);
 MB86290WriteFifo(3,(GDC_TYPE_DRAWRECTP << 24) | (GDC_CMD_BLT_FILL <<
16),(y1 << 16)|x1,(DeltaY<<16)|DeltaX);

}

Thanks,

Xiaoshuang Liu

------=_Part_6697_17268726.1207274149477
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi,all</div>
<div>&nbsp;</div>
<div>has anyone written gfxdriver for graphic controller mb86296??&nbsp; I have a problem when I&#39;m writing the gfxdriver that refered to gfxdriver for sm501.&nbsp;I want to enable the gfxdriver drawing line and filling rectangle and so on .After finishing the gfxdriver, I run a&nbsp;test program to see if the gfxdriver could draw a line in the center of the screen and fill a black rectangle as background, I find there is nothing in display screen where there should&nbsp;be a line in&nbsp;the center of the screen. here is some part of my gfxdriver code about line and rectangle:</div>

<div>&nbsp;</div>
<div>//draw line with with given coordinate point and color</div>
<div>void&nbsp;de_line(int x1,int y1,int x2,int y2,int c)<br>{<br>&nbsp;&nbsp;<br>&nbsp;MB86290WriteFifo(4, (GDC_TYPE_SETCOLORREGISTER &lt;&lt; 24) | (GDC_CMD_BODY_FORE_COLOR &lt;&lt; 16), c,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (GDC_TYPE_SETMODEREGISTER &lt;&lt; 24) | (GDC_CMD_MDR1 &lt;&lt; 16), (2 &lt;&lt; 7));<br>
&nbsp;<br>&nbsp;long cmd2 = (GDC_TYPE_DRAWLINE2I &lt;&lt; 24) | 1;</div>
<div>
<p>&nbsp;&nbsp;&nbsp; MB86290WriteFifo(6, GDC_TYPE_DRAWLINE2I &lt;&lt; 24, x1 &lt;&lt; 16, y1 &lt;&lt; 16,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd2, x2 &lt;&lt; 16, y2 &lt;&lt; 16);<br>&nbsp;&nbsp;<br>}</p>
<p>// fill rectangle with given coordinate point and color</p>
<p>void&nbsp;de_fillrect(int x1,int y1,int x2,int y2,int c)<br>{<br>int&nbsp;DeltaX;<br>int&nbsp;DeltaY;</p>
<p>&nbsp;// Determine delta X<br>&nbsp;if (x2 &lt; x1) {<br>&nbsp;&nbsp;DeltaX = x1 - x2 + 1;<br>&nbsp;&nbsp;x1 = x2;<br>&nbsp;}<br>&nbsp;else {<br>&nbsp;&nbsp;DeltaX = x2 - x1 + 1;<br>&nbsp;}</p>
<p>&nbsp;// Determine delta Y<br>&nbsp;if (y2 &lt;y1) {<br>&nbsp;&nbsp;DeltaY = y1 - y2 + 1;<br>&nbsp;&nbsp;y1 = y2;<br>&nbsp;}<br>&nbsp;else {<br>&nbsp;&nbsp;DeltaY = y2 - y1 + 1;<br>&nbsp;}</p>
<p>&nbsp;MB86290WriteFifo(2,(GDC_TYPE_SETCOLORREGISTER &lt;&lt; 24) | (GDC_CMD_BODY_FORE_COLOR &lt;&lt; 16),c);<br>&nbsp;MB86290WriteFifo(3,(GDC_TYPE_DRAWRECTP &lt;&lt; 24) | (GDC_CMD_BLT_FILL &lt;&lt; 16),(y1 &lt;&lt; 16)|x1,(DeltaY&lt;&lt;16)|DeltaX);<br>
<br>}</p>
<p>Thanks,</p>
<p>Xiaoshuang Liu<br></p><br>&nbsp;</div>

------=_Part_6697_17268726.1207274149477--
