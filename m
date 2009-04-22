Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAE7EDDFCA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 18:34:00 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3M8XupZ019889
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:33:56 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3M8Xs58008943
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 03:33:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C325.11DB8FBF"
Subject: RE: freeze when reading a PCI bridge register
Date: Wed, 22 Apr 2009 16:33:54 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928C4DD@zch01exm21.fsl.freescale.net>
In-Reply-To: <49EED5EB.7050005@fr.thalesgroup.com>
References: <49EECF8D.9000808@fr.thalesgroup.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208928C4DB@zch01exm21.fsl.freescale.net>
	<49EED5EB.7050005@fr.thalesgroup.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Nicolas Lavocat" <nicolas.lavocat@fr.thalesgroup.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9C325.11DB8FBF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

So the host bridge is important, what is the bridge?
Marvell or Tundra chipset?
=20


________________________________

	From: Nicolas Lavocat [mailto:nicolas.lavocat@fr.thalesgroup.com]=20
	Sent: Wednesday, April 22, 2009 4:32 PM
	To: Liu Dave-R63238
	Cc: linuxppc-dev
	Subject: Re: freeze when reading a PCI bridge register
=09
=09
	a 7448
=09
	Liu Dave-R63238 a =E9crit :=20

			I' am trying to configure a PCI bridge on a private board, with a=20
			powerpc . In a first time, I tried to get informations about PCI=20
			devices, in order to be sure  that  my read  and write methods work ( =

			using 2 configuration registers, like on an x86 architecture.) . 2=20
			configuration registers  are used, for example we  write  an encoded=20
			address (it is a request to a PCI device) in the first and=20
			the answer of=20
			the PCI device can be read in the second register (it is a=20
			configuration=20
			cycle)
			Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.
		=09
			For example, the code used under u-boot:
		=09
			volatile u32* addr;
			u32 vendor_device_ID;
		=09
			puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
			addr=3DCFG_ADDR_PCI1;
			*addr=3D0x80007800;
		=09
			addr=3D CFG_DATA_PCI1;
			vendor_device_ID=3D *addr;
			printf("PCI1: PCI1_VENDOR_DEVICE_ID=3D %08x  \n" ,vendor_device_ID);
		=09
		=09
			Therefore, when I do the same thing under Linux, the system=20
			crash when I=20
			try to read the second register...
			Linux is frozen, and there is no error message.
			Under Linux, I made an ioremap before use the registers and access to =

			these registers thanks to  functions  "in_be32" and "out_be32".
			I tried with different endianness to avoid an error of this type.
		=09
			If I understand, the main difference between u-boot and Linux (about=20
			registers access) is the activation of the MMU.
			So I thought that  problem could come from it.=20
			I think the problem could came from the configuration of DBAT=20
			and IBATS=20
			registers of the MMU, but I didn't found any information=20
			about the MMU=20
			configuration under Linux.
			So after this novel, I have some questions:
		=09
			-Is the MMU configuration generic under Linux?
			-Does somebody think that the problem doesn't come from MMU?
			-How does work ioremap? Is it a fully software function, or does it=20
			speaks to MMU to get the effective address from physical address?
			-Does somebody have an idea, or a documentation about MMU=20
			configuration=20
			under linux?
			-Do you think that my MMU is under the control of an evil spirit? ^^
		=09
			   =20

		What is the PowerPC you are using?
	=09
		 =20


------_=_NextPart_001_01C9C325.11DB8FBF
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY text=3D#000000 bgColor=3D#ffffff>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D549463208-22042009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>So the host bridge is important, what is the=20
bridge?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D549463208-22042009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Marvell or Tundra chipset?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D549463208-22042009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Nicolas Lavocat=20
  [mailto:nicolas.lavocat@fr.thalesgroup.com] <BR><B>Sent:</B> =
Wednesday, April=20
  22, 2009 4:32 PM<BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B>=20
  linuxppc-dev<BR><B>Subject:</B> Re: freeze when reading a PCI bridge=20
  register<BR></FONT><BR></DIV>
  <DIV></DIV>a 7448<BR><BR>Liu Dave-R63238 a =E9crit&nbsp;:=20
  <BLOCKQUOTE=20
  =
cite=3DmidD7CCA83BB0796C49BC0BB53B6AB1208928C4DB@zch01exm21.fsl.freescale=
.net=20
  type=3D"cite">
    <BLOCKQUOTE type=3D"cite"><PRE wrap=3D"">I' am trying to configure a =
PCI bridge on a private board, with a=20
powerpc . In a first time, I tried to get informations about PCI=20
devices, in order to be sure  that  my read  and write methods work (=20
using 2 configuration registers, like on an x86 architecture.) . 2=20
configuration registers  are used, for example we  write  an encoded=20
address (it is a request to a PCI device) in the first and=20
the answer of=20
the PCI device can be read in the second register (it is a=20
configuration=20
cycle)
Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.

For example, the code used under u-boot:

volatile u32* addr;
u32 vendor_device_ID;

puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
addr=3DCFG_ADDR_PCI1;
*addr=3D0x80007800;

addr=3D CFG_DATA_PCI1;
vendor_device_ID=3D *addr;
printf("PCI1: PCI1_VENDOR_DEVICE_ID=3D %08x  \n" ,vendor_device_ID);


Therefore, when I do the same thing under Linux, the system=20
crash when I=20
try to read the second register...
Linux is frozen, and there is no error message.
Under Linux, I made an ioremap before use the registers and access to=20
these registers thanks to  functions  "in_be32" and "out_be32".
I tried with different endianness to avoid an error of this type.

If I understand, the main difference between u-boot and Linux (about=20
registers access) is the activation of the MMU.
So I thought that  problem could come from it.=20
I think the problem could came from the configuration of DBAT=20
and IBATS=20
registers of the MMU, but I didn't found any information=20
about the MMU=20
configuration under Linux.
So after this novel, I have some questions:

-Is the MMU configuration generic under Linux?
-Does somebody think that the problem doesn't come from MMU?
-How does work ioremap? Is it a fully software function, or does it=20
speaks to MMU to get the effective address from physical address?
-Does somebody have an idea, or a documentation about MMU=20
configuration=20
under linux?
-Do you think that my MMU is under the control of an evil spirit? ^^

    </PRE></BLOCKQUOTE><PRE wrap=3D""><!---->What is the PowerPC you are =
using?

  </PRE></BLOCKQUOTE></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C9C325.11DB8FBF--
