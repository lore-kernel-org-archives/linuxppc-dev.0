Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A61161A15E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:03:17 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 19/20] tile/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Date: Tue, 12 Aug 2014 15:26:12 +0800
Message-ID: <1407828373-24322-20-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>, "H.
 Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a new struct msi_chip tile_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/tile/kernel/pci_gx.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index e39f9c5..d1f308c 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -1485,7 +1485,7 @@ static struct irq_chip tilegx_msi_chip = {
 	/* TBD: support set_affinity. */
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int tile_setup_msi_irq(struct device *dev, struct msi_desc *desc)
 {
 	struct pci_controller *controller;
 	gxio_trio_context_t *trio_context;
@@ -1510,7 +1510,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	 * Most PCIe endpoint devices do support 64-bit message addressing.
 	 */
 	if (desc->msi_attrib.is_64 == 0) {
-		dev_printk(KERN_INFO, &pdev->dev,
+		dev_printk(KERN_INFO, dev,
 			"64-bit MSI message address not supported, "
 			"falling back to legacy interrupts.\n");
 
@@ -1549,7 +1549,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 		/* SQ regions are out, allocate from map mem regions. */
 		mem_map = gxio_trio_alloc_memory_maps(trio_context, 1, 0, 0);
 		if (mem_map < 0) {
-			dev_printk(KERN_INFO, &pdev->dev,
+			dev_printk(KERN_INFO, dev,
 				"%s Mem-Map alloc failure. "
 				"Failed to initialize MSI interrupts. "
 				"Falling back to legacy interrupts.\n",
@@ -1580,7 +1580,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 					mem_map, mem_map_base, mem_map_limit,
 					trio_context->asid);
 	if (ret < 0) {
-		dev_printk(KERN_INFO, &pdev->dev, "HV MSI config failed.\n");
+		dev_printk(KERN_INFO, dev, "HV MSI config failed.\n");
 
 		goto hv_msi_config_failure;
 	}
@@ -1604,7 +1604,17 @@ is_64_failure:
 	return ret;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void tile_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
+
+struct msi_chip tile_msi_chip = {
+	.setup_irq = tile_setup_msi_irq,
+	.teardown_irq = tile_teardown_msi_irq,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &tile_msi_chip;
+}
-- 
1.7.1
