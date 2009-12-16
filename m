Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42284B6F14
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:49:48 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBG6niSm022554
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 23:49:44 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nBG6njH3018797
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 00:49:46 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Wed, 16 Dec 2009 12:19:42 +0530
Message-ID: <0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>
In-Reply-To: <4B27FEE3.80001@embedded-sol.com>
References: <4B27FEE3.80001@embedded-sol.com>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>, <linuxppc-dev@ozlabs.org>,
	"Aggrwal Poonam-B10812" <B10812@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+vivek.mahajan=3Dfreescale.com@lists.ozlabs.
> org=20
> [mailto:linuxppc-dev-bounces+vivek.mahajan=3Dfreescale.com@lists
.ozlabs.org] On Behalf Of Felix Radensky
> Sent: Wednesday, December 16, 2009 2:56 AM
> To: linuxppc-dev@ozlabs.org; Aggrwal Poonam-B10812; Kumar Gala
> Subject: Problem with mini-PCI-E slot on P2020RDB
>=20
> Hi,
>=20
> I'm trying to use mini-PCI-E WLAN card on P2020RDB running=20
> 2.6.32, but so far without success.
> ath9k driver identifies the device, I can run ifconfig,=20
> iwconfig and hostapd on wlan0, but device is not getting any=20
> interrupts,  so I suspect the interrupt configuration is=20
> wrong. Atheros ath9k driver reports:
>=20
> phy0: Atheros AR9280 MAC/BB Rev:2 AR5133 RF Rev:d0:=20
> mem=3D0xf1060000, irq=3D16
>=20
> The mapping for irq 16 is:
>=20
> irq: irq 1 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
>=20
> According to /proc/interrupts:
>=20
>           CPU0
>  16:          0   OpenPIC   Edge      ath9k
>=20
> The same problem happens if Atheros card is plugged (with=20
> adapter) into regular PCI-E slot.
>=20
> It seems that p2020rdb device tree is missing=20
> interrupt-map-mask and interrupt-map properties in PCI-E nodes.
>=20
> I've tried running kernel from latest FSL BSP for this board=20
> (based on 2.6.32-rc3). The device tree has the=20
> interrupt-map-mask and interrupt-map properties, and=20
> interrupt mapping is different:
>=20
> irq: irq 0 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
>=20
> In /proc/interrups I see
>            CPU0
>  16:     100001   OpenPIC   Level     ath9k
>=20
> However, when ath9k driver is loaded I get this:
>=20
> irq 16: nobody cared (try booting with the "irqpoll" option)=20
> Call Trace:
> [efbefa40] [c00074b0] show_stack+0x4c/0x16c (unreliable)=20
> [efbefa70] [c0073970] __report_bad_irq+0x38/0xd0 [efbefa90]=20
> [c0073bd4] note_interrupt+0x1cc/0x22c [efbefac0] [c00747d0]=20
> handle_fasteoi_irq+0xf4/0x128 [efbefae0] [c0004eb8]=20
> do_IRQ+0xc8/0xf4 [efbefb00] [c001081c]=20
> ret_from_except+0x0/0x18 [efbefbc0] [00000000] (null)=20
> [efbefc10] [c0004d24] do_softirq+0x60/0x64 [efbefc20]=20
> [c0044670] irq_exit+0x88/0xa8 [efbefc30] [c0004ebc]=20
> do_IRQ+0xcc/0xf4 [efbefc50] [c001081c]=20
> ret_from_except+0x0/0x18 [efbefd10] [c00730b4]=20
> __setup_irq+0x320/0x39c [efbefd30] [c0073214]=20
> request_threaded_irq+0xe4/0x148 [efbefd60] [f2244218]=20
> ath_pci_probe+0x1b0/0x3a4 [ath9k] [efbefda0] [c01c386c]=20
> local_pci_probe+0x24/0x34 [efbefdb0] [c01c3bc0]=20
> pci_device_probe+0x84/0xa8 [efbefde0] [c01e86b8]=20
> driver_probe_device+0xa8/0x1a8 [efbefe00] [c01e8874]=20
> __driver_attach+0xbc/0xc0 [efbefe20] [c01e7d88]=20
> bus_for_each_dev+0x70/0xac [efbefe50] [c01e84d8]=20
> driver_attach+0x24/0x34 [efbefe60] [c01e7504]=20
> bus_add_driver+0xb8/0x278 [efbefe90] [c01e8bec]=20
> driver_register+0x84/0x178 [efbefeb0] [c01c3e6c]=20
> __pci_register_driver+0x54/0xe4 [efbefed0] [f2244434]=20
> ath_pci_init+0x28/0x38 [ath9k] [efbefee0] [f215702c]=20
> ath9k_init+0x2c/0x100 [ath9k] [efbefef0] [c0001d34]=20
> do_one_initcall+0x3c/0x1e8 [efbeff20] [c006f9f0]=20
> sys_init_module+0xf8/0x220 [efbeff40] [c00101c4]=20
> ret_from_syscall+0x0/0x3c
> handlers:
> [<f223badc>] (ath_isr+0x0/0x1b4 [ath9k]) Disabling IRQ #16

Looks like INTA is not being routed to IRQ0 properly for this
PCIe ctlr. Try changing the interrupt-map prop for the ctlr=20
at 0xffe0a000 to the following, temporarily:-

interrupt-map =3D <
/* IDSEL 0x0 */
0000 0x0 0x0 0x1 &mpic 0x1 0x1
0000 0x0 0x0 0x2 &mpic 0x2 0x1
0000 0x0 0x0 0x3 &mpic 0x3 0x1
0000 0x0 0x0 0x4 &mpic 0x0 0x1
>;

>=20
> Atheros card plugged into regular PCI-E slot  works OK in  FSL BSP.
>=20
> Any help in resolving this is much appreciated.
>=20
> Thanks.
>=20
> Felix.
>=20

Thanks,
Vivek
