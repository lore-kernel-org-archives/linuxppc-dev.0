Return-Path: <olof@lixom.net>
Date: Fri, 4 Apr 2008 13:18:04 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Minor cleanups of iommu code
Message-ID: <20080404181804.GA27175@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean up the pwrficient iommu code a bit. It was using u32 *-based offsets
for registers, which can be confusing when comparing to the manual.

Generated binaries from the code is unchanged from before.


---

This will be pushed to for-2.6.26 of pasemi.git, so no signed-off here.


    
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 5803f11..86967bd 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2005-2007, PA Semi, Inc
+ * Copyright (C) 2005-2008, PA Semi, Inc
  *
  * Maintained by: Olof Johansson <olof@lixom.net>
  *
@@ -27,7 +27,6 @@
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
-
 #define IOBMAP_PAGE_SHIFT	12
 #define IOBMAP_PAGE_SIZE	(1 << IOBMAP_PAGE_SHIFT)
 #define IOBMAP_PAGE_MASK	(IOBMAP_PAGE_SIZE - 1)
@@ -35,13 +34,13 @@
 #define IOB_BASE		0xe0000000
 #define IOB_SIZE		0x3000
 /* Configuration registers */
-#define IOBCAP_REG		0x10
-#define IOBCOM_REG		0x40
+#define IOBCAP_REG		0x40
+#define IOBCOM_REG		0x100
 /* Enable IOB address translation */
 #define IOBCOM_ATEN		0x00000100
 
 /* Address decode configuration register */
-#define IOB_AD_REG		0x53
+#define IOB_AD_REG		0x14c
 /* IOBCOM_AD_REG fields */
 #define IOB_AD_VGPRT		0x00000e00
 #define IOB_AD_VGAEN		0x00000100
@@ -56,13 +55,13 @@
 #define IOB_AD_TRNG_2G		0x00000001
 #define IOB_AD_TRNG_128G	0x00000003
 
-#define IOB_TABLEBASE_REG	0x55
+#define IOB_TABLEBASE_REG	0x154
 
 /* Base of the 64 4-byte L1 registers */
-#define IOB_XLT_L1_REGBASE	0xac0
+#define IOB_XLT_L1_REGBASE	0x2b00
 
 /* Register to invalidate TLB entries */
-#define IOB_AT_INVAL_TLB_REG	0xb40
+#define IOB_AT_INVAL_TLB_REG	0x2d00
 
 /* The top two bits of the level 1 entry contains valid and type flags */
 #define IOBMAP_L1E_V		0x40000000
@@ -76,7 +75,7 @@
 #define IOBMAP_L2E_V		0x80000000
 #define IOBMAP_L2E_V_CACHED	0xc0000000
 
-static u32 __iomem *iob;
+static void __iomem *iob;
 static u32 iob_l1_emptyval;
 static u32 iob_l2_emptyval;
 static u32 *iob_l2_base;
@@ -219,7 +218,7 @@ int __init iob_init(struct device_node *dn)
 	for (i = 0; i < 64; i++) {
 		/* Each L1 covers 32MB, i.e. 8K entries = 32K of ram */
 		regword = IOBMAP_L1E_V | (__pa(iob_l2_base + i*0x2000) >> 12);
-		out_le32(iob+IOB_XLT_L1_REGBASE+i, regword);
+		out_le32(iob+IOB_XLT_L1_REGBASE+i*4, regword);
 	}
 
 	/* set 2GB translation window, based at 0 */
