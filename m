Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id D27EA67F3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 08:20:29 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Henk Stegeman'" <henk.stegeman@gmail.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Best location for call to spi_register_board_info () on PPC
	(MPC5200)
Date: Wed, 13 Dec 2006 22:08:11 +0100
Message-ID: <035101c71efa$cdf4d3a0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0352_01C71F03.2FB93BA0"
In-Reply-To: <ae4f76fd0612131259h6df7b20fi68561d7878f49483@mail.gmail.com>
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

------=_NextPart_000_0352_01C71F03.2FB93BA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 


  _____  

From: linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se@ozlabs.org
[mailto:linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se@ozlabs.org] On Behalf Of Henk Stegeman
Sent: den 13 december 2006 21:59
To: linuxppc-embedded@ozlabs.org
Subject: Best location for call to spi_register_board_info () on PPC (MPC5200)


I'm working on an SPI procol driver on the MPC52XX.
I spend some time in trying to find the best location for calling spi_register_board_info () (which basically registers the
relations between protocol drivers and the SPI chip selects). 

I wish to call this function from my copy of the arch/ppc/platforms/Lite5200.c file  since these relations are board-specific,
however I found that placing the call in any of these functions (eg. lite5200_setup_arch) results in an -ENOMEM from the
spi_register_board_info () call. 

Now I'm calling spi_register_board_info () from the spi controller driver which is soo ugly.

Thanks in advance,

Henk.  
 
Try doing it as an arch_initcall() in Lite5200.c, I do that in my custom board port file


------=_NextPart_000_0352_01C71F03.2FB93BA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2995" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT>&nbsp;</DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.o=
rg]=20
  <B>On Behalf Of </B>Henk Stegeman<BR><B>Sent:</B> den 13 december 2006 =

  21:59<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
Best=20
  location for call to spi_register_board_info () on PPC=20
  (MPC5200)<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>I'm working on an SPI procol driver on the MPC52XX.<BR>I spend =
some time=20
  in trying to find the best location for calling =
spi_register_board_info ()=20
  (which basically registers the relations between protocol drivers and =
the SPI=20
  chip selects). <BR><BR>I wish to call this function from my copy of =
the=20
  arch/ppc/platforms/Lite5200.c file&nbsp; since these relations are=20
  board-specific, however I found that placing the call in any of these=20
  functions (eg. lite5200_setup_arch) results in an -ENOMEM from the=20
  spi_register_board_info () call. <BR><BR>Now I'm calling=20
  spi_register_board_info () from the spi controller driver which is soo =

  ugly.<BR><BR>Thanks in advance,<BR><BR>Henk.<SPAN=20
  class=3D625080521-13122006><FONT face=3DArial color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN><SPAN=20
  class=3D625080521-13122006>&nbsp;</SPAN><BR><SPAN =
class=3D625080521-13122006><FONT=20
  face=3DArial color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D625080521-13122006><FONT face=3DArial =
color=3D#0000ff=20
  size=3D2>Try&nbsp;doing it as an arch_initcall() in Lite5200.c, I do =
that in my=20
  custom board port file</FONT></SPAN></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0352_01C71F03.2FB93BA0--
