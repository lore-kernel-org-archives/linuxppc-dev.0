Return-Path: <scottwood@freescale.com>
Date: Mon, 17 Jan 2011 14:25:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl_msi: Handle msi-available-ranges better
Message-ID: <20110117202528.GB561@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now handles multiple ranges, doesn't make assumptions about interrupt
specifier format, and doesn't claim interrupts that don't correspond to an
available range.

Also has some better error checking.

The device tree binding is updated to clarify some existing assumptions.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/msi-pic.txt |    9 ++-
 arch/powerpc/sysdev/fsl_msi.c                      |   92 ++++++++++++--------
 2 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt b/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
index bcc30ba..c0d80fb 100644
--- a/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
@@ -5,14 +5,21 @@ Required properties:
   first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
   etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
   the parent type.
+
 - reg : should contain the address and the length of the shared message
   interrupt register set.
+
 - msi-available-ranges: use <start count> style section to define which
   msi interrupt can be used in the 256 msi interrupts. This property is
   optional, without this, all the 256 MSI interrupts can be used.
+  Each available range must begin and end on a multiple of 32 (i.e.
+  no splitting an individual MSI register or the associated PIC interrupt).
+
 - interrupts : each one of the interrupts here is one entry per 32 MSIs,
   and routed to the host interrupt controller. the interrupts should
-  be set as edge sensitive.
+  be set as edge sensitive.  If msi-available-ranges is present, only
+  the interrupts that correspond to available ranges shall be present.
+
 - interrupt-parent: the phandle for the interrupt controller
   that services interrupts for this device. for 83xx cpu, the interrupts
   are routed to IPIC, and for 85xx/86xx cpu the interrupts are routed
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 108d76f..46e27ac 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2010 Freescale Semiconductor, Inc.
+ * Copyright (C) 2007-2011 Freescale Semiconductor, Inc.
  *
  * Author: Tony Li <tony.li@freescale.com>
  *	   Jason Jin <Jason.jin@freescale.com>
@@ -273,19 +273,47 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	return 0;
 }
 
+static int __devinit fsl_msi_setup_hwirq(struct fsl_msi *msi,
+					 struct platform_device *dev,
+					 int offset, int irq_index)
+{
+	struct fsl_msi_cascade_data *cascade_data = NULL;
+	int virt_msir;
+
+	virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
+	if (virt_msir == NO_IRQ) {
+		dev_err(&dev->dev, "%s: Cannot translate IRQ index %d\n",
+			__func__, irq_index);
+		return 0;
+	}
+
+	cascade_data = kzalloc(sizeof(struct fsl_msi_cascade_data), GFP_KERNEL);
+	if (!cascade_data) {
+		dev_err(&dev->dev, "No memory for MSI cascade data\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_virqs[irq_index] = virt_msir;
+	cascade_data->index = offset + irq_index;
+	cascade_data->msi_data = msi;
+	set_irq_data(virt_msir, cascade_data);
+	set_irq_chained_handler(virt_msir, fsl_msi_cascade);
+
+	return 0;
+}
+
 static int __devinit fsl_of_msi_probe(struct platform_device *dev,
 				const struct of_device_id *match)
 {
 	struct fsl_msi *msi;
 	struct resource res;
-	int err, i, count;
+	int err, i, j, irq_index, count;
 	int rc;
-	int virt_msir;
 	const u32 *p;
 	struct fsl_msi_feature *features = match->data;
-	struct fsl_msi_cascade_data *cascade_data = NULL;
 	int len;
 	u32 offset;
+	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -332,42 +360,34 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev,
 		goto error_out;
 	}
 
-	p = of_get_property(dev->dev.of_node, "interrupts", &count);
-	if (!p) {
-		dev_err(&dev->dev, "no interrupts property found on %s\n",
-				dev->dev.of_node->full_name);
-		err = -ENODEV;
-		goto error_out;
-	}
-	if (count % 8 != 0) {
-		dev_err(&dev->dev, "Malformed interrupts property on %s\n",
-				dev->dev.of_node->full_name);
+	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
+	if (p && len % (2 * sizeof(u32)) != 0) {
+		dev_err(&dev->dev, "%s: Malformed msi-available-ranges property\n",
+			__func__);
 		err = -EINVAL;
 		goto error_out;
 	}
-	offset = 0;
-	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
-	if (p)
-		offset = *p / IRQS_PER_MSI_REG;
-
-	count /= sizeof(u32);
-	for (i = 0; i < min(count / 2, NR_MSI_REG); i++) {
-		virt_msir = irq_of_parse_and_map(dev->dev.of_node, i);
-		if (virt_msir != NO_IRQ) {
-			cascade_data = kzalloc(
-					sizeof(struct fsl_msi_cascade_data),
-					GFP_KERNEL);
-			if (!cascade_data) {
-				dev_err(&dev->dev,
-					"No memory for MSI cascade data\n");
-				err = -ENOMEM;
+
+	if (!p)
+		p = all_avail;
+
+	for (irq_index = 0, i = 0; i < len / (2 * sizeof(u32)); i++) {
+		if (p[i * 2] % IRQS_PER_MSI_REG ||
+		    p[i * 2 + 1] % IRQS_PER_MSI_REG) {
+			printk(KERN_WARNING "%s: %s: msi available range of %u at %u is not IRQ-aligned\n",
+			       __func__, dev->dev.of_node->full_name,
+			       p[i * 2 + 1], p[i * 2]);
+			err = -EINVAL;
+			goto error_out;
+		}
+
+		offset = p[i * 2] / IRQS_PER_MSI_REG;
+		count = p[i * 2 + 1] / IRQS_PER_MSI_REG;
+
+		for (j = 0; j < count; j++, irq_index++) {
+			err = fsl_msi_setup_hwirq(msi, dev, offset, irq_index);
+			if (err)
 				goto error_out;
-			}
-			msi->msi_virqs[i] = virt_msir;
-			cascade_data->index = i + offset;
-			cascade_data->msi_data = msi;
-			set_irq_data(virt_msir, (void *)cascade_data);
-			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
 		}
 	}
 
-- 
1.7.0.4
