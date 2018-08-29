Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420dQH47NtzF2QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:02:31 +1000 (AEST)
Date: Wed, 29 Aug 2018 10:02:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Message-ID: <20180829080219.GN24124@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2018 at 10:30:19PM +0530, Srikar Dronamraju wrote:
> With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> sched domain") scheduler introduces an new numa level. However on shared
> lpars like powerpc, this extra sched domain creation can lead to
> repeated rcu stalls, sometimes even causing unresponsive systems on
> boot. On such stalls, it was noticed that init_sched_groups_capacity()
> (sg != sd->groups is always true).
> 
> INFO: rcu_sched self-detected stall on CPU
>  1-....: (240039 ticks this GP) idle=c32/1/4611686018427387906 softirq=782/782 fqs=80012
>   (t=240039 jiffies g=6272 c=6271 q=263040)
> NMI backtrace for cpu 1

> --- interrupt: 901 at __bitmap_weight+0x70/0x100
>     LR = __bitmap_weight+0x78/0x100
> [c00000832132f9b0] [c0000000009bb738] __func__.61127+0x0/0x20 (unreliable)
> [c00000832132fa00] [c00000000016c178] build_sched_domains+0xf98/0x13f0
> [c00000832132fb30] [c00000000016d73c] partition_sched_domains+0x26c/0x440
> [c00000832132fc20] [c0000000001ee284] rebuild_sched_domains_locked+0x64/0x80
> [c00000832132fc50] [c0000000001f11ec] rebuild_sched_domains+0x3c/0x60
> [c00000832132fc80] [c00000000007e1c4] topology_work_fn+0x24/0x40
> [c00000832132fca0] [c000000000126704] process_one_work+0x1a4/0x470
> [c00000832132fd30] [c000000000126a68] worker_thread+0x98/0x540
> [c00000832132fdc0] [c00000000012f078] kthread+0x168/0x1b0
> [c00000832132fe30] [c00000000000b65c]
> ret_from_kernel_thread+0x5c/0x80
> 
> Similar problem was earlier also reported at
> https://lwn.net/ml/linux-kernel/20180512100233.GB3738@osiris/
> 
> Allow arch to set and clear masks corresponding to numa sched domain.

What this Changelog fails to do is explain the problem and motivate why
this is the right solution.

As-is, this reads like, something's buggered, I changed this random thing
and it now works.

So what is causing that domain construction error?
