Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <097e3536dc91bd2d1383f34f5ae4b61b8ac41d61.1211767956.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] Rework Axon MSI setup so we can avoid freeing the irq_host
Date: Mon, 26 May 2008 12:12:30 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we do the call ot irq_of_parse_and_map() first, then we don't
need to worry about freeing the irq_host.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 8b055bc..b43defb 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -358,6 +358,13 @@ static int axon_msi_probe(struct of_device *device,
 		goto out_free_msic;
 	}
 
+	virq = irq_of_parse_and_map(dn, 0);
+	if (virq == NO_IRQ) {
+		printk(KERN_ERR "axon_msi: irq parse and map failed for %s\n",
+		       dn->full_name);
+		goto out_free_fifo;
+	}
+
 	msic->irq_host = irq_alloc_host(of_node_get(dn), IRQ_HOST_MAP_NOMAP,
 					NR_IRQS, &msic_host_ops, 0);
 	if (!msic->irq_host) {
@@ -368,13 +375,6 @@ static int axon_msi_probe(struct of_device *device,
 
 	msic->irq_host->host_data = msic;
 
-	virq = irq_of_parse_and_map(dn, 0);
-	if (virq == NO_IRQ) {
-		printk(KERN_ERR "axon_msi: irq parse and map failed for %s\n",
-		       dn->full_name);
-		goto out_free_host;
-	}
-
 	set_irq_data(virq, msic);
 	set_irq_chained_handler(virq, axon_msi_cascade);
 	pr_debug("axon_msi: irq 0x%x setup for axon_msi\n", virq);
@@ -399,8 +399,6 @@ static int axon_msi_probe(struct of_device *device,
 
 	return 0;
 
-out_free_host:
-	kfree(msic->irq_host);
 out_free_fifo:
 	dma_free_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES, msic->fifo_virt,
 			  msic->fifo_phys);
-- 
1.5.5
