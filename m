Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6A1ABDDDE5
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 13:37:22 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2C2bGV7000485
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Mar 2007 20:37:17 -0600 (MDT)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2C2bDOu023485
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Mar 2007 21:37:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: IRQ numbering (was: Better timer and RTC handling for 8641HPCN.)
Date: Mon, 12 Mar 2007 10:37:11 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C131C8F@zch01exm26.fsl.freescale.net>
In-Reply-To: <DA03B38D-D18C-44F7-9C07-EA9C1F2C150E@kernel.crashing.org>
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
	<46B96294322F7D458F9648B60E15112C131B7D@zch01exm26.fsl.freescale.net>
	<DA03B38D-D18C-44F7-9! C07-EA9C1 F2C150E@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >>>>> Please use 80.
> >>>>> We reserve the first 16 ints for legacy 8259 interrupts. And we
> >>>>> want the
> >>>>> virq is the same value to hw-irq.
> >>>>
> >>>> Why?
> >>>
> >>> If the virq equals hw-irq, it's clear and simple to user.
> >>
> >> I don't think that's a good reason to over allocate.
> >>
> >> There's a reason we have virtual IRQs now.  Its=20
> specifically to deal
> >> with issues like the 16 interrupts for 8259 and not have=20
> to do games
> >> to offset IRQs.
> >>
> >> If we needed create some debugfs or sysfs info that translates VIRQ
> >> to HW irq
> >>
> >
> > I know that's the advantage of virtual IRQs. But in this=20
> platform, we
> > want to fix up the virq to hwirq and let users know which irq is =20
> > coming
> > from which devices.
>=20
> But how do I know IRQ 42 is really 26 for the MPIC.  What are you =20
> users doing that they can't handle the virtual irq concept?
>=20
> It was pointed out, that you are coupling the IRQ # in the .dts with =20
> the kernel virtual number which is a bad idea.  In theory the device-=20
> tree description shouldn't be coupled this tightly to the kernel.
>=20
> I think the Freescale reference boards should strive to show people =20
> how to do things properly since people tend to copy this code=20
> and use =20
> it as a starting point.  I doubt most 86xx designs are really going =20
> to have an 8259 controller on them and thus making things focus =20
> around it seems silly.
>=20
Hi, Kumar,

I have used the a fake interrupt hole to avoid the hwirq overlapping.
Now the virq equals the hwirq.=20

I agree with the virq has lots of advantages than irq offset. But we can
not give the user a fixup irq list since the virq will be changed by
different device driver loading. And the user can not get the hwirq from
the user space application.

I think creating some debugfs or sysfs info that translates VIRQ to HW
irq is a _good_ idea, or just add some fields (irq host, hwirq) in
/proc/interrupts. If we have this, I'll fix all irqs in dts file and
remove the fake irq hole.

Before we have a virq-hwirq mapping list, I keep my option about the irq
number.

Thanks!
Zhang Wei
