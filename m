Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 305E02C06BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:12:59 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 14:12:56 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0646C19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 14:12:45 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RKCoFI184442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 14:12:51 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RKFGJu031189
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 14:15:18 -0600
Date: Thu, 27 Jun 2013 13:12:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 16/45] rcu: Use cpu_is_offline_nocheck() to avoid
 false-positive warnings
Message-ID: <20130627201246.GA3828@linux.vnet.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
 <20130627195517.29830.64108.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130627195517.29830.64108.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 David.Laight@aculab.com, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 28, 2013 at 01:25:17AM +0530, Srivatsa S. Bhat wrote:
> In RCU code, rcu_implicit_dynticks_qs() checks if a CPU is offline,
> while being protected by a spinlock. At first, it appears as if we need to
> use the get/put_online_cpus_atomic() APIs to properly synchronize with CPU
> hotplug, once we get rid of stop_machine(). However, RCU has adequate
> synchronization with CPU hotplug, making that unnecessary. But since the
> locking details are non-trivial, it is hard to teach this to the rudimentary
> hotplug locking validator.
> 
> So use the _nocheck() variants of the cpu accessor functions to prevent false-
> positive warnings from the CPU hotplug debug code. Also, add a comment
> explaining the hotplug synchronization design used in RCU, so that its easy
> to see why it is justified to use the _nocheck() variants.
> 
> Cc: Dipankar Sarma <dipankar@in.ibm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
>  kernel/rcutree.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index cf3adc6..ced28a45 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -794,7 +794,17 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  	if (ULONG_CMP_GE(rdp->rsp->gp_start + 2, jiffies))
>  		return 0;  /* Grace period is not old enough. */
>  	barrier();
> -	if (cpu_is_offline(rdp->cpu)) {
> +
> +	/*
> +	 * It is safe to use the _nocheck() version of cpu_is_offline() here
> +	 * (to avoid false-positive warnings from CPU hotplug debug code),
> +	 * because:
> +	 * 1. rcu_gp_init() holds off CPU hotplug operations during grace
> +	 *    period initialization.
> +	 * 2. The current grace period has not ended yet.
> +	 * So it is safe to sample the offline state without synchronization.
> +	 */
> +	if (cpu_is_offline_nocheck(rdp->cpu)) {
>  		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, "ofl");
>  		rdp->offline_fqs++;
>  		return 1;
> 
