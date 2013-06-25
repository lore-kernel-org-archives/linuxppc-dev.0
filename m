Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E6102C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:00:46 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 18:00:43 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 63B5738C801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 18:00:40 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PM0eWX206614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 18:00:40 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PM2tWM007775
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:02:57 -0600
Date: Tue, 25 Jun 2013 15:00:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Message-ID: <20130625220026.GG3828@linux.vnet.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 26, 2013 at 01:57:55AM +0530, Srivatsa S. Bhat wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> In RCU code, rcu_implicit_dynticks_qs() checks if a CPU is offline,
> while being protected by a spinlock. Use the get/put_online_cpus_atomic()
> APIs to prevent CPUs from going offline, while invoking from atomic context.

I am not completely sure that this is needed.  Here is a (quite possibly
flawed) argument for its not being needed:

o	rcu_gp_init() holds off CPU-hotplug operations during
	grace-period initialization.  Therefore, RCU will avoid
	looking for quiescent states from CPUs that were offline
	(and thus in an extended quiescent state) at the beginning
	of the grace period.

o	If force_qs_rnp() is looking for a quiescent state from
	a given CPU, and if it senses that CPU as being offline,
	then even without synchronization we know that the CPU
	was offline some time during the current grace period.

	After all, it was online at the beginning of the grace
	period (otherwise, we would not be looking at it at all),
	and our later sampling of its state must have therefore
	happened after the start of the grace period.  Given that
	the grace period has not yet ended, it also has to happened
	before the end of the grace period.

o	Therefore, we should be able to sample the offline state
	without synchronization.

Possible flaws in this argument:  memory ordering, oddnesses in
the sampling and updates of the cpumask recording which CPUs are
online, and so on.

Thoughts?

							Thanx, Paul

> Cc: Dipankar Sarma <dipankar@in.ibm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  kernel/rcutree.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index cf3adc6..caeed1a 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -2107,6 +2107,8 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *))
>  			rcu_initiate_boost(rnp, flags); /* releases rnp->lock */
>  			continue;
>  		}
> +
> +		get_online_cpus_atomic();
>  		cpu = rnp->grplo;
>  		bit = 1;
>  		for (; cpu <= rnp->grphi; cpu++, bit <<= 1) {
> @@ -2114,6 +2116,8 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *))
>  			    f(per_cpu_ptr(rsp->rda, cpu)))
>  				mask |= bit;
>  		}
> +		put_online_cpus_atomic();
> +
>  		if (mask != 0) {
> 
>  			/* rcu_report_qs_rnp() releases rnp->lock. */
> 
