Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 429BEDDF41
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:11:53 +1100 (EST)
Message-Id: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: a.zummo@towertech.it
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: state of GEN_RTC vs rtc subsystem
Date: Wed, 20 Feb 2008 10:11:23 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, rz@linux-m68k.org,
	LKML Kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is the functionality provided by drivers/char/gen_rtc.c completely  
handled by the rtc subsystem in drivers/rtc?

I ask for two reasons:
1. should we make it mutually exclusive in Kconfig
2. I've enabled both and get (we'll my defconfig did):

proc_dir_entry 'rtc' already registered
Call Trace:
[df82bd70] [c0006b8c] show_stack+0x3c/0x1b0 (unreliable)
[df82bda0] [c00cda48] proc_register+0xf8/0x1a0
[df82bdd0] [c00cdc44] create_proc_entry+0x64/0xf0
[df82bdf0] [c024a484] rtc_proc_add_device+0x54/0x90
[df82be00] [c0249048] rtc_device_register+0x1d8/0x220
[df82be40] [c046c0bc] cmos_platform_probe+0x13c/0x3c0
[df82be70] [c01cd524] platform_drv_probe+0x24/0x40
[df82be80] [c01cb15c] driver_probe_device+0xbc/0x200
[df82bea0] [c01cb4ac] __driver_attach+0xcc/0x100
[df82bec0] [c01ca0dc] bus_for_each_dev+0x5c/0xa0
[df82bef0] [c01caf44] driver_attach+0x24/0x40
[df82bf00] [c01cad70] bus_add_driver+0x1f0/0x270
[df82bf20] [c01cb778] driver_register+0x48/0x140
[df82bf40] [c01cd948] platform_driver_register+0x98/0xb0
[df82bf50] [c01cd97c] platform_driver_probe+0x1c/0x90
[df82bf60] [c046bf70] cmos_init+0x20/0x30
[df82bf70] [c0450218] kernel_init+0xa8/0x2b0
[df82bff0] [c000e638] kernel_thread+0x44/0x60
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0

- k
