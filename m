Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYqSG0Q56zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 00:12:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LE96ro114307
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:12:43 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2crfr4r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:12:43 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 10:12:42 -0400
Date: Tue, 21 Jun 2016 19:42:31 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
 <20160615155350.GB24102@mtj.duckdns.org>
 <20160615192844.GA20301@in.ibm.com>
 <20160616193504.GB3262@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160616193504.GB3262@mtj.duckdns.org>
Message-Id: <20160621141231.GA30251@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tejun,
On Thu, Jun 16, 2016 at 03:35:04PM -0400, Tejun Heo wrote:
> Hello,
> 
> So, the issue of the initial worker not having its affinity set
> correctly wasn't caused by the order of the operations.  Reordering
> just made set_cpus_allowed tried one more time late enough so that it
> hides the race condition most of the time.  The problem is that
> CPU_ONLINE callbacks are called while the cpu being onlined is online
> but not active and select_fallback_rq() only considers active cpus, so
> if a kthread gets scheduled in the meantime and it doesn't have any
> cpu which is active in its allowed mask, it's allowed mask gets reset
> to cpu_possible_mask.
> 
> Would something like the following make sense?
> 
> Thanks.
> ------ 8< ------
> Subject: [PATCH] sched: allow kthreads to fallback to online && !active cpus
> 
> During CPU hotplug, CPU_ONLINE callbacks are run while the CPU is
> online but not active.  A CPU_ONLINE callback may create or bind a
> kthread so that its cpus_allowed mask only allows the CPU which is
> being brought online.  The kthread may start executing before the CPU
> is made active and can end up in select_fallback_rq().
> 
> In such cases, the expected behavior is selecting the CPU which is
> coming online; however, because select_fallback_rq() only chooses from
> active CPUs, it determines that the task doesn't have any viable CPU
> in its allowed mask and ends up overriding it to cpu_possible_mask.
> 
> CPU_ONLINE callbacks should be able to put kthreads on the CPU which
> is coming online.  Update select_fallback_rq() so that it follows
> cpu_online() rather than cpu_active() for kthreads.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>

Hi Tejun,

This patch fixes the issue on POWER. I am able to see the worker
threads of the unbound workqueues of the newly onlined node with this.

Tested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  kernel/sched/core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 017d539..a12e3db 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1536,7 +1536,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>  	for (;;) {
>  		/* Any allowed, online CPU? */
>  		for_each_cpu(dest_cpu, tsk_cpus_allowed(p)) {
> -			if (!cpu_active(dest_cpu))
> +			if (!(p->flags & PF_KTHREAD) && !cpu_active(dest_cpu))
> +				continue;
> +			if (!cpu_online(dest_cpu))
>  				continue;
>  			goto out;
>  		}
> 
