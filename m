Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 062FCB7D00
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 22:29:37 +1000 (EST)
Subject: Re: [PATCH 1/5] sched: fix capacity calculations for SMT4
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20100409062118.D4096CBB6C@localhost.localdomain>
References: <20100409062118.D4096CBB6C@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 14:29:26 +0200
Message-ID: <1271161766.4807.1280.camel@twins>
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
> When calculating capacity we use the following calculation:
>=20
>        capacity =3D DIV_ROUND_CLOSEST(power, SCHED_LOAD_SCALE);
>=20
> In SMT2, power will be 1178/2 (provided we are not scaling power with
> freq say) and SCHED_LOAD_SCALE will be 1024, resulting in capacity
> being 1.
>=20
> With SMT4 however, power will be 1178/4, hence capacity will end up as
> 0.
>=20
> Fix this by ensuring capacity is always at least 1 after this
> calculation.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I'm not sure this is the correct fix but this works for me. =20

Right, so I suspect this will indeed break some things.

We initially allowed 0 capacity for when a cpu is consumed by an RT task
and there simply isn't much capacity left, in that case you really want
to try and move load to your sibling cpus if possible.

However you're right that this goes awry in your case.

One thing to look at is if that 15% increase is indeed representative
for the power7 cpu, it having 4 SMT threads seems to suggest there was
significant gains, otherwise they'd not have wasted the silicon.

(The broken x86 code was meant to actually compute the SMT gain, so that
we'd not have to guess the 15%)

Now, increasing this will only marginally fix the issue, since if you
end up with 512 per thread it only takes a very tiny amount of RT
workload to drop below and end up at 0 again.

One thing we could look at is using the cpu base power to compute
capacity from. We'd have to add another field to sched_group and store
power before we do the scale_rt_power() stuff.

Thoughts?


>  kernel/sched_fair.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Index: linux-2.6-ozlabs/kernel/sched_fair.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/kernel/sched_fair.c
> +++ linux-2.6-ozlabs/kernel/sched_fair.c
> @@ -1482,6 +1482,7 @@ static int select_task_rq_fair(struct ta
>  			}
> =20
>  			capacity =3D DIV_ROUND_CLOSEST(power, SCHED_LOAD_SCALE);
> +			capacity =3D max(capacity, 1UL);
> =20
>  			if (tmp->flags & SD_POWERSAVINGS_BALANCE)
>  				nr_running /=3D 2;
> @@ -2488,6 +2489,7 @@ static inline void update_sg_lb_stats(st
> =20
>  	sgs->group_capacity =3D
>  		DIV_ROUND_CLOSEST(group->cpu_power, SCHED_LOAD_SCALE);
> +	sgs->group_capacity =3D max(sgs->group_capacity, 1UL);
>  }
> =20
>  /**
> @@ -2795,9 +2797,11 @@ find_busiest_queue(struct sched_group *g
> =20
>  	for_each_cpu(i, sched_group_cpus(group)) {
>  		unsigned long power =3D power_of(i);
> -		unsigned long capacity =3D DIV_ROUND_CLOSEST(power, SCHED_LOAD_SCALE);
> +		unsigned long capacity;
>  		unsigned long wl;
> =20
> +		capacity =3D max(DIV_ROUND_CLOSEST(power, SCHED_LOAD_SCALE), 1UL);
> +
>  		if (!cpumask_test_cpu(i, cpus))
>  			continue;
> =20
