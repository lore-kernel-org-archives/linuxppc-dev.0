Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/8] Remove unused pte_offset variable
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1204099491.15052.227.camel@pasglop>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
	<180c3c87682d05b1d58e50df77f99478f98d9b30.1204097262.git.michael@ellerman.id.au>
	<1204099491.15052.227.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OnF8ymBJd4RARaIYFDYC"
Date: Wed, 27 Feb 2008 19:11:00 +1100
Message-Id: <1204099860.6932.2.camel@concordia>
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


--=-OnF8ymBJd4RARaIYFDYC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-02-27 at 19:04 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-02-27 at 18:28 +1100, Michael Ellerman wrote:
> > The cell IOMMU code no longer needs to save the pte_offset variable
> > separately, it is incorporated into tbl->it_offset.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
>=20
> Do this work on spider ?
>=20
> There is a subtle difference with spider is that the 0x80000000 you give
> to devices disappears when reaching the iommu (so isn't to be catered
> in the iommu offset).
>=20
> It's a bit like the offset you have to add to the direct mapping on
> axon, in fact (the 0x8000060000000000 or so ...)

I'm pretty sure I tested it and it worked.

But I didn't actually change anything WRT the spider offset anyway, we
still add it to it_offset just like we used to, it's just we don't put
it in the window and then pull it out again.

The only thing that's changed is we now use offset (aka. base) in the
tce routines in addition to pte_offset.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-OnF8ymBJd4RARaIYFDYC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBHxRsUdSjSd0sB4dIRAjiIAJjVEkq/5lcn7KbYZd6/wSzFh64MAJ9MOT5m
WaUA5riPdMo6RQSLULfk2Q==
=FSV8
-----END PGP SIGNATURE-----

--=-OnF8ymBJd4RARaIYFDYC--
