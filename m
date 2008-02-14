Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45584DDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 21:00:43 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1EA0THp014183
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 21:00:29 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1EA4KWx150190
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 21:04:20 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1EA0gVT004646
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 21:00:42 +1100
Message-ID: <47B4111C.1010301@linux.vnet.ibm.com>
Date: Thu, 14 Feb 2008 15:29:56 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.25-rc1-git1 softlockup while bootup on powerpc
References: <47B1463E.1070809@linux.vnet.ibm.com>
	<20080212075812.GC11775@elte.hu>
In-Reply-To: <20080212075812.GC11775@elte.hu>
Content-Type: text/plain; charset=us-ascii
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
>> While booting with the 2.6.25-rc1-git1 kernel on the powerbox the 
>> softlockup is seen, with following trace.
> 
>> BUG: soft lockup - CPU#1 stuck for 61s! [insmod:377]
>> TASK = c00000077cb2f0e0[377] 'insmod' THREAD: c00000077cb28000 CPU: 1
>> NIP [c0000000001b172c] .radix_tree_gang_lookup+0xdc/0x1e4
>> LR [c0000000001a6f00] .call_for_each_cic+0x50/0x10c
>> Call Trace:
>> [c00000077cb2bb20] [c0000000001a6f60] .call_for_each_cic+0xb0/0x10c (unreliable)
>> [c00000077cb2bc60] [c00000000019ecd8] .exit_io_context+0xf0/0x110
>> [c00000077cb2bcf0] [c00000000006254c] .do_exit+0x820/0x850
>> [c00000077cb2bda0] [c000000000062648] .do_group_exit+0xcc/0xe8
>> [c00000077cb2be30] [c00000000000872c] syscall_exit+0x0/0x40
> 
> this call_for_each_cic/radix_tree_gang_lookup locked up, and all other 
> CPUs deadlocked in stopmachine, due to this one.
> 
> call_for_each_cic is in ./block/cfq-iosched.c uses RCU, but you've got 
> classic-RCU:
> 
>   CONFIG_CLASSIC_RCU=y
>   # CONFIG_PREEMPT_RCU is not set
> 
> so it's not related to the preempt-RCU changes either.
> 
> It is this part that locks up:
> 
>         do {
> ...
>                 nr = radix_tree_gang_lookup(&ioc->radix_root, (void **) cics,
>                                                 index, CIC_GANG_NR);
> ...
>         } while (nr == CIC_GANG_NR);
> ...
> 
> it seems the radix tree will yield new entries again and again. Either 
> it got corrupted, or some other CPU is filling it faster than we can 
> deplete it [unlikely i think].
> 
> 	Ingo

This softlockup is seen with the 2.6.25-rc1-git3 also. Let me know if you
need more details.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
