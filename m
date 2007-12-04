Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH] Add IPIC MSI interrupt support
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Tony <Tony.Li@freescale.com>
In-Reply-To: <995B09A8299C2C44B59866F6391D2635D75588@zch01exm21.fsl.freescale.net>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196746689.20158.4.camel@concordia>
	<995B09A8299C2C44B59866F6391D2635D75588@zch01exm21.fsl.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MNXgi35vWGI6zfC6jCGJ"
Date: Tue, 04 Dec 2007 23:04:18 +1100
Message-Id: <1196769858.32524.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MNXgi35vWGI6zfC6jCGJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-12-04 at 18:34 +0800, Li Tony wrote:
> > From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> > Sent: 2007=E5=B9=B412=E6=9C=884=E6=97=A5 13:38
> > To: Li Tony
> > Cc: Li Tony; Gala Kumar; linuxppc-dev
> > Subject: Re: [PATCH] Add IPIC MSI interrupt support
> >=20
> > On Mon, 2007-12-03 at 17:07 +0800, Li Li wrote:
> > > Hi Michael,
> > >=20
> > > I emulate mpic to write this IPIC MSI routines. :)
> > >=20
> > >=20
> > > > > diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c=20
> > > > > b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > > > > index 6048f1b..dbea34b 100644
> > > > > --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > > > > +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> >=20
> > > > > +
> > > > > +#define	ipic_msi_irq_to_hw(virq)=09
> > ((unsigned int)irq_map[virq].hwirq)
> > > >=20
> > > > What's wrong with virq_to_hw() ?
> > > >=20
> > >=20
> > > viqr_to_hw is not __inline__.
> >=20
> > Hmm, ok. The three places you use it you also take a spin=20
> > lock, so I'm not sure the function call's really going to=20
> > kill you performance wise.
> >=20
>=20
> I am not very sure about spin_lock influence.
> But maybe somebody will change the virq_to_hw implementation.
> I will take virq_to_hw instead.=20

I mean the time to take the function call should be pretty small
compared to taking and releasing a spinlock - but if you have
performance numbers to prove otherwise let me know :)

> I see that the virq_to_hw is do inline in 2.6.22.
> Why remove it?

It was made non-inline because modules want to use it, and we didn't
want to export the irq_map to modules as well.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-MNXgi35vWGI6zfC6jCGJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHVUJCdSjSd0sB4dIRAorgAJ9eTv5i+BZv/gJm/fcx9F9ZO+yPpwCdGeIl
EwpBGaMeLZaWjb6bDWETHbA=
=9Y3F
-----END PGP SIGNATURE-----

--=-MNXgi35vWGI6zfC6jCGJ--
