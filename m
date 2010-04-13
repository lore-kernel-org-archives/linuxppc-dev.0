Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D151BB7E5E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 22:29:47 +1000 (EST)
Subject: Re: [PATCH 4/5] sched: Mark the balance type for use in
	need_active_balance()
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20100409062119.040B0CBB6F@localhost.localdomain>
References: <20100409062119.040B0CBB6F@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 14:29:28 +0200
Message-ID: <1271161768.4807.1282.camel@twins>
Mime-Version: 1.0
Cc: Suresh Siddha <suresh.b.siddha@intel.com>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-09 at 16:21 +1000, Michael Neuling wrote:
> need_active_balance() gates the asymmetric packing based due to power
> save logic, but for packing we don't care.

This explanation lacks a how/why.

So the problem is that need_active_balance() ends up returning false and
prevents the active balance from pulling a task to a lower available SMT
sibling?

> This marks the type of balanace we are attempting to do perform from
> f_b_g() and stops need_active_balance() power save logic gating a
> balance in the asymmetric packing case.

At the very least this wants more comments in the code. I'm not really
charmed by having to add yet another variable to pass around that mess,
but I can't seem to come up with something cleaner either.

> Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> ---
>=20
>  kernel/sched_fair.c |   24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6-ozlabs/kernel/sched_fair.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/kernel/sched_fair.c
> +++ linux-2.6-ozlabs/kernel/sched_fair.c
> @@ -91,6 +91,13 @@ const_debug unsigned int sysctl_sched_mi
> =20
>  static const struct sched_class fair_sched_class;
> =20
> +enum balance_type {
> +	BALANCE_NONE =3D 0,
> +	BALANCE_LOAD,
> +	BALANCE_POWER,
> +	BALANCE_PACKING
> +};
> +
>  /**************************************************************
>   * CFS operations on generic schedulable entities:
>   */
> @@ -2783,7 +2790,8 @@ static inline void calculate_imbalance(s
>  static struct sched_group *
>  find_busiest_group(struct sched_domain *sd, int this_cpu,
>  		   unsigned long *imbalance, enum cpu_idle_type idle,
> -		   int *sd_idle, const struct cpumask *cpus, int *balance)
> +		   int *sd_idle, const struct cpumask *cpus, int *balance,
> +		   enum balance_type *bt)
>  {
>  	struct sd_lb_stats sds;
> =20
> @@ -2808,6 +2816,7 @@ find_busiest_group(struct sched_domain *
>  	if (!(*balance))
>  		goto ret;
> =20
> +	*bt =3D BALANCE_PACKING;
>  	if ((idle =3D=3D CPU_IDLE || idle =3D=3D CPU_NEWLY_IDLE) &&
>  	    check_asym_packing(sd, &sds, this_cpu, imbalance))
>  		return sds.busiest;
> @@ -2828,6 +2837,7 @@ find_busiest_group(struct sched_domain *
> =20
>  	/* Looks like there is an imbalance. Compute it */
>  	calculate_imbalance(&sds, this_cpu, imbalance);
> +	*bt =3D BALANCE_LOAD;
>  	return sds.busiest;
> =20
>  out_balanced:
> @@ -2835,10 +2845,12 @@ out_balanced:
>  	 * There is no obvious imbalance. But check if we can do some balancing
>  	 * to save power.
>  	 */
> +	*bt =3D BALANCE_POWER;
>  	if (check_power_save_busiest_group(&sds, this_cpu, imbalance))
>  		return sds.busiest;
>  ret:
>  	*imbalance =3D 0;
> +	*bt =3D BALANCE_NONE;
>  	return NULL;
>  }
> =20
> @@ -2899,9 +2911,10 @@ find_busiest_queue(struct sched_group *g
>  /* Working cpumask for load_balance and load_balance_newidle. */
>  static DEFINE_PER_CPU(cpumask_var_t, load_balance_tmpmask);
> =20
> -static int need_active_balance(struct sched_domain *sd, int sd_idle, int=
 idle)
> +static int need_active_balance(struct sched_domain *sd, int sd_idle, int=
 idle,
> +			       enum balance_type *bt)
>  {
> -	if (idle =3D=3D CPU_NEWLY_IDLE) {
> +	if (idle =3D=3D CPU_NEWLY_IDLE && *bt !=3D BALANCE_PACKING) {
>  		/*
>  		 * The only task running in a non-idle cpu can be moved to this
>  		 * cpu in an attempt to completely freeup the other CPU
> @@ -2946,6 +2959,7 @@ static int load_balance(int this_cpu, st
>  	struct rq *busiest;
>  	unsigned long flags;
>  	struct cpumask *cpus =3D __get_cpu_var(load_balance_tmpmask);
> +	enum balance_type bt;
> =20
>  	cpumask_copy(cpus, cpu_active_mask);
> =20
> @@ -2964,7 +2978,7 @@ static int load_balance(int this_cpu, st
>  redo:
>  	update_shares(sd);
>  	group =3D find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
> -				   cpus, balance);
> +				   cpus, balance, &bt);
> =20
>  	if (*balance =3D=3D 0)
>  		goto out_balanced;
> @@ -3018,7 +3032,7 @@ redo:
>  		schedstat_inc(sd, lb_failed[idle]);
>  		sd->nr_balance_failed++;
> =20
> -		if (need_active_balance(sd, sd_idle, idle)) {
> +		if (need_active_balance(sd, sd_idle, idle, &bt)) {
>  			raw_spin_lock_irqsave(&busiest->lock, flags);
> =20
>  			/* don't kick the migration_thread, if the curr
