Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: MPIC: support more than 256 sources
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070125213834.GA22121@lixom.net>
References: <20070125213834.GA22121@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-T/ur8ulElQwmVAixEDwX"
Date: Fri, 26 Jan 2007 11:49:00 +1100
Message-Id: <1169772540.25005.7.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-T/ur8ulElQwmVAixEDwX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 15:38 -0600, Olof Johansson wrote:
> Allow more than the default 256 MPIC sources. Allocates a new flag
> (MPIC_LARGE_VECTORS) to be used by platform code when instantiating
> the mpic.
>=20
> I picked 11 bits worth right now since it would cover the number of
> sources on any hardware I have seen. It can always be increased later
> if needed.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> Index: powerpc/arch/powerpc/sysdev/mpic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.orig/arch/powerpc/sysdev/mpic.c
> +++ powerpc/arch/powerpc/sysdev/mpic.c
> @@ -496,13 +496,18 @@ static void __init mpic_scan_ht_pics(str
>  static struct mpic *mpic_find(unsigned int irq, unsigned int *is_ipi)
>  {
>  	unsigned int src =3D mpic_irq_to_hw(irq);
> +	struct mpic *mpic;
> =20
>  	if (irq < NUM_ISA_INTERRUPTS)
>  		return NULL;
> +
> +	mpic =3D irq_desc[irq].chip_data;
> +
>  	if (is_ipi)
> -		*is_ipi =3D (src >=3D MPIC_VEC_IPI_0 && src <=3D MPIC_VEC_IPI_3);
> +		*is_ipi =3D (src >=3D mpic->ipi_vecs[0] &&
> +			   src <=3D mpic->ipi_vecs[3]);
> =20
> -	return irq_desc[irq].chip_data;
> +	return mpic;
>  }
> =20
>  /* Convert a cpu mask from logical to physical cpu numbers. */
> @@ -540,7 +545,11 @@ static inline void mpic_eoi(struct mpic=20
>  #ifdef CONFIG_SMP
>  static irqreturn_t mpic_ipi_action(int irq, void *dev_id)
>  {
> -	smp_message_recv(mpic_irq_to_hw(irq) - MPIC_VEC_IPI_0);
> +	struct mpic *mpic;
> +
> +	mpic =3D mpic_find(irq, NULL);
> +	smp_message_recv(mpic_irq_to_hw(irq) - mpic->ipi_vecs[0]);
> +
>  	return IRQ_HANDLED;
>  }
>  #endif /* CONFIG_SMP */
> @@ -663,7 +672,7 @@ static void mpic_end_ht_irq(unsigned int
>  static void mpic_unmask_ipi(unsigned int irq)
>  {
>  	struct mpic *mpic =3D mpic_from_ipi(irq);
> -	unsigned int src =3D mpic_irq_to_hw(irq) - MPIC_VEC_IPI_0;
> +	unsigned int src =3D mpic_irq_to_hw(irq) - mpic->ipi_vecs[0];
> =20
>  	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
>  	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
> @@ -807,11 +816,11 @@ static int mpic_host_map(struct irq_host
> =20
>  	DBG("mpic: map virq %d, hwirq 0x%lx\n", virq, hw);
> =20
> -	if (hw =3D=3D MPIC_VEC_SPURRIOUS)
> +	if (hw =3D=3D mpic->spurious_vec)
>  		return -EINVAL;
> =20
>  #ifdef CONFIG_SMP
> -	else if (hw >=3D MPIC_VEC_IPI_0) {
> +	else if (hw >=3D mpic->ipi_vecs[0]) {
>  		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
> =20
>  		DBG("mpic: mapping as IPI\n");
> @@ -904,6 +913,7 @@ struct mpic * __init mpic_alloc(struct d
>  	u32		reg;
>  	const char	*vers;
>  	int		i;
> +	int		intvec_base;
>  	u64		paddr =3D phys_addr;
> =20
>  	mpic =3D alloc_bootmem(sizeof(struct mpic));
> @@ -914,9 +924,9 @@ struct mpic * __init mpic_alloc(struct d
>  	mpic->name =3D name;
>  	mpic->of_node =3D of_node_get(node);
> =20
> -	mpic->irqhost =3D irq_alloc_host(IRQ_HOST_MAP_LINEAR, 256,
> +	mpic->irqhost =3D irq_alloc_host(IRQ_HOST_MAP_LINEAR, isu_size,
>  				       &mpic_host_ops,
> -				       MPIC_VEC_SPURRIOUS);
> +				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
>  	if (mpic->irqhost =3D=3D NULL) {
>  		of_node_put(node);
>  		return NULL;
> @@ -944,6 +954,21 @@ struct mpic * __init mpic_alloc(struct d
>  	mpic->irq_count =3D irq_count;
>  	mpic->num_sources =3D 0; /* so far */
> =20
> +	if (flags & MPIC_LARGE_VECTORS)
> +		intvec_base =3D 2039;
> +	else
> +		intvec_base =3D 247;
> +
> +	mpic->timer_vecs[0] =3D intvec_base;
> +	mpic->timer_vecs[1] =3D intvec_base+1;
> +	mpic->timer_vecs[2] =3D intvec_base+2;
> +	mpic->timer_vecs[3] =3D intvec_base+3;
> +	mpic->ipi_vecs[0]   =3D intvec_base+4;
> +	mpic->ipi_vecs[1]   =3D intvec_base+5;
> +	mpic->ipi_vecs[2]   =3D intvec_base+6;
> +	mpic->ipi_vecs[3]   =3D intvec_base+7;
> +	mpic->spurious_vec =3D intvec_base+8;

It took me a minute to work out where 2039 and 247 came from, it might
be clearer as:

+	if (flags & MPIC_LARGE_VECTORS)
+		intvec_top =3D 2047;
+	else
+		intvec_top =3D 255;
+
+	mpic->timer_vecs[0] =3D intvec_top - 8;
+	mpic->timer_vecs[1] =3D intvec_top - 7;
+	mpic->timer_vecs[2] =3D intvec_top - 6;
+	mpic->timer_vecs[3] =3D intvec_top - 5;
+	mpic->ipi_vecs[0]   =3D intvec_top - 4;
+	mpic->ipi_vecs[1]   =3D intvec_top - 3;
+	mpic->ipi_vecs[2]   =3D intvec_top - 2;
+	mpic->ipi_vecs[3]   =3D intvec_top - 1;
+	mpic->spurious_vec  =3D intvec_top;

Better still, can you get 255/2047 as (num_sources - 1) or something?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-T/ur8ulElQwmVAixEDwX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuU/7dSjSd0sB4dIRAvl8AJwPTzy8mi7+XHFC2UhozXTzOEN7BgCbBEMZ
qQuz0djZNHPBwztQB1TfIvQ=
=1IlT
-----END PGP SIGNATURE-----

--=-T/ur8ulElQwmVAixEDwX--
