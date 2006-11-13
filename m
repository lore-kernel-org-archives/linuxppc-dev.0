Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 13/16] powerpc: add ps3 platform lpar addressing
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1163292316.4982.240.camel@localhost.localdomain>
References: <4554DB14.3070900@am.sony.com>  <20061111112847.GD24288@lst.de>
	<1163292316.4982.240.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-94KzXEJ0dVh57jGbzEQU"
Date: Mon, 13 Nov 2006 11:41:54 +1100
Message-Id: <1163378514.7410.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-94KzXEJ0dVh57jGbzEQU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-12 at 11:45 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2006-11-11 at 12:28 +0100, Christoph Hellwig wrote:
> > On Fri, Nov 10, 2006 at 12:03:32PM -0800, Geoff Levand wrote:
> > > Adds some needed bits for a config option PS3PF_USE_LPAR_ADDR that di=
sables
> > > the ps3pf lpar address translation mechanism.  This is a currently ne=
eded
> > > workaround for limitations in the design of the spu support.
> >=20
> > So make the code do the sane thing and don't put the config in the
> > kernel tree.
>=20
> Well... I'd like to keep the option for a little while.
>=20
> There are performances issues with sparsemem the way it's used by
> ps3pf.. the problem is that the memory map looks like you get a bunch of
> memory at 0 (the RMO, not sure exactly how much in practice) and the
> rest in a chunk all the way up the 48 bits or so max physical space.
>=20
> So sparsemem ends up with an enormous mapping only populated at the very
> beginning and the very end.
>=20
> Thus, I'd like Geoff to keep the option of doing the manual translation
> in the hash code for now until I finally get some HW and thus can do
> some measurements, and possibly figure out a nicer way to deal with
> that.

I haven't read the ps3 code very carefully, but at first glance it
struck me that it has a similar problem to iSeries. It might be worth
seeing if the iSeries mschunks_map gunk can help (see
include/asm-powerpc/abs_addr.h)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-94KzXEJ0dVh57jGbzEQU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFV79SdSjSd0sB4dIRAmDPAKC4Kg8sL3D+FvpzhqgroSVjd1cMMACfSyrj
9hm9jg1Iy/Qt8vXXnoUlnFc=
=2ER3
-----END PGP SIGNATURE-----

--=-94KzXEJ0dVh57jGbzEQU--
