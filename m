Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07EF71A1735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:03:17 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 18/20] Sparc/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Date: Tue, 12 Aug 2014 15:26:11 +0800
Message-ID: <1407828373-24322-19-git-send-email-wangyijing@huawei.com>
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

Introduce a new struct msi_chip sparc_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/sparc/kernel/pci.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 857ad77..9eabd22 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -839,18 +839,18 @@ int pci_domain_nr(struct pci_bus *pbus)
 EXPORT_SYMBOL(pci_domain_nr);
 
 #ifdef CONFIG_PCI_MSI
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int sparc_setup_msi_irq(struct device *dev, struct msi_desc *desc)
 {
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
+	struct pci_pbm_info *pbm = dev->archdata.host_controller;
 	unsigned int irq;
 
 	if (!pbm->setup_msi_irq)
 		return -EINVAL;
 
-	return pbm->setup_msi_irq(&irq, pdev, desc);
+	return pbm->setup_msi_irq(&irq, to_pci_dev(dev), desc);
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void sparc_teardown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 	struct pci_dev *pdev = entry->dev;
@@ -859,6 +859,16 @@ void arch_teardown_msi_irq(unsigned int irq)
 	if (pbm->teardown_msi_irq)
 		pbm->teardown_msi_irq(irq, pdev);
 }
+
+struct msi_chip sparc_msi_chip = {
+	.setup_irq = sparc_setup_msi_irq,
+	.teardown_irq = sparc_teardown_msi_irq,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &sparc_msi_chip;
+}
 #endif /* !(CONFIG_PCI_MSI) */
 
 static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
-- 
1.7.1
