Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYcpG5MY0zDrJD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 19:13:58 +1000 (AEST)
Date: Fri, 18 Aug 2017 15:56:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/8] powerpc/xive: rename xive_poke_esb() in
 xive_esb_read()
Message-ID: <20170818055631.GS5509@umbus.fritz.box>
References: <20170811142341.22715-1-clg@kaod.org>
 <20170811142341.22715-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="19HmC3QOnaNVzKTI"
In-Reply-To: <20170811142341.22715-4-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--19HmC3QOnaNVzKTI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 04:23:36PM +0200, C=E9dric Le Goater wrote:
> xive_poke_esb() is performing a load/read so it is better named as
> xive_esb_read() as we will need to introduce a xive_esb_write()
> routine. Also use the XIVE_ESB_LOAD_EOI offset when EOI'ing LSI
> interrupts.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v1:
>=20
>  - fixed naming.
> =20
>  arch/powerpc/sysdev/xive/common.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 8774af7a4105..8a58662ed793 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -190,7 +190,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, =
bool just_peek)
>   * This is used to perform the magic loads from an ESB
>   * described in xive.h
>   */
> -static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
> +static u8 xive_esb_read(struct xive_irq_data *xd, u32 offset)
>  {
>  	u64 val;
> =20
> @@ -227,7 +227,7 @@ void xmon_xive_do_dump(int cpu)
>  	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
>  #ifdef CONFIG_SMP
>  	{
> -		u64 val =3D xive_poke_esb(&xc->ipi_data, XIVE_ESB_GET);
> +		u64 val =3D xive_esb_read(&xc->ipi_data, XIVE_ESB_GET);
>  		xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
>  			val & XIVE_ESB_VAL_P ? 'P' : 'p',
>  			val & XIVE_ESB_VAL_P ? 'Q' : 'q');
> @@ -326,9 +326,9 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_d=
ata *xd)
>  		 * properly.
>  		 */
>  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> -			in_be64(xd->eoi_mmio);
> +			xive_esb_read(xd, XIVE_ESB_LOAD_EOI);
>  		else {
> -			eoi_val =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +			eoi_val =3D xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
>  			DBG_VERBOSE("eoi_val=3D%x\n", offset, eoi_val);
> =20
>  			/* Re-trigger if needed */
> @@ -383,12 +383,12 @@ static void xive_do_source_set_mask(struct xive_irq=
_data *xd,
>  	 * ESB accordingly on unmask.
>  	 */
>  	if (mask) {
> -		val =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
> +		val =3D xive_esb_read(xd, XIVE_ESB_SET_PQ_01);
>  		xd->saved_p =3D !!(val & XIVE_ESB_VAL_P);
>  	} else if (xd->saved_p)
> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
> +		xive_esb_read(xd, XIVE_ESB_SET_PQ_10);
>  	else
> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +		xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
>  }
> =20
>  /*
> @@ -768,7 +768,7 @@ static int xive_irq_retrigger(struct irq_data *d)
>  	 * To perform a retrigger, we first set the PQ bits to
>  	 * 11, then perform an EOI.
>  	 */
> -	xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
> +	xive_esb_read(xd, XIVE_ESB_SET_PQ_11);
> =20
>  	/*
>  	 * Note: We pass "0" to the hw_irq argument in order to
> @@ -803,7 +803,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data=
 *d, void *state)
>  		irqd_set_forwarded_to_vcpu(d);
> =20
>  		/* Set it to PQ=3D10 state to prevent further sends */
> -		pq =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
> +		pq =3D xive_esb_read(xd, XIVE_ESB_SET_PQ_10);
> =20
>  		/* No target ? nothing to do */
>  		if (xd->target =3D=3D XIVE_INVALID_TARGET) {
> @@ -832,7 +832,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data=
 *d, void *state)
>  		 * for sure the queue slot is no longer in use.
>  		 */
>  		if (pq & 2) {
> -			pq =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
> +			pq =3D xive_esb_read(xd, XIVE_ESB_SET_PQ_11);
>  			xd->saved_p =3D true;
> =20
>  			/*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--19HmC3QOnaNVzKTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWgYwACgkQbDjKyiDZ
s5LelBAAlY8u++jBlXEwJUX0osFnt3BjgRc3gW28mAYA8Ip6kYK75QInwkGCUbEQ
3OrEYCOHFViS4wzzr5g9/EVX8nK/+3kPkVgCUcWMn4V7ShkUvbDICnE290L1nJAb
cMWn4GxjKUwUZxF2c+l0RiAV2XyphcAFL+IXVWCfV81W/NXPYvXjTV1d6sx7tUnw
U11nm4ijP1dAOI1unHpFPnKXX4ddYgxXD7vBmFQQkcjMvIX32go1Ko9xt8uAtze3
iUYqH8AnmgAfXNiWvmQaV7MqhZAMdguzJtVsq/wK/bg5j6NAIW2NCCXBxZcL2Q1P
2oPn/uI1pCvOSrBvd8A8RZQEP4mDbTwV1jUf/SbbAR5mlUAT0Ml3/tQOvnVGdmrV
qRJgUNDSI4fsGQK53AMmx1BinI3ZkxLaZ8FmS3BL33uxkZoJG6gmCkGr+7uBJ9Oz
PTrzTJdQs+axRx3EXMzXbKHOXW9gWte3XQUVITf1uHFBuge22WGvkkgoZVHcwUxw
/UG4Uk/l26pycN16HqLabGP493GQSUP2aDO1rnpn3BJZv6I2YxtvybiJL0Vx0VXN
0KIzS7mEqqRQhQ7YwoP1sjKNm5rsojI0JoLMf1qhUBdZntYrl61yLcRgyhXd4MiR
abIrX30orbZDUXo9Cf6DM+3lhpdEpA/qTgBqeLNNHoT+/XPAYA4=
=BGOj
-----END PGP SIGNATURE-----

--19HmC3QOnaNVzKTI--
