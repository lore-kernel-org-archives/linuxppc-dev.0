Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 10:41:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
Message-ID: <20070509004102.GA4198@localhost.localdomain>
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
	<1178668594.3696.5.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <1178668594.3696.5.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2007 at 09:56:34AM +1000, Michael Ellerman wrote:
> On Tue, 2007-05-08 at 12:14 -0500, Scott Wood wrote:
> > The prop variable is only referenced when initrd support is
> > turned on.
> >=20
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/powerpc/kernel/prom.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index caef555..6705459 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -720,7 +720,7 @@ static int __init early_init_dt_scan_chosen(unsigne=
d long node,
> >  					    const char *uname, int depth, void *data)
> >  {
> >  	unsigned long *lprop;
> > -	u32 *prop;
> > +	u32 __attribute__((unused)) *prop;
> >  	unsigned long l;
> >  	char *p;
>=20
> Hi Scott,
>=20
> Let's be honest, this is a hack. I think it'd be cleaner to pull the
> initrd logic out into a separate function.

More speficially, if the variable ever really becomes unused, this
will continue to suppress the warning.  I'd be happied with an #ifdef
initrd around it, ugly though that is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQRieaILKxv3ab8YRAgTWAJ9HoXpUa4WsNoMTwO/hBDCPvg7sNACdG+9/
p5KhT8Ek3hyc4sIMx/WKNxw=
=g41h
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
