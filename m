Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D533DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 21:09:58 +1000 (EST)
Received: from mailgw4.ericsson.se (unknown [127.0.0.1])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	89D52205AC for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 13:09:53 +0200 (CEST)
Received: from esealmw129.eemea.ericsson.se (unknown [153.88.254.124])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	696B5211EA for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 13:09:53 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FB6D.DAAB69EE"
Subject: 8270 & Watchdog - early start - II
Date: Thu, 20 Sep 2007 12:06:03 +0200
Message-ID: <AEA1A32F001C6B4F98614B5B80D7647D02D73F76@esealmw115.eemea.ericsson.se>
In-Reply-To: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
References: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
From: "Matias Sundman" <matias.sundman@ericsson.com>
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

------_=_NextPart_001_01C7FB6D.DAAB69EE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guys,
The Software Service Register (SWSR) is 16-bit wide which Laurent
Pinchart [laurentp@cse-semaphore.com] so nicely pointed out for me.
So it actually works with;
*((volatile unsigned short*)(0xf001000e))=3D0x556c;=20
*((volatile unsigned short*)(0xf001000e))=3D0xaa39;=20

=20

Thx // Matias

=20

________________________________

From: linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.or=
g
] On Behalf Of Matias Sundman
Sent: den 20 september 2007 10:19
To: linuxppc-embedded@ozlabs.org
Subject: 8270 & Watchdog - early start




Hi,=20
I have a custom MPC8270 board running Linux and u-boot.=20
Now, I enabled the watchdog on the 8270 and need to kick it regularly by

writing ;=20

0x556c=20
0xaa39=20

To the internal register @ 0x0x1000e.=20

When I am coming out from head.S to start_kernel I was thinking of
kicking=20
it a couple times "manually"=20
before a timer interrupt is inserted which will take care of it until a=20
"superdaemon" is taking over.=20

I tried to serve the register as follows;=20


*((volatile unsigned int*)(0xf001000e))=3D0x556c;=20
*((volatile unsigned int*)(0xf001000e))=3D0xaa39;=20

But it does not take effect. I thought that since u-boot had set up the
IMMR=20
to 0xf000'0000 I could=20
directly write to the register as above.=20


Any clues why this does not work?=20


Thx // Matias=20


------_=_NextPart_001_01C7FB6D.DAAB69EE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>8270 & Watchdog - early start</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1597" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D188530310-20092007><FONT face=3D"Comic Sans MS" =
color=3D#0000ff=20
size=3D2>Hi Guys,</FONT></SPAN></DIV>
<DIV><SPAN class=3D188530310-20092007><FONT face=3D"Comic Sans MS" =
color=3D#0000ff=20
size=3D2><FONT size=3D2>The Software Service Register (SWSR) is 16-bit =
wide which=20
Laurent Pinchart [laurentp@cse-semaphore.com] so nicely pointed out for=20
me.</FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D188530310-20092007><FONT face=3D"Comic Sans MS" =
color=3D#0000ff=20
size=3D2>So it actually works with;</FONT></SPAN></DIV>
<DIV><SPAN class=3D188530310-20092007>
<P><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2>*((volatile=20
unsigned&nbsp;<SPAN =
class=3D188530310-20092007>short</SPAN>*)(0xf001000e))=3D0x556c;=20
<BR>*((volatile unsigned&nbsp;<SPAN=20
class=3D188530310-20092007>short</SPAN>*)(0xf001000e))=3D0xaa39; =
</FONT></P>
<P>&nbsp;</P>
<P><SPAN class=3D188530310-20092007><FONT face=3D"Comic Sans MS" =
color=3D#0000ff=20
size=3D2>Thx // Matias</FONT></SPAN></P></SPAN></DIV>
<DIV><SPAN class=3D188530310-20092007><FONT face=3D"Comic Sans MS" =
color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B>=20
linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.or=
g] <B>On=20
Behalf Of </B>Matias Sundman<BR><B>Sent:</B> den 20 september 2007=20
10:19<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> 8270 =
&amp;=20
Watchdog - early start<BR></FONT><BR></DIV>
<DIV></DIV><!-- Converted from text/rtf format --><BR>
<P><FONT face=3D"Comic Sans MS" size=3D2>Hi,</FONT> <BR><FONT =
face=3D"Comic Sans MS"=20
size=3D2>I have a custom MPC8270 board running Linux and u-boot.</FONT> =
<BR><FONT=20
face=3D"Comic Sans MS" size=3D2>Now, I enabled the watchdog on the 8270 =
and need to=20
kick it regularly by</FONT> <BR><FONT face=3D"Comic Sans MS" =
size=3D2>writing=20
;</FONT> </P>
<P><FONT face=3D"Comic Sans MS" size=3D2>0x556c</FONT> <BR><FONT=20
face=3D"Comic Sans MS" size=3D2>0xaa39</FONT> </P>
<P><FONT face=3D"Comic Sans MS" size=3D2>To the internal register @=20
0x0x1000e.</FONT> </P>
<P><FONT face=3D"Comic Sans MS" size=3D2>When I am coming out from =
head.S to=20
start_kernel I was thinking of kicking</FONT> <BR><FONT face=3D"Comic =
Sans MS"=20
size=3D2>it a couple times "manually"</FONT> <BR><FONT face=3D"Comic =
Sans MS"=20
size=3D2>before a timer interrupt is inserted which will take care of it =
until=20
a</FONT> <BR><FONT face=3D"Comic Sans MS" size=3D2>"superdaemon" is =
taking=20
over.</FONT> </P>
<P><FONT face=3D"Comic Sans MS" size=3D2>I tried to serve the register =
as=20
follows;</FONT> </P><BR>
<P><FONT face=3D"Comic Sans MS" size=3D2>*((volatile unsigned=20
int*)(0xf001000e))=3D0x556c;</FONT> <BR><FONT face=3D"Comic Sans MS"=20
size=3D2>*((volatile unsigned int*)(0xf001000e))=3D0xaa39;</FONT> </P>
<P><FONT face=3D"Comic Sans MS" size=3D2>But it does not take effect. I =
thought that=20
since u-boot had set up the IMMR</FONT> <BR><FONT face=3D"Comic Sans MS" =
size=3D2>to=20
0xf000'0000 I could</FONT> <BR><FONT face=3D"Comic Sans MS" =
size=3D2>directly write=20
to the register as above.</FONT> </P><BR>
<P><FONT face=3D"Comic Sans MS" size=3D2>Any clues why this does not =
work?</FONT>=20
</P><BR>
<P><FONT face=3D"Comic Sans MS" size=3D2>Thx // Matias</FONT> =
</P></BODY></HTML>

------_=_NextPart_001_01C7FB6D.DAAB69EE--
