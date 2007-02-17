Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 721DADDDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 15:31:34 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: clean up ucc_slow.c and ucc_fast.c
Date: Fri, 16 Feb 2007 22:31:21 -0600
Message-Id: <11716866811378-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactored and cleaned up ucc_fast.c and ucc_slow.c so that the two files
look more alike and are easier to read.  Removed uccf_printk() and related
functions, because they were just front-ends to printk().  Fixed some
spacing and tabbing issues.  Minor optimizations of some code.  Changed
the type of some variables to their proper type (mostly buffer
descriptors).

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |  163 ++++++++++++--------------------
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  137 +++++++++++-----------------
 include/asm-powerpc/ucc_slow.h        |    8 +-
 3 files changed, 118 insertions(+), 190 deletions(-)
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index e657559..a457ac1 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -1,13 +1,12 @@
 /*
- * arch/powerpc/sysdev/qe_lib/ucc_fast.c
- *
- * QE UCC Fast API Set - UCC Fast specific routines implementations.
- *
  * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
  *
+ * Description:
+ * QE UCC Fast API Set - UCC Fast specific routines implementations.
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -27,79 +26,61 @@
 #include <asm/ucc.h>
 #include <asm/ucc_fast.h>
 
-#define uccf_printk(level, format, arg...) \
-	printk(level format "\n", ## arg)
-
-#define uccf_dbg(format, arg...) \
-	uccf_printk(KERN_DEBUG , format , ## arg)
-#define uccf_err(format, arg...) \
-	uccf_printk(KERN_ERR , format , ## arg)
-#define uccf_info(format, arg...) \
-	uccf_printk(KERN_INFO , format , ## arg)
-#define uccf_warn(format, arg...) \
-	uccf_printk(KERN_WARNING , format , ## arg)
-
-#ifdef UCCF_VERBOSE_DEBUG
-#define uccf_vdbg uccf_dbg
-#else
-#define uccf_vdbg(fmt, args...) do { } while (0)
-#endif				/* UCCF_VERBOSE_DEBUG */
-
 void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 {
-	uccf_info("UCC%d Fast registers:", uccf->uf_info->ucc_num);
-	uccf_info("Base address: 0x%08x", (u32) uccf->uf_regs);
+	printk(KERN_INFO "UCC%d Fast registers:", uccf->uf_info->ucc_num);
+	printk(KERN_INFO "Base address: 0x%08x", (u32) uccf->uf_regs);
 
-	uccf_info("gumr  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "gumr  : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->gumr, in_be32(&uccf->uf_regs->gumr));
-	uccf_info("upsmr : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "upsmr : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->upsmr, in_be32(&uccf->uf_regs->upsmr));
-	uccf_info("utodr : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utodr : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->utodr, in_be16(&uccf->uf_regs->utodr));
-	uccf_info("udsr  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "udsr  : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->udsr, in_be16(&uccf->uf_regs->udsr));
-	uccf_info("ucce  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "ucce  : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->ucce, in_be32(&uccf->uf_regs->ucce));
-	uccf_info("uccm  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "uccm  : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
-	uccf_info("uccs  : addr - 0x%08x, val - 0x%02x",
+	printk(KERN_INFO "uccs  : addr - 0x%08x, val - 0x%02x",
 		  (u32) & uccf->uf_regs->uccs, uccf->uf_regs->uccs);
-	uccf_info("urfb  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "urfb  : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
-	uccf_info("urfs  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfs  : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->urfs, in_be16(&uccf->uf_regs->urfs));
-	uccf_info("urfet : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfet : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->urfet, in_be16(&uccf->uf_regs->urfet));
-	uccf_info("urfset: addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "urfset: addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->urfset,
 		  in_be16(&uccf->uf_regs->urfset));
-	uccf_info("utfb  : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "utfb  : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->utfb, in_be32(&uccf->uf_regs->utfb));
-	uccf_info("utfs  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utfs  : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->utfs, in_be16(&uccf->uf_regs->utfs));
-	uccf_info("utfet : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utfet : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->utfet, in_be16(&uccf->uf_regs->utfet));
-	uccf_info("utftt : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utftt : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->utftt, in_be16(&uccf->uf_regs->utftt));
-	uccf_info("utpt  : addr - 0x%08x, val - 0x%04x",
+	printk(KERN_INFO "utpt  : addr - 0x%08x, val - 0x%04x",
 		  (u32) & uccf->uf_regs->utpt, in_be16(&uccf->uf_regs->utpt));
-	uccf_info("urtry : addr - 0x%08x, val - 0x%08x",
+	printk(KERN_INFO "urtry : addr - 0x%08x, val - 0x%08x",
 		  (u32) & uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
-	uccf_info("guemr : addr - 0x%08x, val - 0x%02x",
+	printk(KERN_INFO "guemr : addr - 0x%08x, val - 0x%02x",
 		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
 }
 
 u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
 {
 	switch (uccf_num) {
-	case 0:	return QE_CR_SUBBLOCK_UCCFAST1;
+	case 0: return QE_CR_SUBBLOCK_UCCFAST1;
 	case 1: return QE_CR_SUBBLOCK_UCCFAST2;
 	case 2: return QE_CR_SUBBLOCK_UCCFAST3;
 	case 3: return QE_CR_SUBBLOCK_UCCFAST4;
 	case 4: return QE_CR_SUBBLOCK_UCCFAST5;
 	case 5: return QE_CR_SUBBLOCK_UCCFAST6;
 	case 6: return QE_CR_SUBBLOCK_UCCFAST7;
-	case 7:	return QE_CR_SUBBLOCK_UCCFAST8;
+	case 7: return QE_CR_SUBBLOCK_UCCFAST8;
 	default: return QE_CR_SUBBLOCK_INVALID;
 	}
 }
@@ -153,84 +134,72 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 {
 	struct ucc_fast_private *uccf;
 	struct ucc_fast *uf_regs;
-	u32 gumr = 0;
+	u32 gumr;
 	int ret;
 
-	uccf_vdbg("%s: IN", __FUNCTION__);
-
 	if (!uf_info)
 		return -EINVAL;
 
 	/* check if the UCC port number is in range. */
 	if ((uf_info->ucc_num < 0) || (uf_info->ucc_num > UCC_MAX_NUM - 1)) {
-		uccf_err("ucc_fast_init: Illegal UCC number!");
+		printk(KERN_ERR "%s: illegal UCC number", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	/* Check that 'max_rx_buf_length' is properly aligned (4). */
 	if (uf_info->max_rx_buf_length & (UCC_FAST_MRBLR_ALIGNMENT - 1)) {
-		uccf_err("ucc_fast_init: max_rx_buf_length not aligned.");
+		printk(KERN_ERR "%s: max_rx_buf_length not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	/* Validate Virtual Fifo register values */
 	if (uf_info->urfs < UCC_FAST_URFS_MIN_VAL) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register urfs too small.");
+		printk(KERN_ERR "%s: urfs is too small", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->urfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register urfs not aligned.");
+		printk(KERN_ERR "%s: urfs is not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->urfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register urfet not aligned.");
+		printk(KERN_ERR "%s: urfet is not aligned.", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->urfset & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		   ("ucc_fast_init: Virtual Fifo register urfset not aligned.");
+		printk(KERN_ERR "%s: urfset is not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->utfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register utfs not aligned.");
+		printk(KERN_ERR "%s: utfs is not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->utfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register utfet not aligned.");
+		printk(KERN_ERR "%s: utfet is not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (uf_info->utftt & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
-		uccf_err
-		    ("ucc_fast_init: Virtual Fifo register utftt not aligned.");
+		printk(KERN_ERR "%s: utftt is not aligned", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	uccf = kzalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
 	if (!uccf) {
-		uccf_err
-		    ("ucc_fast_init: No memory for UCC slow data structure!");
+		printk(KERN_ERR "%s: Cannot allocate private data", __FUNCTION__);
 		return -ENOMEM;
 	}
 
 	/* Fill fast UCC structure */
 	uccf->uf_info = uf_info;
 	/* Set the PHY base address */
-	uccf->uf_regs =
-	    (struct ucc_fast *) ioremap(uf_info->regs, sizeof(struct ucc_fast));
+	uccf->uf_regs = ioremap(uf_info->regs, sizeof(struct ucc_fast));
 	if (uccf->uf_regs == NULL) {
-		uccf_err
-		    ("ucc_fast_init: No memory map for UCC slow controller!");
+		printk(KERN_ERR "%s: Cannot map UCC registers", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -249,7 +218,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* Init Guemr register */
 	if ((ret = ucc_init_guemr((struct ucc_common *) (uf_regs)))) {
-		uccf_err("ucc_fast_init: Could not init the guemr register.");
+		printk(KERN_ERR "%s: cannot init GUEMR", __FUNCTION__);
 		ucc_fast_free(uccf);
 		return ret;
 	}
@@ -258,7 +227,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	if ((ret = ucc_set_type(uf_info->ucc_num,
 				(struct ucc_common *) (uf_regs),
 				UCC_SPEED_TYPE_FAST))) {
-		uccf_err("ucc_fast_init: Could not set type to fast.");
+		printk(KERN_ERR "%s: cannot set UCC type", __FUNCTION__);
 		ucc_fast_free(uccf);
 		return ret;
 	}
@@ -267,10 +236,9 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* Set GUMR */
 	/* For more details see the hardware spec. */
-	/* gumr starts as zero. */
+	gumr = uf_info->ttx_trx;
 	if (uf_info->tci)
 		gumr |= UCC_FAST_GUMR_TCI;
-	gumr |= uf_info->ttx_trx;
 	if (uf_info->cdp)
 		gumr |= UCC_FAST_GUMR_CDP;
 	if (uf_info->ctsp)
@@ -298,9 +266,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	uccf->ucc_fast_tx_virtual_fifo_base_offset =
 	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
 	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
-		uccf_err
-		    ("ucc_fast_init: Can not allocate MURAM memory for "
-			"struct ucc_fastx_virtual_fifo_base_offset.");
+		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO", __FUNCTION__);
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
@@ -308,14 +274,11 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* Allocate memory for Rx Virtual Fifo */
 	uccf->ucc_fast_rx_virtual_fifo_base_offset =
-	    qe_muram_alloc(uf_info->urfs +
-			   (u32)
+		qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
 	if (IS_MURAM_ERR(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
-		uccf_err
-		    ("ucc_fast_init: Can not allocate MURAM memory for "
-			"ucc_fast_rx_virtual_fifo_base_offset.");
+		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO", __FUNCTION__);
 		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
@@ -342,26 +305,22 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	/* If NMSI (not Tsa), set Tx and Rx clock. */
 	if (!uf_info->tsa) {
 		/* Rx clock routing */
-		if (uf_info->rx_clock != QE_CLK_NONE) {
-			if (ucc_set_qe_mux_rxtx
-			    (uf_info->ucc_num, uf_info->rx_clock,
-			     COMM_DIR_RX)) {
-				uccf_err
-		("ucc_fast_init: Illegal value for parameter 'RxClock'.");
-				ucc_fast_free(uccf);
-				return -EINVAL;
-			}
+		if ((uf_info->rx_clock != QE_CLK_NONE) &&
+		    ucc_set_qe_mux_rxtx(uf_info->ucc_num, uf_info->rx_clock,
+					COMM_DIR_RX)) {
+			printk(KERN_ERR "%s: illegal value for RX clock",
+			       __FUNCTION__);
+			ucc_fast_free(uccf);
+			return -EINVAL;
 		}
 		/* Tx clock routing */
-		if (uf_info->tx_clock != QE_CLK_NONE) {
-			if (ucc_set_qe_mux_rxtx
-			    (uf_info->ucc_num, uf_info->tx_clock,
-			     COMM_DIR_TX)) {
-				uccf_err
-		("ucc_fast_init: Illegal value for parameter 'TxClock'.");
-				ucc_fast_free(uccf);
-				return -EINVAL;
-			}
+		if ((uf_info->tx_clock != QE_CLK_NONE) &&
+		    ucc_set_qe_mux_rxtx(uf_info->ucc_num, uf_info->tx_clock,
+					COMM_DIR_TX)) {
+			printk(KERN_ERR "%s: illegal value for TX clock",
+			       __FUNCTION__);
+			ucc_fast_free(uccf);
+			return -EINVAL;
 		}
 	}
 
@@ -370,9 +329,9 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* First, clear anything pending at UCC level,
 	 * otherwise, old garbage may come through
-	 * as soon as the dam is opened
-	 * Writing '1' clears
-	 */
+	 * as soon as the dam is opened. */
+
+	/* Writing '1' clears */
 	out_be32(&uf_regs->ucce, 0xffffffff);
 
 	*uccf_ret = uccf;
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 0e97e5c..817df73 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -19,7 +19,6 @@
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
 
-#include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/immap_qe.h>
 #include <asm/qe.h>
@@ -27,24 +26,6 @@
 #include <asm/ucc.h>
 #include <asm/ucc_slow.h>
 
-#define uccs_printk(level, format, arg...) \
-        printk(level format "\n", ## arg)
-
-#define uccs_dbg(format, arg...) \
-	uccs_printk(KERN_DEBUG , format , ## arg)
-#define uccs_err(format, arg...) \
-	uccs_printk(KERN_ERR , format , ## arg)
-#define uccs_info(format, arg...) \
-	uccs_printk(KERN_INFO , format , ## arg)
-#define uccs_warn(format, arg...) \
-	uccs_printk(KERN_WARNING , format , ## arg)
-
-#ifdef UCCS_VERBOSE_DEBUG
-#define uccs_vdbg uccs_dbg
-#else
-#define uccs_vdbg(fmt, args...) do { } while (0)
-#endif				/* UCCS_VERBOSE_DEBUG */
-
 u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
 {
 	switch (uccs_num) {
@@ -135,51 +116,53 @@ void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode)
 
 int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** uccs_ret)
 {
+	struct ucc_slow_private *uccs;
 	u32 i;
 	struct ucc_slow *us_regs;
 	u32 gumr;
-	u8 function_code = 0;
-	u8 *bd;
-	struct ucc_slow_private *uccs;
+	struct qe_bd *bd;
 	u32 id;
 	u32 command;
-	int ret;
-
-	uccs_vdbg("%s: IN", __FUNCTION__);
+	int ret = 0;
 
 	if (!us_info)
 		return -EINVAL;
 
 	/* check if the UCC port number is in range. */
 	if ((us_info->ucc_num < 0) || (us_info->ucc_num > UCC_MAX_NUM - 1)) {
-		uccs_err("ucc_slow_init: Illegal UCC number!");
+		printk(KERN_ERR "%s: illegal UCC number", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	/*
 	 * Set mrblr
 	 * Check that 'max_rx_buf_length' is properly aligned (4), unless
- 	 * rfw is 1, meaning that QE accepts one byte at a time, unlike normal
+	 * rfw is 1, meaning that QE accepts one byte at a time, unlike normal
 	 * case when QE accepts 32 bits at a time.
 	 */
 	if ((!us_info->rfw) &&
 		(us_info->max_rx_buf_length & (UCC_SLOW_MRBLR_ALIGNMENT - 1))) {
-		uccs_err("max_rx_buf_length not aligned.");
+		printk(KERN_ERR "max_rx_buf_length not aligned.");
 		return -EINVAL;
 	}
 
 	uccs = kzalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
 	if (!uccs) {
-		uccs_err
-		    ("ucc_slow_init: No memory for UCC slow data structure!");
+		printk(KERN_ERR "%s: Cannot allocate private data", __FUNCTION__);
 		return -ENOMEM;
 	}
 
 	/* Fill slow UCC structure */
 	uccs->us_info = us_info;
+	/* Set the PHY base address */
+	uccs->us_regs = ioremap(us_info->regs, sizeof(struct ucc_slow));
+	if (uccs->us_regs == NULL) {
+		printk(KERN_ERR "%s: Cannot map UCC registers", __FUNCTION__);
+		return -ENOMEM;
+	}
+
 	uccs->saved_uccm = 0;
 	uccs->p_rx_frame = 0;
-	uccs->us_regs = us_info->regs;
 	us_regs = uccs->us_regs;
 	uccs->p_ucce = (u16 *) & (us_regs->ucce);
 	uccs->p_uccm = (u16 *) & (us_regs->uccm);
@@ -190,24 +173,22 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 #endif				/* STATISTICS */
 
 	/* Get PRAM base */
-	uccs->us_pram_offset = qe_muram_alloc(UCC_SLOW_PRAM_SIZE,
-						 ALIGNMENT_OF_UCC_SLOW_PRAM);
+	uccs->us_pram_offset =
+		qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
 	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
-		uccs_err
-		    ("ucc_slow_init: Can not allocate MURAM memory "
-			"for Slow UCC.");
+		printk(KERN_ERR "%s: cannot allocate MURAM for PRAM", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
 	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
 	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, id, QE_CR_PROTOCOL_UNSPECIFIED,
-			(u32) uccs->us_pram_offset);
+		     uccs->us_pram_offset);
 
 	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
 
 	/* Init Guemr register */
 	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->regs)))) {
-		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		printk(KERN_ERR "%s: cannot init GUEMR", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return ret;
 	}
@@ -216,7 +197,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	if ((ret = ucc_set_type(us_info->ucc_num,
 				(struct ucc_common *) (us_info->regs),
 				UCC_SPEED_TYPE_SLOW))) {
-		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		printk(KERN_ERR "%s: cannot set UCC type", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return ret;
 	}
@@ -230,7 +211,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 		qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
 				QE_ALIGNMENT_OF_BD);
 	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
-		uccs_err("ucc_slow_init: No memory for Rx BD's.");
+		printk(KERN_ERR "%s: cannot allocate RX BDs", __FUNCTION__);
 		uccs->rx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
@@ -240,7 +221,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 		qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
 			QE_ALIGNMENT_OF_BD);
 	if (IS_MURAM_ERR(uccs->tx_base_offset)) {
-		uccs_err("ucc_slow_init: No memory for Tx BD's.");
+		printk(KERN_ERR "%s: cannot allocate TX BDs", __FUNCTION__);
 		uccs->tx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
@@ -248,34 +229,33 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 
 	/* Init Tx bds */
 	bd = uccs->confBd = uccs->tx_bd = qe_muram_addr(uccs->tx_base_offset);
-	for (i = 0; i < us_info->tx_bd_ring_len; i++) {
+	for (i = 0; i < us_info->tx_bd_ring_len - 1; i++) {
 		/* clear bd buffer */
-		out_be32(&(((struct qe_bd *)bd)->buf), 0);
+		out_be32(&bd->buf, 0);
 		/* set bd status and length */
-		out_be32((u32*)bd, 0);
-		bd += sizeof(struct qe_bd);
+		out_be32((u32 *) bd, 0);
+		bd++;
 	}
-	bd -= sizeof(struct qe_bd);
-	/* set bd status and length */
-	out_be32((u32*)bd, T_W);	/* for last BD set Wrap bit */
+	/* for last BD set Wrap bit */
+	out_be32(&bd->buf, 0);
+	out_be32((u32 *) bd, cpu_to_be32(T_W));
 
 	/* Init Rx bds */
 	bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
-	for (i = 0; i < us_info->rx_bd_ring_len; i++) {
+	for (i = 0; i < us_info->rx_bd_ring_len - 1; i++) {
 		/* set bd status and length */
 		out_be32((u32*)bd, 0);
 		/* clear bd buffer */
-		out_be32(&(((struct qe_bd *)bd)->buf), 0);
-		bd += sizeof(struct qe_bd);
+		out_be32(&bd->buf, 0);
+		bd++;
 	}
-	bd -= sizeof(struct qe_bd);
-	/* set bd status and length */
-	out_be32((u32*)bd, R_W);	/* for last BD set Wrap bit */
+	/* for last BD set Wrap bit */
+	out_be32((u32*)bd, cpu_to_be32(R_W));
+	out_be32(&bd->buf, 0);
 
 	/* Set GUMR (For more details see the hardware spec.). */
 	/* gumr_h */
-	gumr = 0;
-	gumr |= us_info->tcrc;
+	gumr = us_info->tcrc;
 	if (us_info->cdp)
 		gumr |= UCC_SLOW_GUMR_H_CDP;
 	if (us_info->ctsp)
@@ -295,7 +275,8 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	out_be32(&us_regs->gumr_h, gumr);
 
 	/* gumr_l */
-	gumr = 0;
+	gumr = us_info->tdcr | us_info->rdcr | us_info->tenc | us_info->renc |
+		us_info->diag | us_info->mode;
 	if (us_info->tci)
 		gumr |= UCC_SLOW_GUMR_L_TCI;
 	if (us_info->rinv)
@@ -304,23 +285,14 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 		gumr |= UCC_SLOW_GUMR_L_TINV;
 	if (us_info->tend)
 		gumr |= UCC_SLOW_GUMR_L_TEND;
-	gumr |= us_info->tdcr;
-	gumr |= us_info->rdcr;
-	gumr |= us_info->tenc;
-	gumr |= us_info->renc;
-	gumr |= us_info->diag;
-	gumr |= us_info->mode;
 	out_be32(&us_regs->gumr_l, gumr);
 
 	/* Function code registers */
-	/* function_code has initial value 0 */
 
 	/* if the data is in cachable memory, the 'global' */
 	/* in the function code should be set. */
-	function_code |= us_info->data_mem_part;
-	function_code |= QE_BMR_BYTE_ORDER_BO_MOT;	/* Required for QE */
-	uccs->us_pram->tfcr = function_code;
-	uccs->us_pram->rfcr = function_code;
+	uccs->us_pram->tfcr = uccs->us_pram->rfcr =
+		us_info->data_mem_part | QE_BMR_BYTE_ORDER_BO_MOT;
 
 	/* rbase, tbase are offsets from MURAM base */
 	out_be16(&uccs->us_pram->rbase, uccs->us_pram_offset);
@@ -336,34 +308,29 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	/* If NMSI (not Tsa), set Tx and Rx clock. */
 	if (!us_info->tsa) {
 		/* Rx clock routing */
-		if (ucc_set_qe_mux_rxtx
-		    (us_info->ucc_num, us_info->rx_clock, COMM_DIR_RX)) {
-			uccs_err
-			    ("ucc_slow_init: Illegal value for parameter"
-				" 'RxClock'.");
+		if (ucc_set_qe_mux_rxtx(us_info->ucc_num, us_info->rx_clock,
+					COMM_DIR_RX)) {
+			printk(KERN_ERR "%s: illegal value for RX clock",
+			       __FUNCTION__);
 			ucc_slow_free(uccs);
 			return -EINVAL;
 		}
 		/* Tx clock routing */
-		if (ucc_set_qe_mux_rxtx(us_info->ucc_num,
-				 us_info->tx_clock, COMM_DIR_TX)) {
-			uccs_err
-			    ("ucc_slow_init: Illegal value for parameter "
-				"'TxClock'.");
+		if (ucc_set_qe_mux_rxtx(us_info->ucc_num, us_info->tx_clock,
+					COMM_DIR_TX)) {
+			printk(KERN_ERR "%s: illegal value for TX clock",
+			       __FUNCTION__);
 			ucc_slow_free(uccs);
 			return -EINVAL;
 		}
 	}
 
-	/*
-	 * INTERRUPTS
-	 */
 	/* Set interrupt mask register at UCC level. */
 	out_be16(&us_regs->uccm, us_info->uccm_mask);
 
-	/* First, clear anything pending at UCC level, */
-	/* otherwise, old garbage may come through */
-	/* as soon as the dam is opened. */
+	/* First, clear anything pending at UCC level,
+	 * otherwise, old garbage may come through
+	 * as soon as the dam is opened. */
 
 	/* Writing '1' clears */
 	out_be16(&us_regs->ucce, 0xffff);
@@ -400,3 +367,5 @@ void ucc_slow_free(struct ucc_slow_private * uccs)
 
 	kfree(uccs);
 }
+
+
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
index 1babad9..fdaac9d 100644
--- a/include/asm-powerpc/ucc_slow.h
+++ b/include/asm-powerpc/ucc_slow.h
@@ -150,7 +150,7 @@ struct ucc_slow_info {
 	int ucc_num;
 	enum qe_clock rx_clock;
 	enum qe_clock tx_clock;
-	struct ucc_slow *regs;
+	u32 regs;
 	int irq;
 	u16 uccm_mask;
 	int data_mem_part;
@@ -199,9 +199,9 @@ struct ucc_slow_private {
 				   and length for first BD in a frame */
 	u32 tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
 	u32 rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
-	u8 *confBd;		/* next BD for confirm after Tx */
-	u8 *tx_bd;		/* next BD for new Tx request */
-	u8 *rx_bd;		/* next BD to collect after Rx */
+	struct qe_bd *confBd;	/* next BD for confirm after Tx */
+	struct qe_bd *tx_bd;	/* next BD for new Tx request */
+	struct qe_bd *rx_bd;	/* next BD to collect after Rx */
 	void *p_rx_frame;	/* accumulating receive frame */
 	u16 *p_ucce;		/* a pointer to the event register in memory.
 				 */
-- 
1.5.0
