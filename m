Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 536A8B70D0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 01:36:21 +1000 (EST)
Date: Thu, 12 Aug 2010 08:36:19 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
Message-ID: <20100812153618.GA7498@ovro.caltech.edu>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTikNt7hrxA+QR-omUiiLKVBnjqCw+HTDQh_5B5Ff@mail.gmail.com>
	<AANLkTi=-YiWtBqCGSt-h8dd3WwTMVJcDitvROCDBEMdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=-YiWtBqCGSt-h8dd3WwTMVJcDitvROCDBEMdw@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, MJ embd <mj.embd@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 12, 2010 at 03:55:49PM +0530, Ravi Gupta wrote:
> On Wed, Aug 11, 2010 at 9:45 PM, MJ embd <mj.embd@gmail.com> wrote:
> 
> > u can directly access GPIO registers in kernel, by ioremap of GPIO
> > memory mapped registers.
> > you might need to check
> > - muxing of gpio
> >
> > -mj
> >
> 
> Hi MJ,
> 
> Thanks for the reply.
> I tried memory mapping but it fails, here is my code :
> 
> #include <linux/module.h>
> #include <linux/errno.h>    /* error codes */
> #include <linux/mm.h>
> 
> void __iomem *ioaddr = NULL;
> 
> static __init int sample_module_init(void)
> {
>     ioaddr = ioremap(0xFF400C00, 0x24);
>     if(ioaddr == NULL) {
>         printk(KERN_WARNING "ioremap failed\n");
>     }
>     printk(KERN_WARNING "ioremap successed\n");
>     printk(KERN_WARNING "GP1DIR = %u\n", ioread32(ioaddr));
>     return 0;
> }
> 
> static __exit void sample_module_exit(void)
> {
>     iounmap(ioaddr);
> }
> 
> MODULE_LICENSE("GPL");
> module_init(sample_module_init);
> module_exit(sample_module_exit);
> 
> As per the MPC8377ERDB data sheet default IMMRBAR address is 0xFF40_0000 and
> offset of GPIO1 is 0C00 and each GPIO has programmable registers that occupy
> 24 bytes of memory-mapped space, so I mapped from 24bytes (0x18) starting
> from 0xFF40_0C00 address. But when I tried to read the values from the
> mapped memory I get the following errors. Is there something I am missing.
> Any help with reference to MPC8377ERDB board will be highly appreciable.
> 
> # tftp -l ~/immrbar.ko -r immrbar.ko -g 10.20.50.70
> # insmod ./immrbar.ko
> [  717.825241] ioremap successed
> [  717.849215] Machine check in kernel mode.
> [  717.853220] Caused by (from SRR1=41000): Transfer error ack signal
> [  717.859405] Oops: Machine check, sig: 7 [#1]
> [  717.863668] MPC837x RDB
> [  717.866106] Modules linked in: immrbar(+)
> [  717.870119] NIP: 00000900 LR: d1034054 CTR: c0014d50
> [  717.875079] REGS: cf895d00 TRAP: 0200   Not tainted  (2.6.28.9)
> [  717.880992] MSR: 00041000 <ME>  CR: 24000082  XER: 20000000
> [  717.886578] TASK = cf8e8640[647] 'insmod' THREAD: cf894000
> [  717.891882] GPR00: d103404c cf895db0 cf8e8640 00000000 000023d5 ffffffff
> c01e
> 04f4 00020000
> [  717.900265] GPR08: 00000001 c0383f3c 000023d5 c0014d50 4c72ff56 10019100
> 1007
> 77e0 1007ea98
> [  717.908650] GPR16: 10077834 100a0000 100a0000 100a0000 bfaf4828 00000000
> 1009
> f23c 10000cfc
> [  717.917034] GPR24: 10000d00 10000d24 10012008 c03650e8 00000000 d1034000
> 1001
> 2018 d1030000
> [  717.925598] NIP [00000900] 0x900
> [  717.928828] LR [d1034054] sample_module_init+0x54/0xc0 [immrbar]
> [  717.934828] Call Trace:
> [  717.937273] [cf895db0] [d103404c] sample_module_init+0x4c/0xc0 [immrbar]
> (unr
> eliable)
> [  717.945115] [cf895dc0] [c00038a0] do_one_initcall+0x64/0x18c
> [  717.950780] [cf895f20] [c004d7b8] sys_init_module+0xac/0x19c
> [  717.956441] [cf895f40] [c00122f0] ret_from_syscall+0x0/0x38
> [  717.962013] --- Exception: c01 at 0x48043f6c
> [  717.962017]     LR = 0x100009cc
> [  717.969407] Instruction dump:
> [  717.972370] 00000000 XXXXXXXX XXXXXXXX XXXXXXXX 00000000 XXXXXXXX
> XXXXXXXX XX
> XXXXXX
> [  717.980140] 00000000 XXXXXXXX XXXXXXXX XXXXXXXX 7d5043a6 XXXXXXXX
> XXXXXXXX XX
> XXXXXX
> [  717.987919] ---[ end trace a47be794e2873cef ]---
> 

Looking at the device tree for this board, it appears U-Boot remaps the
IMMR registers to 0xe0000000. They are no longer accessible at
0xff400000.

I would recommend studying arch/powerpc/boot/dts/mpc8377_rdb.dts in the
Linux source code. That describes the device layout on your board after
U-Boot has run.

A wonderful tool for testing devices from userspace is "busybox devmem".
It allows you to poke any physical address with any value. The output of
"busybox devmem --help" should get you started. As a quick example,
"busybox devmem 0xe0000c00 w 0x1" will write the 32-bit value 0x1 to
address 0xe0000c00.

I would also recommend using the built-in Linux GPIO API. It works, you
just need to figure out how to use it. It will be much easier to get
your code upstream if you use the provided APIs.

The Documentation/gpio.txt file should help you in understanding the
in-kernel Linux GPIO API. I'm afraid I don't have much experience other
than accessing it via sysfs from userspace.

Ira
