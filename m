Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw07t5NGFzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:46:18 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 18:16:16 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3RCkFrr20578720
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:16:15 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3RCk89e026506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 18:16:12 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 alistair@popple.id.au, ruscur@russell.cc,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 3/5] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
 supports IRQ remapping
Date: Wed, 27 Apr 2016 20:43:28 +0800
Message-Id: <1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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
