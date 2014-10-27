Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 301721A0063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 23:43:54 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 13/16] IA64/MSI: Use MSI controller framework to configure
 MSI/MSI-X irq
Date: Mon, 27 Oct 2014 21:22:19 +0800
Message-ID: <1414416142-31239-14-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
References: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Sergei
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

Use MSI controller framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/include/asm/pci.h |    3 ++-
 arch/ia64/kernel/msi_ia64.c |   24 ++++++++++++++++++------
 arch/ia64/pci/pci.c         |    1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 52af5ed..805bbc3 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -93,7 +93,7 @@ struct pci_controller {
 	void *iommu;
 	int segment;
 	int node;		/* nearest node with memory or NUMA_NO_NODE for global allocation */
-
+	struct msi_controller *msi_ctrl;
 	void *platform_data;
 };
 
@@ -101,6 +101,7 @@ struct pci_controller {
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
 #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
 
+extern struct msi_controller ia64_msi_ctrl;
 extern struct pci_ops pci_root_ops;
 
 static inline int pci_proc_domain(struct pci_bus *bus)
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index 8c3730c..b92b8e2 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -42,7 +42,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 }
 #endif /* CONFIG_SMP */
 
-int ia64_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int __ia64_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct msi_msg	msg;
 	unsigned long	dest_phys_id;
@@ -77,7 +77,7 @@ int ia64_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	return 0;
 }
 
-void ia64_teardown_msi_irq(unsigned int irq)
+void __ia64_teardown_msi_irq(unsigned int irq)
 {
 	destroy_irq(irq);
 }
@@ -111,23 +111,35 @@ static struct irq_chip ia64_msi_chip = {
 	.irq_retrigger		= ia64_msi_retrigger_irq,
 };
 
+struct msi_controller *pcibios_msi_controller(struct pci_bus *bus)
+{
+	struct pci_controller *ctrl = bus->sysdata;
+
+	return ctrl->msi_ctrl;
+}
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int ia64_setup_msi_irq(struct msi_controller *ctrl,
+		struct pci_dev *pdev, struct msi_desc *desc)
 {
 	if (platform_setup_msi_irq)
 		return platform_setup_msi_irq(pdev, desc);
 
-	return ia64_setup_msi_irq(pdev, desc);
+	return __ia64_setup_msi_irq(pdev, desc);
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void ia64_teardown_msi_irq(struct msi_controller *ctrl, unsigned int irq)
 {
 	if (platform_teardown_msi_irq)
 		return platform_teardown_msi_irq(irq);
 
-	return ia64_teardown_msi_irq(irq);
+	return __ia64_teardown_msi_irq(irq);
 }
 
+struct msi_controller ia64_msi_ctrl = {
+	.setup_irq = ia64_setup_msi_irq,
+	.teardown_irq = ia64_teardown_msi_irq,
+};
+
 #ifdef CONFIG_INTEL_IOMMU
 #ifdef CONFIG_SMP
 static int dmar_msi_set_affinity(struct irq_data *data,
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 291a582..875f46a 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -437,6 +437,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	controller->companion = device;
 	controller->node = acpi_get_node(device->handle);
+	controller->msi_ctrl = &ia64_msi_ctrl;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-- 
1.7.1
