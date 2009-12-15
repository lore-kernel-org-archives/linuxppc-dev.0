Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDF70B6F0F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 08:26:01 +1100 (EST)
Message-ID: <4B27FEE3.80001@embedded-sol.com>
Date: Tue, 15 Dec 2009 23:25:55 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: Problem with mini-PCI-E slot on P2020RDB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to use mini-PCI-E WLAN card on P2020RDB running 2.6.32, but 
so far without success.
ath9k driver identifies the device, I can run ifconfig, iwconfig and 
hostapd on wlan0, but device is not
getting any interrupts,  so I suspect the interrupt configuration is 
wrong. Atheros ath9k driver reports:

phy0: Atheros AR9280 MAC/BB Rev:2 AR5133 RF Rev:d0: mem=0xf1060000, irq=16

The mapping for irq 16 is:

irq: irq 1 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16

According to /proc/interrupts:

          CPU0
 16:          0   OpenPIC   Edge      ath9k

The same problem happens if Atheros card is plugged (with adapter) into 
regular PCI-E slot.

It seems that p2020rdb device tree is missing interrupt-map-mask and 
interrupt-map properties
in PCI-E nodes.

I've tried running kernel from latest FSL BSP for this board (based on 
2.6.32-rc3). The device tree
has the interrupt-map-mask and interrupt-map properties, and interrupt 
mapping is different:

irq: irq 0 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16

In /proc/interrups I see
           CPU0
 16:     100001   OpenPIC   Level     ath9k

However, when ath9k driver is loaded I get this:

irq 16: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[efbefa40] [c00074b0] show_stack+0x4c/0x16c (unreliable)
[efbefa70] [c0073970] __report_bad_irq+0x38/0xd0
[efbefa90] [c0073bd4] note_interrupt+0x1cc/0x22c
[efbefac0] [c00747d0] handle_fasteoi_irq+0xf4/0x128
[efbefae0] [c0004eb8] do_IRQ+0xc8/0xf4
[efbefb00] [c001081c] ret_from_except+0x0/0x18
[efbefbc0] [00000000] (null)
[efbefc10] [c0004d24] do_softirq+0x60/0x64
[efbefc20] [c0044670] irq_exit+0x88/0xa8
[efbefc30] [c0004ebc] do_IRQ+0xcc/0xf4
[efbefc50] [c001081c] ret_from_except+0x0/0x18
[efbefd10] [c00730b4] __setup_irq+0x320/0x39c
[efbefd30] [c0073214] request_threaded_irq+0xe4/0x148
[efbefd60] [f2244218] ath_pci_probe+0x1b0/0x3a4 [ath9k]
[efbefda0] [c01c386c] local_pci_probe+0x24/0x34
[efbefdb0] [c01c3bc0] pci_device_probe+0x84/0xa8
[efbefde0] [c01e86b8] driver_probe_device+0xa8/0x1a8
[efbefe00] [c01e8874] __driver_attach+0xbc/0xc0
[efbefe20] [c01e7d88] bus_for_each_dev+0x70/0xac
[efbefe50] [c01e84d8] driver_attach+0x24/0x34
[efbefe60] [c01e7504] bus_add_driver+0xb8/0x278
[efbefe90] [c01e8bec] driver_register+0x84/0x178
[efbefeb0] [c01c3e6c] __pci_register_driver+0x54/0xe4
[efbefed0] [f2244434] ath_pci_init+0x28/0x38 [ath9k]
[efbefee0] [f215702c] ath9k_init+0x2c/0x100 [ath9k]
[efbefef0] [c0001d34] do_one_initcall+0x3c/0x1e8
[efbeff20] [c006f9f0] sys_init_module+0xf8/0x220
[efbeff40] [c00101c4] ret_from_syscall+0x0/0x3c
handlers:
[<f223badc>] (ath_isr+0x0/0x1b4 [ath9k])
Disabling IRQ #16

Atheros card plugged into regular PCI-E slot  works OK in  FSL BSP.

Any help in resolving this is much appreciated.

Thanks.

Felix.
