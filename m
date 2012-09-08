Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 248E12C0093
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:39 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 02:44:38 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2349519D803C
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 02:44:35 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iYXT260648
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 02:44:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iYhS003255
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 02:44:34 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/22] ppc/eeh: create PEs duing EEH initialization
Date: Sat,  8 Sep 2012 16:44:09 +0800
Message-Id: <1347093863-6319-9-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/eeh.c    |    6 ++
 arch/powerpc/platforms/pseries/eeh_pe.c |   80 +++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1cc1388..6b13790 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -166,6 +166,7 @@ static inline void eeh_unlock(void)
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
+int eeh_add_to_parent_pe(struct eeh_dev *edev);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 0ba7e3b..8f214906 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -895,6 +895,8 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			eeh_subsystem_enabled = 1;
 			edev->mode |= EEH_MODE_SUPPORTED;
 
+			eeh_add_to_parent_pe(edev);
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
+				eeh_add_to_parent_pe(edev);
+
 				return NULL;
 			}
 		}
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 6b53fb8..08b62de 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -261,3 +261,83 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 
 	return NULL;
 }
+
+/**
+ * eeh_add_to_parent_pe - Add EEH device to parent PE
+ * @edev: EEH device
+ *
+ * Add EEH device to the parent PE. If the parent PE already
+ * exists, the PE type will be changed to EEH_PE_BUS. Otherwise,
+ * we have to create new PE to hold the EEH device and the new
+ * PE will be linked to its parent PE as well.
+ */
+int eeh_add_to_parent_pe(struct eeh_dev *edev)
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
+		pr_debug("EEH: Add %s to Bus PE#%x\n",
+			edev->dn->full_name, pe->addr);
+
+		return 0;
+	}
+
+	/* Create a new EEH PE */
+	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (!pe) {
+		pr_err("%s: out of memory!\n", __func__);
+		return -ENOMEM;
+	}
+	pe->addr	= edev->pe_config_addr;
+	pe->config_addr	= edev->config_addr;
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
+	}
+	pe->parent = parent;
+
+	/*
+	 * Put the newly created PE into the child list and
+	 * link the EEH device accordingly.
+	 */
+	list_add_tail(&pe->child, &parent->child_list);
+	list_add_tail(&edev->list, &pe->edevs);
+	edev->pe = pe;
+	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
+		edev->dn->full_name, pe->addr, pe->parent->addr);
+
+	return 0;
+}
-- 
1.7.5.4
