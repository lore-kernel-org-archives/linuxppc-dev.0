Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201005192024.02780.markn@au1.ibm.com>
References: <201005172253.29825.markn@au1.ibm.com>
	<1274189851.26143.63.camel@concordia>
	<201005192024.02780.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-7EmfWOQtdaNOXNjyXBW3"
Date: Wed, 19 May 2010 22:02:46 +1000
Message-ID: <1274270566.13433.22.camel@concordia>
Mime-Version: 1.0
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-7EmfWOQtdaNOXNjyXBW3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-19 at 20:24 +1000, Mark Nelson wrote:
> On Tuesday 18 May 2010 23:37:31 Michael Ellerman wrote:
> > On Mon, 2010-05-17 at 22:53 +1000, Mark Nelson wrote:

> >=20
> > > +	/* check to see if we've already registered this function with
> > > +	 * this scope. If we have, don't register it again
> > > +	 */
> > > +	iter =3D ioei_isr_list;
> > > +	while (iter) {
> > > +		if (iter->ioei_isr =3D=3D isr && iter->scope =3D=3D scope)
> > > +			break;
> > > +		iter =3D iter->next;
> > > +	}
> > > +
> > > +	if (iter) {
> > > +		ret =3D -EEXIST;
> > > +		goto out;
> > > +	}
> > > +
> > > +	cons =3D kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);
> >=20
> > But you don't want to kmalloc while holding the lock and with interrupt=
s
> > off.
>=20
> I could allocate above, before taking the lock, and then if we get the
> case where it already exists in the list I could just free it before
> returning. Would that work?

Yeah I think so, optimise for the normal case where it doesn't already
exist. The other option would be to take the lock, check, do the alloc,
retake the lock and recheck - but that's a pain and not really worth the
trouble.

> > > +	ioei_sec =3D (struct io_events_section *)ch_ptr;
> > > +
> > > +	ioei_call_consumers(ioei_sec->scope, ioei_sec);
> >=20
> > Guaranteed to be only one section returned to us per call?
>=20
> My understanding is that there's only ever one, but I'll double check.

OK good to check. Could be worth checking in the code, unless it's going
to be really expensive.

> >=20
> > We /could/ copy the ioei_sec and drop the buf lock, which would allow
> > another interrupt to come in and start doing the RTAS call (on another
> > cpu, and iff there are actually multiple interrupts). But we probably
> > don't care.
>=20
> Good point - I'll update it so that we do the copy.

Sounds like we should. It's not such a concern to call the handlers with
the lock held IMHO (Sonny raised that), as long as the handlers don't
try and register/unregister themselves. But that will be pretty obvious
if it happens.

> > > +		request_event_sources_irqs(np, io_event_interrupt, "IO_EVENT");
> > > +		of_node_put(np);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +device_initcall(init_ioei_IRQ);
> >=20
> > Should probably be a machine_initcall().
>=20
> I'll change it to machine_device_initcall?

Yep.

> > > Index: upstream/arch/powerpc/platforms/pseries/Makefile
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- upstream.orig/arch/powerpc/platforms/pseries/Makefile
> > > +++ upstream/arch/powerpc/platforms/pseries/Makefile
> > > @@ -8,7 +8,7 @@ endif
> > > =20
> > >  obj-y			:=3D lpar.o hvCall.o nvram.o reconfig.o \
> > >  			   setup.o iommu.o event_sources.o ras.o \
> > > -			   firmware.o power.o dlpar.o
> > > +			   firmware.o power.o dlpar.o io_events.o
> >=20
> > The BML guys might appreciate an option to turn it off?
>=20
> I initially had an option that gets selected by PPC_PSERIES, how about
> that?

Select is not great because it disregards dependencies, and BML is
PSERIES. Probably just have an option that depends on PSERIES and is
default y.

cheers


--=-7EmfWOQtdaNOXNjyXBW3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEABECAAYFAkvz02IACgkQdSjSd0sB4dKJ3wCeMIqIw1+TYaFfCs/fdSvHylY9
n5sAmOFiClf7X2gNjByVZ8qBWmz61S4=
=bM2U
-----END PGP SIGNATURE-----

--=-7EmfWOQtdaNOXNjyXBW3--
