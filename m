Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth05.prod.mesa1.secureserver.net
	(smtpauth05.prod.mesa1.secureserver.net [64.202.165.99])
	by ozlabs.org (Postfix) with SMTP id A02F4DDF5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 11:21:53 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <guojin02@tsinghua.org.cn>
Subject: The question about the QUICC ENGINE microcode for freescale
Date: Tue, 11 Mar 2008 17:20:25 -0700
Message-ID: <002101c883d6$de78ae30$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0022_01C8839C.3219D630"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
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

------=_NextPart_000_0022_01C8839C.3219D630
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Couple of thoughts, is that according to Freescale specs, the QE can only
support TWO 1000Mbit end points. And that is assuming RAW traffic, not
protocol layer processing. Since the 8360E has two QUICC Engines, that is
only 1000Mbits data per Engine. Are you intending to get 1000Mbits TX and RX
on each engine? I think in reality you will be capped at 1000Mbit aggregate
in the RX and TX. I could be wrong, but you might want to run that past a
Freescale FAE, do you have the name of your contact for your area?

This is assuming that you are running at the full speed of the MPC8360E, i.e
both QUICC engines probably pushing 500Mhz. You'll also need to probably be
running DDR2 RAM at MAX speed to achieve these rates, as each skbuf will
have to be dma'd out to external memory. All the early dev boards by
Freescale only used DDR1. As well you'll want to be sure your Coherent
System Bus <CSB> speed is as near max, i.e. 300-333Mhz.

What clock speeds / Frequency of chip are you using to test this?  As well
which driver are you using with this test?

As a HW designer for these boards and driver programmer I am just curious
what your HW is looking / configured like?

-Russ





Hi,friends,

I want to realize the high speed TCP package on GETH of MPC8360E,I would
like the speed on both UCC1 and UCC2 for both send and receive TCP
package(big package) up to 1000M bits/sec, so the total internet speed is
4000M bits/sec for MPC8360E.

I tested the internet performance by IPERF test software with the condition
that the core cpu deal with the TCP package,without microcode. I config the
UCC2 down, config UCC1 to send package out to an server PC,no receive,the
speed for UCC1 just only sending package is about 300M bits/sec, and CPU is
100% used. This speed is so slow, is too slow. If I send and recieve at the
same time, the speed is much slower, if I make the UCC2 up, the speed is
much slower and slower.
I do not know how to incrase the internet speed for MPC8360E, somebody told
me, we must use the microcode for QUICC ENGINE.  

My question is that where can I download the microcode for QUICC ENGINE and
how to use it?  Whether or not this microcode can help me to realize the
4000M bits/sec for TCP package?




------=_NextPart_000_0022_01C8839C.3219D630
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>The question about the QUICC ENGINE microcode for =
freescale</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">Couple of</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">t</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">houghts</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">, is that according =
to Freescale specs, the QE can only s</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">u</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">pport</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> TWO 100</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New">0Mbit end points.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> A</FONT><FONT SIZE=3D2 FACE=3D"Courier New">nd =
that is assuming RAW traffic, not protocol layer =
processing.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">S</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New">ince the 8360E has two QUICC Engines, that =
is only 1000Mbits data per Engine.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">Are you intending to get 1000Mbits =
T</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">X</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> and R</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">X</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> on each =
engine?</FONT> <FONT SIZE=3D2 FACE=3D"Courier New">I think in reality =
you will be capped at 1000Mbit aggregate in the RX and TX</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New">.</FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">I could be wrong, but you migh</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">t want to run that past a Freescale FAE, do you have the name of =
your co</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">nt</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New">act for your area?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">This is assuming that you are running at the full speed of the =
MPC8360E</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">, i.e</FONT> <FONT =
SIZE=3D2 FACE=3D"Courier New">b</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">oth</FONT> <FONT SIZE=3D2 FACE=3D"Courier New">QUICC</FONT> <FONT =
SIZE=3D2 FACE=3D"Courier New">engines probably pushing =
500Mhz</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">. =
You</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">ll also need to probably be running DDR2 =
RAM</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Courier New">at</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> MAX speed to</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">achieve</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 FACE=3D"Courier New">these =
rates, as each</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">s</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">k</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">buf</FONT> <FONT SIZE=3D2 FACE=3D"Courier New">will have to =
be</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Courier New">dma</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">d out to external memory</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">.</FONT><FONT SIZE=3D2 FACE=3D"Courier New"></FONT> =
<FONT SIZE=3D2 FACE=3D"Courier New">A</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New">ll the early dev boards by Freescale only used =
DDR1.</FONT> <FONT SIZE=3D2 FACE=3D"Courier New">As well =
you</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">ll want to be sure your Coherent System =
Bus</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Courier New">&lt;CSB&gt;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">speed is as near max, i.e.</FONT> <FONT SIZE=3D2 =
FACE=3D"Courier New">300-333Mhz.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">W</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">hat clock speeds / Frequency of chip are you using to test =
this?</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us">&nbsp;<FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 FACE=3D"Courier New">As =
well</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Courier New">which driver are you using with this =
test</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">A</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">s a HW designer</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">for =
these</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Courier New">boards</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">and driver =
programmer</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">I</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"></FONT> <FONT =
SIZE=3D2 FACE=3D"Courier New">am just curious what your HW is =
looking</FONT><FONT SIZE=3D2 FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 =
FACE=3D"Courier New">/</FONT><FONT SIZE=3D2 FACE=3D"Courier New"></FONT> =
<FONT SIZE=3D2 FACE=3D"Courier New">configured</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New"> like?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">-Russ</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>
<BR>
<BR>
<BR>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">Hi,friends,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">I =
want to realize the high speed TCP package on GETH of MPC8360E,I would =
like the speed on both UCC1 and UCC2 for both send</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New"> and receive TCP package(big package) up to 1000M =
bits/sec, so the total internet speed is 4000M bits/sec for =
MPC8360E.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">I =
tested the internet performance by IPERF test software with the =
condition that the core cpu deal with the TCP package,without =
microco</FONT><FONT SIZE=3D2 FACE=3D"Courier New">de. I config the UCC2 =
down, config UCC1 to send package out to an server PC,no receive,the =
speed for UCC1 just only sending package is about 300M bits/sec, and CPU =
is 100% used. This speed is so slow, is too slow. If I send and recieve =
at the same time, t</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New">h</FONT><FONT SIZE=3D2 FACE=3D"Courier New">e speed is much slower, =
if I make the UCC2 up, the speed is much slower and =
slower.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">I =
do not know how to incrase the internet speed for MPC8360E, somebody =
told me, we must use the microcode for QUICC ENGINE.&nbsp; =
</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">My =
question is that where can I download the</FONT> <FONT SIZE=3D2 =
FACE=3D"Courier New">microcode for QUICC ENGINE and how to use it?&nbsp; =
Whether or not this microcode can help me to realize the 4000M bits/sec =
for TCP package?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------=_NextPart_000_0022_01C8839C.3219D630--
