Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D6F33DDFBB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 00:26:58 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id A881A379E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 14:27:51 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 8CDE4378D
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 14:27:51 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fs_enet: Remove unused fields in the fs_mii_bb_platform_info
	structure.
Date: Fri, 15 Feb 2008 14:27:41 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2401636.IUBJYVMUfl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802151427.44321.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2401636.IUBJYVMUfl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the=20
fs_mii_bb_platform_info structure are left-overs from the move to the Phy
Abstraction Layer subsystem. They can be safely removed.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/sysdev/fsl_soc.c |    4 ----
 include/linux/fs_enet_pd.h    |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..cefc8b4 100644
=2D-- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -804,10 +804,6 @@ static int __init fs_enet_of_init(void)
 					mdio_bb_prop[1];
 				fs_enet_mdio_bb_data.mdc_dat.bit =3D
 					mdio_bb_prop[2];
=2D				fs_enet_mdio_bb_data.mdio_port =3D
=2D					mdio_bb_prop[3];
=2D				fs_enet_mdio_bb_data.mdc_port =3D
=2D					mdio_bb_prop[4];
 				fs_enet_mdio_bb_data.delay =3D
 					mdio_bb_prop[5];
=20
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 9bc045b..decc4b5 100644
=2D-- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -103,10 +103,6 @@ struct fs_mii_bb_platform_info {
 	struct fs_mii_bit 	mdio_dir;
 	struct fs_mii_bit 	mdio_dat;
 	struct fs_mii_bit	mdc_dat;
=2D	int mdio_port;	/* port & bit for MDIO */
=2D	int mdio_bit;
=2D	int mdc_port;	/* port & bit for MDC  */
=2D	int mdc_bit;
 	int delay;	/* delay in us         */
 	int irq[32]; 	/* irqs per phy's */
 };
=2D-=20
1.5.0

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2401636.IUBJYVMUfl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHtZNQ8y9gWxC9vpcRAmJCAJwLjWI7T3lKihQ1gGa2+j8x/t3c+wCfbVPD
tiE5/xE51j/KedO7dtvfqF0=
=1Ft7
-----END PGP SIGNATURE-----

--nextPart2401636.IUBJYVMUfl--
