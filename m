Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7304DDEED
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 18:58:48 +1100 (EST)
Date: Tue, 12 Feb 2008 08:58:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.25-rc1-git1 softlockup while bootup on powerpc
Message-ID: <20080212075812.GC11775@elte.hu>
References: <47B1463E.1070809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B1463E.1070809@linux.vnet.ibm.com>
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


* Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> While booting with the 2.6.25-rc1-git1 kernel on the powerbox the 
> softlockup is seen, with following trace.

> BUG: soft lockup - CPU#1 stuck for 61s! [insmod:377]
> TASK = c00000077cb2f0e0[377] 'insmod' THREAD: c00000077cb28000 CPU: 1
> NIP [c0000000001b172c] .radix_tree_gang_lookup+0xdc/0x1e4
> LR [c0000000001a6f00] .call_for_each_cic+0x50/0x10c
> Call Trace:
> [c00000077cb2bb20] [c0000000001a6f60] .call_for_each_cic+0xb0/0x10c (unreliable)
> [c00000077cb2bc60] [c00000000019ecd8] .exit_io_context+0xf0/0x110
> [c00000077cb2bcf0] [c00000000006254c] .do_exit+0x820/0x850
> [c00000077cb2bda0] [c000000000062648] .do_group_exit+0xcc/0xe8
> [c00000077cb2be30] [c00000000000872c] syscall_exit+0x0/0x40

this call_for_each_cic/radix_tree_gang_lookup locked up, and all other 
CPUs deadlocked in stopmachine, due to this one.

call_for_each_cic is in ./block/cfq-iosched.c uses RCU, but you've got 
classic-RCU:

  CONFIG_CLASSIC_RCU=y
  # CONFIG_PREEMPT_RCU is not set

so it's not related to the preempt-RCU changes either.

It is this part that locks up:

        do {
...
                nr = radix_tree_gang_lookup(&ioc->radix_root, (void **) cics,
                                                index, CIC_GANG_NR);
...
        } while (nr == CIC_GANG_NR);
...

it seems the radix tree will yield new entries again and again. Either 
it got corrupted, or some other CPU is filling it faster than we can 
deplete it [unlikely i think].

	Ingo
