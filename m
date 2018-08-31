Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421wXn35PDzF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 20:27:36 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7VANkvs118366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 06:27:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m73dh9ees-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 06:27:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 31 Aug 2018 11:27:32 +0100
Date: Fri, 31 Aug 2018 03:27:24 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
 <20180829080219.GN24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180829080219.GN24124@hirez.programming.kicks-ass.net>
Message-Id: <20180831102724.GB8437@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <peterz@infradead.org> [2018-08-29 10:02:19]:

> On Fri, Aug 10, 2018 at 10:30:19PM +0530, Srikar Dronamraju wrote:
> > With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> > sched domain") scheduler introduces an new numa level. However on shared
> > lpars like powerpc, this extra sched domain creation can lead to
> > repeated rcu stalls, sometimes even causing unresponsive systems on
> > boot. On such stalls, it was noticed that init_sched_groups_capacity()
> > (sg != sd->groups is always true).
> > 
> > INFO: rcu_sched self-detected stall on CPU
> >  1-....: (240039 ticks this GP) idle=c32/1/4611686018427387906 softirq=782/782 fqs=80012
> >   (t=240039 jiffies g=6272 c=6271 q=263040)
> > NMI backtrace for cpu 1
> 
> > --- interrupt: 901 at __bitmap_weight+0x70/0x100
> >     LR = __bitmap_weight+0x78/0x100
> > [c00000832132f9b0] [c0000000009bb738] __func__.61127+0x0/0x20 (unreliable)
> > [c00000832132fa00] [c00000000016c178] build_sched_domains+0xf98/0x13f0
> > [c00000832132fb30] [c00000000016d73c] partition_sched_domains+0x26c/0x440
> > [c00000832132fc20] [c0000000001ee284] rebuild_sched_domains_locked+0x64/0x80
> > [c00000832132fc50] [c0000000001f11ec] rebuild_sched_domains+0x3c/0x60
> > [c00000832132fc80] [c00000000007e1c4] topology_work_fn+0x24/0x40
> > [c00000832132fca0] [c000000000126704] process_one_work+0x1a4/0x470
> > [c00000832132fd30] [c000000000126a68] worker_thread+0x98/0x540
> > [c00000832132fdc0] [c00000000012f078] kthread+0x168/0x1b0
> > [c00000832132fe30] [c00000000000b65c]
> > ret_from_kernel_thread+0x5c/0x80
> > 
> > Similar problem was earlier also reported at
> > https://lwn.net/ml/linux-kernel/20180512100233.GB3738@osiris/
> > 
> > Allow arch to set and clear masks corresponding to numa sched domain.
> 

> What this Changelog fails to do is explain the problem and motivate why
> this is the right solution.
> 
> As-is, this reads like, something's buggered, I changed this random thing
> and it now works.
> 
> So what is causing that domain construction error?
> 

Powerpc lpars running on Phyp have 2 modes. Dedicated and shared.

Dedicated lpars are similar to kvm guest with vcpupin.

Shared  lpars are similar to kvm guest without any pinning. When running
shared lpar mode, Phyp allows overcommitting. Now if more lpars are
created/destroyed, Phyp will internally move / consolidate the cores. The
objective is similar to what autonuma tries achieves on the host but with a
different approach (consolidating to optimal nodes to achieve the best
possible output).  This would mean that the actual underlying cpus/node
mapping has changed. Phyp will propogate upwards an event to the lpar.  The
lpar / os can choose to ignore or act on the same.

We have found that acting on the event will provide upto 40% improvement
over ignoring the event. Acting on the event would mean moving the cpu from
one node to the other, and topology_work_fn exactly does that.

In the case where we didn't have the NUMA sched domain, we would build the
independent (aka overlap) sched_groups. With NUMA  sched domain
introduction, we try to reuse sched_groups (aka non-overlay). This results
in the above, which I thought I tried to explain in
https://lwn.net/ml/linux-kernel/20180810164533.GB42350@linux.vnet.ibm.com

In the typical case above, lets take 2 node, 8 core each having SMT 8
threads.  Initially all the 8 cores might come from node 0.  Hence
sched_domains_numa_masks[NODE][node1] and
sched_domains_numa_mask[NUMA][node1] is set at sched_init_numa will have
blank cpumasks.

Let say Phyp decides to move some of the load to another node, node 1, which
till now has 0 cpus.  Hence we will see

"BUG: arch topology borken \n the DIE domain not a subset of the NODE
domain"   which is probably okay. This problem is even present even before
NODE domain was created and systems still booted and ran.

However with the introduction of NODE sched_domain,
init_sched_groups_capacity() gets called for non-overlay sched_domains which
gets us into even worse problems. Here we will end up in a situation where
sgA->sgB->sgC-sgD->sgA gets converted into sgA->sgB->sgC->sgB which ends up
creating cpu stalls.

So the request is to expose the sched_domains_numa_masks_set /
sched_domains_numa_masks_clear to arch, so that on topology update i.e event
from phyp, arch set the mask correctly. The scheduler seems to take care of
everything else.

-- 
Thanks and Regards
Srikar Dronamraju
