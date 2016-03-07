Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0060.outbound.protection.outlook.com [157.56.111.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18CDF1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:49:38 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 6/7] iommu/fsl: PAMU power management support
Date: Mon, 7 Mar 2016 17:34:22 +0200
Message-ID: <1457364863-18004-7-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Varun Sethi <Varun.Sethi@freescale.com>

PAMU driver suspend and resume support.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c | 155 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 123 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 181759e..290231a 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -23,6 +23,7 @@
 #include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/mpc85xx.h>
 #include <asm/reg.h>
@@ -35,10 +36,13 @@
 
 #define make64(high, low) (((u64)(high) << 32) | (low))
 
-struct pamu_isr_data {
+struct pamu_info {
 	void __iomem *pamu_reg_base;	/* Base address of PAMU regs */
 	unsigned int count;		/* The number of PAMUs */
-};
+} pamu_info_data;
+
+/* Pointer to the device configuration space */
+static struct ccsr_guts __iomem *guts_regs;
 
 static struct paace *ppaact;
 static struct paace *spaact;
@@ -104,6 +108,36 @@ static struct paace *pamu_get_ppaace(int liodn)
 	return &ppaact[liodn];
 }
 
+#ifdef CONFIG_SUSPEND
+/**
+ * set_dcfg_liodn() - set the device LIODN in DCFG
+ * @np: device tree node pointer
+ * @liodn: liodn value to program
+ *
+ * Returns 0 upon success else error code < 0 returned
+ */
+static int set_dcfg_liodn(struct device_node *np, int liodn)
+{
+	const __be32 *prop;
+	u32 liodn_reg_offset;
+	int len;
+	void __iomem *dcfg_region = (void *)guts_regs;
+
+	if (!dcfg_region)
+		return -ENODEV;
+
+	prop = of_get_property(np, "fsl,liodn-reg", &len);
+	if (!prop || len != 8)
+		return -EINVAL;
+
+	liodn_reg_offset = be32_to_cpup(&prop[1]);
+
+	out_be32((u32 *)(dcfg_region + liodn_reg_offset), liodn);
+
+	return 0;
+}
+#endif
+
 /**
  * pamu_enable_liodn() - Set valid bit of PACCE
  * @liodn: liodn PAACT index for desired PAACE
@@ -743,7 +777,7 @@ static void setup_omt(struct ome *omt)
  * Get the maximum number of PAACT table entries
  * and subwindows supported by PAMU
  */
-static void get_pamu_cap_values(unsigned long pamu_reg_base)
+static void get_pamu_cap_values(void *pamu_reg_base)
 {
 	u32 pc_val;
 
@@ -753,10 +787,8 @@ static void get_pamu_cap_values(unsigned long pamu_reg_base)
 }
 
 /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */
-static int setup_one_pamu(unsigned long pamu_reg_base,
-			  unsigned long pamu_reg_size,
-			  phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
-			  phys_addr_t omt_phys)
+static int setup_one_pamu(void *pamu_reg_base, phys_addr_t ppaact_phys,
+			  phys_addr_t spaact_phys, phys_addr_t omt_phys)
 {
 	u32 *pc;
 	struct pamu_mmap_regs *pamu_regs;
@@ -846,7 +878,7 @@ static void setup_liodns(void)
 
 static irqreturn_t pamu_av_isr(int irq, void *arg)
 {
-	struct pamu_isr_data *data = arg;
+	struct pamu_info *data = arg;
 	phys_addr_t phys;
 	unsigned int i, j, ret;
 
@@ -1098,11 +1130,9 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *pamu_regs = NULL;
-	struct ccsr_guts __iomem *guts_regs = NULL;
 	u32 pamubypenr, pamu_counter;
+	void __iomem *pamu_reg_base;
 	unsigned long pamu_reg_off;
-	unsigned long pamu_reg_base;
-	struct pamu_isr_data *data = NULL;
 	struct device_node *guts_node;
 	u64 size;
 	struct page *p;
@@ -1129,22 +1159,17 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	}
 	of_get_address(dev->of_node, 0, &size, NULL);
 
+	pamu_info_data.pamu_reg_base = pamu_regs;
+	pamu_info_data.count = size / PAMU_OFFSET;
+
 	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (irq == NO_IRQ) {
 		dev_warn(dev, "no interrupts listed in PAMU node\n");
 		goto error;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto error;
-	}
-	data->pamu_reg_base = pamu_regs;
-	data->count = size / PAMU_OFFSET;
-
 	/* The ISR needs access to the regs, so we won't iounmap them */
-	ret = request_irq(irq, pamu_av_isr, 0, "pamu", data);
+	ret = request_irq(irq, pamu_av_isr, 0, "pamu", &pamu_info_data);
 	if (ret < 0) {
 		dev_err(dev, "error %i installing ISR for irq %i\n", ret, irq);
 		goto error;
@@ -1167,7 +1192,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	}
 
 	/* read in the PAMU capability registers */
-	get_pamu_cap_values((unsigned long)pamu_regs);
+	get_pamu_cap_values(pamu_regs);
 	/*
 	 * To simplify the allocation of a coherency domain, we allocate the
 	 * PAACT and the OMT in the same memory buffer. Unfortunately, this
@@ -1243,9 +1268,9 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	for (pamu_reg_off = 0, pamu_counter = 0x80000000; pamu_reg_off < size;
 	     pamu_reg_off += PAMU_OFFSET, pamu_counter >>= 1) {
 
-		pamu_reg_base = (unsigned long)pamu_regs + pamu_reg_off;
-		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
-			       spaact_phys, omt_phys);
+		pamu_reg_base = pamu_regs + pamu_reg_off;
+		setup_one_pamu(pamu_reg_base, ppaact_phys, spaact_phys,
+			       omt_phys);
 		/* Disable PAMU bypass for this PAMU */
 		pamubypenr &= ~pamu_counter;
 	}
@@ -1255,8 +1280,6 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	/* Enable all relevant PAMU(s) */
 	out_be32(&guts_regs->pamubypenr, pamubypenr);
 
-	iounmap(guts_regs);
-
 	/* Enable DMA for the LIODNs in the device tree */
 
 	setup_liodns();
@@ -1268,12 +1291,7 @@ error_genpool:
 
 error:
 	if (irq != NO_IRQ)
-		free_irq(irq, data);
-
-	if (data) {
-		memset(data, 0, sizeof(struct pamu_isr_data));
-		kfree(data);
-	}
+		free_irq(irq, &pamu_info_data);
 
 	if (pamu_regs)
 		iounmap(pamu_regs);
@@ -1296,6 +1314,77 @@ static struct platform_driver fsl_of_pamu_driver = {
 	.probe = fsl_pamu_probe,
 };
 
+#ifdef CONFIG_SUSPEND
+static int iommu_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < pamu_info_data.count; i++) {
+		u32 val;
+		void __iomem *p;
+
+		p = pamu_info_data.pamu_reg_base + i * PAMU_OFFSET;
+		val = in_be32((u32 *)(p + PAMU_PICS));
+		/* Disable access violation interrupts */
+		out_be32((u32 *)(p + PAMU_PICS),
+			 val & ~PAMU_ACCESS_VIOLATION_ENABLE);
+	}
+
+	return 0;
+}
+
+static void restore_dcfg_liodns(void)
+{
+	struct device_node *node;
+	const __be32 *prop;
+	int ret, liodn;
+
+	for_each_node_with_property(node, "fsl,liodn-reg") {
+		prop = of_get_property(node, "fsl,liodn", 0);
+		if (!prop)
+			continue;
+		liodn = be32_to_cpup(prop);
+		ret = set_dcfg_liodn(node, liodn);
+		if (ret)
+			pr_debug("LIODN restore failed for %s\n",
+				 node->full_name);
+	}
+}
+
+static void iommu_resume(void)
+{
+	int i;
+	u32 pamubypenr, pamu_counter;
+
+	restore_dcfg_liodns();
+	pamubypenr = in_be32(&guts_regs->pamubypenr);
+	for (i = 0, pamu_counter = 0x80000000; i < pamu_info_data.count;
+		 i++, pamu_counter >>= 1) {
+		void __iomem *p;
+
+		p = pamu_info_data.pamu_reg_base + i * PAMU_OFFSET;
+		setup_one_pamu(p, virt_to_phys(ppaact), virt_to_phys(spaact),
+			       virt_to_phys(omt));
+		pamubypenr &= ~pamu_counter;
+	}
+	/* Enable all PAMUs */
+	out_be32(&guts_regs->pamubypenr, pamubypenr);
+}
+
+static struct syscore_ops iommu_syscore_ops = {
+	.resume		= iommu_resume,
+	.suspend	= iommu_suspend,
+};
+
+static void __init init_iommu_pm_ops(void)
+{
+	register_syscore_ops(&iommu_syscore_ops);
+}
+
+#else
+static inline void init_iommu_pm_ops(void) {}
+#endif	/* CONFIG_SUSPEND */
+
 static __init int fsl_pamu_init(void)
 {
 	struct platform_device *pdev = NULL;
@@ -1353,6 +1442,8 @@ static __init int fsl_pamu_init(void)
 		goto error_device_add;
 	}
 
+	init_iommu_pm_ops();
+
 	return 0;
 
 error_device_add:
-- 
1.9.3
