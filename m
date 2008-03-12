Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1205280788.7544.2.camel@concordia.ozlabs.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C750CE.7050202@austin.ibm.com>
	<18390.8909.874184.315920@cargo.ozlabs.ibm.com>
	<1205280788.7544.2.camel@concordia.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Lr5l6Pu8lJOLaxubH2g6"
Date: Wed, 12 Mar 2008 11:53:33 +1100
Message-Id: <1205283213.7544.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Lr5l6Pu8lJOLaxubH2g6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2008-03-12 at 11:13 +1100, Michael Ellerman wrote:
> On Tue, 2008-03-11 at 17:12 +1100, Paul Mackerras wrote:
> > Manish Ahuja writes:
> >=20
> > > +#else /* CONFIG_PHYP_DUMP */
> > > +int early_init_dt_scan_phyp_dump(unsigned long node,
> > > +		const char *uname, int depth, void *data) { return 0; }
> >=20
> > This shouldn't be in the header file.  Either put it in prom.c (and
> > make it return 1 so the of_scan_flat_dt call doesn't have to go
> > through the entire device tree), or put #ifdef CONFIG_PHYP_DUMP around
> > the of_scan_flat_dt call itself.
>=20
> It should be in the header file, otherwise we need an #ifdef around the
> call site - which is uglier.

Right I'm an idiot. It is called via a function pointer, so a static
inline (which this should be, but isn't) is no good. An #ifdef around
the call site is probably the least ugly option given that otherwise we
have to have an empty version in the binary.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Lr5l6Pu8lJOLaxubH2g6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1ymNdSjSd0sB4dIRAoGGAJ9F1e0S/yyT1rVad2AlvGUUXA+NzgCfS/v9
Uv0cC1KBkpbyiMvM7toyWdg=
=dCbw
-----END PGP SIGNATURE-----

--=-Lr5l6Pu8lJOLaxubH2g6--
