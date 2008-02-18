Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
From: Michael Ellerman <michael@ellerman.id.au>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20080218141340.GB667@cs181133002.pp.htv.fi>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
	<Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
	<20080218141340.GB667@cs181133002.pp.htv.fi>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IdwcwOSGnOD6G3yqipy8"
Date: Tue, 19 Feb 2008 08:46:03 +1100
Message-Id: <1203371163.6844.2.camel@concordia>
Mime-Version: 1.0
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Willy Tarreau <w@1wt.eu>, Arjan van de Ven <arjan@infradead.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IdwcwOSGnOD6G3yqipy8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-02-18 at 16:13 +0200, Adrian Bunk wrote:
> On Mon, Feb 18, 2008 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 18 Feb 2008, Adrian Bunk wrote:
> > >=20
> > > This means it generates faster code with a current gcc for your platf=
orm.
> > >=20
> > > But a future gcc might e.g. replace the whole loop with a division
> > > (gcc SVN head (that will soon become gcc 4.3) already does=20
> > > transformations like replacing loops with divisions [1]).
> >=20
> > Hence shouldn't we ask the gcc people what's the purpose of __builtin_e=
xpect(),
> > if it doesn't live up to its promise?
>=20
> That's a different issue.
>=20
> My point here is that we do not know how the latest gcc available in the=20
> year 2010 might transform this code, and how a likely/unlikely placed=20
> there might influence gcc's optimizations then.

You're right, we don't know. But if giving the compiler _more_
information causes it to produce vastly inferior code then we should be
filing gcc bugs. After all the unlikely/likely is just a hint, if gcc
knows better it can always ignore it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-IdwcwOSGnOD6G3yqipy8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHufybdSjSd0sB4dIRAuniAKC9yzwN6FD6IrilD99aAJxbRgQNNgCgxz+v
G9yh8IdhjWVhKqqh7KfCB5Y=
=XGUG
-----END PGP SIGNATURE-----

--=-IdwcwOSGnOD6G3yqipy8--
