Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3F1F067BD4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 13:53:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7E3r9BA011877 for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Aug 2006 20:53:09 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7E3r6ka010949
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Aug 2006 22:53:08 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI DMA_MR Problem
Date: Mon, 14 Aug 2006 11:53:02 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26350CD593@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060811135746.68402.qmail@web53115.mail.yahoo.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "jimmy liu" <jimmyzhmliu@yahoo.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The memory map configuration registers is little-endain. Be careful this
Please byte swap this
-Dave=20
>=20
> I got a problem when I set the pci dmamr for MPC8250 for DMA=20
> PCI transfering data on linux kernel 2.6.17.
> When I set the values for the pci_dmamr registers, then print=20
> the register values back, some bits can not be set. Did=20
> anybody know what are the problem, or I have to set other stuff.
>=20
> Thanks.
>=20
> The code like this:
>=20
> volatile cpm2_map_t *immap =3D cpm2_immr;
> immap->im_pci.pci_dmamr0 =3D 0x0042b00c;
> immap->im_pci.pci_dmamr1 =3D 0x0042b00c;
> immap->im_pci.pci_dmamr2 =3D 0x0042b00c;
> immap->im_pci.pci_dmamr3 =3D 0x0042b00c;
>=20
> printk("DMA0 MR =3D 0x%08x\n",
> immap->im_pci.pci_dmamr0);
> printk("DMA1 MR (0x%08x) =3D 0x%08x\n",
> immap->im_pci.pci_dmamr1);
> printk("DMA2 MR (0x%08x) =3D 0x%08x\n",
> immap->im_pci.pci_dmamr2);
> printk("DMA3 MR (0x%08x) =3D 0x%08x\n",
> immap->im_pci.pci_dmamr3);
>=20
> The results are following:
> DMA0 MR (0xf0010500) =3D 0x0040b000
> DMA1 MR (0xf0010580) =3D 0x0040b000
> DMA2 MR (0xf0010600) =3D 0x0040b000
> DMA3 MR (0xf0010680) =3D 0x0040b000
>=20
>=20
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection=20
> around http://mail.yahoo.com=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
