Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Fix irq_alloc_host() reference counting and callers
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18473.29766.501740.124434@cargo.ozlabs.ibm.com>
References: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
	<dabdb53ffc73aa86b0432118bf07f2fc9ce72f6f.1210220561.git.michael@ellerman.id.au>
	<18473.29766.501740.124434@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LfnllInl1X1eM9fmW4Y3"
Date: Tue, 13 May 2008 21:49:46 +1000
Message-Id: <1210679386.14810.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LfnllInl1X1eM9fmW4Y3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-05-13 at 20:58 +1000, Paul Mackerras wrote:
> Michael Ellerman writes:
>=20
> > When I changed irq_alloc_host() to take an of_node
> > (52964f87c64e6c6ea671b5bf3030fb1494090a48: "Add an
> > optional device_node pointer to the irq_host"),
> > I botched the reference counting semantics.
> >=20
> > Stephen pointed out that it's irq_alloc_host()'s
> > business if it needs to take an additional reference
> > to the device_node, the caller shouldn't need to care.
> > To make that clean we also need a free routine, so
> > the caller doesn't have to deal with dropping the
> > reference.
> >=20
> > Luckily we now have an irq_free_host() where we can
> > drop the reference - so we can make the reference
> > counting internal to irq_alloc_host()/irq_free_host().
>=20
> Is this needed for 2.6.26?=20

No.

> What's the worst possible effect of this bug?

Only nodes having an incorrect reference count - in either direction.
But pseries is fine, so there should be no real bug.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LfnllInl1X1eM9fmW4Y3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIKYBadSjSd0sB4dIRAs+PAKCXqxpGahIZNE8WuWEkjVhA3zu6jACglOHS
jubBqjoiwWDtGHH1a4wX18c=
=2q8e
-----END PGP SIGNATURE-----

--=-LfnllInl1X1eM9fmW4Y3--
