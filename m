Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/7] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <e4520bd4be50f2884003a9421863627c@bga.com>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qIMgta+c3Q0XUGLDNg+d"
Date: Mon, 23 Apr 2007 13:45:22 +1000
Message-Id: <1177299922.3889.16.camel@concordia.ozlabs.ibm.com>
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


--=-qIMgta+c3Q0XUGLDNg+d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 18:17 -0500, Milton Miller wrote:
> On Apr 19, 2007, Michael Ellerman wrote:
> > MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> > Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
> ...
> > Index: msi-new/arch/powerpc/sysdev/Makefile
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- msi-new.orig/arch/powerpc/sysdev/Makefile
> > +++ msi-new/arch/powerpc/sysdev/Makefile
> > @@ -4,6 +4,7 @@ endif
> >
> >  mpic-obj-y			:=3D mpic.o
> >  mpic-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o
> > +mpic-obj-$(CONFIG_PCI_MSI)	+=3D mpic_htmsi.o
> >  obj-$(CONFIG_MPIC)		+=3D $(mpic-obj-y)
>=20
> This is overly complicated.  You aren't going to be making this
> a seperate link object anyways.   It should end up somehting like
>=20
> mpic-msi-$(CONFIG_PCI_MSI)	:=3D mpic_msi.o mpic_htmsi.o
> obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-y)

Fixed.

> > -static void mpic_unmask_irq(unsigned int irq)
> > +void mpic_unmask_irq(unsigned int irq)
> ...
> > -static void mpic_mask_irq(unsigned int irq)
> > +void mpic_mask_irq(unsigned int irq)
> ...
> Ok mpic.c is big enough already.

Yeah I tried it the other way, but it was messy.

> > Index: msi-new/arch/powerpc/sysdev/mpic.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- msi-new.orig/arch/powerpc/sysdev/mpic.h
> > +++ msi-new/arch/powerpc/sysdev/mpic.h
> > @@ -11,14 +11,23 @@
> >   *
> >   */
> >
> > +#include <linux/irq.h>
> > +
>=20
> Why do you need this now?   You already had uses of irq_ht_umber_t
> and struct mpic.  Unless this should be in the earlier patch?

Cruft, removed.

> >  #ifdef CONFIG_PCI_MSI
> >  extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t=20
> > hwirq);
> > +extern int mpic_htmsi_init(struct mpic *mpic);
> >  #else
> >  static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
> >  					  irq_hw_number_t hwirq)
> >  {
> >  	return;
> >  }
> > +static inline int mpic_htmsi_init(struct mpic *mpic) { return -1; }
>=20
> more lines please

OK.

> > +int mpic_htmsi_init(struct mpic *mpic)
> > +{
> > +	int rc;
> > +
> > +	rc =3D mpic_msi_init_allocator(mpic);
> > +	if (rc) {
> > +		pr_debug("htmsi: Error allocating bitmap!\n");
> > +		return rc;
> > +	}
> > +
> > +	pr_debug("htmsi: Registering MPIC MSI callbacks.\n");
> > +
> > +	BUG_ON(msi_mpic);
> > +	msi_mpic =3D mpic;
> > +
> > +	ppc_md.setup_msi_irqs =3D htmsi_setup_msi_irqs;
> > +	ppc_md.teardown_msi_irqs =3D htmsi_teardown_msi_irqs;
> > +	ppc_md.msi_check_device =3D htmsi_msi_check_device;
>=20
> Unlike the rtas patch, this one didn't advertise it was
> going to set the arch hooks unconditionally.

Yeah OK, fixed.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qIMgta+c3Q0XUGLDNg+d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLCvSdSjSd0sB4dIRAuMzAKCnay98xYjezkxL+G3LfJ9tjBHGQgCfXvY4
X5L/FFHjoIpp/aFxM/BVQ48=
=zjJE
-----END PGP SIGNATURE-----

--=-qIMgta+c3Q0XUGLDNg+d--
