Return-Path: <mike.dyer@provision-comm.com>
Received: from smtp1.betherenow.co.uk (smtp1.betherenow.co.uk [87.194.0.68])
	by ozlabs.org (Postfix) with SMTP id 53D22DDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 21:06:32 +1100 (EST)
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
From: Mike Dyer <mike.dyer@provision-comm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>
References: <48F49D7D.5070107@provision-comm.com>
	<48F4A8CD.6000101@provision-comm.com>
	<22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 11:06:25 +0100
Message-Id: <1224065185.457.31.camel@mike-linux.provision-comm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

On Tue, 2008-10-14 at 09:35 -0500, Kumar Gala wrote: 
> On Oct 14, 2008, at 9:12 AM, Mike Dyer wrote:
> 
> > Hi All,
> >
> > Apologies for the bad formatting of the previous message...
> >
> > I've just pulled the 2.6.27 kernel from git and am trying it out on  
> > my MPC8313E RDB dev kit.  I get the following badness during boot  
> > (the complete boot record is attached later) :
> 
> can you enable kernel symbols in your build (CONFIG_KALLSYMS)

I can, but it no longer boots...  Will keep trying.

I've gone through my system.map and pulled out the call stack, if that
helps.  I put a printk in sysfs_add_one, and it appears it is being
called with sd->s_name = 'e00082a8.dma'

> ------------[ cut here ]------------
> Badness at c00c5b50 [verbose debug info unavailable]
> NIP: c00c5b50 LR: c00c5b38 CTR: 00000000
> REGS: c7827d90 TRAP: 0700   Not tainted  (2.6.27)
> MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER: 20000000
> TASK = c7816400[1] 'swapper' THREAD: c7826000
> GPR00: c00c5b38 c7827e40 c7816400 ffffffef c7800e5c c7800b7c c7811570 00000000 
> GPR08: 000001a0 c0370000 00000048 00000000 82044048 100b224c 07ffb000 00000000 
> GPR16: 07ff09e0 07ff94c8 00000000 00000000 00000000 c035a76c c035a740 c7ace610 
> GPR24: 00000000 00000000 00000000 00000001 c7811570 fffffffe c7acdc00 c7827e58 
> Call Trace:
> [c7827e40] [c00c5b38] 0xc00c5b38 (unreliable) sysfs_add_one
> [c7827e50] [c00c6dc0] 0xc00c6dc0              sysfs_do_create_link
> [c7827e80] [c0182d40] 0xc0182d40              bus_add_device
> [c7827ea0] [c018153c] 0xc018153c              device_add
> [c7827ef0] [c0213a14] 0xc0213a14              of_device_register
> [c7827f00] [c0009818] 0xc0009818              of_platform_device_create
> [c7827f10] [c00098c0] 0xc00098c0              of_platform_bus_create
> [c7827f30] [c0009a30] 0xc0009a30              of_platform_bus_probe
> [c7827f50] [c03281d4] 0xc03281d4              __machine_initcall_mpc831x_rdb_declare_of_platform_devices
> [c7827f60] [c0003874] 0xc0003874              do_one_initcall
> [c7827fd0] [c031317c] 0xc031317c              kernel_init
> [c7827ff0] [c001216c] 0xc001216c              kernel_thread

> 
> - k

Cheers,
Mike
