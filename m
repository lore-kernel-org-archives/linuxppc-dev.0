Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D548AB6F13
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:54:13 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:54:10 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9D4E83B20751
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:02:06 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG25qg023970
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:05 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG214M021124
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:01 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/21] ppc/eeh: Create PEs for PHBs
Date: Thu, 28 Jun 2012 00:01:36 +0800
Message-Id: <1340812911-6793-7-git-send-email-shangw@linux.vnet.ibm.com>
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

For one particular PE, it's only meaningful in the ancestor PHB
domain. Therefore, each PHB should have its own PE hierarchy tree
to trace those PEs created against the PHB.

The patch creates PEs for the PHBs and put those PEs into the
global link list traced by "eeh_phb_pe". The link list of PEs
would be first level of overall PE hierarchy tree across the
system.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h           |    2 +
 arch/powerpc/platforms/pseries/Makefile  |    5 +-
 arch/powerpc/platforms/pseries/eeh_dev.c |    4 ++
 arch/powerpc/platforms/pseries/eeh_pe.c  |  103 ++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/eeh_pe.c

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 248b3d9..7b9c7d6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -164,6 +164,8 @@ static inline void eeh_unlock(void)
  */
 #define EEH_MAX_ALLOWED_FREEZES 5
 
+int __devinit eeh_phb_pe_create(struct pci_controller *phb);
+
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int __init eeh_ops_register(struct eeh_ops *ops);
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index c222189..890622b 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,8 +6,9 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   firmware.o power.o dlpar.o mobility.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh.o eeh_dev.o eeh_cache.o eeh_driver.o \
-			   eeh_event.o eeh_sysfs.o eeh_pseries.o
+obj-$(CONFIG_EEH)	+= eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
+			   eeh_driver.o eeh_event.o eeh_sysfs.o \
+			   eeh_pseries.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index a0cee3a..6644234 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -65,6 +65,7 @@ void * __devinit eeh_dev_init(struct device_node *dn, void *data)
 	PCI_DN(dn)->edev = edev;
 	edev->dn  = dn;
 	edev->phb = phb;
+	INIT_LIST_HEAD(&edev->list);
 
 	return NULL;
 }
@@ -80,6 +81,9 @@ void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
 	struct device_node *dn = phb->dn;
 
+	/* EEH PE for PHB */
+	eeh_phb_pe_create(phb);
+
 	/* EEH device for PHB */
 	eeh_dev_init(dn, phb);
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
new file mode 100644
index 0000000..20d65dc
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -0,0 +1,103 @@
+/*
+ * The file intends to implement PE based on the information from
+ * platforms. Basically, there have 3 types of PEs: PHB/Bus/Device.
+ * All the PEs should be organized as hierarchy tree. The first level
+ * of the tree will be associated to existing PHBs since the particular
+ * PE is only meaningful in one PHB domain.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+static LIST_HEAD(eeh_phb_pe);
+
+/**
+ * eeh_phb_pe_create - Create PHB PE 
+ * @phb: PCI controller
+ *
+ * The function should be called while the PHB is detected during
+ * system boot or PCI hotplug in order to create PHB PE.
+ */
+int __devinit eeh_phb_pe_create(struct pci_controller *phb)
+{
+	struct eeh_pe *pe;
+
+	/* Allocate PHB PE */
+	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
+	if (!pe) {
+		pr_err("%s: out of memory!\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* Initialize PHB PE */
+	pe->type = EEH_PE_PHB;
+	pe->phb = phb;
+	INIT_LIST_HEAD(&pe->child_list);
+	INIT_LIST_HEAD(&pe->child);
+	INIT_LIST_HEAD(&pe->edevs);
+
+	/* Put it into the list */
+	eeh_lock();
+	list_add_tail(&pe->child, &eeh_phb_pe);
+	eeh_unlock();
+
+	pr_info("EEH: Add PE for PHB#%d\n", phb->global_number);
+
+	return 0;
+}
+
+/**
+ * eeh_phb_pe_get - Retrieve PHB PE based on the given PHB
+ * @phb: PCI controller
+ *
+ * The overall PEs form hierarchy tree. The first layer of the
+ * hierarchy tree is composed of PHB PEs. The function is used
+ * to retrieve the corresponding PHB PE according to the given PHB.
+ */
+static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
+{
+	struct eeh_pe *pe;
+
+	eeh_lock();
+
+	list_for_each_entry(pe, &eeh_phb_pe, child) {
+		/*
+		 * Actually, we needn't check the type since
+		 * the PE for PHB has been determined when that
+		 * was created.
+		 */
+		if (pe->type == EEH_PE_PHB &&
+		    pe->phb == phb) {
+			eeh_unlock();
+			return pe;
+		}
+	}
+
+	eeh_unlock();
+
+	return NULL;
+}
+
-- 
1.7.9.5
