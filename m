Return-Path: <thomas.moll@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id 9C7BDB7D8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 May 2010 16:34:20 +1000 (EST)
Date: Tue, 18 May 2010 08:28:23 +0200
From: Thomas Moll <thomas.moll@sysgo.com>
To: akpm@linux-foundation.org
Subject: [PATCH 1/1] RapidIO: Fix maintenance access to higher memory areas
Message-Id: <20100518082823.37887262.thomas.moll@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, alexandre.bounine@idt.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the maintenance access functions to farend RapidIO devices.
1. Fixed shift of the given offset, to open the maintenance window
2. Mask offset to limit access to the opened maintenance window
3. Added extended destid part to rowtear register, required for 16bit mode

This method is matching maintenance transactions generation described
by Freescale in the appnote AN2932. With this modification full access
to a 16MB maintenance window is possible, this patch is required for
IDT cps switches. For easier handling of the access routines, the
access was limited to aligned memory regions. This should be no problem
because all registers are 32bit wide.

The patch was generated against 2.6.34 kernel + patches from
Alexandre Bounine

Signed-off-by: Thomas Moll <thomas.moll@sysgo.com>
Tested-by: Alexandre Bounine <alexandre.bounine@idt.com>
---
 fsl_rio.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)
diff -purN linux-base/arch/powerpc/sysdev/fsl_rio.c linux-new/arch/powerpc/sysdev/fsl_rio.c
--- linux-base/arch/powerpc/sysdev/fsl_rio.c	2010-05-17 08:56:43.000000000 +0200
+++ linux-new/arch/powerpc/sysdev/fsl_rio.c	2010-05-17 09:40:41.000000000 +0200
@@ -1,6 +1,10 @@
 /*
  * Freescale MPC85xx/MPC86xx RapidIO support
  *
+ * Copyright 2009 Sysgo AG
+ * Thomas Moll <thomas.moll@sysgo.com>
+ * - fixed maintenance access routines, check for aligned access
+ *
  * Copyright 2009 Integrated Device Technology, Inc.
  * Alex Bounine <alexandre.bounine@idt.com>
  * - Added Port-Write message handling
@@ -371,10 +375,17 @@ fsl_rio_config_read(struct rio_mport *mp
 	pr_debug
 	    ("fsl_rio_config_read: index %d destid %d hopcount %d offset %8.8x len %d\n",
 	     index, destid, hopcount, offset, len);
+
+	/* 16MB maintenance window possible */
+	/* allow only aligned access to maintenance registers */
+	if (offset > (0x1000000 - len) || !IS_ALIGNED(offset, len))
+		return -EINVAL;
+
 	out_be32(&priv->maint_atmu_regs->rowtar,
-		 (destid << 22) | (hopcount << 12) | ((offset & ~0x3) >> 9));
+		 (destid << 22) | (hopcount << 12) | (offset >> 12));
+	out_be32(&priv->maint_atmu_regs->rowtear,  (destid >> 10));
 
-	data = (u8 *) priv->maint_win + offset;
+	data = (u8 *) priv->maint_win + (offset & (RIO_MAINT_WIN_SIZE - 1));
 	switch (len) {
 	case 1:
 		__fsl_read_rio_config(rval, data, err, "lbz");
@@ -382,9 +393,11 @@ fsl_rio_config_read(struct rio_mport *mp
 	case 2:
 		__fsl_read_rio_config(rval, data, err, "lhz");
 		break;
-	default:
+	case 4:
 		__fsl_read_rio_config(rval, data, err, "lwz");
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	if (err) {
@@ -419,10 +432,17 @@ fsl_rio_config_write(struct rio_mport *m
 	pr_debug
 	    ("fsl_rio_config_write: index %d destid %d hopcount %d offset %8.8x len %d val %8.8x\n",
 	     index, destid, hopcount, offset, len, val);
+
+	/* 16MB maintenance windows possible */
+	/* allow only aligned access to maintenance registers */
+	if (offset > (0x1000000 - len) || !IS_ALIGNED(offset, len))
+		return -EINVAL;
+
 	out_be32(&priv->maint_atmu_regs->rowtar,
-		 (destid << 22) | (hopcount << 12) | ((offset & ~0x3) >> 9));
+		 (destid << 22) | (hopcount << 12) | (offset >> 12));
+	out_be32(&priv->maint_atmu_regs->rowtear,  (destid >> 10));
 
-	data = (u8 *) priv->maint_win + offset;
+	data = (u8 *) priv->maint_win + (offset & (RIO_MAINT_WIN_SIZE - 1));
 	switch (len) {
 	case 1:
 		out_8((u8 *) data, val);
@@ -430,9 +450,11 @@ fsl_rio_config_write(struct rio_mport *m
 	case 2:
 		out_be16((u16 *) data, val);
 		break;
-	default:
+	case 4:
 		out_be32((u32 *) data, val);
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1483,7 +1505,8 @@ int fsl_rio_setup(struct of_device *dev)
 
 	/* Configure maintenance transaction window */
 	out_be32(&priv->maint_atmu_regs->rowbar, law_start >> 12);
-	out_be32(&priv->maint_atmu_regs->rowar, 0x80077015);	/* 4M */
+	out_be32(&priv->maint_atmu_regs->rowar,
+		 0x80077000 | (ilog2(RIO_MAINT_WIN_SIZE) - 1));
 
 	priv->maint_win = ioremap(law_start, RIO_MAINT_WIN_SIZE);
 
