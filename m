Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DF681A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:56:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 14:56:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C64C92CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D4tphp44564552
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D4tQ8j027615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI: Allow registering reset method
Date: Fri, 13 Feb 2015 15:54:58 +1100
Message-Id: <1423803299-22356-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exposes function pci_dev_add_specific_reset() to allow
registering PCI device specific reset methods.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  9 ++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37f4c5d..ef811ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3534,6 +3534,70 @@ static struct pci_dev_reset_method pci_dev_reset_methods[] = {
 	}
 };
 
+static bool pci_dev_reset_match(struct pci_dev_reset_method *m,
+				u16 vendor, u16 device,
+				int (*reset)(struct pci_dev *, int))
+{
+	if (m->vendor != (u16)PCI_ANY_ID &&
+	    vendor != (u16)PCI_ANY_ID &&
+	    m->vendor != vendor)
+		return false;
+
+	if (m->device != (u16)PCI_ANY_ID &&
+	    device != (u16)PCI_ANY_ID &&
+	    m->device != device)
+		return false;
+
+	if (m->reset != reset)
+		return false;
+
+	return true;
+}
+
+int pci_dev_add_specific_reset(u16 vendor, u16 device,
+			       int (*reset)(struct pci_dev *, int))
+{
+	struct pci_dev_reset_method *m, *method;
+	int i;
+
+	/* Always expect valid handler */
+	if (!reset)
+		return -EINVAL;
+
+	method = kzalloc(sizeof(*method), GFP_KERNEL);
+	if (!method)
+		return -ENOMEM;
+
+	/* Check if we have conflicting method */
+	mutex_lock(&pci_dev_reset_mutex);
+	if (!pci_dev_reset_populated) {
+		for (i = 0; i < ARRAY_SIZE(pci_dev_reset_methods); i++) {
+			m = &pci_dev_reset_methods[i];
+			if (pci_dev_reset_match(m, vendor, device, reset))
+				goto found;
+		}
+	} else {
+		list_for_each_entry(m, &pci_dev_reset_list, node) {
+			if (pci_dev_reset_match(m, vendor, device, reset))
+				goto found;
+		}
+	}
+
+	/* Populate it */
+	method->vendor = vendor;
+	method->device = device;
+	method->reset  = reset;
+	INIT_LIST_HEAD(&method->node);
+	list_add_tail(&method->node, &pci_dev_reset_list);
+	mutex_unlock(&pci_dev_reset_mutex);
+	return 0;
+found:
+	mutex_unlock(&pci_dev_reset_mutex);
+	kfree(method);
+	return -EEXIST;
+}
+EXPORT_SYMBOL(pci_dev_add_specific_reset);
+
 static void pci_dev_populate_reset(void)
 {
 	struct pci_dev_reset_method *m;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..b98be1a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1605,6 +1605,8 @@ enum pci_fixup_pass {
 
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
+int pci_dev_add_specific_reset(u16 vendor, u16 device,
+			       int (*reset)(struct pci_dev *, int));
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 void pci_dev_specific_enable_acs(struct pci_dev *dev);
 #else
@@ -1615,6 +1617,13 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
+
+int pci_dev_add_specific_reset(u16 vendor, u16 device,
+			       int (*reset)(struct pci_dev *, int))
+{
+	return -ENOTTY;
+}
+
 static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
 #endif
 
-- 
1.8.3.2
