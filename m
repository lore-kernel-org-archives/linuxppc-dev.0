Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0ACC1A09CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 23:43:59 +1100 (AEDT)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 01/16] PCI/MSI: Refactor MSI controller to make it become more
 common
Date: Mon, 27 Oct 2014 21:22:07 +0800
Message-ID: <1414416142-31239-2-git-send-email-wangyijing@huawei.com>
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

Now there are a lot of weak arch MSI functions in MSI code.
These functions make MSI driver complex. Because people need
to know much which arch MSI function should be overrode and
which is not. Thierry introduced MSI chip framework to configure
MSI/MSI-X irq in arm. MSI chip framework is better than raw arch
MSI functions, people can clearly know they should implement which
MSI ops in specific platform. Use MSI chip framework to refactor all
other platform MSI code to eliminate weak arch MSI functions.
This patch add .restore_irqs(), .teardown_irqs() and .setup_irqs()
to make it become more common.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/msi.c   |   15 +++++++++++++++
 include/linux/msi.h |    8 ++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 27b6a54..0e1da3e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -70,6 +70,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
+	struct msi_controller *ctrl;
+
+	ctrl = pci_msi_controller(dev->bus);
+	if (ctrl && ctrl->setup_irqs)
+		return ctrl->setup_irqs(ctrl, dev, nvec, type);
 
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
@@ -112,6 +117,11 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
 
 void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_controller *ctrl = pci_msi_controller(dev->bus);
+
+	if (ctrl && ctrl->teardown_irqs)
+		return ctrl->teardown_irqs(ctrl, dev);
+
 	return default_teardown_msi_irqs(dev);
 }
 
@@ -135,6 +145,11 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 
 void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_controller *ctrl = pci_msi_controller(dev->bus);
+
+	if (ctrl && ctrl->restore_irqs)
+             return ctrl->restore_irqs(ctrl, dev);
+
 	return default_restore_msi_irqs(dev);
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6704991..4426cb4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -71,9 +71,13 @@ struct msi_controller {
 	struct device_node *of_node;
 	struct list_head list;
 
-	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
+	int (*setup_irq)(struct msi_controller *ctrl, struct pci_dev *dev,
 			 struct msi_desc *desc);
-	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
+	int (*setup_irqs)(struct msi_controller *ctrl, struct pci_dev *dev,
+			int nvec, int type);
+	void (*teardown_irq)(struct msi_controller *ctrl, unsigned int irq);
+	void (*teardown_irqs)(struct msi_controller *ctrl, struct pci_dev *dev);
+	void (*restore_irqs)(struct msi_controller *ctrl, struct pci_dev *dev);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
