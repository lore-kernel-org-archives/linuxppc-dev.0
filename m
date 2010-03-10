Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5DCA1B7CA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 03:43:40 +1100 (EST)
Date: Wed, 10 Mar 2010 17:43:23 +0100
From: Gabriel Paubert <paubert@iram.es>
To: acrux <acrux_it@libero.it>
Subject: Re: mv643xx_eth broken again on pegasos2 G4
Message-ID: <20100310164323.GB9743@iram.es>
References: <20100310161441.6e76143f.acrux_it@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100310161441.6e76143f.acrux_it@libero.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 10, 2010 at 04:14:41PM +0100, acrux wrote:
> hi,
> mv643xx_eth driver seems to be broken (and very often there is a kernel panic too).
> Last working kernel is 2.6.31.2
> 
> here a dmesg from 2.6.32.9:

My Pegasos running a pristine 2.6.32 seems to disagree with you.

[...]
Linux version 2.6.32 (xxx@yyy) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #129 Mon Jan 18 16:29:40 GMT 2010
Found legacy serial port 0 for /pci@80000000/isa@C/serial@i2F8
  port=2f8, taddr=fe0002f8, irq=0, clk=1843200, speed=0
chrp type = 6 [Genesi Pegasos]
[...]
MV-643xx 10/100/1000 ethernet driver version 1.4
mv643xx_eth smi: probed
net eth1: port 1 with MAC address 00:0b:2f:15:10:ef
net eth1: configured with sram
[...]

This said I cannot go close to it right now to compile and test
something newer. But I can connect to it through the network
and it uses the mv643xx_eth port.

The difference may be that mv643xx_eth is built-in and not modular.

> MV-643xx 10/100/1000 ethernet driver version 1.4
> sysfs: cannot create duplicate filename '/class/mdio_bus/0'
> ------------[ cut here ]------------
> Badness at fs/sysfs/dir.c:491
> NIP: c00dc568 LR: c00dc568 CTR: c00200ac
> REGS: ef015c70 TRAP: 0700   Not tainted  (2.6.32.9)
> MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22422488  XER: 00000000
> TASK = ef082bc0[1011] 'modprobe' THREAD: ef014000
> GPR00: c00dc568 ef015d20 ef082bc0 00000042 c04303f0 c04303f0 00000000 00000001
> GPR08: 00000000 00000000 01430ee0 ffffffff 81f2ba43 10020a5c 00000000 00000000
> GPR16: 00000000 00000000 100056bc 00000003 4801f000 00000000 00000000 c0430120
> GPR24: 107fb560 107fb57c ef17fc48 00000001 ffffffef ef015d48 ef108030 ef355000
> NIP [c00dc568] sysfs_add_one+0x7c/0xa0
> LR [c00dc568] sysfs_add_one+0x7c/0xa0
> Call Trace:
> [ef015d20] [c00dc568] sysfs_add_one+0x7c/0xa0 (unreliable)
> [ef015d40] [c00dd700] sysfs_do_create_link+0xf4/0x188
> [ef015d70] [c022ffbc] device_add+0x1a8/0x51c
> [ef015db0] [c026be38] mdiobus_register+0xa0/0x1ac
> [ef015de0] [f224d5dc] mv643xx_eth_shared_probe+0x140/0x3f8 [mv643xx_eth]
> [ef015e00] [c0233dd0] platform_drv_probe+0x20/0x30
> [ef015e10] [c0232a4c] driver_probe_device+0xd4/0x1a8
> [ef015e30] [c0232b90] __driver_attach+0x70/0xa4
> [ef015e50] [c02320cc] bus_for_each_dev+0x5c/0xac
> [ef015e80] [c023285c] driver_attach+0x24/0x34
> [ef015e90] [c0231910] bus_add_driver+0xb4/0x248
> [ef015eb0] [c0232f78] driver_register+0xd0/0x174
> [ef015ed0] [c023412c] platform_driver_register+0x6c/0x7c
> [ef015ee0] [f2256024] mv643xx_eth_init_module+0x24/0x80 [mv643xx_eth]
> [ef015f00] [c0003ee0] do_one_initcall+0x64/0x1f8
> [ef015f20] [c0054680] sys_init_module+0xe0/0x224
> [ef015f40] [c0013828] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xff69720
>     LR = 0x10004150
> Instruction dump:
> 807d0000 7fe4fb78 4bffff51 3c80c03a 3884adb0 4bf3ce4d 809e0010 4bf3ce45
> 7c641b78 3c60c03b 38639868 48259099 <0fe00000> 7fe3fb78 4bfaac0d 80010024
> mii_bus 0 failed to register
> mv643xx_eth: probe of mv643xx_eth.0 failed with error -12
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xf2250908
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT CHRP
> Modules linked in: mv643xx_eth(+) via_rhine serio_raw parport firewire_core
> NIP: f2250908 LR: f2250900 CTR: c0232574
> REGS: ef015d10 TRAP: 0300   Tainted: G        W   (2.6.32.9)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 84422488  XER: 20000000
> DAR: 00000000, DSISR: 40000000
> TASK = ef082bc0[1011] 'modprobe' THREAD: ef014000
> GPR00: f22508f4 ef015dc0 ef082bc0 00000000 efb42300 efb42005 efb4214d 00000000
> GPR08: 00000000 00000001 2bfd0c6b c0232574 00000000 10020a5c 00000000 00000000
> GPR16: 00000000 00000000 100056bc 00000003 c0430230 00000000 00000000 00000000
> GPR24: c0430228 107fb57c 00000000 efb42000 f22528c0 fffffff4 c04300d8 efb42300
> NIP [f2250908] mv643xx_eth_probe+0xac/0x620 [mv643xx_eth]
> LR [f2250900] mv643xx_eth_probe+0xa4/0x620 [mv643xx_eth]
> Call Trace:
> [ef015dc0] [f22508f4] mv643xx_eth_probe+0x98/0x620 [mv643xx_eth] (unreliable)
> [ef015e00] [c0233dd0] platform_drv_probe+0x20/0x30
> [ef015e10] [c0232a4c] driver_probe_device+0xd4/0x1a8
> [ef015e30] [c0232b90] __driver_attach+0x70/0xa4
> [ef015e50] [c02320cc] bus_for_each_dev+0x5c/0xac
> [ef015e80] [c023285c] driver_attach+0x24/0x34
> [ef015e90] [c0231910] bus_add_driver+0xb4/0x248
> [ef015eb0] [c0232f78] driver_register+0xd0/0x174
> [ef015ed0] [c023412c] platform_driver_register+0x6c/0x7c
> [ef015ee0] [f2256034] mv643xx_eth_init_module+0x34/0x80 [mv643xx_eth]
> [ef015f00] [c0003ee0] do_one_initcall+0x64/0x1f8
> [ef015f20] [c0054680] sys_init_module+0xe0/0x224
> [ef015f40] [c0013828] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xff69720
>     LR = 0x10004150
> Instruction dump:
> 7c7b1b79 41820528 3bfb0300 3a980008 7e83a378 7fe4fb78 48000dd1 807e0000
> 38630008 480011b5 907b0300 813e0004 <80030000> 5529502a 39290400 7c004a14
> ---[ end trace 1a9241f24ee15efc ]---

	Gabriel
