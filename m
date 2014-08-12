Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 014D81A15E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:02:59 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 06/20] PCI/MSI: Introduce arch_get_match_msi_chip() to
 find the match msi_chip
Date: Tue, 12 Aug 2014 15:25:59 +0800
Message-ID: <1407828373-24322-7-git-send-email-wangyijing@huawei.com>
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

Introduce __weak arch_get_match_msi_chip() to find the match msi_chip.
We prepare to use struct msi_chip to eliminate arch_xxx functions
in all platforms. The MSI device and the msi_chip binding is platform
specific. For instance, in x86, LAPICs receive all MSI irq, but in
arm, PCI device usually deliver their MSI to PCI hostbridge, if more
than one msi_chip found in system, DTS file will report the binding
between MSI devices and target msi_chip. So we need a platform implemented
interface to do that.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7b7abe9..feba5dd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -29,10 +29,22 @@ static int pci_msi_enable = 1;
 
 /* Arch hooks */
 
-int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+struct msi_chip * __weak arch_get_match_msi_chip(struct device *dev)
+{
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct msi_chip *chip = pdev->bus->msi;
+
+		return chip;
+	}
+
+	return NULL;
+}
+
+int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_chip *chip = dev->bus->msi;
 	int err;
+	struct msi_chip *chip = arch_get_match_msi_chip(&dev->dev);
 
 	if (!chip || !chip->setup_irq)
 		return -EINVAL;
@@ -46,7 +58,8 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 
 void __weak arch_teardown_msi_irq(unsigned int irq)
 {
-	struct msi_chip *chip = irq_get_chip_data(irq);
+	struct msi_desc *entry = irq_get_msi_desc(irq);
+	struct msi_chip *chip = arch_get_match_msi_chip(&entry->dev->dev);
 
 	if (!chip || !chip->teardown_irq)
 		return;
@@ -56,7 +69,7 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
 
 int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 {
-	struct msi_chip *chip = dev->bus->msi;
+	struct msi_chip *chip = arch_get_match_msi_chip(&dev->dev);
 
 	if (!chip || !chip->check_device)
 		return 0;
@@ -68,7 +81,12 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
+	struct msi_chip *chip;
 
+	chip = arch_get_match_msi_chip(&dev->dev);
+	if (chip && chip->setup_irqs)
+		return chip->setup_irqs(&dev->dev, nvec, type);
+
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
 	 * override arch_setup_msi_irqs()
@@ -133,6 +151,10 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 
 void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_chip *chip = arch_get_msi_chip(&dev->dev);
+	if (chip && chip->restore_irqs)
+		return chip->restore_irqs(&dev->dev);
+
 	return default_restore_msi_irqs(dev);
 }
 
-- 
1.7.1
