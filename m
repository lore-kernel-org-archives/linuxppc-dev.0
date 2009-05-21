Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f125.google.com (mail-pz0-f125.google.com
	[209.85.222.125]) by ozlabs.org (Postfix) with ESMTP id 1F86EDE1C9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 02:30:09 +1000 (EST)
Received: by pzk31 with SMTP id 31so1466832pzk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 09:30:08 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v4 2/3] powerpc/virtex: refactor intc driver and add support
	for i8259 cascading
To: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Thu, 21 May 2009 10:24:29 -0600
Message-ID: <20090521162429.10880.31243.stgit@localhost.localdomain>
In-Reply-To: <20090521162202.10880.34056.stgit@localhost.localdomain>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch refactors some of the xilinx_intc interrupt controller driver
and adds support for cascading an i8259 off one of the irq lines.

This patch was based on the ML510 support work done by Roderick
Colenbrander.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/xilinx_intc.c |   76 ++++++++++++++++++++++++++++---------
 1 files changed, 58 insertions(+), 18 deletions(-)


diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index c658b41..90b5772 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <asm/io.h>
 #include <asm/processor.h>
+#include <asm/i8259.h>
 #include <asm/irq.h>
 
 /*
@@ -191,20 +192,14 @@ struct irq_host * __init
 xilinx_intc_init(struct device_node *np)
 {
 	struct irq_host * irq;
-	struct resource res;
 	void * regs;
-	int rc;
 
 	/* Find and map the intc registers */
-	rc = of_address_to_resource(np, 0, &res);
-	if (rc) {
-		printk(KERN_ERR __FILE__ ": of_address_to_resource() failed\n");
+	regs = of_iomap(np, 0);
+	if (!regs) {
+		pr_err("xilinx_intc: could not map registers\n");
 		return NULL;
 	}
-	regs = ioremap(res.start, 32);
-
-	printk(KERN_INFO "Xilinx intc at 0x%08llx mapped to 0x%p\n",
-		(unsigned long long) res.start, regs);
 
 	/* Setup interrupt controller */
 	out_be32(regs + XINTC_IER, 0); /* disable all irqs */
@@ -217,6 +212,7 @@ xilinx_intc_init(struct device_node *np)
 	if (!irq)
 		panic(__FILE__ ": Cannot allocate IRQ host\n");
 	irq->host_data = regs;
+
 	return irq;
 }
 
@@ -227,23 +223,65 @@ int xilinx_intc_get_irq(void)
 	return irq_linear_revmap(master_irqhost, in_be32(regs + XINTC_IVR));
 }
 
+#if defined(CONFIG_PPC_I8259)
+/*
+ * Support code for cascading to 8259 interrupt controllers
+ */
+static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+	if (cascade_irq)
+		generic_handle_irq(cascade_irq);
+
+	/* Let xilinx_intc end the interrupt */
+	desc->chip->ack(irq);
+	desc->chip->unmask(irq);
+}
+
+static void __init xilinx_i8259_setup_cascade(void)
+{
+	struct device_node *cascade_node;
+	int cascade_irq;
+
+	/* Initialize i8259 controller */
+	cascade_node = of_find_compatible_node(NULL, NULL, "chrp,iic");
+	if (!cascade_node)
+		return;
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (!cascade_irq) {
+		pr_err("virtex_ml510: Failed to map cascade interrupt\n");
+		goto out;
+	}
+
+	i8259_init(cascade_node, 0);
+	set_irq_chained_handler(cascade_irq, xilinx_i8259_cascade);
+
+ out:
+	of_node_put(cascade_node);
+}
+#else
+static inline void xilinx_i8259_setup_cascade(void) { return; }
+#endif /* defined(CONFIG_PPC_I8259) */
+
+static struct of_device_id xilinx_intc_match[] __initconst = {
+	{ .compatible = "xlnx,opb-intc-1.00.c", },
+	{ .compatible = "xlnx,xps-intc-1.00.a", },
+	{}
+};
+
+/*
+ * Initialize master Xilinx interrupt controller
+ */
 void __init xilinx_intc_init_tree(void)
 {
 	struct device_node *np;
 
 	/* find top level interrupt controller */
-	for_each_compatible_node(np, NULL, "xlnx,opb-intc-1.00.c") {
+	for_each_matching_node(np, xilinx_intc_match) {
 		if (!of_get_property(np, "interrupts", NULL))
 			break;
 	}
-	if (!np) {
-		for_each_compatible_node(np, NULL, "xlnx,xps-intc-1.00.a") {
-			if (!of_get_property(np, "interrupts", NULL))
-				break;
-		}
-	}
-
-	/* xilinx interrupt controller needs to be top level */
 	BUG_ON(!np);
 
 	master_irqhost = xilinx_intc_init(np);
@@ -251,4 +289,6 @@ void __init xilinx_intc_init_tree(void)
 
 	irq_set_default_host(master_irqhost);
 	of_node_put(np);
+
+	xilinx_i8259_setup_cascade();
 }
