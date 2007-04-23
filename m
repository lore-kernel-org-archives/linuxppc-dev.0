Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070423035025.GA29839@lixom.net>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X1S3rEohKnjnA1VxKGUP"
Date: Mon, 23 Apr 2007 13:53:42 +1000
Message-Id: <1177300422.3889.21.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X1S3rEohKnjnA1VxKGUP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-04-22 at 22:50 -0500, Olof Johansson wrote:
> On Thu, Apr 19, 2007 at 05:35:28PM +1000, Michael Ellerman wrote:
> > To support MSI on MPIC we need a way to reserve and allocate hardware i=
rq
> > numbers, this patch implements an allocator for that.
> >=20
> > New firmware platforms must define a "msi-available-ranges" property on=
 their
> > MPIC node for MSI to work. For BROKEN_U3 we do a best-guess setup.
>=20
> It's time to rename BROKEN_U3. It used to be the config option to enable
> a few workarounds, but now it's used to select whenever there's a U3 in
> the system. Care to do it in the scope of this patch set?

Yeah it's pretty ugly. I guess I can do it. Got an idea for a better
name? MPIC_HT?

> > Index: msi-new/include/asm-powerpc/mpic.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- msi-new.orig/include/asm-powerpc/mpic.h
> > +++ msi-new/include/asm-powerpc/mpic.h
> > @@ -292,6 +292,11 @@ struct mpic
> >  	u32			*hw_set;
> >  #endif
> > =20
> > +#ifdef CONFIG_PCI_MSI
> > +	spinlock_t		bitmap_lock;
> > +	unsigned long		*hwirq_bitmap;
> > +#endif
>=20
> Besides the #ifdef there's nothing in the name that indicates that it's
> used for msi. Better names could be useful.

True. Although, it doesn't necessarily have anything to do with MSI,
it's just a bitmap of hwirqs that are used/free. As it happens we only
need it when we're doing MSI though.

>=20
> > @@ -440,5 +445,11 @@ void mpic_set_clk_ratio(struct mpic *mpi
> >  /* Enable/Disable EPIC serial interrupt mode */
> >  void mpic_set_serial_int(struct mpic *mpic, int enable);
> > =20
> > +#ifdef CONFIG_PCI_MSI
> > +extern int mpic_msi_init_allocator(struct mpic *mpic);
> > +extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int nu=
m);
> > +extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int nu=
m);
> > +#endif
>=20
> These should go in mpic.h instead.

Yep.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-X1S3rEohKnjnA1VxKGUP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLC3GdSjSd0sB4dIRAryUAJ9lDNiL2DIO7/gYJCvtW5o4VxSPqwCffwKh
Vxp6AGcNSsrdSj3OiulCnA0=
=Kb42
-----END PGP SIGNATURE-----

--=-X1S3rEohKnjnA1VxKGUP--
