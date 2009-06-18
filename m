Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 30785B7289
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:53 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <53154f19beb3e8a24b92ab91704b4c026a793f88.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/7] powerpc/cell: Use pr_devel() in axon_msi.c
Date: Thu, 18 Jun 2009 14:13:53 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   7083    1616       0    8699    21fb arch/powerpc/../axon_msi.o

size after:
   text    data     bss     dec     hex filename
   5772    1208       0    6980    1b44 arch/powerpc/../axon_msi.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index c71498d..aca5741 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -85,7 +85,7 @@ static inline void axon_msi_debug_setup(struct device_node *dn,
 
 static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 {
-	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
+	pr_devel("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
 
 	dcr_write(msic->dcr_host, dcr_n, val);
 }
@@ -98,7 +98,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	int retry = 0;
 
 	write_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
-	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
+	pr_devel("axon_msi: original write_offset 0x%x\n", write_offset);
 
 	/* write_offset doesn't wrap properly, so we have to mask it */
 	write_offset &= MSIC_FIFO_SIZE_MASK;
@@ -108,7 +108,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		msi  = le32_to_cpu(msic->fifo_virt[idx]);
 		msi &= 0xFFFF;
 
-		pr_debug("axon_msi: woff %x roff %x msi %x\n",
+		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
 
 		if (msi < NR_IRQS && irq_map[msi].host == msic->irq_host) {
@@ -123,12 +123,12 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 			 */
 			udelay(1);
 			retry++;
-			pr_debug("axon_msi: invalid irq 0x%x!\n", msi);
+			pr_devel("axon_msi: invalid irq 0x%x!\n", msi);
 			continue;
 		}
 
 		if (retry) {
-			pr_debug("axon_msi: late irq 0x%x, retry %d\n",
+			pr_devel("axon_msi: late irq 0x%x, retry %d\n",
 				 msi, retry);
 			retry = 0;
 		}
@@ -332,7 +332,7 @@ static int axon_msi_shutdown(struct of_device *device)
 	struct axon_msic *msic = dev_get_drvdata(&device->dev);
 	u32 tmp;
 
-	pr_debug("axon_msi: disabling %s\n",
+	pr_devel("axon_msi: disabling %s\n",
 		  msic->irq_host->of_node->full_name);
 	tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
 	tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
@@ -349,7 +349,7 @@ static int axon_msi_probe(struct of_device *device,
 	unsigned int virq;
 	int dcr_base, dcr_len;
 
-	pr_debug("axon_msi: setting up dn %s\n", dn->full_name);
+	pr_devel("axon_msi: setting up dn %s\n", dn->full_name);
 
 	msic = kzalloc(sizeof(struct axon_msic), GFP_KERNEL);
 	if (!msic) {
@@ -403,7 +403,7 @@ static int axon_msi_probe(struct of_device *device,
 
 	set_irq_data(virq, msic);
 	set_irq_chained_handler(virq, axon_msi_cascade);
-	pr_debug("axon_msi: irq 0x%x setup for axon_msi\n", virq);
+	pr_devel("axon_msi: irq 0x%x setup for axon_msi\n", virq);
 
 	/* Enable the MSIC hardware */
 	msic_dcr_write(msic, MSIC_BASE_ADDR_HI_REG, msic->fifo_phys >> 32);
@@ -484,13 +484,13 @@ void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 
 	addr = of_translate_address(dn, of_get_property(dn, "reg", NULL));
 	if (addr == OF_BAD_ADDR) {
-		pr_debug("axon_msi: couldn't translate reg property\n");
+		pr_devel("axon_msi: couldn't translate reg property\n");
 		return;
 	}
 
 	msic->trigger = ioremap(addr, 0x4);
 	if (!msic->trigger) {
-		pr_debug("axon_msi: ioremap failed\n");
+		pr_devel("axon_msi: ioremap failed\n");
 		return;
 	}
 
@@ -498,7 +498,7 @@ void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 
 	if (!debugfs_create_file(name, 0600, powerpc_debugfs_root,
 				 msic, &fops_msic)) {
-		pr_debug("axon_msi: debugfs_create_file failed!\n");
+		pr_devel("axon_msi: debugfs_create_file failed!\n");
 		return;
 	}
 }
-- 
1.6.2.1
