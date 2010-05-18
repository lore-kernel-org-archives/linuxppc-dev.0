Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id F3359B7D12
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 02:31:04 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1OEPh7-0000UC-3W
	for linuxppc-dev@ozlabs.org; Tue, 18 May 2010 18:31:01 +0200
Received: from ppp-182-111.98-62.inwind.it ([62.98.111.182])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 18:31:01 +0200
Received: from ppc.addon by ppp-182-111.98-62.inwind.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 18:31:01 +0200
To: linuxppc-dev@ozlabs.org
From: nello martuscielli <ppc.addon@gmail.com>
Subject: Re: "event-scan failed" logflood
Date: Tue, 18 May 2010 16:30:50 +0000 (UTC)
Message-ID: <loom.20100518T182547-195@post.gmane.org>
References: <20100513111603.3352.qmail@kosh.dhis.org>
	<1273786104.21352.190.camel@pasglop>
	<loom.20100517T145602-17@post.gmane.org>
	<1274185991.26143.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael <at> ellerman.id.au> writes:

_omissis__
> > 
> > hi, is there available that patch?
> > With the fresh new 2.6.34 the logflood problem is still present.
> 
> You could try this, completely untested:
> 
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 4190eae..fd68bed 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -490,6 +490,12 @@ static int __init rtas_init(void)
>                 return -ENODEV;
>         }
> 
> +       if (!rtas_event_scan_rate) {
> +               /* Broken firmware: take a rate of zero to mean don't scan */
> +               printk(KERN_DEBUG "rtasd: scan rate is 0, not scanning\n");
> +               return 0;
> +       }
> +
>         /* Make room for the sequence number */
>         rtas_error_log_max = rtas_get_error_log_max();
>         rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
> 


hi Michael, thanks for pointing me to that patch, now my Pegasos2 G4 seems to
work fine.
Anyway i got these dumps caused by mv643xx_eth:


[...]
sysfs: cannot create duplicate filename '/class/mdio_bus/0'
------------[ cut here ]------------
Badness at fs/sysfs/dir.c:451
NIP: c00efc70 LR: c00efc70 CTR: 00000000
REGS: ef117c70 TRAP: 0700   Not tainted  (2.6.34)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22002488  XER: 00000000
TASK = ef110630[80] 'modprobe' THREAD: ef116000
GPR00: c00efc70 ef117d20 ef110630 00000042 c0009480 00000000 00134ac8 00000000
GPR08: 00000000 00000000 22002482 10000002 ffffffff 10023ab8 00000000 00000000
GPR16: 00000000 107db0b0 00000000 107db088 10005558 00000003 107db324 107db008
GPR24: 10005558 00000000 0000a9ce fffffffe ef117d48 ef0a4300 efb87000 ffffffef
NIP [c00efc70] sysfs_add_one+0x88/0xb8
LR [c00efc70] sysfs_add_one+0x88/0xb8
Call Trace:
[ef117d20] [c00efc70] sysfs_add_one+0x88/0xb8 (unreliable)
[ef117d40] [c00f0d9c] sysfs_do_create_link+0x104/0x1ac
[ef117d70] [c026b238] device_add+0x1c8/0x534
[ef117db0] [c02b2e40] mdiobus_register+0xb4/0x1d8
[ef117de0] [f222c510] mv643xx_eth_shared_probe+0x14c/0x420 [mv643xx_eth]
[ef117e00] [c026f4b4] platform_drv_probe+0x20/0x30
[ef117e10] [c026e044] driver_probe_device+0xdc/0x194
[ef117e30] [c026e174] __driver_attach+0x78/0xb4
[ef117e50] [c026d610] bus_for_each_dev+0x68/0xc0
[ef117e80] [c026de3c] driver_attach+0x24/0x34
[ef117e90] [c026cdbc] bus_add_driver+0xc8/0x278
[ef117eb0] [c026e59c] driver_register+0xd0/0x188
[ef117ed0] [c026f82c] platform_driver_register+0x6c/0x7c
[ef117ee0] [f223602c] mv643xx_eth_init_module+0x2c/0x90 [mv643xx_eth]
[ef117f00] [c0003eec] do_one_initcall+0x70/0x20c
[ef117f20] [c005ccb4] sys_init_module+0xf4/0x248
[ef117f40] [c0015b20] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff654b8
    LR = 0x10002e7c
Instruction dump:
807c0000 7fc4f378 4bffff3d 3c80c043 38843afa 4bf2bb8d 809d0010 4bf2bb85
7c641b78 3c60c043 38633ac7 482c7d91 <0fe00000> 7fc3f378 4bfa4f75 80010024
mii_bus 0 failed to register
mv643xx_eth: probe of mv643xx_eth.0 failed with error -12
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xf222f26c
usbcore: registered new interface driver hiddev
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT CHRP
last sysfs file: /sys/devices/virtual/tty/ptyv3/uevent
Modules linked in: snd_mpu401_uart usbhid(+) snd_rawmidi mv643xx_eth(+) firewire
_core via_rhine i2c_viapro
NIP: f222f26c LR: f222f264 CTR: c026daf0
REGS: ef117d10 TRAP: 0300   Tainted: G        W   (2.6.34)
MSR: 00009032 <EE,ME,IR,DR>  CR: 84002488  XER: 20000000
DAR: 00000000, DSISR: 40000000
TASK = ef110630[80] 'modprobe' THREAD: ef116000
GPR00: f222f258 ef117dc0 ef110630 00000000 efa9e320 efa9e005 efa9e155 00000000
GPR08: 00000400 ef856cc0 efa9e314 00000001 ffffffff 10023ab8 00000000 00000000
GPR16: 00000000 107db0b0 00000000 107db088 10005558 00000003 107db324 107db008
GPR24: 10005558 c04ca290 0000a9ce c04ca288 c04ca138 fffffff4 efa9e000 efa9e320
NIP [f222f26c] mv643xx_eth_probe+0xd8/0x690 [mv643xx_eth]
LR [f222f264] mv643xx_eth_probe+0xd0/0x690 [mv643xx_eth]
Call Trace:
[ef117dc0] [f222f258] mv643xx_eth_probe+0xc4/0x690 [mv643xx_eth] (unreliable)
[ef117e00] [c026f4b4] platform_drv_probe+0x20/0x30
[ef117e10] [c026e044] driver_probe_device+0xdc/0x194
[ef117e30] [c026e174] __driver_attach+0x78/0xb4
[ef117e50] [c026d610] bus_for_each_dev+0x68/0xc0
[ef117e80] [c026de3c] driver_attach+0x24/0x34
[ef117e90] [c026cdbc] bus_add_driver+0xc8/0x278
[ef117eb0] [c026e59c] driver_register+0xd0/0x188
[ef117ed0] [c026f82c] platform_driver_register+0x6c/0x7c
[ef117ee0] [f223603c] mv643xx_eth_init_module+0x3c/0x90 [mv643xx_eth]
[ef117f00] [c0003eec] do_one_initcall+0x70/0x20c
[ef117f20] [c005ccb4] sys_init_module+0xf4/0x248
[ef117f40] [c0015b20] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff654b8
    LR = 0x10002e7c
Instruction dump:
7c7e1b79 41820544 3bfe0320 3b3b0008 7f23cb78 7fe4fb78 480019e5 807c0000
38630008 48001dc9 907e0320 817c0004 <80030000> 556b502a 396b0400 7d605a14
[...]

cheers,
nello
