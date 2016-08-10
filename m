Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8C8K3CGszDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:44:17 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A0hQFO094033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 20:44:15 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9puwd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 20:44:15 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 21:44:13 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2A72D1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:44:02 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A0iBTW32440618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:11 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A0iAdS006336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:10 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc: add refcount to struct pci_controller
Date: Tue,  9 Aug 2016 21:44:03 -0300
In-Reply-To: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit introduces the 'refcount' field in struct pci_controller,
along with the corresponding functions 'controller_(get|put|free)()'.

The functions 'pcibios_(alloc|free)_controller()' are modified to use
that in a backwards compatible manner. (i.e., kfree(phb) is performed
when pcibios_free_controller() is called.)

So, this patch adds the infrastructure with no functional differences
to current users of pcibios_(alloc|free)_controller().  Notably, only
the pseries platform calls pcibios_free_controller() for some purpose
other than to release the pci_controller in case of errors just after
the call to pcibios_alloc_controller() (i.e., 'goto error' scenarios).

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h | 15 +++++++++++
 arch/powerpc/kernel/pci-common.c      | 47 ++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b5e88e4..6fde0a9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
+#include <linux/kref.h>
 
 struct device_node;
 
@@ -128,9 +129,23 @@ struct pci_controller {
 	struct pci_dn *pci_data;
 #endif	/* CONFIG_PPC64 */
 
+	/*
+	 * Reference counting for the structures:
+	 * - TODO pci_dev
+	 * - TODO pci_bus
+	 * - TODO pci_dn
+	 * - TODO eeh_pe
+	 * - TODO eeh_dev
+	 */
+	struct kref refcount;
+
 	void *private_data;
 };
 
+void controller_get(struct pci_controller *phb);
+void controller_put(struct pci_controller *phb);
+void controller_free(struct kref *kref);
+
 /* These are used for config access before all the PCI probing
    has been done. */
 extern int early_read_config_byte(struct pci_controller *hose, int bus,
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 08afddf..29b37d3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -114,6 +114,8 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	phb = zalloc_maybe_bootmem(sizeof(struct pci_controller), GFP_KERNEL);
 	if (phb == NULL)
 		return NULL;
+
+	kref_init(&phb->refcount); /* use first reference for hose_list entry */
 	spin_lock(&hose_spinlock);
 	phb->global_number = get_phb_number(dev);
 	list_add_tail(&phb->list_node, &hose_list);
@@ -130,12 +132,53 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 		PHB_SET_NODE(phb, nid);
 	}
 #endif
+
+	pr_debug("PCI domain %d, phb %p, phb->is_dynamic %d\n",
+		phb->global_number, phb, phb->is_dynamic);
+
 	return phb;
 }
 EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
 
+void controller_get(struct pci_controller *phb)
+{
+	if (unlikely(!phb)) {
+		pr_warn("%s: null PHB; refcount bug!\n", __func__);
+		WARN_ON(1);
+	} else {
+		pr_debug("PCI domain %d, phb %p\n", phb->global_number, phb);
+		kref_get(&phb->refcount);
+	}
+}
+
+void controller_put(struct pci_controller *phb)
+{
+	if (unlikely(!phb)) {
+		pr_warn("%s: null PHB; refcount bug!\n", __func__);
+		WARN_ON(1);
+	} else {
+		pr_debug("PCI domain %d, phb %p\n", phb->global_number, phb);
+		kref_put(&phb->refcount, controller_free);
+	}
+}
+
+void controller_free(struct kref *kref)
+{
+	struct pci_controller *phb = container_of(kref, struct pci_controller,
+							refcount);
+
+	pr_info("%s: PCI domain: %d, phb %p, phb->is_dynamic %d\n",
+		__func__, phb->global_number, phb, phb->is_dynamic);
+
+	if (phb->is_dynamic)
+		kfree(phb);
+}
+
 void pcibios_free_controller(struct pci_controller *phb)
 {
+	pr_debug("PCI domain %d, phb %p, phb->is_dynamic %d\n",
+		phb->global_number, phb, phb->is_dynamic);
+
 	spin_lock(&hose_spinlock);
 
 	/* Clear bit of phb_bitmap to allow reuse of this PHB number. */
@@ -143,10 +186,8 @@ void pcibios_free_controller(struct pci_controller *phb)
 		clear_bit(phb->global_number, phb_bitmap);
 
 	list_del(&phb->list_node);
+	controller_put(phb);
 	spin_unlock(&hose_spinlock);
-
-	if (phb->is_dynamic)
-		kfree(phb);
 }
 EXPORT_SYMBOL_GPL(pcibios_free_controller);
 
-- 
1.8.3.1
