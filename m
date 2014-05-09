Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420F1140108
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:50 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0E6002CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497SPeH5505434
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497njq5031968
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 03/10] powerpc/eeh: Search EEH device by guest address
Date: Fri,  9 May 2014 17:49:35 +1000
Message-Id: <1399621782-23281-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces function eeh_vfio_dev_get() to search the EEH
device according to its guest address, which is made up of PHB BUID,
bus, slot and function number. The function is useful in the backends
for EEH RTAS emulation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  5 +++++
 arch/powerpc/kernel/eeh_pe.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3268692..8ffaf39 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -381,6 +381,11 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
+
+#ifdef CONFIG_VFIO_EEH
+struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
+#endif /* CONFIG_VFIO_EEH */
+
 #ifdef CONFIG_PPC64
 /*
  * MMIO read/write operations with EEH support.
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..d09f055 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -248,6 +248,48 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 	return pe;
 }
 
+#ifdef CONFIG_VFIO_EEH
+static void *__eeh_vfio_dev_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_vfio_pci_addr *addr = (struct eeh_vfio_pci_addr *)flag;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!eeh_dev_passed(edev))
+			continue;
+
+		/* Comparing the address in the guest */
+		if (addr->buid == edev->gaddr.buid &&
+		    addr->bdn  == edev->gaddr.bdn)
+			return edev;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_vfio_dev_get - Search EEH device based on guest's address
+ * @addr: EEH device guest address
+ *
+ * Search the EEH device according to its guest's address, which
+ * is made up of PHB BUID, and PCI config address.
+ */
+struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr)
+{
+	struct eeh_pe *root;
+	struct eeh_dev *edev;
+
+	list_for_each_entry(root, &eeh_phb_pe, child) {
+		edev = eeh_pe_traverse(root, __eeh_vfio_dev_get, addr);
+		if (edev)
+			return edev;
+	}
+
+	return NULL;
+}
+#endif /* CONFIG_VFIO_EEH */
+
 /**
  * eeh_pe_get_parent - Retrieve the parent PE
  * @edev: EEH device
-- 
1.8.3.2
