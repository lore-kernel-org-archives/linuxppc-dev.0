Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9C77B7CFA
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 22:29:36 +1000 (EST)
Subject: Re: [PATCH 5/5] sched: make fix_small_imbalance work with
	asymmetric packing
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20100409062119.10AC5CBB6D@localhost.localdomain>
References: <20100409062119.10AC5CBB6D@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 14:29:29 +0200
Message-ID: <1271161769.4807.1283.camel@twins>
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
> With the asymmetric packing infrastructure, fix_small_imbalance is
> causing idle higher threads to pull tasks off lower threads. =20
>=20
> This is being caused by an off-by-one error. =20
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I'm not sure this is the right fix but without it, higher threads pull
> tasks off the lower threads, then the packing pulls it back down, etc
> etc and tasks bounce around constantly.

Would help if you expand upon the why/how it manages to get pulled up.

I can't immediately spot anything wrong with the patch, but then that
isn't my favourite piece of code either.. Suresh, any comments?

> ---
>=20
>  kernel/sched_fair.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-2.6-ozlabs/kernel/sched_fair.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/kernel/sched_fair.c
> +++ linux-2.6-ozlabs/kernel/sched_fair.c
> @@ -2652,7 +2652,7 @@ static inline void fix_small_imbalance(s
>  						 * SCHED_LOAD_SCALE;
>  	scaled_busy_load_per_task /=3D sds->busiest->cpu_power;
> =20
> -	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >=3D
> +	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >
>  			(scaled_busy_load_per_task * imbn)) {
>  		*imbalance =3D sds->busiest_load_per_task;
>  		return;
