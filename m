Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0831A0355
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:22:52 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 19 Jun 2014 17:22:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B27793578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:22:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5J7MV7432374832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:22:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5J7MkRS022864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:22:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] PCI: Make resetting secondary bus logic common
Date: Thu, 19 Jun 2014 17:22:44 +1000
Message-Id: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d92a208d086 ("powerpc/pci: Mask linkDown on resetting PCI bus")
implemented same logic (resetting PCI secondary bus by bridge's config
register PCI_BRIDGE_CTL_BUS_RESET) in PCI core and arch-dependent
code. In order to avoid the duplicate implementation introduced by the
commit, the patch puts the logic into pci_reset_secondary_bus().

That commit also missed declaring newly introduced weak function
pcibios_reset_secondary_bus() in linux/include/pci.h. The patch fixes
it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c   | 7 ++++++-
 include/linux/pci.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 63a54a3..758f1d8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3193,7 +3193,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
-void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
+void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
 
@@ -3219,6 +3219,11 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 	ssleep(1);
 }
 
+void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
+{
+	pci_reset_secondary_bus(dev);
+}
+
 /**
  * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
  * @dev: Bridge device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 466bcd1..340529d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -978,6 +978,8 @@ int pci_try_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_bus *bus);
 int pci_try_reset_bus(struct pci_bus *bus);
+void pci_reset_secondary_bus(struct pci_dev *dev);
+void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
-- 
1.8.3.2
