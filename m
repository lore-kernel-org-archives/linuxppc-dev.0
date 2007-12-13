Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:43 +1100
Subject: [PATCH 15/20] [POWERPC] Adds 44x CPR0 accessors to boot wrapper
Message-Id: <20071213073848.A1730DDFD6@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds macros to the boot wrapper to access the CPR
registers from the boot wrappers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dcr.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- linux-merge.orig/arch/powerpc/boot/dcr.h	2007-12-13 18:33:32.000000000 +1100
+++ linux-merge/arch/powerpc/boot/dcr.h	2007-12-13 18:33:33.000000000 +1100
@@ -147,4 +147,31 @@ static const unsigned long sdram_bxcr[] 
 #define DCRN_405_CPC0_CR0 0xb1
 #define DCRN_405_CPC0_CR1 0xb2
 
+
+/* 440GX Clock control etc */
+
+
+#define DCRN_CPR0_CLKUPD				0x020
+#define DCRN_CPR0_PLLC					0x040
+#define DCRN_CPR0_PLLD					0x060
+#define DCRN_CPR0_PRIMAD				0x080
+#define DCRN_CPR0_PRIMBD				0x0a0
+#define DCRN_CPR0_OPBD					0x0c0
+#define DCRN_CPR0_PERD					0x0e0
+#define DCRN_CPR0_MALD					0x100
+
+/* CPRs read/write helper macros - based off include/asm-ppc/ibm44x.h */
+
+#define DCRN_CPR0_CFGADDR				0xc
+#define DCRN_CPR0_CFGDATA				0xd
+
+#define CPR0_READ(offset) ({\
+	mtdcr(DCRN_CPR0_CFGADDR, offset); \
+	mfdcr(DCRN_CPR0_CFGDATA); })
+#define CPR0_WRITE(offset, data) ({\
+	mtdcr(DCRN_CPR0_CFGADDR, offset); \
+	mtdcr(DCRN_CPR0_CFGDATA, data); })
+
+
+
 #endif	/* _PPC_BOOT_DCR_H_ */
