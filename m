Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
 by ozlabs.org (Postfix) with ESMTP id 2CD96B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 18:19:44 +1100 (EST)
Date: Tue, 18 Oct 2011 09:19:39 +0200
From: Gabriel Paubert <paubert@iram.es>
To: nello martuscielli <ppc.addon@gmail.com>
Subject: Re: linux-3.0.4, mv643xx_eth troubles on Pegasos2 G4
Message-ID: <20111018071939.GB16633@iram.es>
References: <CABMX=WzPuhBywZTJShnM5W1Y2cqMOr=2BuJTKecsyfCp73Ko7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABMX=WzPuhBywZTJShnM5W1Y2cqMOr=2BuJTKecsyfCp73Ko7g@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, acrux@linuxmail.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 17, 2011 at 11:40:54PM +0200, nello martuscielli wrote:
> i'm trying to enable marvel gigabit ethernet support but it doesn't work.
> Here my dmesg instead my config is attached.
[snipped]
> via_rhine: v1.10-LK1.5.0 2010-10-09 Written by Donald Becker
> mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
> uhci_hcd 0000:00:0c.2: irq 9, io base 0x00001040
> sysfs: cannot create duplicate filename '/class/mdio_bus/0'

I have 2 Pegasos running 3.0, but in my case mv643xx_eth is non-modular
and /sys/class/mdio_bus/0 exists and points to

../../devices/platform/mv643xx_eth.0/mdio_bus/0

which is correct as far as I can say. 

Is it a regression from 3.0 or not? Try to make it non modular and see
what happens. If it is a regression, could you try to bisect it?

I won't be close enough to the machines to do a regression
hunt myself before a week or 3 (really, maybe next week, 
I don't yet know, but for sure starting on Nov 8th).

>

> usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:455
> Modules linked in: snd_via82xx(+) snd_ac97_codec mv643xx_eth(+)
> via_rhine(+) i2c_viapro(+) ac97_bus ohci_hcd(+) snd_mpu401_uart
> uhci_hcd(+) snd_rawmidi
> NIP: c00fa718 LR: c00fa718 CTR: 00000000
> REGS: ef271c00 TRAP: 0700   Not tainted  (3.0.4)
> MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22004428  XER: 00000000
> TASK = ef294c60[94] 'modprobe' THREAD: ef270000
> GPR00: c00fa718 ef271cb0 ef294c60 00000042 c0008904 00000001 00000000 00000000
> GPR08: c06b6bd8 00000000 22004482 ef271c70 22004422 10024440 1000ba68 00000000
> GPR16: 1000ba44 bf83e324 00000000 1000ba58 00000000 104410ec 00000a30 00000000
> GPR24: c0059210 00000124 00000000 00000001 ef271cd8 ef2ba480 ffffffef ef344000
> NIP [c00fa718] sysfs_add_one+0x88/0xa0
> LR [c00fa718] sysfs_add_one+0x88/0xa0
> Call Trace:
> [ef271cb0] [c00fa718] sysfs_add_one+0x88/0xa0 (unreliable)
> [ef271cd0] [c00faff4] sysfs_do_create_link+0x134/0x1e0
> [ef271d00] [c0392cf8] device_add+0x204/0x544
> [ef271d40] [c03d67e4] mdiobus_register+0xa4/0x198
> [ef271d60] [f26785a4] mv643xx_eth_shared_probe+0x144/0x428 [mv643xx_eth]
> [ef271d80] [c039685c] platform_drv_probe+0x20/0x30
> [ef271d90] [c0395578] driver_probe_device+0xe4/0x198
> [ef271db0] [c039569c] __driver_attach+0x70/0x98
> [ef271dd0] [c0394614] bus_for_each_dev+0x60/0x90
> [ef271e00] [c03951d0] driver_attach+0x24/0x34
> [ef271e10] [c0394d9c] bus_add_driver+0xbc/0x23c
> [ef271e30] [c0395ac8] driver_register+0xb8/0x144
> [ef271e50] [c0396bb4] platform_driver_register+0x68/0x78
> [ef271e60] [f2680024] mv643xx_eth_init_module+0x24/0x80 [mv643xx_eth]
> [ef271e80] [c000402c] do_one_initcall+0xe0/0x1c0
> [ef271eb0] [c005b438] sys_init_module+0x1600/0x17f4
> [ef271f40] [c0012df8] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xff62ac0
>    LR = 0x10003f2c
> Instruction dump:
> 807c0000 7fe4fb78 4bfff469 3c80c060 3884f131 4bf2051d 809d0010 4bf20515
> 7c641b78 3c60c060 3863f0fe 484650f9 <0fe00000> 7fe3fb78 4bfa8009 39610020
> ---[ end trace cebed1f190337b77 ]---
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: UHCI Host Controller
> usb usb2: Manufacturer: Linux 3.0.4 uhci_hcd
> usb usb2: SerialNumber: 0000:00:0c.2
> hub 2-0:1.0: USB hub found
> mii_bus 0 failed to register
> mv643xx_eth: probe of mv643xx_eth.0 failed with error -12
> hub 2-0:1.0: 2 ports detected
> ohci_hcd 0000:00:05.0: OHCI Host Controller
> ohci_hcd 0000:00:05.0: new USB bus registered, assigned bus number 3
> Unable to handle kernel paging request for data at address 0x00000000
> ohci_hcd 0000:00:05.0: irq 9, io mem 0x80000000
> Faulting instruction address: 0xf267b3a8
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT CHRP
> Modules linked in: snd_via82xx(+) snd_ac97_codec mv643xx_eth(+)
> via_rhine(+) i2c_viapro(+) ac97_bus ohci_hcd(+) snd_mpu401_uart
> uhci_hcd(+) snd_rawmidi
> NIP: f267b3a8 LR: f267b3a0 CTR: c0394ff4
> REGS: ef271c90 TRAP: 0300   Tainted: G        W    (3.0.4)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 84004448  XER: 00000000
> DAR: 00000000, DSISR: 40000000
> TASK = ef294c60[94] 'modprobe' THREAD: ef270000
> GPR00: 00000000 ef271d40 ef294c60 00000000 eec003c0 eec00005 ef24bb3c 00000000
> GPR08: ef24bb28 ef8a7600 ffffffff 00000001 44004442 10024440 1000ba68 00000000
> GPR16: 1000ba44 bf83e324 00000000 1000ba58 00000000 104410ec 00000a30 00000000
> GPR24: c0059210 c06b68c0 00000020 c06b68b8 fffffff4 eec00000 c06b6740 eec003c0
> NIP [f267b3a8] mv643xx_eth_probe+0x98/0x604 [mv643xx_eth]
> LR [f267b3a0] mv643xx_eth_probe+0x90/0x604 [mv643xx_eth]
> Call Trace:
> [ef271d40] [f267b394] mv643xx_eth_probe+0x84/0x604 [mv643xx_eth] (unreliable)
> [ef271d80] [c039685c] platform_drv_probe+0x20/0x30
> [ef271d90] [c0395578] driver_probe_device+0xe4/0x198
> [ef271db0] [c039569c] __driver_attach+0x70/0x98
> [ef271dd0] [c0394614] bus_for_each_dev+0x60/0x90
> [ef271e00] [c03951d0] driver_attach+0x24/0x34
> [ef271e10] [c0394d9c] bus_add_driver+0xbc/0x23c
> [ef271e30] [c0395ac8] driver_register+0xb8/0x144
> [ef271e50] [c0396bb4] platform_driver_register+0x68/0x78
> [ef271e60] [f2680034] mv643xx_eth_init_module+0x34/0x80 [mv643xx_eth]
> [ef271e80] [c000402c] do_one_initcall+0xe0/0x1c0
> [ef271eb0] [c005b438] sys_init_module+0x1600/0x17f4
> [ef271f40] [c0012df8] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xff62ac0
>    LR = 0x10003f2c
> Instruction dump:
> 7c7d1b79 41820530 3bfd03c0 3b3b0008 7fe4fb78 7f23cb78 48001101 807e0000
> 38630008 48001505 907d03c0 817e0004
> 556b502a 396b0400 7d605a14
> usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
> usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: OHCI Host Controller
> usb usb3: Manufacturer: Linux 3.0.4 ohci_hcd
> usb usb3: SerialNumber: 0000:00:05.0
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 3 ports detected
> vt596_smbus 0000:00:0c.4: SMBUS: Error: Host SMBus controller not
> enabled! - upgrade BIOS or use force=1
> VIA 82xx Audio 0000:00:0c.5: enabling device (0000 -> 0001)
> ---[ end trace cebed1f190337b78 ]---
> via-rhine 0000:00:0d.0: enabling device (0000 -> 0003)
> via-rhine 0000:00:0d.0: eth0: VIA Rhine II at 0x80001900,

	Regards,
	Gabriel
