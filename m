Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6042C1A2C55
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:02:53 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:46:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 15/31] powerpc/iommu: Fix IOMMU ownership
 control functions
Message-ID: <20150420024638.GE10218@voom>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
 <20150416061049.GF3632@voom.redhat.com>
 <5530DD6D.8000001@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
In-Reply-To: <5530DD6D.8000001@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 08:16:13PM +1000, Alexey Kardashevskiy wrote:
> On 04/16/2015 04:10 PM, David Gibson wrote:
> >On Fri, Apr 10, 2015 at 04:30:57PM +1000, Alexey Kardashevskiy wrote:
> >>This adds missing locks in iommu_take_ownership()/
> >>iommu_release_ownership().
> >>
> >>This marks all pages busy in iommu_table::it_map in order to catch
> >>errors if there is an attempt to use this table while ownership over it
> >>is taken.
> >>
> >>This only clears TCE content if there is no page marked busy in it_map.
> >>Clearing must be done outside of the table locks as iommu_clear_tce()
> >>called from iommu_clear_tces_and_put_pages() does this.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v5:
> >>* do not store bit#0 value, it has to be set for zero-based table
> >>anyway
> >>* removed test_and_clear_bit
> >>---
> >>  arch/powerpc/kernel/iommu.c | 26 ++++++++++++++++++++++----
> >>  1 file changed, 22 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >>index 7d6089b..068fe4ff 100644
> >>--- a/arch/powerpc/kernel/iommu.c
> >>+++ b/arch/powerpc/kernel/iommu.c
> >>@@ -1052,17 +1052,28 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
> >>
> >>  static int iommu_table_take_ownership(struct iommu_table *tbl)
> >>  {
> >>-	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> >>+	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> >>+	int ret =3D 0;
> >>+
> >>+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> >>+	for (i =3D 0; i < tbl->nr_pools; i++)
> >>+		spin_lock(&tbl->pools[i].lock);
> >>
> >>  	if (tbl->it_offset =3D=3D 0)
> >>  		clear_bit(0, tbl->it_map);
> >>
> >>  	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
> >>  		pr_err("iommu_tce: it_map is not empty");
> >>-		return -EBUSY;
> >>+		ret =3D -EBUSY;
> >>+		if (tbl->it_offset =3D=3D 0)
> >>+			set_bit(0, tbl->it_map);
> >
> >This really needs a comment.  Why on earth are you changing the it_map
> >on a failure case?
>=20
>=20
> Does this explain?
>=20
> /*
>  * The platform code reserves zero address in iommu_init_table().
>  * As we cleared busy bit for page @0 before using bitmap_empty(),
>  * we are restoring it now.
>  */

Only partly.  What's it reserved for, and why do you know it was
always set on entry?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVNGiOAAoJEGw4ysog2bOSjysP/0JjZNc2tq4hsjZHokGXiHir
1hbpSqBj/UyXQk9IAwmZDsL+gSV2ixtyPeDqjnIWLbCsYfExrsA8ZgyouwjxGLYV
/Av3agLQYNoDwZWvbxGQq5anscFF+X/69s0yVEEPPCMoAy4JQm4T+Br25whqiRL3
uePbcNxTKD601MVJqnxts7jG2a4zdIbNgUe53HE4ZjbMtPyT1SZhkUl66wUET+ab
zUcc5XuHDdY/zx7FKvLiVBqo0J2EzgABXNqU826ft9bdu6VUaY7xhWKP88nzFeEM
ndTUOIVLu1t2RH4mtwtqO6mPLVmLbcx4WsbF9KCoMocpMB0rHIQf87dygbChxy8g
P20NDgVLpQCrdKLSGKbON3s3GX5kDvt9w/W2q9r+w0N5Kx8sJTBXhlNa7mvyl9i8
DGCrcTe7Z/ipew6w4LFWfFF4zdFaEcyXiPbvV8+dcEj24ri6pvlDB2L5qLmn2y/i
JxKwioGzx13/EPGaCknkOQEKFvI60LbVF5ApI8h90Yike8IhP4K6CVrv/UxqEdTa
H992jYaEhYK3Qd0ov/NrnpK0ofmDBBr2zqOoJrg+4kR+j25g7t/ZvLq99P+RCKwB
INBb4ud6QSBxhYSfyPvli0HEKT1k325XeeCs164gzMkQVagWphGbZMVQWq2gIh1+
d16F+QzxXKe55m0Ib40Y
=GmA0
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
