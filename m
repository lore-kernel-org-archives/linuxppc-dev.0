Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 48D9567A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 00:25:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65D73.BDA4D082"
Subject: RTC/I2C problems
Date: Tue, 11 Apr 2006 10:25:10 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD42D958E@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65D73.BDA4D082
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We had a similar problem with our 8xx implementation. The problem was
decrementer underflow. In the kernel initialization, calibrate_decr()
was called before set_dec(), so the decrementer can count down through 0
before the decrementer exception gets enabled. To fix this, we moved the
call to set_dec() from time_init() to calibrate_decr() before the
exception is enabled in the tbcsr.

Ken Poole


>Hi everybody.

>I have a problem with my RTC, i work on a MEN A12 board with MPC8245
and=20
>when my kernel start it takes 8 min to run. I have find the problem but
i=20
>don't know how to solve it. In time.c the function time_init execute
the=20
>following lines :

>if (__USE_RTC()) {
>    /* 601 processor: dec counts down by 128 every 128ns */
>    tb_ticks_per_jiffy =3D DECREMENTER_COUNT_601;
>    /* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
>    tb_to_us =3D 0x0x418937;
>}  else {
>    ppc_md.calibrate_decr();
>    tb_to_ns_scale =3D mulhwu(tb_to_us, 1000 << 10);
>}

>this is the ppc_md.calibrate_decr() function that takes a lot of time
and i=20
>don't know how to solve the problem. USE_RTC is fixed at 0 for 6xx
config=20
>maybe it must be at 1 ? My RTC run with SMBus (I2C). I work with ELDK
4.0=20
>and linux 2.6.15.


------_=_NextPart_001_01C65D73.BDA4D082
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RTC/I2C problems</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">We had a similar problem with ou</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">r</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> 8xx implementation. =
The</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New"> problem was decrementer underflow.</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">In the kernel =
initialization, calibrate_decr() was called before set_dec(), so the =
decrementer</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> can count down through 0 before the decrementer =
exception gets enabled. To fix this, we moved the call to set_dec() from =
time_init() to calibrate_decr()</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New"> before the exception is enabled in the =
tbcsr.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Ken Poole</FONT></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">Hi everybody.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">I have a problem with my RTC, i work on a MEN A12 =
board with MPC8245 and </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">when my kernel start it takes 8 min to run. I have =
find the problem but i </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">don't know how to solve it. In time.c the function =
time_init execute the </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">following lines :</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">if (__USE_RTC()) {</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; /* 601 processor: dec counts =
down by 128 every 128ns */</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; tb_ticks_per_jiffy =3D =
DECREMENTER_COUNT_601;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; /* =
mulhwu_scale_factor(1000000000, 1000000) is 0x418937 =
*/</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; tb_to_us =3D =
0x0x418937;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">}&nbsp; else {</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
ppc_md.calibrate_decr();</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; tb_to_ns_scale =3D =
mulhwu(tb_to_us, 1000 &lt;&lt; 10);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">}</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">this is the ppc_md.calibrate_decr() function that =
takes a lot of time and i </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">don't know how to solve the problem. USE_RTC is =
fixed at 0 for 6xx config </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">maybe it must be at 1 ? My RTC run with SMBus =
(I2C). I work with ELDK 4.0 </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">and linux 2.6.15.</FONT></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C65D73.BDA4D082--
