Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
From: Michael Ellerman <michael@ellerman.id.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <47D8AD9C.2030106@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C750CE.7050202@austin.ibm.com>
	<1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
	<3ae3aa420803121052g6ded9c94xd23823a4e81f4bbf@mail.gmail.com>
	<47D8AD9C.2030106@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-QJSaSkM/nG16UHy4kWKg"
Date: Fri, 14 Mar 2008 15:20:46 +1100
Message-Id: <1205468446.7414.7.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-QJSaSkM/nG16UHy4kWKg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-03-12 at 23:29 -0500, Manish Ahuja wrote:
> If Mike and Paul are okay, then I will leave this bit as is and fix all=20
> other issues and comments.

Well I still don't like it - it uglifies the code _now_, for a potential
future benefit that may never come. But I don't care that much, if
Paul's happy with it let it go in.

cheers

> Linas Vepstas wrote:
> > On 10/03/2008, Michael Ellerman <michael@ellerman.id.au> wrote:
> >> On Thu, 2008-02-28 at 18:24 -0600, Manish Ahuja wrote:
> >=20
> >>  > +
> >>  > +/* Global, used to communicate data between early boot and late bo=
ot */
> >>  > +static struct phyp_dump phyp_dump_global;
> >>  > +struct phyp_dump *phyp_dump_info =3D &phyp_dump_global;
> >>
> >> I don't see the point of this. You have a static (ie. non-global) stru=
ct
> >>  called phyp_dump_global, then you create a pointer to it and pass tha=
t
> >>  around.
> >=20
> > I did this. This is a style used to minimize disruption due to future
> > design changes. Basically, the idea is that, at some later time, for
> > some unknown reason, we decide that this structure shouldn't
> > be global, or maybe shouldn't be statically allocated, or maybe
> > should be per-cpu, or who knows.  By creating a pointer, and
> > just passing that around, you isolate other code from this change.
> >=20
> > I learned this trick after spending too many months of my life hunting
> > down globals and replacing them by dynamically allocated structs.
> > Its a long and painful process, on many levels, often requiring major
> > code restructuring.  Code that touches globals directly is often
> > poorly thought out, designed.  But going in the opposite direction
> > is easy: if your code always passes everything it needs as args
> > to subroutines,  then you are free & clear ... if one of those args
> > just happens to be a pointer to a global, there's no loss (not even
> > a performance loss -- the arg passing overhead is about the same
> > as a global TOC lookup!)
> >=20
> > So it may look weird if you're not used to seeing it; but the alternati=
ve
> > is almost always worse.


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-QJSaSkM/nG16UHy4kWKg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH2f0edSjSd0sB4dIRAnSVAJ9ZEK9rM6bKB4a/saWKY+g58RwZRwCePu5w
zf24AaWoRmlJTeSIDO+b1A4=
=RhIL
-----END PGP SIGNATURE-----

--=-QJSaSkM/nG16UHy4kWKg--
