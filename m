Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 545552C011E
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 08:40:33 +1000 (EST)
Message-ID: <1378852822.12204.371.camel@snotra.buserror.net>
Subject: Re: Power PC Build problem
From: Scott Wood <scottwood@freescale.com>
To: Jason Rennie <jason.rennie@rftechnology.com.au>
Date: Tue, 10 Sep 2013 17:40:22 -0500
In-Reply-To: <5226A3E3.2050308@rftechnology.com.au>
References: <5226A3E3.2050308@rftechnology.com.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-04 at 13:07 +1000, Jason Rennie wrote:
> But when I try building it with the latest buildroot (2013.08) and I
> configure the kernel (3.10.10) I get one of two things. If I don't
> include specific settings for physmap compat support (Device Drivers
> -> MTD Support -> Mapping drivers for chip access) then I get a kernel
> panic when it can't mount the root filesystem as follows 
[snip]
> ----------- 
> and when I do include the physmap settings 
> 
> <*> Flash device in physical memory map 
>  [*]   Physmap compat support 
>   (0xFF000000) Physical start address of flash mapping 
>   (0x1000000) Physical length of flash mapping 
>   (2)     Bank width in octets 
> 
> which I took from the earlier build and do seem to be right, it does
> the following. 
> -------------------- 
> f0011a00.serial: ttyCPM0 at MMIO 0xc505ea00 (irq = 40) is a CPM UART 
> f0011a60.serial: ttyCPM1 at MMIO 0xc5060a60 (irq = 43) is a CPM UART 
> brd: module loaded 
> physmap platform flash device: 01000000 at ff000000 
> Machine check in kernel mode. 
> Caused by (from SRR1=49030): Transfer error ack signal 
> Oops: Machine check, sig: 7 [#1] 
> PREEMPT Freescale MPC8272 ADS 
> Modules linked in: 
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.10 #12 
> task: c3830000 ti: c3832000 task.ti: c3832000 
> NIP: c01a5da8 LR: c01a6200 CTR: c01a60cc 
> REGS: c3833c00 TRAP: 0200   Not tainted  (3.10.10) 
> MSR: 00049030 <EE,ME,IR,DR>  CR: 22000022  XER: 00000000 
> 
> GPR00: c01a59a0 c3833cb0 c3830000 00000000 c39c0e24 c3833cf8 00000002
> 00000aaa 
> GPR08: c5080000 0000aaaa 00000002 00000002 42000024 00000000 c000406c
> 00000000 
> GPR16: 00000000 00000000 c39c0e24 c02c9ff4 00000001 c02c8d30 c02c9fe8
> c0356e23 
> GPR24: c02c8d78 00000001 00000000 00000001 c03b89d8 00000000 c39c0e24
> c3833cf8 
> NIP [c01a5da8] jedec_reset+0x124/0x448 
> LR [c01a6200] jedec_probe_chip+0x134/0x1050 
> Call Trace: 
> [c3833cb0] [c002d900] call_usermodehelper_exec+0x154/0x160
> (unreliable) 
> [c3833cf0] [c01a59a0] mtd_do_chip_probe+0x78/0x34c 
> [c3833d70] [c01a73a8] physmap_flash_probe+0x1ec/0x30c 
> [c3833db0] [c01996c8] driver_probe_device+0xb8/0x1f4 
> [c3833dd0] [c0197a64] bus_for_each_drv+0x60/0xa8 
> [c3833e00] [c01995d8] device_attach+0x7c/0x94 
> [c3833e20] [c0198ac4] bus_probe_device+0x34/0xac 
> [c3833e40] [c0196f94] device_add+0x3d4/0x570 
> [c3833e80] [c019acd0] platform_device_add+0x164/0x1dc 
> [c3833ea0] [c039a438] physmap_init+0x34/0x50 
> [c3833ec0] [c0003acc] do_one_initcall+0xdc/0x180 
> [c3833ef0] [c0386bcc] kernel_init_freeable+0x11c/0x1c0 
> [c3833f30] [c0004088] kernel_init+0x1c/0xf4 
> [c3833f40] [c000d3a8] ret_from_kernel_thread+0x5c/0x64 
> Instruction dump: 
> 5529063e 7d2839ae 48000024 2f8a0002 40be0010 5529043e 7d283b2e
> 48000010 
> 2f8a0004 409e0324 7d28392e 7c0004ac <81250008> 8105000c 81440018
> 7d6849d6 
> ---[ end trace 06e97f39189bf8ef ]--- 
> 
> Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000007 
> 
> Rebooting in 1 seconds.. 
> -------------------- 
> I assume it is crashing when it tries to probe the flash chips? 
> 
> I'm at a loss to work out what I am doing wrong here. Can anybody
> offer any pointers? 

It sounds like the address you're specifying for flash is incorrect.
You shouldn't need to specify it this way; the information is in the
device tree (and for mpc8272ads the device tree says it's at
0xff800000).

Do you have CONFIG_MTD_PHYSMAP_OF enabled?

BTW, I don't see how this is a "build problem".

-Scott
