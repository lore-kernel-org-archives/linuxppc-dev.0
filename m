Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQKQ4ldMzDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:14 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 21:05:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2C7A72CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IB51lh23724202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:05:10 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IB4arJ013497
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:04:37 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 08/10] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
 supports IRQ remapping
Date: Mon, 18 Apr 2016 19:04:01 +0800
Message-Id: <1460977443-29405-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On ARM HW the capability of IRQ remapping is abstracted on
MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
this [1].

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when MSI_FLAG_IRQ_REMAPPING is set.

[1] http://www.spinics.net/lists/kvm/msg130256.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/msi.c   |   12 ++++++++++++
 drivers/pci/probe.c |    3 +++
 include/linux/msi.h |    6 +++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..1661cdf 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1134,6 +1134,18 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 }
 EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
 
+void pci_bus_check_msi_remapping(struct pci_bus *bus,
+				 struct irq_domain *domain)
+{
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	struct msi_domain_info *info;
+
+	info = msi_get_domain_info(domain);
+	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
+		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+#endif
+}
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 /**
  * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..25cf1b1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -696,6 +696,9 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	if (!d)
 		d = pci_host_bridge_msi_domain(b);
 
+	if (d && b == bus)
+		pci_bus_check_msi_remapping(bus, d);
+
 	dev_set_msi_domain(&bus->dev, d);
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 03eda72..b4c649e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -15,6 +15,8 @@ extern int pci_msi_ignore_mask;
 struct irq_data;
 struct msi_desc;
 struct pci_dev;
+struct pci_bus;
+struct irq_domain;
 struct platform_msi_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -155,6 +157,9 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
+void pci_bus_check_msi_remapping(struct pci_bus *bus,
+				 struct irq_domain *domain);
+
 struct msi_controller {
 	struct module *owner;
 	struct device *dev;
@@ -173,7 +178,6 @@ struct msi_controller {
 #include <linux/irqhandler.h>
 #include <asm/msi.h>
 
-struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
 struct device_node;
-- 
1.7.9.5
