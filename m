Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:41 +1100
Subject: [PATCH 13/20] [POWERPC] Adds decoding of 440SPE memory size to boot
	wrapper library
Message-Id: <20071213073847.372B6DE02C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a function to the bootwrapper 4xx library to decode memory
size on 440SPE processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/4xx.c             |   85 +++++++++++++++++++++++++++++-------
 arch/powerpc/boot/4xx.h             |    3 -
 arch/powerpc/boot/bamboo.c          |    2 
 arch/powerpc/boot/cuboot-taishan.c  |    2 
 arch/powerpc/boot/dcr.h             |   10 +++-
 arch/powerpc/boot/ebony.c           |    2 
 arch/powerpc/boot/treeboot-walnut.c |    2 
 7 files changed, 85 insertions(+), 21 deletions(-)

--- linux-work.orig/arch/powerpc/boot/4xx.c	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.c	2007-12-03 14:25:34.000000000 +1100
@@ -22,16 +22,14 @@
 #include "dcr.h"
 
 /* Read the 4xx SDRAM controller to get size of system memory. */
-void ibm4xx_fixup_memsize(void)
+void ibm4xx_sdram_fixup_memsize(void)
 {
 	int i;
 	unsigned long memsize, bank_config;
 
 	memsize = 0;
 	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
-		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
-		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
-
+		bank_config = SDRAM0_READ(sdram_bxcr[i]);
 		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
 			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
 	}
@@ -39,6 +37,69 @@ void ibm4xx_fixup_memsize(void)
 	dt_fixup_memory(0, memsize);
 }
 
+/* Read the 440SPe MQ controller to get size of system memory. */
+#define DCRN_MQ0_B0BAS		0x40
+#define DCRN_MQ0_B1BAS		0x41
+#define DCRN_MQ0_B2BAS		0x42
+#define DCRN_MQ0_B3BAS		0x43
+
+static u64 ibm440spe_decode_bas(u32 bas)
+{
+	u64 base = ((u64)(bas & 0xFFE00000u)) << 2;
+
+	/* open coded because I'm paranoid about invalid values */
+	switch ((bas >> 4) & 0xFFF) {
+	case 0:
+		return 0;
+	case 0xffc:
+		return base + 0x000800000ull;
+	case 0xff8:
+		return base + 0x001000000ull;
+	case 0xff0:
+		return base + 0x002000000ull;
+	case 0xfe0:
+		return base + 0x004000000ull;
+	case 0xfc0:
+		return base + 0x008000000ull;
+	case 0xf80:
+		return base + 0x010000000ull;
+	case 0xf00:
+		return base + 0x020000000ull;
+	case 0xe00:
+		return base + 0x040000000ull;
+	case 0xc00:
+		return base + 0x080000000ull;
+	case 0x800:
+		return base + 0x100000000ull;
+	}
+	printf("Memory BAS value 0x%08x unsupported !\n", bas);
+	return 0;
+}
+
+void ibm440spe_fixup_memsize(void)
+{
+	u64 banktop, memsize = 0;
+
+	/* Ultimately, we should directly construct the memory node
+	 * so we are able to handle holes in the memory address space
+	 */
+	banktop = ibm440spe_decode_bas(mfdcr(DCRN_MQ0_B0BAS));
+	if (banktop > memsize)
+		memsize = banktop;
+	banktop = ibm440spe_decode_bas(mfdcr(DCRN_MQ0_B1BAS));
+	if (banktop > memsize)
+		memsize = banktop;
+	banktop = ibm440spe_decode_bas(mfdcr(DCRN_MQ0_B2BAS));
+	if (banktop > memsize)
+		memsize = banktop;
+	banktop = ibm440spe_decode_bas(mfdcr(DCRN_MQ0_B3BAS));
+	if (banktop > memsize)
+		memsize = banktop;
+
+	dt_fixup_memory(0, memsize);
+}
+
+
 /* 4xx DDR1/2 Denali memory controller support */
 /* DDR0 registers */
 #define DDR0_02			2
@@ -77,19 +138,13 @@ void ibm4xx_fixup_memsize(void)
 
 #define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
 
-static inline u32 mfdcr_sdram0(u32 reg)
-{
-        mtdcr(DCRN_SDRAM0_CFGADDR, reg);
-        return mfdcr(DCRN_SDRAM0_CFGDATA);
-}
-
 void ibm4xx_denali_fixup_memsize(void)
 {
 	u32 val, max_cs, max_col, max_row;
 	u32 cs, col, row, bank, dpath;
 	unsigned long memsize;
 
-	val = mfdcr_sdram0(DDR0_02);
+	val = SDRAM0_READ(DDR0_02);
 	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
 		fatal("DDR controller is not initialized\n");
 
@@ -99,7 +154,7 @@ void ibm4xx_denali_fixup_memsize(void)
 	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
 
 	/* get CS value */
-	val = mfdcr_sdram0(DDR0_10);
+	val = SDRAM0_READ(DDR0_10);
 
 	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
 	cs = 0;
@@ -115,7 +170,7 @@ void ibm4xx_denali_fixup_memsize(void)
 		fatal("DDR wrong CS configuration\n");
 
 	/* get data path bytes */
-	val = mfdcr_sdram0(DDR0_14);
+	val = SDRAM0_READ(DDR0_14);
 
 	if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
 		dpath = 8; /* 64 bits */
@@ -123,7 +178,7 @@ void ibm4xx_denali_fixup_memsize(void)
 		dpath = 4; /* 32 bits */
 
 	/* get adress pins (rows) */
-	val = mfdcr_sdram0(DDR0_42);
+	val = SDRAM0_READ(DDR0_42);
 
 	row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);
 	if (row > max_row)
@@ -131,7 +186,7 @@ void ibm4xx_denali_fixup_memsize(void)
 	row = max_row - row;
 
 	/* get collomn size and banks */
-	val = mfdcr_sdram0(DDR0_43);
+	val = SDRAM0_READ(DDR0_43);
 
 	col = DDR_GET_VAL(val, DDR_COL_SZ, DDR_COL_SZ_SHIFT);
 	if (col > max_col)
Index: linux-work/arch/powerpc/boot/4xx.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/4xx.h	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.h	2007-12-03 14:25:34.000000000 +1100
@@ -11,7 +11,8 @@
 #ifndef _POWERPC_BOOT_4XX_H_
 #define _POWERPC_BOOT_4XX_H_
 
-void ibm4xx_fixup_memsize(void);
+void ibm4xx_sdram_fixup_memsize(void);
+void ibm440spe_fixup_memsize(void);
 void ibm4xx_denali_fixup_memsize(void);
 void ibm44x_dbcr_reset(void);
 void ibm40x_dbcr_reset(void);
Index: linux-work/arch/powerpc/boot/bamboo.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/bamboo.c	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/bamboo.c	2007-12-03 14:25:34.000000000 +1100
@@ -31,7 +31,7 @@ static void bamboo_fixups(void)
 	unsigned long sysclk = 33333333;
 
 	ibm440ep_fixup_clocks(sysclk, 11059200);
-	ibm4xx_fixup_memsize();
+	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
 	dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
 }
Index: linux-work/arch/powerpc/boot/dcr.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/dcr.h	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/dcr.h	2007-12-03 14:25:34.000000000 +1100
@@ -14,12 +14,20 @@
 #define DCRN_SDRAM0_CFGADDR				0x010
 #define DCRN_SDRAM0_CFGDATA				0x011
 
+#define SDRAM0_READ(offset) ({\
+	mtdcr(DCRN_SDRAM0_CFGADDR, offset); \
+	mfdcr(DCRN_SDRAM0_CFGDATA); })
+#define SDRAM0_WRITE(offset, data) ({\
+	mtdcr(DCRN_SDRAM0_CFGADDR, offset); \
+	mtdcr(DCRN_SDRAM0_CFGDATA, data); })
+
 #define 	SDRAM0_B0CR				0x40
 #define 	SDRAM0_B1CR				0x44
 #define 	SDRAM0_B2CR				0x48
 #define 	SDRAM0_B3CR				0x4c
 
-static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR, SDRAM0_B2CR, SDRAM0_B3CR };
+static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR,
+					    SDRAM0_B2CR, SDRAM0_B3CR };
 
 #define			SDRAM_CONFIG_BANK_ENABLE        0x00000001
 #define			SDRAM_CONFIG_SIZE_MASK          0x000e0000
Index: linux-work/arch/powerpc/boot/ebony.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/ebony.c	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/ebony.c	2007-12-03 14:25:34.000000000 +1100
@@ -134,7 +134,7 @@ static void ebony_fixups(void)
 	unsigned long sysclk = 33000000;
 
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
-	ibm4xx_fixup_memsize();
+	ibm4xx_sdram_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ebony_flashsel_fixup();
Index: linux-work/arch/powerpc/boot/treeboot-walnut.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/treeboot-walnut.c	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/treeboot-walnut.c	2007-12-03 14:25:34.000000000 +1100
@@ -63,7 +63,7 @@ static void walnut_flashsel_fixup(void)
 #define WALNUT_OPENBIOS_MAC_OFF 0xfffffe0b
 static void walnut_fixups(void)
 {
-	ibm4xx_fixup_memsize();
+	ibm4xx_sdram_fixup_memsize();
 	ibm405gp_fixup_clocks(33330000, 0xa8c000);
 	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
 	ibm4xx_fixup_ebc_ranges("/plb/ebc");
Index: linux-work/arch/powerpc/boot/cuboot-taishan.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/cuboot-taishan.c	2007-12-03 14:25:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/cuboot-taishan.c	2007-12-03 14:25:54.000000000 +1100
@@ -38,7 +38,7 @@ static void taishan_fixups(void)
 	   so we just use that code for now at least */
 	ibm440ep_fixup_clocks(sysclk, 6 * 1843200);
 
-	ibm4xx_fixup_memsize();
+	ibm4xx_sdram_fixup_memsize();
 
 	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
 
