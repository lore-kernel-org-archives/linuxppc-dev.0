Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 311B0DE02E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 02:11:49 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 8B75112F36
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 18:11:47 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 746D912F11
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 18:11:47 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] cpm2: Rework baud rate generators configuration to support
	external clocks.
Date: Wed, 18 Jun 2008 18:11:44 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1343493.T06Wib82Kf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806181811.46860.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1343493.T06Wib82Kf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I have to configure a CPM2 baud rate generator to use an external clock in =
a=20
device driver. To avoid code duplication I'd like to reorganize the CPM2 ba=
ud=20
rate configuration functions as proposed in the attached patch. Would this =
be=20
acceptable ?

=2D-

The CPM2 BRG setup functions cpm_setbrg and cpm2_fastbrg don't support=20
external clocks. This patch adds a new exported __cpm2_setbrg function that=
=20
takes the clock rate and clock source as extra parameters, and moves=20
cpm_setbrg and cpm2_fastbrg to include/asm-powerpc/cpm2.h where they become=
=20
inline wrappers around __cpm2_setbrg.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/sysdev/cpm2.c |   34 +++----------------------------
 include/asm-powerpc/cpm2.h |   46 +++++++++++++++++++++++++++++++---------=
=2D--
 2 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 9311778..f1c3395 100644
=2D-- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -115,16 +115,10 @@ EXPORT_SYMBOL(cpm_command);
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers).  Documentation uses 1-based numbering.
  */
=2D#define BRG_INT_CLK	(get_brgfreq())
=2D#define BRG_UART_CLK	(BRG_INT_CLK/16)
=2D
=2D/* This function is used by UARTS, or anything else that uses a 16x
=2D * oversampled clock.
=2D */
=2Dvoid
=2Dcpm_setbrg(uint brg, uint rate)
+void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src)
 {
 	u32 __iomem *bp;
+	u32 val;
=20
 	/* This is good enough to get SMCs running.....
 	*/
@@ -135,34 +129,14 @@ cpm_setbrg(uint brg, uint rate)
 		brg -=3D 4;
 	}
 	bp +=3D brg;
=2D	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
=2D
=2D	cpm2_unmap(bp);
=2D}
=2D
=2D/* This function is used to set high speed synchronous baud rate
=2D * clocks.
=2D */
=2Dvoid
=2Dcpm2_fastbrg(uint brg, uint rate, int div16)
=2D{
=2D	u32 __iomem *bp;
=2D	u32 val;
=2D
=2D	if (brg < 4) {
=2D		bp =3D cpm2_map_size(im_brgc1, 16);
=2D	} else {
=2D		bp =3D cpm2_map_size(im_brgc5, 16);
=2D		brg -=3D 4;
=2D	}
=2D	bp +=3D brg;
=2D	val =3D ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
+	val =3D (((clk / rate) - 1) << 1) | CPM_BRG_EN | src;
 	if (div16)
 		val |=3D CPM_BRG_DIV16;
=20
 	out_be32(bp, val);
 	cpm2_unmap(bp);
 }
+EXPORT_SYMBOL(__cpm2_setbrg);
=20
 int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 {
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 4c85ed9..dab9949 100644
=2D-- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -12,6 +12,7 @@
=20
 #include <asm/immap_cpm2.h>
 #include <asm/cpm.h>
+#include <sysdev/fsl_soc.h>
=20
 #ifdef CONFIG_PPC_85xx
 #define CPM_MAP_ADDR (get_immrbase() + 0x80000)
@@ -119,10 +120,40 @@ extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(unsigned long offset);
 #endif
=20
=2Dextern void cpm_setbrg(uint brg, uint rate);
=2Dextern void cpm2_fastbrg(uint brg, uint rate, int div16);
 extern void cpm2_reset(void);
=20
+/* Baud rate generators.
+*/
+#define CPM_BRG_RST		((uint)0x00020000)
+#define CPM_BRG_EN		((uint)0x00010000)
+#define CPM_BRG_EXTC_INT	((uint)0x00000000)
+#define CPM_BRG_EXTC_CLK3_9	((uint)0x00004000)
+#define CPM_BRG_EXTC_CLK5_15	((uint)0x00008000)
+#define CPM_BRG_ATB		((uint)0x00002000)
+#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
+#define CPM_BRG_DIV16		((uint)0x00000001)
+
+#define CPM2_BRG_INT_CLK	(get_brgfreq())
+#define CPM2_BRG_UART_CLK	(CPM2_BRG_INT_CLK/16)
+
+extern void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int sr=
c);
+
+/* This function is used by UARTS, or anything else that uses a 16x
+ * oversampled clock.
+ */
+static inline void cpm_setbrg(uint brg, uint rate)
+{
+	__cpm2_setbrg(brg, rate, CPM2_BRG_UART_CLK, 0, CPM_BRG_EXTC_INT);
+}
+
+/* This function is used to set high speed synchronous baud rate
+ * clocks.
+ */
+static inline void cpm2_fastbrg(uint brg, uint rate, int div16)
+{
+	__cpm2_setbrg(brg, rate, CPM2_BRG_INT_CLK, div16, CPM_BRG_EXTC_INT);
+}
+
 /* Function code bits, usually generic to devices.
 */
 #define CPMFCR_GBL	((u_char)0x20)	/* Set memory snooping */
@@ -221,17 +252,6 @@ typedef struct smc_uart {
 #define SMCM_TX		((unsigned char)0x02)
 #define SMCM_RX		((unsigned char)0x01)
=20
=2D/* Baud rate generators.
=2D*/
=2D#define CPM_BRG_RST		((uint)0x00020000)
=2D#define CPM_BRG_EN		((uint)0x00010000)
=2D#define CPM_BRG_EXTC_INT	((uint)0x00000000)
=2D#define CPM_BRG_EXTC_CLK3_9	((uint)0x00004000)
=2D#define CPM_BRG_EXTC_CLK5_15	((uint)0x00008000)
=2D#define CPM_BRG_ATB		((uint)0x00002000)
=2D#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
=2D#define CPM_BRG_DIV16		((uint)0x00000001)
=2D
 /* SCCs.
 */
 #define SCC_GSMRH_IRP		((uint)0x00040000)
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

--nextPart1343493.T06Wib82Kf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIWTPC8y9gWxC9vpcRAgHeAJ9IZmknnp+pfhBlpi0U5tHlgTiLnQCfbe23
Cd5b3hDuaSzNVZfBo1lYbZI=
=PeBF
-----END PGP SIGNATURE-----

--nextPart1343493.T06Wib82Kf--
