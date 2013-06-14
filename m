Return-Path: <B31939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 639C72C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 17:15:55 +1000 (EST)
Received: from mail40-tx2 (localhost [127.0.0.1])	by mail40-tx2-R.bigfish.com
 (Postfix) with ESMTP id 8DDF8300581	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 14 Jun 2013 07:15:51 +0000 (UTC)
Received: from TX2EHSMHS022.bigfish.com (unknown [10.9.14.248])	by
 mail40-tx2.bigfish.com (Postfix) with ESMTP id E00FD2C009C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:49 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/5] powerpc/fsl_msi: add 'msiregs' kernel parameter
Date: Fri, 14 Jun 2013 15:15:59 +0800
Message-ID: <1371194159-17332-5-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. Only MSIIR1 can index 16 MSI registers, but when using MSIIR1
the IRQs of a register are not continuous. for example, the first
register irq values are 0x0, 0x10, 0x20, 0x30 ... 0x1f0. So it
is hard to use 'msi-available-ranges' property to indicate the
available ranges and 'msi-available-ranges' property has been
removed from dts node, so this patch removes the related code.

2. Add 'msiregs' kernel parameter instead of 'msi-available-ranges'
functionality. 'msiregs' is used to indicate the available MSI
registers ranges and uses a colon ':' to separate the multiple
banks. The range representation format is 'start-end', 'start'
and 'end' are integers describe the start and end register index,
the available registers lies between start and end and not include
end. For example, the available register x satisfying
start <= x < end.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 118 ++++++++++++++++++++++++++++--------------
 arch/powerpc/sysdev/fsl_msi.h |   1 +
 2 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 34510b7..db382ef9b 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -52,6 +52,60 @@ struct fsl_msi_cascade_data {
 	int index;
 };
 
+struct msi_reg_range {
+	u32 start;
+	u32 end;
+};
+
+static struct msi_reg_range msiregs[NR_MSI_BANK] = {
+	{.start = 0, .end = NR_MSI_REG },
+	{.start = 0, .end = NR_MSI_REG },
+	{.start = 0, .end = NR_MSI_REG },
+	{.start = 0, .end = NR_MSI_REG },
+};
+
+/*
+ * Handle 'msiregs' parameter.
+ * msiregs is used to indicate the available MSI registers range and
+ * uses colon ':' to separate the multiple banks ranges.
+ * For each bank, the registers range format is 'start-end'
+ * start and end are integers, used to the indicate the start and end
+ * register index. The range is a set of real numbers that lies between
+ * start and end but not include end. For example, the set of all numbers
+ * x satisfying start <= x < end.
+ * if no range specified, driver will use the default range including all
+ * the registers.
+ * if you do no want to use this bank, you can set range as '0-0'
+ * For example msiregs=0-16:0-0::0-2
+ */
+static int msi_regs_setup(char *s)
+{
+	int bank = 0;
+	char *p;
+	struct msi_reg_range *range;
+
+	while ((p = strsep(&s, ":")) != NULL) {
+		int start = 0, end = NR_MSI_REG;
+
+		if (bank >= NR_MSI_BANK)
+			break;
+		range = &msiregs[bank];
+
+		if ((*p != '\0') && (sscanf(p, "%d-%d", &start, &end) < 1))
+			pr_err("msiregs correct format is: start-end\n");
+
+		/* Ok, gets the specified value */
+		range->start = start;
+		range->end = end;
+		pr_info("MSI bank%d available regs range is %d-%d\n",
+			 bank, range->start, range->end);
+		bank++;
+	}
+	return 1;
+}
+
+__setup("msiregs=", msi_regs_setup);
+
 static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
 {
 	return in_be32(base + (reg >> 2));
@@ -350,7 +404,7 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 static struct lock_class_key fsl_msi_irq_class;
 
 static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
-			       int offset, int irq_index)
+			       int irq_index)
 {
 	struct fsl_msi_cascade_data *cascade_data = NULL;
 	int virt_msir, i;
@@ -369,7 +423,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	}
 	irq_set_lockdep_class(virt_msir, &fsl_msi_irq_class);
 	msi->msi_virqs[irq_index] = virt_msir;
-	cascade_data->index = offset;
+	cascade_data->index = irq_index;
 	cascade_data->msi_data = msi;
 	irq_set_handler_data(virt_msir, cascade_data);
 	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
@@ -377,7 +431,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	/* Release the hwirqs corresponding to this MSI register */
 	for (i = 0; i < IRQS_PER_MSI_REG; i++)
 		msi_bitmap_free_hwirqs(&msi->bitmap,
-				       msi_hwirq(msi, offset, i), 1);
+				       msi_hwirq(msi, irq_index, i), 1);
 
 	return 0;
 }
@@ -387,21 +441,29 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 {
 	const struct of_device_id *match;
 	struct fsl_msi *msi;
+	static int bank;
+	struct msi_reg_range *range;
 	struct resource res, msiir;
-	int err, i, j, irq_index, count;
+	int err, irq_index, count;
 	int rc;
-	const u32 *p;
 	const struct fsl_msi_feature *features;
-	int len;
-	u32 offset;
-	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
 
 	match = of_match_device(fsl_of_msi_ids, &dev->dev);
 	if (!match)
 		return -EINVAL;
 	features = match->data;
 
-	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
+	if (bank >= NR_MSI_BANK)
+		return -EINVAL;
+	range = &msiregs[bank];
+	pr_debug("Setting up Freescale MSI bank%d support\n", bank);
+
+	count = of_irq_count(dev->dev.of_node);
+	if (!count)
+		return -ENODEV;
+
+	if (count > NR_MSI_REG)
+		count = NR_MSI_REG;
 
 	msi = kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
 	if (!msi) {
@@ -475,39 +537,17 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 		goto error_out;
 	}
 
-	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
-	if (p && len % (2 * sizeof(u32)) != 0) {
-		dev_err(&dev->dev, "%s: Malformed msi-available-ranges property\n",
-			__func__);
-		err = -EINVAL;
-		goto error_out;
-	}
-
-	if (!p) {
-		p = all_avail;
-		len = sizeof(all_avail);
-	}
-
-	for (irq_index = 0, i = 0; i < len / (2 * sizeof(u32)); i++) {
-		if (p[i * 2] % IRQS_PER_MSI_REG ||
-		    p[i * 2 + 1] % IRQS_PER_MSI_REG) {
-			printk(KERN_WARNING "%s: %s: msi available range of %u at %u is not IRQ-aligned\n",
-			       __func__, dev->dev.of_node->full_name,
-			       p[i * 2 + 1], p[i * 2]);
-			err = -EINVAL;
+	for (irq_index = 0; irq_index < count; irq_index++) {
+		/* Check whether the register is contained in range */
+		if (irq_index < range->start ||
+			irq_index >= range->end)
+			continue;
+		err = fsl_msi_setup_hwirq(msi, dev, irq_index);
+		if (err)
 			goto error_out;
-		}
-
-		offset = p[i * 2] / IRQS_PER_MSI_REG;
-		count = p[i * 2 + 1] / IRQS_PER_MSI_REG;
-
-		for (j = 0; j < count; j++, irq_index++) {
-			err = fsl_msi_setup_hwirq(msi, dev, offset + j, irq_index);
-			if (err)
-				goto error_out;
-		}
 	}
 
+	bank++;
 	list_add_tail(&msi->list, &msi_head);
 
 	/* The multiple setting ppc_md.setup_msi_irqs will not harm things */
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 43a9d99..6048415 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <asm/msi_bitmap.h>
 
+#define NR_MSI_BANK		4
 #define NR_MSI_REG		16
 #define IRQS_PER_MSI_REG	32
 #define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
-- 
1.8.1.2
