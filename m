Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id B41B467D02
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:17:33 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/9] [POWERPC] Add common routines for 52xx support in
	arch/powerpc
Date: Mon, 27 Nov 2006 14:16:27 -0700
Message-Id: <11646622072224-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1164662207513-git-send-email-grant.likely@secretlab.ca>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622052490-git-send-email-grant.likely@secretlab.ca>
	<11646622063980-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
	<1164662207513-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds utility routines used by 52xx device drivers and board support
code.  Main functionality is to add device nodes to the of_platform_bus,
retrieve the IPB bus frequency, and find+ioremap device registers

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/platforms/52xx/Makefile         |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  124 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |  110 +++++------------------
 include/asm-powerpc/mpc52xx.h                |    4 +
 4 files changed, 151 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 1c9c122..b8f27a8 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for 52xx based boards
 #
 ifeq ($(CONFIG_PPC_MERGE),y)
-obj-y				+= mpc52xx_pic.o
+obj-y				+= mpc52xx_pic.o mpc52xx_common.o
 endif
 
 obj-$(CONFIG_PPC_EFIKA) += efika-setup.o efika-pci.o
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
new file mode 100644
index 0000000..05b2144
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -0,0 +1,124 @@
+/*
+ *
+ * Utility functions for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/of_platform.h>
+#include <asm/mpc52xx.h>
+
+
+void __iomem *
+mpc52xx_find_and_map(const char *compatible)
+{
+	struct device_node *ofn;
+	const u32 *regaddr_p;
+	u64 regaddr64, size64;
+
+	ofn = of_find_compatible_node(NULL, NULL, compatible);
+	if (!ofn)
+		return NULL;
+
+	regaddr_p = of_get_address(ofn, 0, &size64, NULL);
+	if (!regaddr_p) {
+		of_node_put(ofn);
+		return NULL;
+	}
+
+	regaddr64 = of_translate_address(ofn, regaddr_p);
+
+	of_node_put(ofn);
+
+	return ioremap((u32)regaddr64, (u32)size64);
+}
+
+
+/**
+ * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
+ * 	@node:	device node
+ *
+ * 	Returns IPB bus frequency, or 0 if the bus frequency cannot be found.
+ */
+unsigned int
+mpc52xx_find_ipb_freq(struct device_node *node)
+{
+	struct device_node *np;
+	const unsigned int *p_ipb_freq = NULL;
+
+	of_node_get(node);
+	while (node) {
+		p_ipb_freq = get_property(node, "bus-frequency", NULL);
+		if (p_ipb_freq)
+			break;
+
+		np = of_get_parent(node);
+		of_node_put(node);
+		node = np;
+	}
+	if (node)
+		of_node_put(node);
+
+	return p_ipb_freq ? *p_ipb_freq : 0;
+}
+
+
+void __init
+mpc52xx_setup_cpu(void)
+{
+	struct mpc52xx_cdm  __iomem *cdm;
+	struct mpc52xx_xlb  __iomem *xlb;
+
+	/* Map zones */
+	cdm = mpc52xx_find_and_map("mpc52xx-cdm");
+	xlb = mpc52xx_find_and_map("mpc52xx-xlb");
+
+	if (!cdm || !xlb) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error while mapping CDM/XLB during mpc52xx_setup_cpu. "
+			"Expect some abnormal behavior\n");
+		goto unmap_regs;
+	}
+
+	/* Use internal 48 Mhz */
+	out_8(&cdm->ext_48mhz_en, 0x00);
+	out_8(&cdm->fd_enable, 0x01);
+	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
+		out_be16(&cdm->fd_counters, 0x0001);
+	else
+		out_be16(&cdm->fd_counters, 0x5555);
+
+	/* Configure the XLB Arbiter priorities */
+	out_be32(&xlb->master_pri_enable, 0xff);
+	out_be32(&xlb->master_priority, 0x11111111);
+
+	/* Disable XLB pipelining */
+	/* (cfr errate 292. We could do this only just before ATA PIO
+	    transaction and re-enable it afterwards ...) */
+	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+
+	/* Unmap zones */
+unmap_regs:
+	if (cdm) iounmap(cdm);
+	if (xlb) iounmap(xlb);
+}
+
+static int __init
+mpc52xx_declare_of_platform_devices(void)
+{
+	/* Find every child of the SOC node and add it to of_platform */
+	return of_platform_bus_probe(NULL, NULL, NULL);
+}
+
+device_initcall(mpc52xx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 504154f..cd91a6c 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -54,12 +54,12 @@ static unsigned char mpc52xx_map_senses[
  *
 */
 
-static inline void io_be_setbit(u32 __iomem * addr, int bitno)
+static inline void io_be_setbit(u32 __iomem *addr, int bitno)
 {
 	out_be32(addr, in_be32(addr) | (1 << bitno));
 }
 
-static inline void io_be_clrbit(u32 __iomem * addr, int bitno)
+static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
 {
 	out_be32(addr, in_be32(addr) & ~(1 << bitno));
 }
@@ -104,7 +104,7 @@ static void mpc52xx_extirq_ack(unsigned 
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
-	io_be_setbit(&intr->ctrl, 27 - l2irq);
+	io_be_setbit(&intr->ctrl, 27-l2irq);
 }
 
 static struct irq_chip mpc52xx_extirq_irqchip = {
@@ -379,81 +379,21 @@ static struct irq_host_ops mpc52xx_irqho
 
 void __init mpc52xx_init_irq(void)
 {
-	struct device_node *picnode = NULL;
-	int picnode_regsize;
-	u32 picnode_regoffset;
-
-	struct device_node *sdmanode = NULL;
-	int sdmanode_regsize;
-	u32 sdmanode_regoffset;
-
-	u64 size64;
-	int flags;
-
 	u32 intr_ctrl;
-
-	picnode = of_find_compatible_node(NULL, "interrupt-controller",
-						"mpc5200-pic");
-	if (picnode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to find the interrupt controller "
-			"in the OpenFirmware device tree\n");
-		goto end;
-	}
-
-	sdmanode = of_find_compatible_node(NULL, "dma-controller",
-						 "mpc5200-bestcomm");
-	if (sdmanode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC"
-			"Unable to find the Bestcomm DMA controller device "
-			"in the OpenFirmware device tree\n");
-		goto end;
-	}
-
-	/* Retrieve PIC ressources */
-	picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
-	if (picnode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC"
-			"Unable to get the interrupt controller address\n");
-		goto end;
-	}
-
-	picnode_regoffset =
-		of_translate_address(picnode, (u32 *) picnode_regoffset);
-	picnode_regsize = (int)size64;
-
-	/* Retrieve SDMA ressources */
-	sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
-	if (sdmanode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to get the Bestcomm DMA controller address\n");
-		goto end;
-	}
-
-	sdmanode_regoffset =
-	    of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
-	sdmanode_regsize = (int)size64;
+	struct device_node *picnode;
 
 	/* Remap the necessary zones */
-	intr = ioremap(picnode_regoffset, picnode_regsize);
-	if (intr == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to ioremap interrupt controller registers!\n");
-		goto end;
-	}
+	picnode = of_find_compatible_node(NULL, NULL, "mpc52xx-pic");
 
-	sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
-	if (sdma == NULL) {
-		iounmap(intr);
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to ioremap Bestcomm DMA registers!\n");
-		goto end;
-	}
+	intr = mpc52xx_find_and_map("mpc52xx-pic");
+	if (!intr)
+		panic(__FILE__	": find_and_map failed on 'mpc52xx-pic'. "
+				"Check node !");
 
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8x\n",
-		picnode_regoffset);
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n",
-		sdmanode_regoffset);
+	sdma = mpc52xx_find_and_map("mpc52xx-bestcomm");
+	if (!sdma)
+		panic(__FILE__	": find_and_map failed on 'mpc52xx-bestcomm'. "
+				"Check node !");
 
 	/* Disable all interrupt sources. */
 	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
@@ -480,21 +420,15 @@ void __init mpc52xx_init_irq(void)
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
-		printk(KERN_ERR
-			"MPC52xx PIC: Unable to allocate the IRQ host\n");
-	}
+	if (!mpc52xx_irqhost)
+		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
-end:
-	of_node_put(picnode);
-	of_node_put(sdmanode);
+	mpc52xx_irqhost->host_data = picnode;
+	printk(KERN_INFO "MPC52xx PIC is up and running!\n");
 }
 
 /*
@@ -526,9 +460,10 @@ unsigned int mpc52xx_get_irq(void)
 			irq = ffs(status) - 1;
 			irq |=	(MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
 				MPC52xx_IRQ_L1_MASK;
-		} else
+		} else {
 			irq |=	(MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
 				MPC52xx_IRQ_L1_MASK;
+		}
 	}
 
 	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
@@ -536,4 +471,3 @@ unsigned int mpc52xx_get_irq(void)
 
 	return irq_linear_revmap(mpc52xx_irqhost, irq);
 }
-
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index fff752c..4a28a85 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -241,6 +241,10 @@ #endif /* __ASSEMBLY__ */
 
 #ifndef __ASSEMBLY__
 
+extern void __iomem * mpc52xx_find_and_map(const char *);
+extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
+extern void mpc52xx_setup_cpu(void);
+
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
-- 
1.4.3.rc2.g0503
