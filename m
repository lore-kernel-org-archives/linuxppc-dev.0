Return-Path: <michael@ellerman.id.au>
Subject: Re: problem with numa reserve bootmem
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <49924348.5050702@am.sony.com>
References: <48EE6720.6010601@linux.vnet.ibm.com>
	<49924348.5050702@am.sony.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HJRnWMwgd7Q/iMCgAUcJ"
Date: Wed, 11 Feb 2009 14:55:30 +1100
Message-Id: <1234324530.11846.11.camel@localhost>
Mime-Version: 1.0
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HJRnWMwgd7Q/iMCgAUcJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-02-10 at 19:17 -0800, Geoff Levand wrote:
> Hi Jon,
>=20
> Jon Tollefson wrote:
> > This patch takes out the reserved region loop from inside
> > the loop that goes over each node.  It looks up the active region conta=
ining
> > the start of the reserved region.  If it extends past that active regio=
n then
> > it adjusts the size and gets the next active region containing it.
> >=20
> >  numa.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++--------=
---------
> >  1 file changed, 80 insertions(+), 28 deletions(-)
>=20
> I had some problems with this numa change (commit 8f64e1f2d1e09267ac926e1=
5090fd505c1c0cbcb)
> missing an lmb reserved region.
>=20
> There have been some changes to this code since this patch was committed,
> but the general problem still exists.
>=20
> With the PS3 platform, the boot wrapper program puts the device tree
> above the boot wrapper's _end symbol.  So with this there is a small
> reserved bootmem section for the DT of about 0x270 bytes
> (reserved.region[0x1]):
>=20
> lmb_dump_all:
>     memory.cnt            =3D 0x1
>     memory.size           =3D 0x8000000
>     memory.region[0x0].base       =3D 0x0
>                       .size     =3D 0x8000000
>     reserved.cnt          =3D 0x2
>     reserved.size         =3D 0x8000000
>     reserved.region[0x0].base       =3D 0x0
>                       .size     =3D 0xcc8000
>     reserved.region[0x1].base       =3D 0xce0300
>                       .size     =3D 0x270
>=20
> > +	/* Mark reserved regions */
> > +	for (i =3D 0; i < lmb.reserved.cnt; i++) {
> > +		unsigned long physbase =3D lmb.reserved.region[i].base;
> > +		unsigned long size =3D lmb.reserved.region[i].size;
> > +		unsigned long start_pfn =3D physbase >> PAGE_SHIFT;
> > +		unsigned long end_pfn =3D ((physbase + size) >> PAGE_SHIFT);
>=20
> With reserved.region[0x1] start_pfn and end_pfn are equal (0xce0) here.
>=20
> > +		struct node_active_region node_ar;
> > +
> > +		get_node_active_region(start_pfn, &node_ar);
> > +		while (start_pfn < end_pfn) {
>=20
> And this while (start_pfn < end_pfn) test fails,
>=20
> > +			/*
> > +			 * if reserved region extends past active region
> > +			 * then trim size to active region
> > +			 */
> > +			if (end_pfn > node_ar.end_pfn)
> > +				size =3D (node_ar.end_pfn << PAGE_SHIFT)
> > +					- (start_pfn << PAGE_SHIFT);
> > +			dbg("reserve_bootmem %lx %lx nid=3D%d\n", physbase, size,
> > +				node_ar.nid);
> > +			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
> > +						size, BOOTMEM_DEFAULT);
>=20
> And so this reserve_bootmem_node() is never called for the small region.
>=20
> I'm not sure if the problem is the calculation of the end_pfn, or if we
> need to test for equality in the while: (start_pfn <=3D end_pfn).  Please
> let me know what you think.  I'll look at it some more tomorrow.

Dave, you had a patch for this I think?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HJRnWMwgd7Q/iMCgAUcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSTDIACgkQdSjSd0sB4dK0RgCghoJUHzMTBfgp6wBJL68PtSYa
DqkAoJg07Cmw1Tesogs/eS3wx2HyD3Tb
=UDkQ
-----END PGP SIGNATURE-----

--=-HJRnWMwgd7Q/iMCgAUcJ--
