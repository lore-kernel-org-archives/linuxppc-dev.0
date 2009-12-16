Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4DCAB7B5F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 20:52:52 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBG9qnbs012861
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 02:52:49 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBG9vBEj007862
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 03:57:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Wed, 16 Dec 2009 15:22:46 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>
In-Reply-To: <4B28A7C3.6040209@embedded-sol.com>
References: <4B27FEE3.80001@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>
	<4B28A7C3.6040209@embedded-sol.com>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org, Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Felix Radensky [mailto:felix@embedded-sol.com]=20
> Sent: Wednesday, December 16, 2009 2:56 PM
> To: Mahajan Vivek-B08308
> Cc: linuxppc-dev@ozlabs.org; Aggrwal Poonam-B10812; Kumar Gala
> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>=20
> Hi,
> >
> > Looks like INTA is not being routed to IRQ0 properly for this PCIe=20
> > ctlr. Try changing the interrupt-map prop for the ctlr at=20
> 0xffe0a000=20
> > to the following, temporarily:-
> >
> > interrupt-map =3D <
> > /* IDSEL 0x0 */
> > 0000 0x0 0x0 0x1 &mpic 0x1 0x1
> > 0000 0x0 0x0 0x2 &mpic 0x2 0x1
> > 0000 0x0 0x0 0x3 &mpic 0x3 0x1
> > 0000 0x0 0x0 0x4 &mpic 0x0 0x1
> >  =20
>=20
> Thanks for your help. With this change "nobody cared" message=20
> disappears, but interrupts are not coming at all.
>=20
> Is it a SoC problem or a board problem ?

As per the p2020rm, PCIe legacy INTA is shared with IRQ0 for=20
this ctlr, which is the exactly the case with other SoC's=20
p2020ds, mpc8536ds, mpc8572ds. To me it seems like a board=20
issue and it needs to be followed up.

I plugged in ralink rt2860 pcie wirless card in the mini-pcie=20
slot of p2020rdb, which ran fine becaused it used MSI by default.
How hard is it to enable MSI in the atheros wireless driver.

>=20
> Thanks.
>=20
> Felix.
>=20

Thanks,
Vivek
