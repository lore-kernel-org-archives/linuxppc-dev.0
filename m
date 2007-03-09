Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6741CDDEC5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 16:24:14 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l295OACK026526
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 22:24:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l295O8uH021596
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 23:24:09 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Fri, 9 Mar 2007 13:24:06 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C131B7D@zch01exm26.fsl.freescale.net>
In-Reply-To: <DFDB8D99-C0C2-4884-95F8-98DC8C172A60@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
	<1173381017.23776.211.camel@ld0161-tx32>
	<1173381543.2968.10.camel@udp097531uds.am.freescale.net>
	<82D7F244-A949-4DC9-8DE3-A91DD25CD50A@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C131B07@zch01exm26.fsl.freescale.net>
	<53280A91-C40D-4E01-8DA3-D1D9B1C40A61@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C131B5F@zch01exm26.fsl.freescale.net>
	<DFDB8D99-C0C2-4884-95F8-98DC8C172A60@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> >>> Please use 80.
> >>> We reserve the first 16 ints for legacy 8259 interrupts. And we
> >>> want the
> >>> virq is the same value to hw-irq.
> >>
> >> Why?
> >
> > If the virq equals hw-irq, it's clear and simple to user.
>=20
> I don't think that's a good reason to over allocate.
>=20
> There's a reason we have virtual IRQs now.  Its specifically to deal =20
> with issues like the 16 interrupts for 8259 and not have to do games =20
> to offset IRQs.
>=20
> If we needed create some debugfs or sysfs info that translates VIRQ =20
> to HW irq
>=20

I know that's the advantage of virtual IRQs. But in this platform, we
want to fix up the virq to hwirq and let users know which irq is coming
from which devices.

- z
