Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43D18B708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Jun 2009 22:05:03 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6A22DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 22:05:02 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n55C4vfh001533
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 17:34:57 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n55C4vLF884856
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 17:34:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n55C4usM006100
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 22:04:57 +1000
Message-ID: <4A2909E8.6000507@in.ibm.com>
Date: Fri, 05 Jun 2009 17:34:56 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
In-Reply-To: <4A081002.4050802@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Today's Next tree failed to boot on a Power6 box with following BUG :
>
> BUG: spinlock bad magic on CPU#1, modprobe/63
> Unable to handle kernel paging request for data at address 0xffffc994838
> Faulting instruction address: 0xc00000000035f5a8
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=1024 DEBUG_PAGEALLOC NUMA pSeries
> Modules linked in: scsi_mod(+)
> NIP: c00000000035f5a8 LR: c00000000035f58c CTR: 0000000000136f8c
> REGS: c0000000c7d03500 TRAP: 0300   Not tainted  
> (2.6.30-rc5-autotest-next-20090511)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 28222484  XER: 0000000f
> DAR: 00000ffffc994838, DSISR: 0000000040000000
> TASK = c0000000c7cf0a80[63] 'modprobe' THREAD: c0000000c7d00000 CPU: 1
> GPR00: c00000000035f58c c0000000c7d03780 c000000000aaeed8 
> 0000000000000031 GPR04: 0000000000000000 00000000585cf4e0 
> 0000000000673580 80000000565a6cc0 GPR08: 0000000000000000 
> c0000000009ebf50 0000000000000000 c0000000009ebf38 GPR12: 
> 0000000028222482 c000000000b82600 0000000000000000 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000 GPR20: 0000000000000018 ffffffffffffffff 
> c0000000009bbe40 0000000000000010 GPR24: 0000000000210d00 
> c0000000c6caff80 c0000000dfc732a0 c000000000f61380 GPR28: 
> c0000000007c8350 c0000000008a4280 c000000000a2f928 00000ffffc994550 
> NIP [c00000000035f5a8] .spin_bug+0x90/0xd4
> LR [c00000000035f58c] .spin_bug+0x74/0xd4
> Call Trace:
> [c0000000c7d03780] [c00000000035f58c] .spin_bug+0x74/0xd4 (unreliable)
> [c0000000c7d03810] [c00000000035f890] ._raw_spin_lock+0x48/0x184
> [c0000000c7d038b0] [c0000000005d67d8] ._spin_lock+0x10/0x24
> [c0000000c7d03920] [c00000000013fbdc] .__slab_alloc_page+0x344/0x3cc
> [c0000000c7d039e0] [c000000000141168] .kmem_cache_alloc+0x13c/0x21c
> [c0000000c7d03aa0] [c000000000141b04] .kmem_cache_create+0x294/0x2a8
> [c0000000c7d03b90] [d000000000ea14cc] .scsi_init_queue+0x38/0x170 
> [scsi_mod]
> [c0000000c7d03c20] [d000000000ea13c8] .init_scsi+0x1c/0xe8 [scsi_mod]
> [c0000000c7d03ca0] [c0000000000092c0] .do_one_initcall+0x80/0x19c
> [c0000000c7d03d90] [c0000000000c0540] .SyS_init_module+0xe0/0x244
> [c0000000c7d03e30] [c000000000008534] syscall_exit+0x0/0x40
> Instruction dump:
> 7f84e378 e87e8020 38c604d0 e8e902ea 4827fced 60000000 2fbf0000 
> 80bd0004 409e0010 e8de8028 38e0ffff 4800000c <e8ff02ea> 38df04d0 
> 7fa4eb78 811d0008 ---[ end trace f725820a6fa9dbb7 ]---
> /init: line 21:    63 Segmentation fault      modprobe $file
>
Nick, Pekka

I can still recreate this bug on a Power 6 hardware with today's next tree.
I can recreate this problem at will.
Let me know if i can help in debugging this problem.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
