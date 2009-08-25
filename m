Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCBFEB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 16:08:58 +1000 (EST)
Received: from mail-px0-f189.google.com (mail-px0-f189.google.com
	[209.85.216.189]) by ozlabs.org (Postfix) with ESMTP id 0BB96DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 16:08:56 +1000 (EST)
Received: by pxi27 with SMTP id 27so2779954pxi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 23:08:55 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: add cascade support to xilinx intc controller
To: john.linn@xilinx.com, linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com,
	benh@kernel.crashing.org
Date: Tue, 25 Aug 2009 00:08:51 -0600
Message-ID: <20090825060848.3913.60710.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch allows the Xilinx intc interrupt controller to be cascaded
instead of being the master irqhost.  Useful when attaching an FPGA
to an SoC that has its own interrupt controller.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/xilinx_intc.h |    1 +
 arch/powerpc/sysdev/Kconfig            |    4 ++
 arch/powerpc/sysdev/Makefile           |    2 +
 arch/powerpc/sysdev/xilinx_intc.c      |   61 ++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 4 deletions(-)


diff --git a/arch/powerpc/include/asm/xilinx_intc.h b/arch/powerpc/include/asm/xilinx_intc.h
index 343612f..47ef6bd 100644
--- a/arch/powerpc/include/asm/xilinx_intc.h
+++ b/arch/powerpc/include/asm/xilinx_intc.h
@@ -13,6 +13,7 @@
 
 #ifdef __KERNEL__
 
+extern int xilinx_intc_cascade_setup(struct device_node *cascade_node);
 extern void __init xilinx_intc_init_tree(void);
 extern unsigned int xilinx_intc_get_irq(void);
 
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 3965828..d78f2da 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,3 +12,7 @@ config PPC_MSI_BITMAP
 	depends on PCI_MSI
 	default y if MPIC
 	default y if FSL_PCI
+
+config XILINX_INTC
+	bool
+	default y if XILINX_VIRTEX
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9d4b174..1cf11b6 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
-obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_XILINX_INTC)	+= xilinx_intc.o
 obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 3ee1fd3..14ef172 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -188,8 +188,7 @@ static struct irq_host_ops xilinx_intc_ops = {
 	.xlate = xilinx_intc_xlate,
 };
 
-struct irq_host * __init
-xilinx_intc_init(struct device_node *np)
+struct irq_host *xilinx_intc_init(struct device_node *np)
 {
 	struct irq_host * irq;
 	void * regs;
@@ -269,13 +268,69 @@ static void __init xilinx_i8259_setup_cascade(void)
 static inline void xilinx_i8259_setup_cascade(void) { return; }
 #endif /* defined(CONFIG_PPC_I8259) */
 
-static struct of_device_id xilinx_intc_match[] __initconst = {
+static struct of_device_id xilinx_intc_match[] = {
 	{ .compatible = "xlnx,opb-intc-1.00.c", },
 	{ .compatible = "xlnx,xps-intc-1.00.a", },
 	{}
 };
 
 /*
+ * Cascaded Xilinx interrupt controller
+ */
+static void xilinx_intc_cascade(unsigned int virq, struct irq_desc *desc)
+{
+	struct irq_host *cascade_irqhost = get_irq_data(virq);
+	void *regs = cascade_irqhost->host_data;
+	unsigned int cascade_virq;
+
+	pr_debug("%s(virq=%i) irq_host=%p\n", __func__, virq, cascade_irqhost);
+	cascade_virq = irq_linear_revmap(cascade_irqhost,
+					 in_be32(regs + XINTC_IVR));
+	if (cascade_virq)
+		generic_handle_irq(cascade_virq);
+}
+
+/**
+ * xilinx_intc_cascade_setup - Add a xilinx intc device as a cascaded controller
+ * @cascade_node: device node for xilinx intc controller.
+ */
+int xilinx_intc_cascade_setup(struct device_node *cascade_node)
+{
+	struct irq_host *cascade_irqhost;
+	int cascade_virq;
+
+	if (!cascade_node) {
+		pr_err("%s(): cannot find xilinx intc node\n", __func__);
+		return -ENODEV;
+	}
+
+	/* Make sure this is a xilinx intc device */
+	if (!of_match_node(xilinx_intc_match, cascade_node)) {
+		pr_err("%s(): %s is not compatible\n",
+			__func__, cascade_node->name);
+		return -EINVAL;
+	}
+
+	/* Map a VIRQ for the cascaded handler */
+	cascade_virq = irq_of_parse_and_map(cascade_node, 0);
+	if (!cascade_virq) {
+		pr_err("%s(): error mapping cascade interrupt\n", __func__);
+		return -ENODEV;
+	}
+
+	/* Set up the irqhost and register it */
+	cascade_irqhost = xilinx_intc_init(cascade_node);
+	set_irq_data(cascade_virq, cascade_irqhost);
+	set_irq_chained_handler(cascade_virq, xilinx_intc_cascade);
+
+	pr_debug("%s(): cascading virq %i to irq_host %p\n",
+		 __func__, cascade_virq, cascade_irqhost);
+
+	return 0;
+}
+EXPORT_SYMBOL(xilinx_intc_cascade_setup);
+
+/*
  * Initialize master Xilinx interrupt controller
  */
 void __init xilinx_intc_init_tree(void)
