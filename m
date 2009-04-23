Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [93.92.193.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B51B2DDFAD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 06:54:33 +1000 (EST)
Date: Fri, 24 Apr 2009 00:55:06 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: ibm4xx_denali_fixup_memsize fix
Message-ID: <20090423205506.GA2962@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F0CBC6.4050805@harris.com>
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some U-Boot versions incorrectly set the number of chipselects to two
for Sequoia/Rainier boards while they only have one chipselect hardwired.
This patch adds a workaround for this, hardcoding the number of chipselects
to one for sequioa/rainer board models and reading the actual value from
the memory controller register DDR0_10 otherwise.
It also fixes another error in the way ibm4xx_denali_fixup_memsize
calculates memory size. When testing the DDR_REDUC bit, the polarity is
backwards.  A "1" implies 32-bit wide memory while a "0" implies 64-bit
wide memory.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Signed-off-by: Steven A. Falco <sfalco@harris.com>
---
 arch/powerpc/boot/4xx.c |   56 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index 5c87843..325b310 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -158,21 +158,33 @@ void ibm440spe_fixup_memsize(void)
 
 #define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
 
-void ibm4xx_denali_fixup_memsize(void)
+/*
+ * Some U-Boot versions set the number of chipselects to two
+ * for Sequoia/Rainier boards while they only have one chipselect
+ * hardwired. Hardcode the number of chipselects to one
+ * for sequioa/rainer board models or read the actual value
+ * from the memory controller register DDR0_10 otherwise.
+ */
+static inline u32 ibm4xx_denali_get_cs(void)
 {
-	u32 val, max_cs, max_col, max_row;
-	u32 cs, col, row, bank, dpath;
-	unsigned long memsize;
+	void *devp;
+	char model[64];
+	u32 val, cs;
 
-	val = SDRAM0_READ(DDR0_02);
-	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
-		fatal("DDR controller is not initialized\n");
+	devp = finddevice("/");
+	if (!devp)
+		goto read_cs;
 
-	/* get maximum cs col and row values */
-	max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
-	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
-	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
+	if (getprop(devp, "model", model, sizeof(model)) <= 0)
+		goto read_cs;
 
+	model[sizeof(model)-1] = 0;
+
+	if (!strcmp(model, "amcc,sequoia") ||
+	    !strcmp(model, "amcc,rainier"))
+		return 1;
+
+read_cs:
 	/* get CS value */
 	val = SDRAM0_READ(DDR0_10);
 
@@ -183,7 +195,25 @@ void ibm4xx_denali_fixup_memsize(void)
 			cs++;
 		val = val >> 1;
 	}
+	return cs;
+}
+
+void ibm4xx_denali_fixup_memsize(void)
+{
+	u32 val, max_cs, max_col, max_row;
+	u32 cs, col, row, bank, dpath;
+	unsigned long memsize;
+
+	val = SDRAM0_READ(DDR0_02);
+	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
+		fatal("DDR controller is not initialized\n");
 
+	/* get maximum cs col and row values */
+	max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
+	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
+	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
+
+	cs = ibm4xx_denali_get_cs();
 	if (!cs)
 		fatal("No memory installed\n");
 	if (cs > max_cs)
@@ -193,9 +223,9 @@ void ibm4xx_denali_fixup_memsize(void)
 	val = SDRAM0_READ(DDR0_14);
 
 	if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
-		dpath = 8; /* 64 bits */
-	else
 		dpath = 4; /* 32 bits */
+	else
+		dpath = 8; /* 64 bits */
 
 	/* get address pins (rows) */
  	val = SDRAM0_READ(DDR0_42);
