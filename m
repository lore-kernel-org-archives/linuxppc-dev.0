Return-Path: <michael@ellerman.id.au>
Subject: Re: cast truncates bits from constant value (8000000000000000
	becomes 0)
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0612011553100.30940@pademelon.sonytel.be>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<20061201143940.GB3078@ftp.linux.org.uk>
	<Pine.LNX.4.62.0612011553100.30940@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pv/Cw+SRebEp+T+e19p4"
Date: Sat, 02 Dec 2006 18:50:26 +1100
Message-Id: <1165045826.6246.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-sparse@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pv/Cw+SRebEp+T+e19p4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-01 at 15:55 +0100, Geert Uytterhoeven wrote:
> On Fri, 1 Dec 2006, Al Viro wrote:
> > On Fri, Dec 01, 2006 at 03:25:08PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, 21 Nov 2006, Geoff Levand wrote:
> > > > +enum ps3_vendor_id {
> > > > +	PS3_VENDOR_ID_NONE =3D 0,
> > > > +	PS3_VENDOR_ID_SONY =3D 0x8000000000000000UL,
> > > > +};
> > >=20
> > > I've just ran `make C=3D1' (PPC in 64-bit mode, and sparse is called =
with -m64),
> > > and noticed that sparse (cloned from
> > > git://git.kernel.org/pub/scm/devel/sparse/sparse.git a few minutes ag=
o)
> > > complains about the second value with:
> > >=20
> > > | warning: cast truncates bits from constant value (8000000000000000 =
becomes 0)
> > >=20
> > > Section 6.7.2.2.4 of C99 says:
> > >=20
> > > | Each enumerated type shall be compatible with char, a signed intege=
r type, or
> > > | an unsigned integer type. The choice of type is implementation-defi=
ned, but
> > > | shall be capable of representing the values of all the members of t=
he
> > > | enumeration.
> >=20
> > FWIW, that code is *not* valid C99; note that all enumeration members m=
ust
> > fit the range of int (see 6.7.2.2.2).  What you quote speaks about the
>=20
> You're right. I missed that one.
>=20
> > IOW, you are using a gccism in an area where gcc is bloody inconsistent
> > in the set of bugs it shows in different versions.
>=20
> Hmmm...
>=20
> > Generally safe way is to split the anonymous huge enum members into
> > single-element enums and pray that gcc will at least stay consistent
> > in handling of those.
>=20
> Or fall back to #defines, which is what we were trying to avoid in the fi=
rst
> place (i.e. group related values together in enums)...

The enum achieves very little in this case IMHO, it's just a more
verbose way of #defining - and it doesn't even have reliable semantics.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pv/Cw+SRebEp+T+e19p4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFcTBBdSjSd0sB4dIRAqCxAJwK2RBu4/SGzBLncIzE1PDOct1uBgCgt+6W
xPvL+xvtbgoVEEmGHxhfSMw=
=SakU
-----END PGP SIGNATURE-----

--=-pv/Cw+SRebEp+T+e19p4--
