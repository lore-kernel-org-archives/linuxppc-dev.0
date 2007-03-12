Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17908.51949.695284.464275@cargo.ozlabs.ibm.com>
Date: Mon, 12 Mar 2007 14:37:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: RE: IRQ numbering (was: Better timer and RTC handling for 8641HPCN.)
In-Reply-To: <46B96294322F7D458F9648B60E15112C131C8F@zch01exm26.fsl.freescale.net>
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
	<46B96294322F7D458F9648B60E15112C131C8F@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Wang Haiying-r54964 <Haiying.Wang@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei-r63237 writes:

> I think creating some debugfs or sysfs info that translates VIRQ to HW
> irq is a _good_ idea, or just add some fields (irq host, hwirq) in
> /proc/interrupts. If we have this, I'll fix all irqs in dts file and
> remove the fake irq hole.

It would have to be a (host, hwirq) pair.  A "hwirq" has no meaning by
itself, since in general we can have multiple interrupt controllers
and they will each have their own space of interrupt numbers.

> Before we have a virq-hwirq mapping list, I keep my option about the irq
> number.

There is no point trying to fake things up in the .dts so that you get
virq numbers that you expect.  The numbers in the .dts should be the
controller-relative "hwirq" numbers.

Paul.
