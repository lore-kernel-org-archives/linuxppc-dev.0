Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 691EE2C009D
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:40 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 04:44:37 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A390CC9003C
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 04:44:34 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iYvU128986
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iXj0002571
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 05:44:34 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/22] ppc/eeh: Search PE based on requirement
Date: Sat,  8 Sep 2012 16:44:08 +0800
Message-Id: <1347093863-6319-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements searching PE based on the following
requirements:

 * Search PE according to PE address, which is traditional
   PE address that is composed of PCI bus/device/function
   number, or unified PE address assigned by firmware or
   platform.
 * Search parent PE according to the given EEH device. It's
   useful when creating new PE and put it into right position.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |  143 +++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7b9c7d6..1cc1388 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -164,6 +164,7 @@ static inline void eeh_unlock(void)
  */
 #define EEH_MAX_ALLOWED_FREEZES 5
 
+typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 535788e..6b53fb8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -118,3 +118,146 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 
 	return NULL;
 }
+
+/**
+ * eeh_pe_next - Retrieve the next PE in the tree
+ * @pe: current PE
+ * @root: root PE
+ *
+ * The function is used to retrieve the next PE in the
+ * hierarchy PE tree.
+ */
+static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
+				  struct eeh_pe *root)
+{
+	struct list_head *next = pe->child_list.next;
+
+	if (next == &pe->child_list) {
+		while (1) {
+			if (pe == root)
+				return NULL;
+			next = pe->child.next;
+			if (next != &pe->parent->child_list)
+				break;
+			pe = pe->parent;
+		}
+	}
+
+	return list_entry(next, struct eeh_pe, child);
+}
+
+/**
+ * eeh_pe_traverse - Traverse PEs in the specified PHB
+ * @root: root PE
+ * @fn: callback
+ * @flag: extra parameter to callback
+ *
+ * The function is used to traverse the specified PE and its
+ * child PEs. The traversing is to be terminated once the
+ * callback returns something other than NULL, or no more PEs
+ * to be traversed.
+ */
+static void *eeh_pe_traverse(struct eeh_pe *root,
+			eeh_traverse_func fn, void *flag)
+{
+	struct eeh_pe *pe;
+	void *ret;
+
+	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		ret = fn(pe, flag);
+		if (ret) return ret;
+	}
+
+	return NULL;
+}
+
+/**
+ * __eeh_pe_get - Check the PE address
+ * @data: EEH PE
+ * @flag: EEH device
+ *
+ * For one particular PE, it can be identified by PE address
+ * or tranditional BDF address. BDF address is composed of
+ * Bus/Device/Function number. The extra data referred by flag
+ * indicates which type of address should be used.
+ */
+static void *__eeh_pe_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_dev *edev = (struct eeh_dev *)flag;
+
+	/* Unexpected PHB PE */
+	if (pe->type == EEH_PE_PHB)
+		return NULL;
+
+	/* We prefer PE address */
+	if (edev->pe_config_addr &&
+	   (edev->pe_config_addr == pe->addr))
+		return pe;
+
+	/* Try BDF address */
+	if (edev->pe_config_addr &&
+	   (edev->config_addr == pe->config_addr))
+		return pe;
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_get - Search PE based on the given address
+ * @edev: EEH device
+ *
+ * Search the corresponding PE based on the specified address which
+ * is included in the eeh device. The function is used to check if
+ * the associated PE has been created against the PE address. It's
+ * notable that the PE address has 2 format: traditional PE address
+ * which is composed of PCI bus/device/function number, or unified
+ * PE address.
+ */
+static struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
+{
+	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
+	struct eeh_pe *pe;
+
+	eeh_lock();
+	pe = eeh_pe_traverse(root, __eeh_pe_get, edev);
+	eeh_unlock();
+
+	return pe;
+}
+
+/**
+ * eeh_pe_get_parent - Retrieve the parent PE
+ * @edev: EEH device
+ *
+ * The whole PEs existing in the system are organized as hierarchy
+ * tree. The function is used to retrieve the parent PE according
+ * to the parent EEH device.
+ */
+static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
+{
+	struct device_node *dn;
+	struct eeh_dev *parent;
+
+	/*
+	 * It might have the case for the indirect parent
+	 * EEH device already having associated PE, but
+	 * the direct parent EEH device doesn't have yet.
+	 */
+	dn = edev->dn->parent;
+	while (dn) {
+		/* We're poking out of PCI territory */
+		if (!PCI_DN(dn)) return NULL;
+
+		parent = of_node_to_eeh_dev(dn);
+		/* We're poking out of PCI territory */
+		if (!parent) return NULL;
+
+		if (parent->pe)
+			return parent->pe;
+
+		dn = dn->parent;
+	}
+
+	return NULL;
+}
-- 
1.7.5.4
