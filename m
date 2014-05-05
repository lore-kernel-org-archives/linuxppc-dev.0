Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D9B6A140172
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:56 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 916162CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516cpG1638820
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RrQi011654
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 05/22] powerpc/eeh: Release VFIO dev on VM destruction
Date: Mon,  5 May 2014 11:27:54 +1000
Message-Id: <1399253291-3975-6-git-send-email-gwshan@linux.vnet.ibm.com>
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

When the VM is destroyed, the EEH devices and PEs that have been
marked as being owned by guest should be returned to host. The
patch introduces kvmppc_vfio_pci_free() to do it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  6 +++++-
 arch/powerpc/kernel/eeh_pe.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c   |  2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3807167..677c719 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -380,6 +380,8 @@ static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
 
 static inline void eeh_remove_device(struct pci_dev *dev) { }
 
+static inline void kvmppc_eeh_vfio_release(struct kvm *kvm) { }
+
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
@@ -388,7 +390,9 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 #ifdef CONFIG_KVM_EEH
 struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
 struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr);
-
+void kvmppc_eeh_vfio_release(struct kvm *kvm);
+#else
+static inline void kvmppc_eeh_vfio_release(void *kvm) { };
 #endif /* CONFIG_KVM_EEH */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 1bd7b1f..9e73188 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -331,6 +331,48 @@ struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr)
 
 	return NULL;
 }
+
+static void *__kvmppc_eeh_vfio_release(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct kvm *kvm = (struct kvm *)flag;
+	struct eeh_dev *edev, *tmp;
+
+	if (!eeh_pe_passed(pe))
+		return NULL;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!eeh_dev_passed(edev))
+			continue;
+
+		if (edev->gaddr.kvm == kvm)
+			eeh_dev_set_passed(edev, false);
+	}
+
+	eeh_pe_set_passed(pe, false);
+
+	return NULL;
+}
+
+/**
+ * kvmppc_eeh_vfio_release - Release VFIO devices for the given VM
+ * @kvm: VM indicator
+ *
+ * The function is expected to be called while the VM is destroyed.
+ * In turn, the PCI devices that have been passed to that VM should
+ * be released and their address mapping maintained will be destroyed.
+ */
+void kvmppc_eeh_vfio_release(struct kvm *kvm)
+{
+	struct eeh_pe *root;
+	void *ret;
+
+	list_for_each_entry(root, &eeh_phb_pe, child) {
+		ret = eeh_pe_traverse(root, __kvmppc_eeh_vfio_release, kvm);
+		if (ret) return;
+	}
+}
+EXPORT_SYMBOL_GPL(kvmppc_eeh_vfio_release);
 #endif /* CONFIG_KVM_EEH */
 
 /**
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8227dba..f07a12d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -49,6 +49,7 @@
 #include <asm/hvcall.h>
 #include <asm/switch_to.h>
 #include <asm/smp.h>
+#include <asm/eeh.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
@@ -2344,6 +2345,7 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 		kvm->arch.rma = NULL;
 	}
 
+	kvmppc_eeh_vfio_release(kvm);
 	kvmppc_free_hpt(kvm);
 }
 
-- 
1.8.3.2
