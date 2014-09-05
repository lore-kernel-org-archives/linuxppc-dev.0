Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25D081A0BB1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 19:46:10 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Fri, 5 Sep 2014 18:09:53 +0800
Message-ID: <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
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
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 84c2fce..e669ee4 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -376,6 +376,11 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
+static void xen_teardown_msi_irq(unsigned int irq)
+{
+	xen_destroy_irq(irq);
+}
+
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
@@ -385,19 +390,26 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
-
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
-}
-
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	xen_destroy_irq(irq);
+
+	list_for_each_entry(msidesc, &dev->msi_list, list) {
+		int i, nvec;
+		if (msidesc->irq == 0)
+			continue;
+		if (msidesc->nvec_used)
+			nvec = msidesc->nvec_used;
+		else
+			nvec = 1 << msidesc->msi_attrib.multiple;
+		for (i = 0; i < nvec; i++)
+			xen_teardown_msi_irq(msidesc->irq + i);
+	}
 }
 
 void xen_nop_msi_mask(struct irq_data *data)
 {
 }
+
+struct msi_chip xen_msi_chip;
+
 #endif
 
 int __init pci_xen_init(void)
@@ -418,9 +430,9 @@ int __init pci_xen_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
+	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	msi_chip.irq_mask = xen_nop_msi_mask;
 	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
@@ -441,8 +453,9 @@ int __init pci_xen_hvm_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_msi_chip.setup_irqs = xen_hvm_setup_msi_irqs;
+	xen_msi_chip.teardown_irq = xen_teardown_msi_irq;
+	x86_msi_chip = &xen_msi_chip;
 #endif
 	return 0;
 }
@@ -499,9 +512,10 @@ int __init pci_xen_initial_domain(void)
 	int irq;
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_initdom_setup_msi_irqs;
+	xen_msi_chip.teardown_irq = xen_teardown_msi_irq;
+	xen_msi_chip.restore_irqs = xen_initdom_restore_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	msi_chip.irq_mask = xen_nop_msi_mask;
 	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
-- 
1.7.1
