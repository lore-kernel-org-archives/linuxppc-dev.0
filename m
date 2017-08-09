Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRyLF3YLLzDqvM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 14:03:33 +1000 (AEST)
Date: Wed, 9 Aug 2017 13:55:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 03/10] powerpc/xive: rename xive_poke_esb in xive_esb_read
Message-ID: <20170809035534.GD13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-4-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
In-Reply-To: <1502182579-990-4-git-send-email-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 10:56:13AM +0200, C=E9dric Le Goater wrote:
> xive_poke_esb() is performing a load/read so it is better named as
> xive_esb_read().

Uh, patch seems to mismatch the comment here, calling it
xive_peek_esb() instead.

Does reading the ESB had a side effect on the hardware?  If so "poke"
might be an appropriate name.

> Also introduce a XIVE_ESB_LOAD_EOI read when EOI'ing
> LSI interrupts.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/sysdev/xive/common.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 6595462b1fc8..e6b245bb9602 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -190,7 +190,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, =
bool just_peek)
>   * This is used to perform the magic loads from an ESB
>   * described in xive.h
>   */
> -static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
> +static u8 xive_peek_esb(struct xive_irq_data *xd, u32 offset)
>  {
>  	u64 val;
> =20
> @@ -227,7 +227,7 @@ void xmon_xive_do_dump(int cpu)
>  	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
>  #ifdef CONFIG_SMP
>  	{
> -		u64 val =3D xive_poke_esb(&xc->ipi_data, XIVE_ESB_GET);
> +		u64 val =3D xive_peek_esb(&xc->ipi_data, XIVE_ESB_GET);
>  		xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
>  			val & XIVE_ESB_VAL_P ? 'P' : 'p',
>  			val & XIVE_ESB_VAL_P ? 'Q' : 'q');
> @@ -326,9 +326,9 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_d=
ata *xd)
>  		 * properly.
>  		 */
>  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> -			in_be64(xd->eoi_mmio);
> +			xive_peek_esb(xd, XIVE_ESB_LOAD_EOI);
>  		else {
> -			eoi_val =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +			eoi_val =3D xive_peek_esb(xd, XIVE_ESB_SET_PQ_00);
>  			DBG_VERBOSE("eoi_val=3D%x\n", offset, eoi_val);
> =20
>  			/* Re-trigger if needed */
> @@ -383,12 +383,12 @@ static void xive_do_source_set_mask(struct xive_irq=
_data *xd,
>  	 * ESB accordingly on unmask.
>  	 */
>  	if (mask) {
> -		val =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
> +		val =3D xive_peek_esb(xd, XIVE_ESB_SET_PQ_01);
>  		xd->saved_p =3D !!(val & XIVE_ESB_VAL_P);
>  	} else if (xd->saved_p)
> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
> +		xive_peek_esb(xd, XIVE_ESB_SET_PQ_10);
>  	else
> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +		xive_peek_esb(xd, XIVE_ESB_SET_PQ_00);
>  }
> =20
>  /*
> @@ -768,7 +768,7 @@ static int xive_irq_retrigger(struct irq_data *d)
>  	 * To perform a retrigger, we first set the PQ bits to
>  	 * 11, then perform an EOI.
>  	 */
> -	xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
> +	xive_peek_esb(xd, XIVE_ESB_SET_PQ_11);
> =20
>  	/*
>  	 * Note: We pass "0" to the hw_irq argument in order to
> @@ -803,7 +803,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data=
 *d, void *state)
>  		irqd_set_forwarded_to_vcpu(d);
> =20
>  		/* Set it to PQ=3D10 state to prevent further sends */
> -		pq =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
> +		pq =3D xive_peek_esb(xd, XIVE_ESB_SET_PQ_10);
> =20
>  		/* No target ? nothing to do */
>  		if (xd->target =3D=3D XIVE_INVALID_TARGET) {
> @@ -832,7 +832,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data=
 *d, void *state)
>  		 * for sure the queue slot is no longer in use.
>  		 */
>  		if (pq & 2) {
> -			pq =3D xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
> +			pq =3D xive_peek_esb(xd, XIVE_ESB_SET_PQ_11);
>  			xd->saved_p =3D true;
> =20
>  			/*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKh7YACgkQbDjKyiDZ
s5LqxA/+KVJksFx2kKgoxBIlrA551k8JMOKQwI7dJdvFxQT4e465w5EPPW7FlV1E
14xoCQ/wb6qCl21vm+Kvzn2Jrxq/Ky91U16lHwmnYORHfEFP37NpziGKNJvhijT9
i3XYSxU5XL+HTYZ2xwqIm+PrXF/BiP3wGMd57dN54ZeljvHQcasTVfV7epN4qF7p
wlbvtUtKiyAY9ZHU6B0HEHd8k9+KVzHOoMrRUTqi625f9t8J9Dlm7mGjcrs2LAQB
ebCNV/1HeUx7CxP69McZW7KwxNheK8wnemwTBY0/0CDploi0Aegc9wNIud0MVda3
l1PVLeaeSmXw7g7obadD0VjjubpmoeZAfctcxhRdrJAilLWz+uCFN1IhY4CGzgS5
OFdNDOpYuI9lVlSaGcDFmxDduHJWqbvGXSYt00Zdtak64nBaj3O5uBjAZZAhCfAe
pGCiMgliwJ2QY22rjyviLU0kswdbF+vIwzVbqfRaSZ9sds+7AUMjxC3lbY2OQl+q
MYUYpSc/BLafiCeLZuJ56/OPq9H/MFN3qdBIBu0ufpftkVMXodR8jlZ0FgmY8BGY
acd68Ag9oYWlA7L6PZbJntMUZ/lORZT8Gut9uI+UcpZRHkwKncYH+GQCtTSV8ZWX
Eona9no09aNqbjlyneeKDZraawMepgbExeLcIY1/pHdH0H5Bihg=
=W3kd
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
