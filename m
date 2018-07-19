Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WrQl4s1jzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 09:51:59 +1000 (AEST)
Date: Fri, 20 Jul 2018 09:51:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras
 <paulus@ozlabs.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20180720095138.275cc9aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M/wB7O1tQxgKIF7Eg3TSknz"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  drivers/vfio/vfio_iommu_spapr_tce.c

between commit:

  1463edca6734 ("vfio/spapr: Use IOMMU pageshift rather than pagesize")

from the powerpc-fixes tree and commit:

  00a5c58d9499 ("KVM: PPC: Make iommu_table::it_userspace big endian")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vfio/vfio_iommu_spapr_tce.c
index 7cd63b0c1a46,11a4c194d6e3..000000000000
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@@ -487,11 -449,11 +449,11 @@@ static void tce_iommu_unuse_page_v2(str
  	if (!pua)
  		return;
 =20
- 	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
- 			&hpa, &mem);
+ 	ret =3D tce_iommu_prereg_ua_to_hpa(container, be64_to_cpu(*pua),
 -			IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
++			tbl->it_page_shift, &hpa, &mem);
  	if (ret)
- 		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
- 				__func__, *pua, entry, ret);
+ 		pr_debug("%s: tce %llx at #%lx was not cached, ret=3D%d\n",
+ 				__func__, be64_to_cpu(*pua), entry, ret);
  	if (mem)
  		mm_iommu_mapped_dec(mem);
 =20
@@@ -599,19 -561,12 +561,12 @@@ static long tce_iommu_build_v2(struct t
  	unsigned long hpa;
  	enum dma_data_direction dirtmp;
 =20
- 	if (!tbl->it_userspace) {
- 		ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
- 		if (ret)
- 			return ret;
- 	}
-=20
  	for (i =3D 0; i < pages; ++i) {
  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
- 		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
- 				entry + i);
+ 		__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
 =20
  		ret =3D tce_iommu_prereg_ua_to_hpa(container,
 -				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
 +				tce, tbl->it_page_shift, &hpa, &mem);
  		if (ret)
  			break;
 =20

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRJAoACgkQAVBC80lX
0GyGIwf/UsUGTDeLCB1dBOXDnIOy937KSGh90Zwx+oOyTE8mjziQB/MtJjZeEhVi
GtTzPDqTwZeOKU963SX9EmrkpmyHby/aSWB2iBeVnsCqvsUxSEAXMIUlbttfyCxT
4wDxGKIgAHoSTn7aDJoOjfLd88FiNmCKwX51UFSNqqkbMbQY9s8U7AQ6yuba23gr
y7rZtAddwYo401xYF5TtUxv9OBgkm1vKyA5vtRPvvHuR023ax9+JkI7NX8Djo4BK
/6JyLVIQRqkjal7HoJ9lgUkk2KLB77ENvCdR82DOJZETPG56zSxH6zwPaG5eWRK1
o270Y/I3BCyXzZjC/f8RQg7KGprJcw==
=n+fN
-----END PGP SIGNATURE-----

--Sig_/M/wB7O1tQxgKIF7Eg3TSknz--
