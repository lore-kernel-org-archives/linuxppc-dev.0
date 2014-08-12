Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F68B1A171D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:03:16 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 15/20] s390/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Date: Tue, 12 Aug 2014 15:26:08 +0800
Message-ID: <1407828373-24322-16-git-send-email-wangyijing@huawei.com>
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

Introduce a new struct msi_chip zpci_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/s390/pci/pci.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9ddc51e..ee7b05c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -398,8 +398,9 @@ static void zpci_irq_handler(struct airq_struct *airq)
 	}
 }
 
-int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+int zpci_setup_msi_irqs(struct device *dev, int nvec, int type)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = get_zdev(pdev);
 	unsigned int hwirq, msi_vecs;
 	unsigned long aisb;
@@ -474,8 +475,9 @@ out:
 	return rc;
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *pdev)
+void zpci_teardown_msi_irqs(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = get_zdev(pdev);
 	struct msi_desc *msi;
 	int rc;
@@ -501,6 +503,16 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
 }
 
+struct msi_chip zpci_msi_chip = {
+	.setup_irqs = zpci_setup_msi_irqs,
+	.teardown_irqs = zpci_teardown_msi_irqs,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &zpci_msi_chip;
+}
+
 static void zpci_map_resources(struct zpci_dev *zdev)
 {
 	struct pci_dev *pdev = zdev->pdev;
-- 
1.7.1
