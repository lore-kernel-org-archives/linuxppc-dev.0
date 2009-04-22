Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 929D8DE0BE
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 18:30:18 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3M8UDG6017011
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:30:14 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3M8UCxZ007670
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 03:30:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: freeze when reading a PCI bridge register
Date: Wed, 22 Apr 2009 16:30:12 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928C4DB@zch01exm21.fsl.freescale.net>
In-Reply-To: <49EECF8D.9000808@fr.thalesgroup.com>
References: <49EECF8D.9000808@fr.thalesgroup.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Nicolas Lavocat" <nicolas.lavocat@fr.thalesgroup.com>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I' am trying to configure a PCI bridge on a private board, with a=20
> powerpc . In a first time, I tried to get informations about PCI=20
> devices, in order to be sure  that  my read  and write methods work (=20
> using 2 configuration registers, like on an x86 architecture.) . 2=20
> configuration registers  are used, for example we  write  an encoded=20
> address (it is a request to a PCI device) in the first and=20
> the answer of=20
> the PCI device can be read in the second register (it is a=20
> configuration=20
> cycle)
> Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.
>=20
> For example, the code used under u-boot:
>=20
> volatile u32* addr;
> u32 vendor_device_ID;
>=20
> puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
> addr=3DCFG_ADDR_PCI1;
> *addr=3D0x80007800;
>=20
> addr=3D CFG_DATA_PCI1;
> vendor_device_ID=3D *addr;
> printf("PCI1: PCI1_VENDOR_DEVICE_ID=3D %08x  \n" ,vendor_device_ID);
>=20
>=20
> Therefore, when I do the same thing under Linux, the system=20
> crash when I=20
> try to read the second register...
> Linux is frozen, and there is no error message.
> Under Linux, I made an ioremap before use the registers and access to=20
> these registers thanks to  functions  "in_be32" and "out_be32".
> I tried with different endianness to avoid an error of this type.
>=20
> If I understand, the main difference between u-boot and Linux (about=20
> registers access) is the activation of the MMU.
> So I thought that  problem could come from it.=20
> I think the problem could came from the configuration of DBAT=20
> and IBATS=20
> registers of the MMU, but I didn't found any information=20
> about the MMU=20
> configuration under Linux.
> So after this novel, I have some questions:
>=20
> -Is the MMU configuration generic under Linux?
> -Does somebody think that the problem doesn't come from MMU?
> -How does work ioremap? Is it a fully software function, or does it=20
> speaks to MMU to get the effective address from physical address?
> -Does somebody have an idea, or a documentation about MMU=20
> configuration=20
> under linux?
> -Do you think that my MMU is under the control of an evil spirit? ^^
>=20
What is the PowerPC you are using?
