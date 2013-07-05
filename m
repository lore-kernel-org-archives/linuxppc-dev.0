Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D59352C0590
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 12:59:05 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 20:59:03 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0A0D1C90073
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:58:59 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r652vcVM170706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 22:57:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r652vcFY027788
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 23:57:38 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] PCI: Add pcibios_stop_dev()
Date: Fri,  5 Jul 2013 10:57:27 +0800
Message-Id: <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gavin Shan <shangw@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When stopping and removing one specific PCI device, the platform
might need take some actions. One example is that EEH already had
eeh cache and eeh device attached to the PCI device, and we need
release eeh cache and device during the time. The patch introduces
hook pcibios_stop_dev() for the purpose.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/probe.c  |    4 ++++
 drivers/pci/remove.c |    2 ++
 include/linux/pci.h  |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 70f10fa..7167dc4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1669,6 +1669,10 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
+void __weak pcibios_stop_dev(struct pci_dev *dev)
+{
+}
+
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8fc54b7..e329efc 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -21,6 +21,8 @@ static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
 
+	pcibios_stop_dev(dev);
+
 	if (dev->is_added) {
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..40df783 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -696,6 +696,7 @@ int no_pci_devices(void);
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
+void pcibios_stop_dev(struct pci_dev *dev);
 void pcibios_fixup_bus(struct pci_bus *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture specific versions may override this (weak) */
-- 
1.7.5.4
