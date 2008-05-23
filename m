Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A94AFDE3AC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:41:04 +1000 (EST)
Date: Fri, 23 May 2008 17:41:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] fsl_msi: few (mostly cosmetic) fixes
Message-ID: <20080523134102.GA31388@polina.dev.rtsoft.ru>
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<20080523125929.GA8752@polina.dev.rtsoft.ru>
	<27CED929-FF61-42D3-A53C-C21B4980BF94@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <27CED929-FF61-42D3-A53C-C21B4980BF94@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes few cosmetic issues, also removes unused function,
makes some functions static and reduces #ifdef count.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Fri, May 23, 2008 at 08:02:39AM -0500, Kumar Gala wrote:
>
> On May 23, 2008, at 7:59 AM, Anton Vorontsov wrote:
>
>> On Fri, May 23, 2008 at 04:32:46PM +0800, Jason Jin wrote:
>>> This MSI driver can be used on 83xx/85xx/86xx board.
>>> In this driver, virtual interrupt host and chip were
>>> setup. There are 256 MSI interrupts in this host, Every 32
>>> MSI interrupts cascaded to one IPIC/MPIC interrupt.
>>> The chip was treated as edge sensitive and some necessary
>>> functions were setup for this chip.
>>>
>>> Before using the MSI interrupt, PCI/PCIE device need to
>>> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
>>> bitmap show which MSI interrupt was used, reserve bit in
>>> the bitmap can be used to force the device use some designate
>>> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
>>> for testing the all the MSI interrupts. The msi-available-ranges
>>> property in the dts file was used for this purpose.
>>>
>>> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>>> ---
>>
>> Hello Jason,
>>
>> Few comments below.
>
> Jason, I'll apply this version.  I expect some clean up based on Anton  
> and Stephen's comments.

Yeah, was a bit late review. Just in case, here is the cleanup
based on my comments.

 arch/powerpc/sysdev/fsl_msi.c |   43 +++++++++++++++++-----------------------
 arch/powerpc/sysdev/fsl_pci.c |    8 ++----
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 9d0685b..2c5187c 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -36,12 +36,6 @@ static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
 	return in_be32(base + (reg >> 2));
 }
 
-static inline void fsl_msi_write(u32 __iomem *base,
-				unsigned int reg, u32 value)
-{
-	out_be32(base + (reg >> 2), value);
-}
-
 /*
  * We do not need this actually. The MSIR register has been read once
  * in the cascade interrupt. So, this MSI interrupt has been acked
@@ -64,7 +58,7 @@ static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
 
 	get_irq_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
 
-	set_irq_chip_and_handler(virq, chip,  handle_edge_irq);
+	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
 
 	return 0;
 }
@@ -73,10 +67,11 @@ static struct irq_host_ops fsl_msi_host_ops = {
 	.map = fsl_msi_host_map,
 };
 
-irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
+static irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
 {
 	unsigned long flags;
-	int offset, order = get_count_order(num);
+	int order = get_count_order(num);
+	int offset;
 
 	spin_lock_irqsave(&msi->bitmap_lock, flags);
 
@@ -91,7 +86,7 @@ irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
 	return offset;
 }
 
-void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
+static void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
 {
 	unsigned long flags;
 	int order = get_count_order(num);
@@ -106,7 +101,8 @@ void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
 
 static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
 {
-	int i, len;
+	int i;
+	int len;
 	const u32 *p;
 
 	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
@@ -138,9 +134,8 @@ static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
 
 static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 {
-	int rc, size;
-
-	size = BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(u32);
+	int rc;
+	int size = BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(u32);
 
 	msi_data->fsl_msi_bitmap = kzalloc(size, GFP_KERNEL);
 
@@ -238,7 +233,7 @@ out_free:
 	return rc;
 }
 
-void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
+static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq;
 	struct fsl_msi *msi_data = fsl_msi;
@@ -260,7 +255,7 @@ void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	if (unlikely(desc->status & IRQ_INPROGRESS))
 		goto unlock;
 
-	msir_index = (int)(desc->handler_data);
+	msir_index = (int)desc->handler_data;
 
 	if (msir_index >= NR_MSI_REG)
 		cascade_irq = NO_IRQ;
@@ -280,12 +275,12 @@ void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		intr_index = ffs(msir_value) - 1;
 
 		cascade_irq = irq_linear_revmap(msi_data->irqhost,
-				(msir_index * IRQS_PER_MSI_REG +
-					intr_index + have_shift));
+				msir_index * IRQS_PER_MSI_REG +
+					intr_index + have_shift);
 		if (cascade_irq != NO_IRQ)
 			generic_handle_irq(cascade_irq);
-		have_shift += (intr_index + 1);
-		msir_value = (msir_value >> (intr_index + 1));
+		have_shift += intr_index + 1;
+		msir_value = msir_value >> (intr_index + 1);
 	}
 	desc->status &= ~IRQ_INPROGRESS;
 
@@ -311,7 +306,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	int rc;
 	int virt_msir;
 	const u32 *p;
-	struct fsl_msi_feature *tmp_data;
+	struct fsl_msi_feature *features = match->data;
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
@@ -348,14 +343,12 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		goto error_out;
 	}
 
-	tmp_data = (struct fsl_msi_feature *)match->data;
-
-	msi->feature = tmp_data->fsl_pic_ip;
+	msi->feature = features->fsl_pic_ip;
 
 	msi->irqhost->host_data = msi;
 
 	msi->msi_addr_hi = 0x0;
-	msi->msi_addr_lo = res.start + tmp_data->msiir_offset;
+	msi->msi_addr_lo = res.start + features->msiir_offset;
 
 	rc = fsl_msi_init_allocator(msi);
 	if (rc) {
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 52a5f7f..489ca5a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -106,15 +106,15 @@ void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }
 
-#ifdef CONFIG_PCI_MSI
-void __init setup_pci_pcsrbar(struct pci_controller *hose)
+static void __init setup_pci_pcsrbar(struct pci_controller *hose)
 {
+#ifdef CONFIG_PCI_MSI
 	phys_addr_t immr_base;
 
 	immr_base = get_immrbase();
 	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, immr_base);
-}
 #endif
+}
 
 static int fsl_pcie_bus_fixup;
 
@@ -222,9 +222,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	setup_pci_atmu(hose, &rsrc);
 
 	/* Setup PEXCSRBAR */
-#ifdef CONFIG_PCI_MSI
 	setup_pci_pcsrbar(hose);
-#endif
 	return 0;
 }
 
-- 
1.5.5.1
