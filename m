Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f1b51505f34145d7b096fef167c14c4409f0baf6.1201240265.git.michael@ellerman.id.au>
In-Reply-To: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1201240265.git.michael@ellerman.id.au>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1201240265.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] Avoid DMA exception when using axon_msi with IOMMU
Date: Fri, 25 Jan 2008 16:59:14 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a brown-paper-bag bug in axon_msi, we pass the address of our
FIFO directly to the hardware, without DMA mapping it. This leads to
DMA exceptions if you enable MSI & the IOMMU.

The fix is to correctly DMA map the fifo, dma_alloc_coherent() does
what we want - and we need to track the virt & phys addresses.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index ea3dc8c..b9a97c4 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -65,7 +65,8 @@
 
 struct axon_msic {
 	struct irq_host *irq_host;
-	__le32 *fifo;
+	__le32 *fifo_virt;
+	dma_addr_t fifo_phys;
 	dcr_host_t dcr_host;
 	u32 read_offset;
 };
@@ -91,7 +92,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	while (msic->read_offset != write_offset) {
 		idx  = msic->read_offset / sizeof(__le32);
-		msi  = le32_to_cpu(msic->fifo[idx]);
+		msi  = le32_to_cpu(msic->fifo_virt[idx]);
 		msi &= 0xFFFF;
 
 		pr_debug("axon_msi: woff %x roff %x msi %x\n",
@@ -306,7 +307,6 @@ static int axon_msi_shutdown(struct of_device *device)
 static int axon_msi_probe(struct of_device *device,
 			  const struct of_device_id *device_id)
 {
-	struct page *page;
 	struct device_node *dn = device->node;
 	struct axon_msic *msic;
 	unsigned int virq;
@@ -338,16 +338,14 @@ static int axon_msi_probe(struct of_device *device,
 		goto out_free_msic;
 	}
 
-	page = alloc_pages_node(of_node_to_nid(dn), GFP_KERNEL,
-				get_order(MSIC_FIFO_SIZE_BYTES));
-	if (!page) {
+	msic->fifo_virt = dma_alloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
+					     &msic->fifo_phys, GFP_KERNEL);
+	if (!msic->fifo_virt) {
 		printk(KERN_ERR "axon_msi: couldn't allocate fifo for %s\n",
 		       dn->full_name);
 		goto out_free_msic;
 	}
 
-	msic->fifo = page_address(page);
-
 	msic->irq_host = irq_alloc_host(of_node_get(dn), IRQ_HOST_MAP_NOMAP,
 					NR_IRQS, &msic_host_ops, 0);
 	if (!msic->irq_host) {
@@ -370,9 +368,9 @@ static int axon_msi_probe(struct of_device *device,
 	pr_debug("axon_msi: irq 0x%x setup for axon_msi\n", virq);
 
 	/* Enable the MSIC hardware */
-	msic_dcr_write(msic, MSIC_BASE_ADDR_HI_REG, (u64)msic->fifo >> 32);
+	msic_dcr_write(msic, MSIC_BASE_ADDR_HI_REG, msic->fifo_phys >> 32);
 	msic_dcr_write(msic, MSIC_BASE_ADDR_LO_REG,
-				  (u64)msic->fifo & 0xFFFFFFFF);
+				  msic->fifo_phys & 0xFFFFFFFF);
 	msic_dcr_write(msic, MSIC_CTRL_REG,
 			MSIC_CTRL_IRQ_ENABLE | MSIC_CTRL_ENABLE |
 			MSIC_CTRL_FIFO_SIZE);
@@ -390,7 +388,8 @@ static int axon_msi_probe(struct of_device *device,
 out_free_host:
 	kfree(msic->irq_host);
 out_free_fifo:
-	__free_pages(virt_to_page(msic->fifo), get_order(MSIC_FIFO_SIZE_BYTES));
+	dma_free_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES, msic->fifo_virt,
+			  msic->fifo_phys);
 out_free_msic:
 	kfree(msic);
 out:
-- 
1.5.2.rc1.1884.g59b20
