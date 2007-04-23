Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <5f69d29368a24aad95648b40e0dfc07e@bga.com>
References: <20070419073555.D2C3EDDEFD@ozlabs.org>
	<5f69d29368a24aad95648b40e0dfc07e@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2iEcJ8TQdg/XU6La1Kkm"
Date: Mon, 23 Apr 2007 14:04:22 +1000
Message-Id: <1177301062.3889.27.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2iEcJ8TQdg/XU6La1Kkm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 18:17 -0500, Milton Miller wrote:
> On Apr 19, 2007, Michael Ellerman wrote:
> > To support MSI on MPIC we need a way to reserve and allocate hardware=20
> > irq
> > numbers, this patch implements an allocator for that.
>=20
> > Index: msi-new/arch/powerpc/sysdev/mpic_msi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ msi-new/arch/powerpc/sysdev/mpic_msi.c
> ...
> > +irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num)
> > +{
> > +	unsigned long flags;
> > +	int offset, order =3D fls(num) - 1;
>=20
> get_count_order would be more clear.  Also it has
> a correction factor.  (Applies several places).

I was hoping someone would point out something better than fls, fixed.

> > +#ifdef CONFIG_MPIC_BROKEN_U3
> > +static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	struct irq_host_ops *ops =3D mpic->irqhost->ops;
> > +	struct device_node *np;
> > +	int flags, index, i;
> > +	struct of_irq oirq;
> > +
> > +	pr_debug("mpic: found U3, guessing msi allocator setup\n");
> > +
> > +	/* Reserve source numbers we know are reserved in the HW */
> > +	for (i =3D 0;   i < 8;   i++) __mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i =3D 42;  i < 46;  i++) __mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i =3D 100; i < 105; i++) __mpic_msi_reserve_hwirq(mpic, i);
>=20
> More lines please.
>=20
> > +#else
> > +static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic) { return -1;=20
> > }
>=20
> and here.

Blank lines aren't free you know!

>=20
> > +	if (len % 8 !=3D 0) {
> > +		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
> > +		       "property on %s\n", mpic->of_node->full_name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	bitmap_allocate_region(mpic->hwirq_bitmap, 0,
> > +			       fls(mpic->irq_count) - 1);
> > +
> > +	/* Format is: (<u32 start> <u32 count>)+ */
> > +	len /=3D sizeof(u32);
> > +	for (i =3D 0; i < len / 2; i++, p +=3D 2)
>=20
> how about just dividing by the calculated 8 above?  or use
> count =3D len / 8.

I'm not sure I follow. If you can think of a clearer way I'm all ears,
or are you just trying to save a divide :)

>=20
> > +		mpic_msi_free_hwirqs(mpic, *p, *(p + 1));
> > +
> > +	return 0;
> > +}
> > +
> > +int mpic_msi_init_allocator(struct mpic *mpic)
> > +{
> > +	int rc, size;
> > +
> > +	BUG_ON(mpic->hwirq_bitmap);
> > +	spin_lock_init(&mpic->bitmap_lock);
> > +
> > +	size =3D mpic->irq_count / 8;
> > +	pr_debug("mpic: allocator bitmap size is 0x%x bytes\n", size);
>=20
> BITS_TO_LONGS() * sizeof(long).   We need to round up to longs to
> use bitmask_*, especially being a big endian architecture.

Eww, sorry that's horrible. Fixed.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2iEcJ8TQdg/XU6La1Kkm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLDBGdSjSd0sB4dIRAjpZAKCJC5ifG86W7Z7p6Kg9TLSRxml9KQCgs/3x
YJKBhfNtFZTm//VxbnsanQA=
=zskh
-----END PGP SIGNATURE-----

--=-2iEcJ8TQdg/XU6La1Kkm--
