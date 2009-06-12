Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD55AB7205
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:02:52 +1000 (EST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5DECDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 19:02:51 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5C92gv4004958
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 14:32:42 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5C92f831769694
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 14:32:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5C92f04013140
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 19:02:41 +1000
Message-ID: <4A3219B0.3040308@in.ibm.com>
Date: Fri, 12 Jun 2009 14:32:40 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 2.6.30-git3 boot failure on PowerPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.30-git3 fails to boot on Power6 box with following messages

[boot]0020 XICS Init
Unable to handle kernel paging request for data at address 0x00000020
Faulting instruction address: 0xc0000000000cb7d8
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in:
NIP: c0000000000cb7d8 LR: c0000000000cb780 CTR: 0000000000000002
REGS: c000000000ef3020 TRAP: 0300   Not tainted  (2.6.30-git3)
MSR: 8000000000001032 <ME,IR,DR>  CR: 28000024  XER: 00000001
DAR: 0000000000000020, DSISR: 0000000040000000
TASK = c000000000e32b40[0] 'swapper' THREAD: c000000000ef0000 CPU: 0
GPR00: 0000000000000000 c000000000ef32a0 c000000000ef21b0 0000000000000000
GPR04: 0000000000000000 0000000000000390 0000000000000370 c000000001453ce8
GPR08: c0000000014435b0 0000000000000000 0000000000000000 c0000000008931f0
GPR12: 8000000000009032 c000000000ff2400 00000000029698f5 0000000002a75be8
GPR16: 0000000000000000 0000000002a75be8 0000000001b5fc90 0000000000000000
GPR20: 0000000000000000 00000000000080d0 ffffffffffffffff c000000000ef3a70
GPR24: c000000041fff8a8 c000000000fa35f0 c000000000f71300 c000000000ef3450
GPR28: 0000000000000000 c00000000113a100 c000000000e6ab68 c000000000ef32a0
NIP [c0000000000cb7d8] .getnstimeofday+0x8c/0x148
LR [c0000000000cb780] .getnstimeofday+0x34/0x148
Call Trace:
[c000000000ef3340] [c0000000000c3ba0] .ktime_get_ts+0x5c/0xbc
[c000000000ef33e0] [c0000000000c3c34] .ktime_get+0x34/0x88
[c000000000ef3480] [c0000000000d02fc] .tick_nohz_stop_sched_tick+0x90/0x43c
[c000000000ef3570] [c0000000000a3dac] .irq_exit+0xac/0xc8
[c000000000ef35f0] [c00000000002ce78] .timer_interrupt+0xe0/0x110
[c000000000ef3680] [c000000000003718] decrementer_common+0x118/0x180
--- Exception: 901 at .raw_local_irq_restore+0x74/0x8c
    LR = .__slab_alloc+0x2e0/0x5bc
[c000000000ef3970] [c000000000ef3a10] init_thread_union+0x3a10/0x4000 (unreliable)
[c000000000ef3a00] [c0000000001845f0] .__slab_alloc+0x2e0/0x5bc
[c000000000ef3ae0] [c000000000186410] .__kmalloc+0x160/0x238
[c000000000ef3ba0] [c00000000004a608] .zalloc_maybe_bootmem+0x4c/0xa8
[c000000000ef3c30] [c00000000000d810] .irq_alloc_host+0x74/0x250
[c000000000ef3cf0] [c00000000084906c] .xics_init_IRQ+0x344/0x3e0
[c000000000ef3de0] [c000000000848394] .pseries_xics_init_IRQ+0x18/0x34
[c000000000ef3e60] [c00000000083387c] .init_IRQ+0x44/0x64
[c000000000ef3ee0] [c000000000830a78] .start_kernel+0x238/0x460
[c000000000ef3f90] [c0000000000083ec] .start_here_common+0x1c/0x30
Instruction dump:
7c2004ac 7b8007e1 41820010 7c210b78 7c421378 4bffffe8 ebbe8000 e93d0010
e95d0018 f93b0000 f95b0008 e87d0020 <e9230020> e8090000 f8410028 7c0903a6
---[ end trace 31fd0ba7d8756001 ]---

git2 boots fine with the same config. 

I came across the following mail from Ben so this could be a know issue.

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073102.html

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
