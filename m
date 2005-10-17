Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id C13BB685B5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 22:24:40 +1000 (EST)
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j9HCODux028623
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 05:24:37 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5D315.AEB5F3AD"
Date: Mon, 17 Oct 2005 05:24:12 -0700
Message-ID: <F795765B112E7344AF36AA911279641584969B@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Need help Please:IOMEM memory allocation
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

------_=_NextPart_001_01C5D315.AEB5F3AD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
I am trying to develop a SPI driver for MPC8541.=20
I need to allocate memory buffers within kernel that their physical
address is
on 64 byte boundary and initialize the transmit and receive buffer
descriptors with the
their physical locations. Since I am not sure how to do this within the
kernel here is how I am doing it:
=20
 unsigned long mem_addr_rx =3D __get_free_page(GFP_KERNEL);  //receive
buffer
 unsigned long mem_addr_tx =3D __get_free_page(GFP_KERNEL); //transmit
buffer
.....
rx_buffer_addr =3D __pa(mem_addr_rx);
tx_buffer_addr=3D__pa(mem_addr_tx);
=20
My assumption is by allocating a page, I am guaranteed that I will have
64 byte boundary condition.
Is this correct?
=20
I have also told, the SPI does not have snoop bit, so I need to allocate
buffers from iomem, I have
no idea how to do this.
=20
Please help,
Many thanks in advance,
Regards,
Bizhan

------_=_NextPart_001_01C5D315.AEB5F3AD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>I am =
trying to=20
develop a SPI driver for MPC8541. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>I need =
to allocate=20
memory buffers within kernel that their physical address =
is</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>on 64 =
byte boundary=20
and initialize the transmit and receive buffer descriptors with=20
the</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>their =
physical=20
locations. Since I am not sure how to do this within =
the</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>kernel =
here is how I=20
am doing it:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D973480512-17102005>&nbsp;unsigned long=20
mem_addr_rx =3D __get_free_page(GFP_KERNEL);&nbsp;&nbsp;//receive=20
buffer<BR>&nbsp;unsigned long mem_addr_tx =3D =
__get_free_page(GFP_KERNEL);=20
//transmit buffer<BR>.....</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D973480512-17102005>rx_buffer_addr =3D=20
__pa(mem_addr_rx);</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005>tx_buffer_addr=3D__pa(mem_addr_tx);</SPAN></FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>My =
assumption is by=20
allocating a page, I am guaranteed that I will have 64 byte boundary=20
condition.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>Is =
this=20
correct?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>I have =
also told,=20
the SPI does not have snoop bit, so I need to allocate buffers from =
iomem, I=20
have</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>no =
idea how to do=20
this.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>Please =

help,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973480512-17102005>Many =
thanks in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005>Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973480512-17102005>Bizhan</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5D315.AEB5F3AD--
