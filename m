Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF91F1A040C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:26:15 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 13/27] x86/xen/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Date: Wed, 15 Oct 2014 11:07:01 +0800
Message-ID: <1413342435-7876-14-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Liviu Dudau <liviu@dudau.co.uk>,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
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
Acked-by: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |   58 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index e5b8b78..75067ca 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,7 +157,8 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
-static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
 	struct msi_desc *msidesc;
@@ -219,7 +220,8 @@ static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 	msg->data = XEN_PIRQ_MSI_DATA;
 }
 
-static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_hvm_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, pirq;
 	struct msi_desc *msidesc;
@@ -267,7 +269,8 @@ error:
 #ifdef CONFIG_XEN_DOM0
 static bool __read_mostly pci_seg_supported = true;
 
-static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_initdom_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int ret = 0;
 	struct msi_desc *msidesc;
@@ -349,7 +352,8 @@ out:
 	return ret;
 }
 
-static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
+static void xen_initdom_restore_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev)
 {
 	int ret = 0;
 
@@ -376,7 +380,13 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
-static void xen_teardown_msi_irqs(struct pci_dev *dev)
+static void xen_teardown_msi_irq(struct msi_chip *chip, unsigned int irq)
+{
+	xen_destroy_irq(irq);
+}
+
+static void xen_teardown_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
 
@@ -386,14 +396,22 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	else
 		xen_pci_frontend_disable_msi(dev);
 
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
-}
+	list_for_each_entry(msidesc, &dev->msi_list, list) {
+		int i, nvec;
+		if (msidesc->irq == 0)
+			continue;
+		if (msidesc->nvec_used)
+			nvec = msidesc->nvec_used;
+		else
+			nvec = 1 << msidesc->msi_attrib.multiple;
+		for (i = 0; i < nvec; i++)
+			xen_teardown_msi_irq(chip, msidesc->irq + i);
+	}
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	xen_destroy_irq(irq);
 }
+
+struct msi_chip xen_msi_chip;
+
 #endif
 
 int __init pci_xen_init(void)
@@ -414,9 +432,9 @@ int __init pci_xen_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
+	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -436,8 +454,9 @@ int __init pci_xen_hvm_init(void)
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
@@ -494,9 +513,10 @@ int __init pci_xen_initial_domain(void)
 	int irq;
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_initdom_setup_msi_irqs;
+	xen_msi_chip.teardown_irq = xen_teardown_msi_irq;
+	xen_msi_chip.restore_irqs = xen_initdom_restore_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
-- 
1.7.1
