Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Use PAGE_OFFSET to tell if an address is
	user/kernel in SW TLB handlers
From: Michael Ellerman <michael@ellerman.id.au>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20071015014524.GG14108@localhost.localdomain>
References: <Pine.LNX.4.64.0710111341140.27045@blarg.am.freescale.net>
	<20071012033032.GH21056@localhost.localdomain>
	<1192190184.3061.27.camel@localhost.localdomain>
	<20071015005447.GD14108@localhost.localdomain>
	<1192410079.13993.4.camel@localhost.localdomain>
	<20071015014524.GG14108@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Lzvf/DsmS2q7H1sp6/da"
Date: Mon, 15 Oct 2007 12:05:31 +1000
Message-Id: <1192413931.6701.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Lzvf/DsmS2q7H1sp6/da
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-10-15 at 11:45 +1000, David Gibson wrote:
> On Sun, Oct 14, 2007 at 08:01:19PM -0500, Josh Boyer wrote:
> > On Mon, 2007-10-15 at 10:54 +1000, David Gibson wrote:
> > > On Fri, Oct 12, 2007 at 06:56:24AM -0500, Josh Boyer wrote:
> > > > On Fri, 2007-10-12 at 13:30 +1000, David Gibson wrote:
> > > > > On Thu, Oct 11, 2007 at 01:42:30PM -0500, Kumar Gala wrote:
> > > > > > Move to using PAGE_OFFSET instead of TASK_SIZE or KERNELBASE va=
lue on
> > > > > > 6xx/40x/44x/fsl-booke to determine if the faulting address is a=
 kernel or
> > > > > > user space address.  This mimics how the macro is_kernel_addr()
> > > > > > works.
> > > > >=20
> > > > > Actually it's ambiguous whether TASK_SIZE or PAGE_OFFSET is corre=
ct in
> > > > > most of these cases (KERNELBASE is certainly wrong, though).
> > > > >=20
> > > > > TASK_SIZE is the top of the userspace mapped area, PAGE_OFFSET is=
 the
> > > > > bottom of the linear mapping.  So, strictly speaking there are 3 =
paths
> > > > > for the miss handlers: < TASK_SIZE =3D> user mapping, >=3D PAGE_O=
FFSET =3D>
> > > > > kernel mapping, between the two =3D> immediate fault.
> > > > >=20
> > > > > We get away with a two way comparison on 32-bit because, a) they =
have
> > > > > the same value and b) none of the pagetables, user or kernel, sho=
uld
> > > > > have any entries in the in between region so we'll end up in
> > > > > do_page_fault in the end, anyway.
> > > >=20
> > > > Kumar's other patch removes the gap.  He changed the default
> > > > CONFIG_TASK_SIZE to 0xc0000000.
> > >=20
> > > That's (a) and only removes the gap in the default configuration..
> >=20
> > I believe the idea was that as defconfigs get updated for 2.6.24, they
> > would pick up the new default.
>=20
> Yes, but if someone overrides CONFIG_TASK_SIZE, it should still work,
> yes?  Or else this should not be a CONFIG option at all.  Which it
> will, of course, because of (b), but one should still be aware of the
> theoretical 3-way branch when touching this code, even if it can be
> reduced to  2-way branch in practice.

There's a construct involving the characters "/" and "*" which I believe
can solve this problem.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Lzvf/DsmS2q7H1sp6/da
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEsrrdSjSd0sB4dIRAmROAKCrlcjxkRE43DyoOgaKk4iQvX+q9QCeIlQw
LqolQT8U7+3YOVuy2QosIbk=
=ts8e
-----END PGP SIGNATURE-----

--=-Lzvf/DsmS2q7H1sp6/da--
