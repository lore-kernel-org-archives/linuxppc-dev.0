Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 924CDDE08B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 02:00:48 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
 kumar.gala@freescale.com
Subject: [PATCH] cpm2: Rework baud rate generators configuration to support
	external clocks.
Date: Tue, 22 Jul 2008 18:00:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807221800.44234.laurentp@cse-semaphore.com>
Cc: vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CPM2 BRG setup functions cpm_setbrg and cpm2_fastbrg don't support external
clocks. This patch adds a new exported __cpm2_setbrg function that takes the
clock rate and clock source as extra parameters, and moves cpm_setbrg and
cpm2_fastbrg to include/asm-powerpc/cpm2.h where they become inline wrappers
around __cpm2_setbrg.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 arch/powerpc/sysdev/cpm2.c |   34 +++----------------------------
 include/asm-powerpc/cpm2.h |   46 +++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 9311778..f1c3395 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -115,16 +115,10 @@ EXPORT_SYMBOL(cpm_command);
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers).  Documentation uses 1-based numbering.
  */
-#define BRG_INT_CLK	(get_brgfreq())
-#define BRG_UART_CLK	(BRG_INT_CLK/16)
-
-/* This function is used by UARTS, or anything else that uses a 16x
- * oversampled clock.
- */
-void
-cpm_setbrg(uint brg, uint rate)
+void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src)
 {
 	u32 __iomem *bp;
+	u32 val;
 
 	/* This is good enough to get SMCs running.....
 	*/
@@ -135,34 +129,14 @@ cpm_setbrg(uint brg, uint rate)
 		brg -= 4;
 	}
 	bp += brg;
-	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
-
-	cpm2_unmap(bp);
-}
-
-/* This function is used to set high speed synchronous baud rate
- * clocks.
- */
-void
-cpm2_fastbrg(uint brg, uint rate, int div16)
-{
-	u32 __iomem *bp;
-	u32 val;
-
-	if (brg < 4) {
-		bp = cpm2_map_size(im_brgc1, 16);
-	} else {
-		bp = cpm2_map_size(im_brgc5, 16);
-		brg -= 4;
-	}
-	bp += brg;
-	val = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
+	val = (((clk / rate) - 1) << 1) | CPM_BRG_EN | src;
 	if (div16)
 		val |= CPM_BRG_DIV16;
 
 	out_be32(bp, val);
 	cpm2_unmap(bp);
 }
+EXPORT_SYMBOL(__cpm2_setbrg);
 
 int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 {
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 4c85ed9..dab9949 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -12,6 +12,7 @@
 
 #include <asm/immap_cpm2.h>
 #include <asm/cpm.h>
+#include <sysdev/fsl_soc.h>
 
 #ifdef CONFIG_PPC_85xx
 #define CPM_MAP_ADDR (get_immrbase() + 0x80000)
@@ -119,10 +120,40 @@ extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(unsigned long offset);
 #endif
 
-extern void cpm_setbrg(uint brg, uint rate);
-extern void cpm2_fastbrg(uint brg, uint rate, int div16);
 extern void cpm2_reset(void);
 
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
+extern void __cpm2_setbrg(uint brg, uint rate, uint clk, int div16, int src);
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
 
-/* Baud rate generators.
-*/
-#define CPM_BRG_RST		((uint)0x00020000)
-#define CPM_BRG_EN		((uint)0x00010000)
-#define CPM_BRG_EXTC_INT	((uint)0x00000000)
-#define CPM_BRG_EXTC_CLK3_9	((uint)0x00004000)
-#define CPM_BRG_EXTC_CLK5_15	((uint)0x00008000)
-#define CPM_BRG_ATB		((uint)0x00002000)
-#define CPM_BRG_CD_MASK		((uint)0x00001ffe)
-#define CPM_BRG_DIV16		((uint)0x00000001)
-
 /* SCCs.
 */
 #define SCC_GSMRH_IRP		((uint)0x00040000)
-- 
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
