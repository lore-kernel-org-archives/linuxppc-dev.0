Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 121A21007D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 17:25:48 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/time: Use clockevents_calc_mult_shift
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111124060847.198884481@samba.org>
Date: Thu, 24 Nov 2011 00:25:32 -0600
Message-Id: <B695AB74-08F7-46DE-A9E9-BC7475FA1F3F@kernel.crashing.org>
References: <20111124060716.362614789@samba.org>
 <20111124060847.198884481@samba.org>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com,
 johnstul@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 24, 2011, at 12:07 AM, Anton Blanchard wrote:

> We can use clockevents_calc_mult_shift instead of doing all
> the work ourselves.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Index: linux-build/arch/powerpc/kernel/time.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 =
10:11:49.035001617 +1100
> +++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 =
10:11:51.175038860 +1100
> @@ -112,8 +112,6 @@ static void decrementer_set_mode(enum cl
> static struct clock_event_device decrementer_clockevent =3D {
>        .name           =3D "decrementer",
>        .rating         =3D 200,
> -       .shift          =3D 0,	/* To be filled in */
> -       .mult           =3D 0,	/* To be filled in */
>        .irq            =3D 0,
>        .set_next_event =3D decrementer_set_next_event,
>        .set_mode       =3D decrementer_set_mode,
> @@ -913,31 +911,6 @@ static void decrementer_set_mode(enum cl
> 		decrementer_set_next_event(DECREMENTER_MAX, dev);
> }
>=20
> -static inline uint64_t div_sc64(unsigned long ticks, unsigned long =
nsec,
> -				int shift)
> -{
> -	uint64_t tmp =3D ((uint64_t)ticks) << shift;
> -
> -	do_div(tmp, nsec);
> -	return tmp;
> -}
> -
> -static void __init setup_clockevent_multiplier(unsigned long hz)
> -{
> -	u64 mult, shift =3D 32;
> -
> -	while (1) {
> -		mult =3D div_sc64(hz, NSEC_PER_SEC, shift);
> -		if (mult && (mult >> 32UL) =3D=3D 0UL)
> -			break;
> -
> -		shift--;
> -	}
> -
> -	decrementer_clockevent.shift =3D shift;
> -	decrementer_clockevent.mult =3D mult;
> -}
> -
> static void register_decrementer_clockevent(int cpu)
> {
> 	struct clock_event_device *dec =3D &per_cpu(decrementers, =
cpu).event;
> @@ -955,7 +928,8 @@ static void __init init_decrementer_cloc
> {
> 	int cpu =3D smp_processor_id();
>=20
> -	setup_clockevent_multiplier(ppc_tb_freq);
> +	clockevents_calc_mult_shift(&decrementer_clockevent, =
ppc_tb_freq, 4);
> +

Where's this magic 4 come from?

> 	decrementer_clockevent.max_delta_ns =3D
> 		clockevent_delta2ns(DECREMENTER_MAX, =
&decrementer_clockevent);
> 	decrementer_clockevent.min_delta_ns =3D
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
