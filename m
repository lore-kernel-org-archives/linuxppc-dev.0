Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FC11A0C41
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:46 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5B2002CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:43 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsZPt21692502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:43 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23NsA4W026114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:11 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v15 02/12] PCI: Add pcibios_bus_add_device() weak function
Date: Fri,  4 Mar 2016 10:53:04 +1100
Message-Id: <1457049194-9281-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

This adds weak function pcibios_bus_add_device() for arch dependent
code could do proper setup. For example, powerpc could setup EEH
related resources for SRIOV VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c   | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 89b3bef..6469ff6 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -271,6 +271,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
+
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -285,6 +287,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
 	 */
+	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3db5e30..bc435d62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -770,6 +770,7 @@ extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
+void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
-- 
2.1.0
