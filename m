Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
From: Michael Ellerman <michael@ellerman.id.au>
To: Sonny Rao <sonnyrao@us.ibm.com>
In-Reply-To: <20100519042744.GA26215@us.ibm.com>
References: <20100519042744.GA26215@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-fo9hT8iJSRafih/Ycb/K"
Date: Wed, 19 May 2010 22:10:58 +1000
Message-ID: <1274271058.13433.30.camel@concordia>
Mime-Version: 1.0
Cc: markn@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-fo9hT8iJSRafih/Ycb/K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-18 at 23:27 -0500, Sonny Rao wrote:
> On Tue, 18 May 2010 23:37:31 +1000, Michael Ellerman wrote:
> >=20
> > On Mon, 2010-05-17 at 22:53 +1000, Mark Nelson wrote:
> > > This patch adds support for handling IO Event interrupts which come
> > > through at the /event-sources/ibm,io-events device tree node.
> >=20
> > Hi Mark,
> >=20
> > You'll have to explain to me offline sometime how it is we ran out of
> > interrupts and started needing to multiplex them ..
>=20
> Firmware has decided to multiplex all i/o error reporting through a singl=
e
> interrupt for reasons unknown, that is the primary reason for this patch.

Yeah, I just don't get why we would do that, but hey whatever.

> > The "checks the scope" requires an RTAS call, which takes a global lock
> > (and you add another) - these aren't going to be used for anything
> > performance critical I hope?
>=20
> Nope it shouldn't be performance critical, but it does raise the point
> that the current RTAS implementation in Linux *always* uses the global
> lock.  There is a set of calls which are not required to be serialized
> against each other.  This would be a totally different patchset to fix th=
at
> problem.  The "check-exception" call is one that doesn't require the glob=
al
> RTAS lock.  I might work on that someday :-)

Aha, that's kind of what I was wondering. I take it PAPR documents which
calls need to be serialised and which don't?

> > > +	cons =3D kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);
> >=20
> > But you don't want to kmalloc while holding the lock and with interrupt=
s
> > off.
>=20
> Well, he could use GFP_ATOMIC but that's the wrong approach.  You should
> allocate the buffer (using GFP_KERNEL) before taking the spin lock.

True, this is not a good example of when to use GFP_ATOMIC though :)

> Also, if we're going to go ahead and use rtas_call() which locks
> it's own buffer which meets the requirements, why do we even need
> a separate buffer?  Really, we should make this call, then copy
> the content of the buffer before handing it over to the drivers.

But another CPU could rtas_call() and blow away our buffer after we've
dropped the RTAS lock but before we've used the content of the buffer.

> > > +	if (rtas_elog->type !=3D RTAS_TYPE_IO_EVENT) {
> > > +		pr_warning("IO Events: We got called with an event type of %d"
> > > +			   " rather than %d!\n", rtas_elog->type,
> > > +			   RTAS_TYPE_IO_EVENT);
> > > +		WARN_ON(1);
> > > +		goto out;
> > > +	}
>=20
> Should we try to process this instead of just warning? =20
> The type we get might be one of the the ones we recognize in
> ras.c; so this is an argument for combining ras.c with this code
> or at least report this in the same manner we report any other
> RTAS error log.

We could, but that would be a massive firmware bug - not that it
wouldn't happen, but it would be Not Our Problem TM.

> > We /could/ copy the ioei_sec and drop the buf lock, which would allow
> > another interrupt to come in and start doing the RTAS call (on another
> > cpu, and iff there are actually multiple interrupts). But we probably
> > don't care.
>=20
> I think we *have* to copy it because we don't want our lock held when we
> call random handlers.

They're not really random, and as long as they don't call the
register/unregister routines it should be /OK/. But copying is probably
good so we don't hold the lock for too long.

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
> Or, we might subvert it for our own evil purposes ;-)

I can only imagine :)

cheers

--=-fo9hT8iJSRafih/Ycb/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvz1VIACgkQdSjSd0sB4dJUYACggNigB1Ol1pEiF8/ajDxCW2qK
r8MAn2IT9scudoK+F8KRTnAkWDYG60xe
=Pi99
-----END PGP SIGNATURE-----

--=-fo9hT8iJSRafih/Ycb/K--
