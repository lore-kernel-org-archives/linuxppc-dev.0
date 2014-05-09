Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8867140108
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:50 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EB0E93578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497SYn632833636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497nj4U021225
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 04/10] powerpc/eeh: Search EEH PE by guest address
Date: Fri,  9 May 2014 17:49:36 +1000
Message-Id: <1399621782-23281-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces function eeh_vfio_pe_get() to search the EEH
PE according to its guest address, which is made up of PHB ID and
PE configuration address. The function will be useful in backends
for EEH RTAS emulation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/eeh_pe.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8ffaf39..750e028 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -384,6 +384,7 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 
 #ifdef CONFIG_VFIO_EEH
 struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
+struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr);
 #endif /* CONFIG_VFIO_EEH */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index d09f055..8dc58ac 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -288,6 +288,44 @@ struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr)
 
 	return NULL;
 }
+
+static void *__eeh_vfio_pe_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_vfio_pci_addr *addr = (struct eeh_vfio_pci_addr *)flag;
+
+	if (!eeh_pe_passed(pe))
+		return NULL;
+
+	/* Comparing the address */
+	if (addr->buid    == pe->gaddr.buid &&
+	    addr->pe_addr == pe->gaddr.pe_addr)
+		return pe;
+
+	return NULL;
+}
+
+/**
+ * eeh_vfio_pe_get - Search EEH PE based on guest's address
+ * @addr: EEH PE guest address
+ *
+ * Search the EEH PE according to the guest address, which
+ * is made up of VM indicator, PHB BUID, and PE configuration
+ * address.
+ */
+struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr)
+{
+	struct eeh_pe *root;
+	struct eeh_pe *pe;
+
+	list_for_each_entry(root, &eeh_phb_pe, child) {
+		pe = eeh_pe_traverse(root, __eeh_vfio_pe_get, addr);
+		if (pe)
+			return pe;
+	}
+
+	return NULL;
+}
 #endif /* CONFIG_VFIO_EEH */
 
 /**
-- 
1.8.3.2
