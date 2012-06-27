Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77637100A94
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:06:28 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:06:25 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A387E6E80A3
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:05 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG34xb190334
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:05 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG26T5023940
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/21] ppc/eeh: create PEs duing EEH initialization
Date: Thu, 28 Jun 2012 00:01:38 +0800
Message-Id: <1340812911-6793-9-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch creates PEs and associated the newly created PEs with
it parent/silbing as well as EEH devices. It would become more
straight to trace EEH errors and recover them accordingly.

Once the EEH functionality on one PCI IOA has been enabled, we
tries to create PE against it. If there's existing PE, to which
the current PCI IOA should be attached, the existing PE will be
converted from "device" type to "bus" type accordingly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh.c    |    6 +++
 arch/powerpc/platforms/pseries/eeh_pe.c |   89 +++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1cc1388..e41107d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -166,6 +166,7 @@ static inline void eeh_unlock(void)
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
+int eeh_pe_create(struct eeh_dev *edev);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 0ba7e3b..99937da 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -895,6 +895,8 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			eeh_subsystem_enabled = 1;
 			edev->mode |= EEH_MODE_SUPPORTED;
 
+			eeh_pe_create(edev);
+
 			pr_debug("EEH: %s: eeh enabled, config=%x pe_config=%x\n",
 				 dn->full_name, edev->config_addr,
 				 edev->pe_config_addr);
@@ -908,6 +910,10 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 				/* Parent supports EEH. */
 				edev->mode |= EEH_MODE_SUPPORTED;
 				edev->config_addr = of_node_to_eeh_dev(dn->parent)->config_addr;
+				edev->pe_config_addr = of_node_to_eeh_dev(dn->parent)->pe_config_addr;
+
+				eeh_pe_create(edev);
+
 				return NULL;
 			}
 		}
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index f019953..56aab91 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -247,3 +247,92 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 	return NULL;
 }
 
+/**
+ * eeh_pe_create - Create EEH PE according to EEH device
+ * @edev: EEH device
+ *
+ * Create EEH PE according to the specified EEH device and
+ * put the EEH PE into appropriate place in the PE hierarchy
+ * tree.
+ */
+int eeh_pe_create(struct eeh_dev *edev)
+{
+	struct eeh_pe *pe, *parent;
+
+	/*
+	 * Search the PE has been existing or not according
+	 * to the PE address. If that has been existing, the
+	 * PE should be composed of PCI bus and its subordinate
+	 * components.
+	 */
+	pe = eeh_pe_get(edev);
+	if (pe) {
+		if (!edev->pe_config_addr) {
+			pr_err("%s: PE with addr 0x%x already exists\n",
+				__func__, edev->config_addr);
+			return -EEXIST;
+		}
+
+		/* Mark the PE as type of PCI bus */
+		pe->type = EEH_PE_BUS;
+		edev->pe = pe;
+
+		/* Put the edev to PE */
+		list_add_tail(&edev->list, &pe->edevs);
+
+		pr_info("EEH: Add %s to Bus PE#%x\n",
+			edev->dn->full_name, pe->addr);
+
+                return 0;
+	}
+
+	/* Create a new EEH PE */
+	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
+	if (!pe) {
+		pr_err("%s: out of memory!\n", __func__);
+		return -ENOMEM;
+	}
+	pe->addr	= edev->pe_config_addr;
+	pe->config_addr	= edev->config_addr;
+	pe->type	= EEH_PE_DEVICE;
+	pe->phb		= edev->phb;
+	INIT_LIST_HEAD(&pe->child_list);
+	INIT_LIST_HEAD(&pe->child);
+	INIT_LIST_HEAD(&pe->edevs);
+
+	/*
+	 * Put the new EEH PE into hierarchy tree. If the parent
+	 * can't be found, the newly created PE will be attached
+	 * to PHB directly. Otherwise, we have to associate the
+	 * PE with its parent.
+	 */
+	parent = eeh_pe_get_parent(edev);
+	if (!parent) {
+		parent = eeh_phb_pe_get(edev->phb);
+		if (!parent) {
+			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
+				__func__, edev->phb->global_number);
+			edev->pe = NULL;
+			kfree(pe);
+			return -EEXIST;
+		}
+
+		pe->parent = parent;
+	} else {
+		pe->parent = parent;
+	}
+
+	/*
+	 * Put the newly created PE into the child list and
+	 * link the EEH device accordingly.
+	 */
+	list_add_tail(&pe->child, &parent->child_list);
+	list_add_tail(&edev->list, &pe->edevs);
+	edev->pe = pe;
+
+        pr_info("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
+                edev->dn->full_name, pe->addr, pe->parent->addr);
+
+        return 0;
+}
+
-- 
1.7.9.5
