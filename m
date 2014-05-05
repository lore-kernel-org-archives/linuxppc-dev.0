Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1A891401B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:57 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 019673578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516cbF53412014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RrgU011461
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 04/22] powerpc/eeh: Search EEH PE by guest address
Date: Mon,  5 May 2014 11:27:53 +1000
Message-Id: <1399253291-3975-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces function eeh_vfio_pe_get() to search the EEH
PE according to its guest address, which is made up of KVM indicator,
PHB ID and PE configuration address. The function will be useful in
backends for EEH RTAS emulation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/eeh_pe.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b12e3e9..3807167 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -387,6 +387,7 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 
 #ifdef CONFIG_KVM_EEH
 struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
+struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr);
 
 #endif /* CONFIG_KVM_EEH */
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index dba7c82..1bd7b1f 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -249,6 +249,46 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 }
 
 #ifdef CONFIG_KVM_EEH
+static void *__eeh_vfio_pe_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_vfio_pci_addr *addr = (struct eeh_vfio_pci_addr *)flag;
+
+	if (!eeh_pe_passed(pe))
+		return NULL;
+
+	/* Comparing the address */
+	if (addr->kvm     == pe->gaddr.kvm &&
+	    addr->buid_hi == pe->gaddr.buid_hi &&
+	    addr->buid_lo == pe->gaddr.buid_lo &&
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
+
 static void *__eeh_vfio_dev_get(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
-- 
1.8.3.2
