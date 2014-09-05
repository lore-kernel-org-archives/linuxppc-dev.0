Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78CDC1A15E1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 19:46:13 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Fri, 5 Sep 2014 18:10:00 +0800
Message-ID: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/msi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 71bd161..01781a4 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,7 +13,7 @@
 
 #include <asm/machdep.h>
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int ppc_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
@@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return ppc_md.setup_msi_irqs(dev, nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
+static void ppc_teardown_msi_irqs(struct pci_dev *dev)
 {
 	ppc_md.teardown_msi_irqs(dev);
 }
+
+static struct msi_chip ppc_msi_chip = {
+	.setup_irqs = ppc_setup_msi_irqs,
+	.teardown_irqs = ppc_teardown_msi_irqs,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &ppc_msi_chip;
+}
-- 
1.7.1
