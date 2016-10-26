Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3gj24kvtzDt2G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 17:53:42 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9Q6mU2f085992
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26ajdyq3b4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:40 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 26 Oct 2016 02:53:39 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [RFC PATCH v7 2/3] PCI: Restore resource's size if we expand it by
 using resource_alignment
Date: Wed, 26 Oct 2016 14:53:32 +0800
In-Reply-To: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1477464813-2499-3-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using resource_alignment kernel parameter, the current implement
reassigns the alignment by changing resources' size which can
potentially break some drivers. For example, the driver uses the size
to locate some register whose length is related to the size.

This saves the increased sizes in pci_reassigndev_resource_alignment()
and restores to original sizes after PCI resource sizing/assigning are
done.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       |    1 +
 drivers/pci/setup-bus.c |   19 +++++++++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9a30832..2933c81 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5130,6 +5130,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 		size = resource_size(r);
 		if (size < align) {
+			dev->bars_addsize[i] = align - size;
 			size = align;
 			dev_info(&dev->dev,
 				"Rounding up size of resource #%d to %#llx.\n",
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f30ca75..12f0e2b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1387,6 +1387,24 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 	}
 }
 
+static inline void pdev_restore_resource_sizes(struct pci_dev *dev)
+{
+	struct resource *r;
+	int i;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		r = &dev->resource[i];
+		if (r->flags & IORESOURCE_UNSET)
+			continue;
+
+		if (!dev->bars_addsize[i])
+			continue;
+
+		r->end -= dev->bars_addsize[i];
+		dev->bars_addsize[i] = 0;
+	}
+}
+
 void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head)
@@ -1398,6 +1416,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_assign_fixed_resources(dev);
+		pdev_restore_resource_sizes(dev);
 
 		b = dev->subordinate;
 		if (!b)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..a60e8c5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,7 @@ struct pci_dev {
 	unsigned int	irq;
 	struct cpumask	*irq_affinity;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	resource_size_t bars_addsize[PCI_ROM_RESOURCE + 1];
 
 	bool match_driver;		/* Skip attaching driver */
 	/* These fields are used by common fixups */
-- 
1.7.9.5
