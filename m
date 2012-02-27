Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 571BDB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 17:37:55 +1100 (EST)
Date: Mon, 27 Feb 2012 17:37:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20120227173747.853e7fbe3ce3afab8939720b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__27_Feb_2012_17_37_47_+1100_mDbqlloX2hPDZ6Xe"
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__27_Feb_2012_17_37_47_+1100_mDbqlloX2hPDZ6Xe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

arch/powerpc/kernel/pci-common.c: In function 'pcibios_setup_phb_resources':
arch/powerpc/kernel/pci-common.c:1520:4: error: cast from pointer to intege=
r of different size [-Werror=3Dpointer-to-int-cast]

Caused by commit 6c5705fec63d ("powerpc/PCI: get rid of device resource
fixups") from the pci tree.  In this build, resource_size_t is 64 bits
while pointers are only 32.

I applied the following fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 27 Feb 2012 17:33:48 +1100
Subject: [PATCH] powerpc/PCI: fix up for mismatch between resource_size_t a=
nd
 pointer size

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-com=
mon.c
index 910b9de..808ecbb 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1517,7 +1517,7 @@ static void __devinit pcibios_setup_phb_resources(str=
uct pci_controller *hose, s
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
 	pci_add_resource_offset(resources, res,
-			(resource_size_t) hose->io_base_virt - _IO_BASE);
+			(resource_size_t)(unsigned long)hose->io_base_virt - _IO_BASE);
=20
 	/* Hookup PHB Memory resources */
 	for (i =3D 0; i < 3; ++i) {
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__27_Feb_2012_17_37_47_+1100_mDbqlloX2hPDZ6Xe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPSyS7AAoJEECxmPOUX5FEAGUQAJNogIeDFNyXgPhvo7O/gpfV
AYLdvSJw4TEdL76Gp630/UcXcWgTOrDgROvfVzSh/aj7RdaHK8v2EP10H/682FAy
uXJZdr0vqAjd5vndsZhuaFAh//5L8GhgCopMYePuG8xT21gQI1tb1oGVuG5kPXn+
FPIKrb0QCGlOJPwei3F05qWQ7du/lqOHhdYZDVem8KDI8yU80bhCzOFKXUGnCQT+
RvrGyHOCkwO+kkudFAir7op1XN0M++qMUyG2sPPqWpBSAEm15w85u6puqVoxG3c6
LiS5Iv5yPloTBKCsgVknR0tcCj/FAGuP6/hnSjw+8Fp1+YWl4j7GzBc0zz6rqLVR
DwiRtKl2wOrAluLJ+EihlC8yETrwZT89+TE6sAkPJgDGJ5MghRojzQbi59T6wUOS
0/hb/4iQvh1vXnj7c+K0IcomqqFYoGvQU8SouXQhYL1D7eW8+xLV8m4rEO4vkrqz
qJhYnN+gg1lxfn3SOu0IFMyjc2Oae+nRUKsYz0TaJ2gtFpZ9SWa5ks0hO/pS0fJ+
5I4C86ViXOf0lvBAcp2NCw0lPju0TXBUppWhS9mZQIH8Jg5gTITr9fbEqjis5Tii
DWKVJ7BCD0JGzAVy25wbm30SIf246mBakNnI3IB1iS24lzZh9I1MTsA1hKpdjOnq
ZR7FOw9p3PBWtq2lpAZ/
=+o2U
-----END PGP SIGNATURE-----

--Signature=_Mon__27_Feb_2012_17_37_47_+1100_mDbqlloX2hPDZ6Xe--
