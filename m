Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F6E62C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 12:57:45 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 20:57:42 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EE0F61FF001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 20:52:22 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r652vemv154476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 20:57:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r652vddu009818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 20:57:40 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc/pci: Override pcibios_stop_dev()
Date: Fri,  5 Jul 2013 10:57:29 +0800
Message-Id: <1372993054-25730-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch overrides the weak function pcibios_stop_dev() to destroy
the EEH device and cache while stopping and removing the corresponding
PCI device.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 3f60880..617d2df 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -22,6 +22,18 @@
 #include <asm/eeh.h>
 
 /**
+ * pcibios_stop_dev - stop the PCI device
+ * @dev: the indicated PCI device
+ *
+ * Stop the PCI device. The function should be called before
+ * stopping the specified PCI device.
+ */
+void pcibios_stop_dev(struct pci_dev *dev)
+{
+	eeh_remove_device(dev, 1);
+}
+
+/**
  * __pcibios_remove_pci_devices - remove all devices under this bus
  * @bus: the indicated PCI bus
  * @purge_pe: destroy the PE on removal of PCI devices
@@ -45,7 +57,6 @@ void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe)
 		 pci_domain_nr(bus),  bus->number);
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
 		pr_debug("     * Removing %s...\n", pci_name(dev));
-		eeh_remove_bus_device(dev, purge_pe);
 		pci_stop_and_remove_bus_device(dev);
 	}
 }
-- 
1.7.5.4
