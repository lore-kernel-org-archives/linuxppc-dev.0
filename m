Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C39E3B7093
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 23:27:12 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBGCR93C014126
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 05:27:09 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBGCVVUB010038
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 06:31:32 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Wed, 16 Dec 2009 17:57:06 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>
In-Reply-To: <4B28CBC4.4010501@embedded-sol.com>
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>
	<4B28CBC4.4010501@embedded-sol.com>
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
> Sent: Wednesday, December 16, 2009 5:30 PM
> > As per the p2020rm, PCIe legacy INTA is shared with IRQ0 for this=20
> > ctlr, which is the exactly the case with other SoC's p2020ds,=20
> > mpc8536ds, mpc8572ds. To me it seems like a board issue and=20
> it needs=20
> > to be followed up.
> >
> > I plugged in ralink rt2860 pcie wirless card in the=20
> mini-pcie slot of=20
> > p2020rdb, which ran fine becaused it used MSI by default.
> > How hard is it to enable MSI in the atheros wireless driver.
> >
> >  =20
>=20
> I've enabled MSI in ath9k driver, by simply adding=20
> pci_enable_msi() and
> pci_disable_msi() at relevant places. The MSI interrupt is allocated.
>=20
> irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to virtual irq 18
> phy0: Atheros AR9280 MAC/BB Rev:2 AR5133 RF Rev:d0:=20
> mem=3D0xf2160000, irq=3D18
>=20
> cat /proc/interrupts
>            CPU0
>  18:          0   FSL-MSI   Edge      ath9k
>=20
> lspci -v shows that MSI was enabled on device
>=20
> But I don't get any interrupts. I've posted a question to=20
> ath9k list, maybe folks there will have some ideas.

I just noticed a MSI enable bit in drivers/net/wireless/ath/ath9k/reg.h=20
as under, may be we need to trun this on:-

reg.h:1013:#define AR_PCIE_MSI                              0x4094
reg.h:1014:#define AR_PCIE_MSI_ENABLE                       0x00000001

>=20
> Thanks.
>=20
> Felix.
>=20

Thanks,
Vivek
