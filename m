Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xck1B49bHzDrLW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 20:19:10 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 2/5] powerpc/eeh: Reduce to one the number of places
 where edev is allocated
Date: Wed, 23 Aug 2017 20:18:58 +1000
Message-Id: <20170823101901.33961-3-aik@ozlabs.ru>
In-Reply-To: <20170823101901.33961-1-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/eeh_dev.c:57 is the only legit place where edev
is allocated; other 2 places allocate it on stack and in the heap for
a very short period of time to use eeh_pe_get() as takes edev.

This changes eeh_pe_get() to receive required parameters explicitly.

This removes unnecessary temporary allocation of edev.

This uses the "pe_no" name instead of the "pe_config_addr" name as
it actually is a PE number and not a config space address as it seemed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/eeh.h               |  3 ++-
 arch/powerpc/kernel/eeh_pe.c                 | 32 ++++++++++++++++++----------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 15 ++-----------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8e37b71674f4..26a6a43f8799 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -262,7 +262,8 @@ typedef void *(*eeh_traverse_func)(void *data, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
-struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
+struct eeh_pe *eeh_pe_get(struct pci_controller *phb,
+			  int pe_no, int config_addr);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 void eeh_pe_update_time_stamp(struct eeh_pe *pe);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index cc4b206f77e4..84d79f3da7d6 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -230,10 +230,15 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
  * Bus/Device/Function number. The extra data referred by flag
  * indicates which type of address should be used.
  */
+struct eeh_pe_get_flag {
+	int pe_no;
+	int config_addr;
+};
+
 static void *__eeh_pe_get(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
-	struct eeh_dev *edev = (struct eeh_dev *)flag;
+	struct eeh_pe_get_flag *tmp = (struct eeh_pe_get_flag *) flag;
 
 	/* Unexpected PHB PE */
 	if (pe->type & EEH_PE_PHB)
@@ -244,17 +249,17 @@ static void *__eeh_pe_get(void *data, void *flag)
 	 * have non-zero PE address
 	 */
 	if (eeh_has_flag(EEH_VALID_PE_ZERO)) {
-		if (edev->pe_config_addr == pe->addr)
+		if (tmp->pe_no == pe->addr)
 			return pe;
 	} else {
-		if (edev->pe_config_addr &&
-		    (edev->pe_config_addr == pe->addr))
+		if (tmp->pe_no &&
+		    (tmp->pe_no == pe->addr))
 			return pe;
 	}
 
 	/* Try BDF address */
-	if (edev->config_addr &&
-	   (edev->config_addr == pe->config_addr))
+	if (tmp->config_addr &&
+	   (tmp->config_addr == pe->config_addr))
 		return pe;
 
 	return NULL;
@@ -262,7 +267,9 @@ static void *__eeh_pe_get(void *data, void *flag)
 
 /**
  * eeh_pe_get - Search PE based on the given address
- * @edev: EEH device
+ * @phb: PCI controller
+ * @pe_no: PE number
+ * @config_addr: Config address
  *
  * Search the corresponding PE based on the specified address which
  * is included in the eeh device. The function is used to check if
@@ -271,12 +278,14 @@ static void *__eeh_pe_get(void *data, void *flag)
  * which is composed of PCI bus/device/function number, or unified
  * PE address.
  */
-struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
+struct eeh_pe *eeh_pe_get(struct pci_controller *phb,
+		int pe_no, int config_addr)
 {
-	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
+	struct eeh_pe *root = eeh_phb_pe_get(phb);
+	struct eeh_pe_get_flag tmp = { pe_no, config_addr };
 	struct eeh_pe *pe;
 
-	pe = eeh_pe_traverse(root, __eeh_pe_get, edev);
+	pe = eeh_pe_traverse(root, __eeh_pe_get, &tmp);
 
 	return pe;
 }
@@ -344,7 +353,8 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 * PE should be composed of PCI bus and its subordinate
 	 * components.
 	 */
-	pe = eeh_pe_get(edev);
+	pe = eeh_pe_get(edev->pdn->phb, edev->pe_config_addr,
+			edev->config_addr);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		/* Mark the PE as type of PCI bus */
 		pe->type = EEH_PE_BUS;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3f48f6df1cf3..ac8c01cd251c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -113,7 +113,6 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 				size_t count, loff_t *ppos)
 {
 	struct pci_controller *hose = filp->private_data;
-	struct eeh_dev *edev;
 	struct eeh_pe *pe;
 	int pe_no, type, func;
 	unsigned long addr, mask;
@@ -135,13 +134,7 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 		return -EINVAL;
 
 	/* Retrieve PE */
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev)
-		return -ENOMEM;
-	edev->phb = hose;
-	edev->pe_config_addr = pe_no;
-	pe = eeh_pe_get(edev);
-	kfree(edev);
+	pe = eeh_pe_get(hose, pe_no, 0);
 	if (!pe)
 		return -ENODEV;
 
@@ -1381,7 +1374,6 @@ static int pnv_eeh_get_pe(struct pci_controller *hose,
 	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *pnv_pe;
 	struct eeh_pe *dev_pe;
-	struct eeh_dev edev;
 
 	/*
 	 * If PHB supports compound PE, to fetch
@@ -1397,10 +1389,7 @@ static int pnv_eeh_get_pe(struct pci_controller *hose,
 	}
 
 	/* Find the PE according to PE# */
-	memset(&edev, 0, sizeof(struct eeh_dev));
-	edev.phb = hose;
-	edev.pe_config_addr = pe_no;
-	dev_pe = eeh_pe_get(&edev);
+	dev_pe = eeh_pe_get(hose, pe_no, 0);
 	if (!dev_pe)
 		return -EEXIST;
 
-- 
2.11.0
