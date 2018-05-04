Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cpVL3CCTzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 20:42:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/4] powerpc/xive: prepare all hcalls to support long busy
 delays
In-Reply-To: <20180403071548.19829-5-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-5-clg@kaod.org>
Date: Fri, 04 May 2018 20:42:01 +1000
Message-ID: <87d0yb8zye.fsf@concordia.ellerman.id.au>
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

> This is not the case for the moment, but future releases of pHyp might
> need to introduce some synchronisation routines under the hood which
> would make the XIVE hcalls longer to complete.
>
> As this was done for H_INT_RESET, let's wrap the other hcalls in a
> loop catching the H_LONG_BUSY_* codes.

Are we sure it's safe to msleep() in all these paths?

cheers

> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index 7113f5d87952..97ea0a67a173 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -165,7 +165,10 @@ static long plpar_int_get_source_info(unsigned long =
flags,
>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>  	long rc;
>=20=20
> -	rc =3D plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
> +	do {
> +		rc =3D plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_GET_SOURCE_INFO lisn=3D%ld failed %ld\n", lisn, rc);
>  		return rc;
> @@ -198,8 +201,11 @@ static long plpar_int_set_source_config(unsigned lon=
g flags,
>  		flags, lisn, target, prio, sw_irq);
>=20=20
>=20=20
> -	rc =3D plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
> -				target, prio, sw_irq);
> +	do {
> +		rc =3D plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
> +					target, prio, sw_irq);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_SET_SOURCE_CONFIG lisn=3D%ld target=3D%lx prio=3D%lx fai=
led %ld\n",
>  		       lisn, target, prio, rc);
> @@ -218,7 +224,11 @@ static long plpar_int_get_queue_info(unsigned long f=
lags,
>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>  	long rc;
>=20=20
> -	rc =3D plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priorit=
y);
> +	do {
> +		rc =3D plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target,
> +				 priority);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_GET_QUEUE_INFO cpu=3D%ld prio=3D%ld failed %ld\n",
>  		       target, priority, rc);
> @@ -247,8 +257,11 @@ static long plpar_int_set_queue_config(unsigned long=
 flags,
>  	pr_devel("H_INT_SET_QUEUE_CONFIG flags=3D%lx target=3D%lx priority=3D%l=
x qpage=3D%lx qsize=3D%lx\n",
>  		flags,  target, priority, qpage, qsize);
>=20=20
> -	rc =3D plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
> -				priority, qpage, qsize);
> +	do {
> +		rc =3D plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
> +					priority, qpage, qsize);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_SET_QUEUE_CONFIG cpu=3D%ld prio=3D%ld qpage=3D%lx return=
ed %ld\n",
>  		       target, priority, qpage, rc);
> @@ -262,7 +275,10 @@ static long plpar_int_sync(unsigned long flags, unsi=
gned long lisn)
>  {
>  	long rc;
>=20=20
> -	rc =3D plpar_hcall_norets(H_INT_SYNC, flags, lisn);
> +	do {
> +		rc =3D plpar_hcall_norets(H_INT_SYNC, flags, lisn);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_SYNC lisn=3D%ld returned %ld\n", lisn, rc);
>  		return  rc;
> @@ -285,7 +301,11 @@ static long plpar_int_esb(unsigned long flags,
>  	pr_devel("H_INT_ESB flags=3D%lx lisn=3D%lx offset=3D%lx in=3D%lx\n",
>  		flags,  lisn, offset, in_data);
>=20=20
> -	rc =3D plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
> +	do {
> +		rc =3D plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset,
> +				 in_data);
> +	} while (plpar_busy_delay(rc));
> +
>  	if (rc) {
>  		pr_err("H_INT_ESB lisn=3D%ld offset=3D%ld returned %ld\n",
>  		       lisn, offset, rc);
> --=20
> 2.13.6
