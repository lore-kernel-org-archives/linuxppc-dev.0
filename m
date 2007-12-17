Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 11:44:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] wrapper: rename offset in offset_devp().
Message-ID: <20071217004415.GC2394@localhost.localdomain>
References: <20071211212303.GA3661@loki.buserror.net>
	<20071212154528.7aaaa829.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
In-Reply-To: <20071212154528.7aaaa829.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2007 at 03:45:28PM +1100, Stephen Rothwell wrote:
> On Tue, 11 Dec 2007 15:23:04 -0600 Scott Wood <scottwood@freescale.com> w=
rote:
> >
> >  #define offset_devp(off)	\
> >  	({ \
> > -		int offset =3D (off); \
> > -		check_err(offset) ? NULL : (void *)(offset+1); \
> > +		int _offset =3D (off); \
> > +		check_err(_offset) ? NULL : (void *)(_offset+1); \
> >  	})
>=20
> Just wondering if this could be a static inline function?

Alas, not really.  If we did that, then the __FUNCTION__ and __LINE__
we use in the error message inside check_err() would always refer to
the offset_devp() function, which would be substantially less useful
than referring to the function which invoked the offset_devp() macro.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZcZfaILKxv3ab8YRAu9kAJ96tyx/4h/s2k7iC/Yz9s3zq5dY8ACeLIMo
J4AJ/TDIQlDOed5PajyQ0e0=
=ujS/
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
