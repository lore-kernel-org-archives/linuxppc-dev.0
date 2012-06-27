Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47E491007D5
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:17:25 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:17:22 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2B8FDC4085F
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:02:27 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2GAL137074
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG271F004379
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:07 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/21] ppc/eeh: Search PE based on requirement
Date: Thu, 28 Jun 2012 00:01:37 +0800
Message-Id: <1340812911-6793-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/eeh_pe.c |  146 +++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

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
index 20d65dc..f019953 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -101,3 +101,149 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 	return NULL;
 }
 
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
+	    (edev->pe_config_addr == pe->addr))
+		return pe;
+
+	/* Try BDF address */
+	if (edev->pe_config_addr &&
+	    (edev->config_addr == pe->config_addr))
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
+		if (!PCI_DN(dn))
+			return NULL;
+
+		parent = of_node_to_eeh_dev(dn);
+
+		/* We're poking out of PCI territory */
+		if (!parent)
+			return NULL;
+
+		if (parent->pe)
+			return parent->pe;
+
+		dn = dn->parent;
+	}
+
+	return NULL;
+}
+
-- 
1.7.9.5
