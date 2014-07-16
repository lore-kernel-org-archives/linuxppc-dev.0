Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC6E31A03C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:55 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 15:50:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2F1DE2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6G5o6YL9634140
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:07 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6G5oMRa024795
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] powerpc/eeh: Aux PE data for error log
Date: Wed, 16 Jul 2014 15:50:19 +1000
Message-Id: <1405489819-26211-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch allows PE (struct eeh_pe) instance to have auxillary data,
whose size is configurable on basis of platform. For PowerNV, the
auxillary data will be used to cache PHB diag-data for that PE
(frozen PE or fenced PHB). In turn, we can retrieve the diag-data
at any later points It's useful for the case of VFIO PCI devices
where the error log should be cached, and then be retrieved by the
guest at later point.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  2 ++
 arch/powerpc/kernel/eeh_pe.c                 | 26 ++++++++++++++++-
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 42 +++++++++++++++++++---------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  3 +-
 4 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 494c3ff..9983c3d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -88,6 +88,7 @@ struct eeh_pe {
 	int false_positives;		/* Times of reported #ff's	*/
 	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
+	void *data;			/* PE auxillary data		*/
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
 	struct list_head child;		/* Child PEs			*/
@@ -248,6 +249,7 @@ static inline void eeh_serialize_unlock(unsigned long flags)
 #define EEH_MAX_ALLOWED_FREEZES 5
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
+void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 77632ab..00e3844 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -32,9 +32,24 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
+static int eeh_pe_aux_size = 0;
 static LIST_HEAD(eeh_phb_pe);
 
 /**
+ * eeh_set_pe_aux_size - Set PE auxillary data size
+ * @size: PE auxillary data size
+ *
+ * Set PE auxillary data size
+ */
+void eeh_set_pe_aux_size(int size)
+{
+	if (size < 0)
+		return;
+
+	eeh_pe_aux_size = size;
+}
+
+/**
  * eeh_pe_alloc - Allocate PE
  * @phb: PCI controller
  * @type: PE type
@@ -44,9 +59,16 @@ static LIST_HEAD(eeh_phb_pe);
 static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 {
 	struct eeh_pe *pe;
+	size_t alloc_size;
+
+	alloc_size = sizeof(struct eeh_pe);
+	if (eeh_pe_aux_size) {
+		alloc_size = ALIGN(alloc_size, cache_line_size());
+		alloc_size += eeh_pe_aux_size;
+	}
 
 	/* Allocate PHB PE */
-	pe = kzalloc(sizeof(struct eeh_pe), GFP_KERNEL);
+	pe = kzalloc(alloc_size, GFP_KERNEL);
 	if (!pe) return NULL;
 
 	/* Initialize PHB PE */
@@ -56,6 +78,8 @@ static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
 	INIT_LIST_HEAD(&pe->child);
 	INIT_LIST_HEAD(&pe->edevs);
 
+	pe->data = (void *)pe + ALIGN(sizeof(struct eeh_pe),
+				      cache_line_size());
 	return pe;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index bccdf60..b4624cf 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -236,20 +236,16 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 	return ret;
 }
 
-static void ioda_eeh_phb_diag(struct pci_controller *hose)
+static void ioda_eeh_phb_diag(struct eeh_pe *pe)
 {
-	struct pnv_phb *phb = hose->private_data;
+	struct pnv_phb *phb = pe->phb->private_data;
 	long rc;
 
-	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, pe->data,
 					 PNV_PCI_DIAG_BUF_SIZE);
-	if (rc != OPAL_SUCCESS) {
+	if (rc != OPAL_SUCCESS)
 		pr_warn("%s: Failed to get diag-data for PHB#%x (%ld)\n",
-			__func__, hose->global_number, rc);
-		return;
-	}
-
-	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
+			__func__, pe->phb->global_number, rc);
 }
 
 static int ioda_eeh_get_phb_state(struct eeh_pe *pe)
@@ -282,7 +278,7 @@ static int ioda_eeh_get_phb_state(struct eeh_pe *pe)
 			  EEH_STATE_DMA_ENABLED);
 	} else if (!(pe->state & EEH_PE_ISOLATED)) {
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-		ioda_eeh_phb_diag(phb->hose);
+		ioda_eeh_phb_diag(pe);
 	}
 
 	return result;
@@ -380,7 +376,7 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 			phb->freeze_pe(phb, pe->addr);
 
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-		ioda_eeh_phb_diag(phb->hose);
+		ioda_eeh_phb_diag(pe);
 	}
 
 	return result;
@@ -623,6 +619,24 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 }
 
 /**
+ * ioda_eeh_get_log - Retrieve error log
+ * @pe: frozen PE
+ * @severity: permanent or temporary error
+ * @drv_log: device driver log
+ * @len: length of device driver log
+ *
+ * Retrieve error log, which contains log from device driver
+ * and firmware.
+ */
+int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
+		     char *drv_log, unsigned long len)
+{
+	pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
+
+	return 0;
+}
+
+/**
  * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
  * @pe: EEH PE
  *
@@ -860,7 +874,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					"detected, location: %s\n",
 					hose->global_number,
 					eeh_pe_loc_get(phb_pe));
-				ioda_eeh_phb_diag(hose);
+				ioda_eeh_phb_diag(phb_pe);
+				pnv_pci_dump_phb_diag_data(hose, phb_pe->data);
 				ret = EEH_NEXT_ERR_NONE;
 			}
 
@@ -908,7 +923,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		    ret == EEH_NEXT_ERR_FENCED_PHB) &&
 		    !((*pe)->state & EEH_PE_ISOLATED)) {
 			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
-			ioda_eeh_phb_diag(hose);
+			ioda_eeh_phb_diag(*pe);
 		}
 
 		/*
@@ -954,6 +969,7 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
+	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index f1f5d4b..f5bbc9f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -326,7 +326,7 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
  * Retrieve the temporary or permanent error from the PE.
  */
 static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
-			char *drv_log, unsigned long len)
+			       char *drv_log, unsigned long len)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -433,6 +433,7 @@ static int __init eeh_powernv_init(void)
 	if (!machine_is(powernv))
 		return ret;
 
+	eeh_set_pe_aux_size(PNV_PCI_DIAG_BUF_SIZE);
 	ret = eeh_ops_register(&powernv_eeh_ops);
 	if (!ret)
 		pr_info("EEH: PowerNV platform initialized\n");
-- 
1.8.3.2
