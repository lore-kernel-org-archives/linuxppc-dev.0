Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A8B21A15D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:03:25 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 14/20] Powerpc/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Date: Tue, 12 Aug 2014 15:26:07 +0800
Message-ID: <1407828373-24322-15-git-send-email-wangyijing@huawei.com>
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

Introduce a new struct msi_chip ppc_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/msi.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 8bbc12d..170b02c 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,7 +13,7 @@
 
 #include <asm/machdep.h>
 
-int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
+int ppc_msi_check_device(struct device *dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
@@ -26,18 +26,29 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
 
 	if (ppc_md.msi_check_device) {
 		pr_debug("msi: Using platform check routine.\n");
-		return ppc_md.msi_check_device(dev, nvec, type);
+		return ppc_md.msi_check_device(to_pci_dev(dev), nvec, type);
 	}
 
         return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+int ppc_setup_msi_irqs(struct device *dev, int nvec, int type)
 {
-	return ppc_md.setup_msi_irqs(dev, nvec, type);
+	return ppc_md.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
+void ppc_teardown_msi_irqs(struct device *dev)
 {
-	ppc_md.teardown_msi_irqs(dev);
+	ppc_md.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+struct msi_chip ppc_msi_chip = {
+	.setup_irqs = ppc_setup_msi_irqs,
+	.teardown_irqs = ppc_teardown_msi_irqs,
+	.check_device = ppc_msi_check_device,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &ppc_msi_chip;
 }
-- 
1.7.1
