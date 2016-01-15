Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03541A072C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:08:46 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 17:08:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4D0523578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:08:43 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F78ZfJ56164356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:08:43 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F78A8O023985
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:08:11 +1100
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 3/5] PCI: Add host bridge attribute to indicate
 filtering of MSIs is supported
Date: Fri, 15 Jan 2016 15:06:12 +0800
Message-Id: <1452841574-2781-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MSI-X tables are not allowed to be mmapped in vfio-pci
driver in case that user get to touch this directly.
This will cause some performance issues when when PCI
adapters have critical registers in the same page as
the MSI-X table.

However, some kind of PCI host bridge such as IODA bridge
on Power support filtering of MSIs, which can ensure that a
given pci device can only shoot the MSIs assigned for it.
So we think it's safe to expose the MSI-X table to userspace
if filtering of MSIs is supported because the exposed MSI-X
table can't be used to do harm to other memory space.

To support this case, this patch adds a pci_host_bridge
attribute to indicate if this PCI host bridge supports
filtering of MSIs.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |    6 ++++++
 include/linux/pci.h       |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 5f4a2e0..c029267 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -96,3 +96,9 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 	res->end = region->end + offset;
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
+
+bool pci_host_bridge_msi_filtered_enabled(struct pci_dev *pdev)
+{
+	return pci_find_host_bridge(pdev->bus)->msi_filtered;
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_msi_filtered_enabled);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b640d65..b952b78 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,6 +412,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int msi_filtered:1;	/* support filtering of MSIs */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
@@ -430,6 +431,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
+bool pci_host_bridge_msi_filtered_enabled(struct pci_dev *pdev);
+
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
-- 
1.7.9.5
