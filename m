Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09B6F1401D9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:58 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7D7F33578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516bcq59048120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RqAh013655
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 03/22] powerpc/eeh: Search EEH device by guest address
Date: Mon,  5 May 2014 11:27:52 +1000
Message-Id: <1399253291-3975-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
device according to its guest address, which is made up of VM indicator,
PHB BUID, bus, slot and function number. The function is useful in the
backends for EEH RTAS emulation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  6 ++++++
 arch/powerpc/kernel/eeh_pe.c   | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8bfb167..b12e3e9 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -384,6 +384,12 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
+
+#ifdef CONFIG_KVM_EEH
+struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
+
+#endif /* CONFIG_KVM_EEH */
+
 #ifdef CONFIG_PPC64
 /*
  * MMIO read/write operations with EEH support.
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..dba7c82 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -248,6 +248,51 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 	return pe;
 }
 
+#ifdef CONFIG_KVM_EEH
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
+		if (addr->kvm     == edev->gaddr.kvm &&
+		    addr->buid_hi == edev->gaddr.buid_hi &&
+		    addr->buid_lo == edev->gaddr.buid_lo &&
+		    addr->bus     == edev->gaddr.bus &&
+		    addr->devfn   == edev->gaddr.devfn)
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
+#endif /* CONFIG_KVM_EEH */
+
 /**
  * eeh_pe_get_parent - Retrieve the parent PE
  * @edev: EEH device
-- 
1.8.3.2
