Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgdmB0JmzzF1Pg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 21:18:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] powerpc/xive: use hw CPU ids when configuring the CPU
 queues
In-Reply-To: <20180213084712.18351-1-clg@kaod.org>
References: <20180213084712.18351-1-clg@kaod.org>
Date: Tue, 13 Feb 2018 21:18:32 +1100
Message-ID: <87a7wd2nwn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> The CPU event notification queues on sPAPR should be configured using
> a hardware CPU identifier.
>
> The problem did not show up on the Power Hypervisor because pHyp
> supports 8 threads per core which keeps CPU number contiguous. This is
> not the case on all sPAPR virtual machines, some use SMT=3D1.
>
> Also improve error logging by adding the CPU number.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  I think we should send this one to stable also.

Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrup=
t controller")
Cc: stable@vger.kernel.org # v4.14+

?

cheers

> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index d9c4c9366049..091f1d0d0af1 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -356,7 +356,8 @@ static int xive_spapr_configure_queue(u32 target, str=
uct xive_q *q, u8 prio,
>=20=20
>  	rc =3D plpar_int_get_queue_info(0, target, prio, &esn_page, &esn_size);
>  	if (rc) {
> -		pr_err("Error %lld getting queue info prio %d\n", rc, prio);
> +		pr_err("Error %lld getting queue info CPU %d prio %d\n", rc,
> +		       target, prio);
>  		rc =3D -EIO;
>  		goto fail;
>  	}
> @@ -370,7 +371,8 @@ static int xive_spapr_configure_queue(u32 target, str=
uct xive_q *q, u8 prio,
>  	/* Configure and enable the queue in HW */
>  	rc =3D plpar_int_set_queue_config(flags, target, prio, qpage_phys, orde=
r);
>  	if (rc) {
> -		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
> +		pr_err("Error %lld setting queue for CPU %d prio %d\n", rc,
> +		       target, prio);
>  		rc =3D -EIO;
>  	} else {
>  		q->qpage =3D qpage;
> @@ -389,8 +391,8 @@ static int xive_spapr_setup_queue(unsigned int cpu, s=
truct xive_cpu *xc,
>  	if (IS_ERR(qpage))
>  		return PTR_ERR(qpage);
>=20=20
> -	return xive_spapr_configure_queue(cpu, q, prio, qpage,
> -					  xive_queue_shift);
> +	return xive_spapr_configure_queue(get_hard_smp_processor_id(cpu),
> +					  q, prio, qpage, xive_queue_shift);
>  }
>=20=20
>  static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *=
xc,
> @@ -399,10 +401,12 @@ static void xive_spapr_cleanup_queue(unsigned int c=
pu, struct xive_cpu *xc,
>  	struct xive_q *q =3D &xc->queue[prio];
>  	unsigned int alloc_order;
>  	long rc;
> +	int hw_cpu =3D get_hard_smp_processor_id(cpu);
>=20=20
> -	rc =3D plpar_int_set_queue_config(0, cpu, prio, 0, 0);
> +	rc =3D plpar_int_set_queue_config(0, hw_cpu, prio, 0, 0);
>  	if (rc)
> -		pr_err("Error %ld setting queue for prio %d\n", rc, prio);
> +		pr_err("Error %ld setting queue for CPU %d prio %d\n", rc,
> +		       hw_cpu, prio);
>=20=20
>  	alloc_order =3D xive_alloc_order(xive_queue_shift);
>  	free_pages((unsigned long)q->qpage, alloc_order);
> --=20
> 2.13.6
