Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id CDB0A67D5C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:34:54 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, nd@bplan-gmbh.de
Subject: [PATCH 5/5] mpc52xx_init_irq() needs to panic() on failure
Date: Mon,  6 Nov 2006 17:34:25 -0700
Message-Id: <11628596762518-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11628596761676-git-send-email-grant.likely@secretlab.ca>
References: <11628596653052-git-send-email-grant.likely@secretlab.ca>
	<11628596751096-git-send-email-grant.likely@secretlab.ca>
	<11628596753992-git-send-email-grant.likely@secretlab.ca>
	<11628596761680-git-send-email-grant.likely@secretlab.ca>
	<11628596761676-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch also includes string changes to keep source lines under 80 chars

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/sysdev/mpc52xx_pic.c |   81 ++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc52xx_pic.c b/arch/powerpc/sysdev/mpc52xx_pic.c
index aa4b420..42ae990 100644
--- a/arch/powerpc/sysdev/mpc52xx_pic.c
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c
@@ -6,7 +6,7 @@
  *
  * Based on (well, mostly copied from) the code from the 2.4 kernel by
  * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
- * 
+ *
  * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 Montavista Software, Inc
  *
@@ -391,54 +391,47 @@ void __init mpc52xx_init_irq(void)
 
 	u32 intr_ctrl;
 
-	picnode = of_find_compatible_node(NULL, "interrupt-controller", "mpc5200-pic");
-	if (picnode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: Unable to find the interrupt controller in the OpenFirmware device tree\n");
-		goto end;
-	}
+	picnode = of_find_compatible_node(NULL, "interrupt-controller",
+	                                  "mpc5200-pic");
+	if (!picnode)
+		panic(__FILE__ ": no interrupt controller in device tree\n");
 
-	sdmanode = of_find_compatible_node(NULL, "dma-controller", "mpc5200-bestcomm");
-	if (sdmanode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: Unable to find the Bestcomm DMA controller device in the OpenFirmware device tree\n");
-		goto end;
-	}
+	sdmanode = of_find_compatible_node(NULL, "dma-controller",
+	                                   "mpc5200-bestcomm");
+	if (!sdmanode)
+		panic(__FILE__ ": no bestcomm DMA controller in device tree\n");
 
 	/* Retrieve PIC ressources */
 	picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
-	if (picnode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC: Unable to get the interrupt controller address\n");
-		goto end;
-	}
+	if (!picnode_regoffset)
+		panic(__FILE__ ": cannot get interrupt controller address\n");
 
-	picnode_regoffset = of_translate_address(picnode, (u32 *) picnode_regoffset);
-	picnode_regsize = (int) size64;	
+	picnode_regoffset = of_translate_address(picnode,
+	                                         (u32*) picnode_regoffset);
+	picnode_regsize = (int) size64;
 
 	/* Retrieve SDMA ressources */
 	sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
-	if (sdmanode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC: Unable to get the Bestcomm DMA controller address\n");
-		goto end;
-	}
+	if (!sdmanode_regoffset)
+		panic(__FILE__ ": Cannot get Bestcomm controller address\n");
 
-	sdmanode_regoffset = of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
+	sdmanode_regoffset = of_translate_address(sdmanode,
+	                                          (u32*)sdmanode_regoffset);
 	sdmanode_regsize = (int) size64;
 
 	/* Remap the necessary zones */
 	intr = ioremap(picnode_regoffset, picnode_regsize);
-	if (intr == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: Unable to ioremap interrupt controller registers!");
-		goto end;
-	}
+	if (!intr)
+		panic(__FILE__ ": cannot ioremap pic registers!");
 
 	sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
-	if (sdma == NULL) {
-		iounmap(intr);
-		printk(KERN_ERR "MPC52xx PIC: Unable to ioremap Bestcomm DMA controller registers!");
-		goto end;
-	}
+	if (!sdma)
+		panic(__FILE__ ": cannot ioremap Bestcomm registers!");
 
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8x\n", picnode_regoffset);
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n", sdmanode_regoffset);
+	printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8x\n",
+	       picnode_regoffset);
+	printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n",
+	       sdmanode_regoffset);
 
 	/* Disable all interrupt sources. */
 	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
@@ -465,18 +458,16 @@ void __init mpc52xx_init_irq(void)
 	 * hw irq information provided by the ofw to linux virq
 	 */
 
-	mpc52xx_irqhost =
-	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,
-			   &mpc52xx_irqhost_ops, -1);
+	mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
+	                                 &mpc52xx_irqhost_ops, -1);
 
-	if (mpc52xx_irqhost) {
-		mpc52xx_irqhost->host_data = picnode;
-		printk(KERN_INFO "MPC52xx PIC is up and running!\n");
-	} else {
-		printk(KERN_ERR "MPC52xx PIC: Unable to allocate the IRQ host\n");
-	}
+	if (!mpc52xx_irqhost)
+		panic(__FILE__ ": Cannot allocate the IRQ host\n");
+
+	mpc52xx_irqhost->host_data = picnode;
+	printk(KERN_INFO "MPC52xx PIC is up and running!\n");
 
-end:
 	of_node_put(picnode);
 	of_node_put(sdmanode);
 }
@@ -513,11 +504,11 @@ unsigned int mpc52xx_get_irq(void)
 			irq |=
 			    (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
 			    MPC52xx_IRQ_L1_MASK;
-		} else
+		} else {
 			irq |=
 			    (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
 			    MPC52xx_IRQ_L1_MASK;
-
+		}
 	}
 
 	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
-- 
1.4.3.rc2.g0503
