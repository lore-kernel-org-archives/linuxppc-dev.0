Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D5DA2DE032
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 19:31:55 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 7F3EAA81B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 11:31:53 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 5FC66A7CE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 11:31:53 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Move opcodes common to CPM1 and CPM2 to
	include/asm-powerpc/cpm.h
Date: Thu, 10 Apr 2008 11:31:50 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6230677.tpHkfZq7Ul";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804101131.52791.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6230677.tpHkfZq7Ul
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 include/asm-powerpc/cpm.h  |   14 ++++++++++++++
 include/asm-powerpc/cpm1.h |   13 -------------
 include/asm-powerpc/cpm2.h |   11 +----------
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
index 77e39da..ede38ff 100644
=2D-- a/include/asm-powerpc/cpm.h
+++ b/include/asm-powerpc/cpm.h
@@ -4,6 +4,20 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
=20
+/* Opcodes common to CPM1 and CPM2
+*/
+#define CPM_CR_INIT_TRX		((ushort)0x0000)
+#define CPM_CR_INIT_RX		((ushort)0x0001)
+#define CPM_CR_INIT_TX		((ushort)0x0002)
+#define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_STOP_TX		((ushort)0x0004)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
+#define CPM_CR_RESTART_TX	((ushort)0x0006)
+#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
+#define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	((ushort)0x0008)
+#define CPM_CR_STOP_IDMA	((ushort)0x000b)
+
 /* Buffer descriptors used by many of the CPM protocols. */
 typedef struct cpm_buf_desc {
 	ushort	cbd_sc;		/* Status and Control */
diff --git a/include/asm-powerpc/cpm1.h b/include/asm-powerpc/cpm1.h
index b2ebd6a..3df4396 100644
=2D-- a/include/asm-powerpc/cpm1.h
+++ b/include/asm-powerpc/cpm1.h
@@ -28,19 +28,6 @@
 #define CPM_CR_CHAN	((ushort)0x00f0)
 #define CPM_CR_FLG	((ushort)0x0001)
=20
=2D/* Some commands (there are more...later)
=2D*/
=2D#define CPM_CR_INIT_TRX		((ushort)0x0000)
=2D#define CPM_CR_INIT_RX		((ushort)0x0001)
=2D#define CPM_CR_INIT_TX		((ushort)0x0002)
=2D#define CPM_CR_HUNT_MODE	((ushort)0x0003)
=2D#define CPM_CR_STOP_TX		((ushort)0x0004)
=2D#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
=2D#define CPM_CR_RESTART_TX	((ushort)0x0006)
=2D#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
=2D#define CPM_CR_SET_GADDR	((ushort)0x0008)
=2D#define CPM_CR_SET_TIMER	CPM_CR_SET_GADDR
=2D
 /* Channel numbers.
 */
 #define CPM_CR_CH_SCC1		((ushort)0x0000)
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index b93a53e..4c85ed9 100644
=2D-- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -71,18 +71,9 @@
=20
 #define CPM_CR_FCC_PAGE(x)	(x + 0x04)
=20
=2D/* Some opcodes (there are more...later)
+/* CPM2-specific opcodes (see cpm.h for common opcodes)
 */
=2D#define CPM_CR_INIT_TRX		((ushort)0x0000)
=2D#define CPM_CR_INIT_RX		((ushort)0x0001)
=2D#define CPM_CR_INIT_TX		((ushort)0x0002)
=2D#define CPM_CR_HUNT_MODE	((ushort)0x0003)
=2D#define CPM_CR_STOP_TX		((ushort)0x0004)
=2D#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
=2D#define CPM_CR_RESTART_TX	((ushort)0x0006)
=2D#define CPM_CR_SET_GADDR	((ushort)0x0008)
 #define CPM_CR_START_IDMA	((ushort)0x0009)
=2D#define CPM_CR_STOP_IDMA	((ushort)0x000b)
=20
 #define mk_cr_cmd(PG, SBC, MCN, OP) \
 	((PG << 26) | (SBC << 21) | (MCN << 6) | OP)
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6230677.tpHkfZq7Ul
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH/d6I8y9gWxC9vpcRAp81AJ0QINEVz/Cbu2USH7Ilk7eneYNMKQCgq9Pn
zqBoE1n811aAAtGxZUEDUxw=
=y8L8
-----END PGP SIGNATURE-----

--nextPart6230677.tpHkfZq7Ul--
