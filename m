Return-Path: <yan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AA0B1A01B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:54:09 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <yan@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 23:54:07 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BD3C12CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:54:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6ADbPsI63701002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:37:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6ADs5hJ032348
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:54:05 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/powernv: Allows to freeze PE
Date: Thu, 10 Jul 2014 21:53:42 +0800
Message-Id: <1405000426-1016-3-git-send-email-yan@linux.vnet.ibm.com>
In-Reply-To: <1405000426-1016-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1405000426-1016-1-git-send-email-yan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

For compound PE, all PEs should be frozen if any one in the group
becomes frozen. Unfortunately, hardware doesn't always do that
automatically with help of PELTV. So we have to flirt with
PESTA/B a bit to freeze all PEs for the case.

The patch sychronizes with firmware hearder and change the name
of opal_pci_eeh_freeze_clear() to opal_pci_eeh_freeze_set() to
reflect its usage: the API can be used to clear or set frozen
state for the specified PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 9 +++++----
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 6 +++---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c      | 4 ++--
 arch/powerpc/platforms/powernv/pci.c           | 4 ++--
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ae885cc..edbfe1c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -84,7 +84,7 @@ struct opal_sg_list {
 #define OPAL_PCI_EEH_FREEZE_STATUS		23
 #define OPAL_PCI_SHPC				24
 #define OPAL_CONSOLE_WRITE_BUFFER_SPACE		25
-#define OPAL_PCI_EEH_FREEZE_CLEAR		26
+#define OPAL_PCI_EEH_FREEZE_SET			26
 #define OPAL_PCI_PHB_MMIO_ENABLE		27
 #define OPAL_PCI_SET_PHB_MEM_WINDOW		28
 #define OPAL_PCI_MAP_PE_MMIO_WINDOW		29
@@ -167,7 +167,8 @@ enum OpalFreezeState {
 	OPAL_EEH_STOPPED_PERM_UNAVAIL = 6
 };
 
-enum OpalEehFreezeActionToken {
+enum OpalPciFreezeActionToken {
+	OPAL_EEH_ACTION_SET_FREEZE_ALL = 0,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO = 1,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_DMA = 2,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_ALL = 3
@@ -762,8 +763,8 @@ int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
 				   uint8_t *freeze_state,
 				   __be16 *pci_error_type,
 				   __be64 *phb_status);
-int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
-				  uint64_t eeh_action_token);
+int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
+				uint64_t eeh_action_token);
 int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
 
 
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 8ad0c5b..723db8b 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -210,7 +210,7 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 		ret = 0;
 		break;
 	case EEH_OPT_THAW_MMIO:
-		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+		ret = opal_pci_eeh_freeze_set(phb->opal_id, pe_no,
 				OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO);
 		if (ret) {
 			pr_warning("%s: Failed to enable MMIO for "
@@ -221,7 +221,7 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 
 		break;
 	case EEH_OPT_THAW_DMA:
-		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+		ret = opal_pci_eeh_freeze_set(phb->opal_id, pe_no,
 				OPAL_EEH_ACTION_CLEAR_FREEZE_DMA);
 		if (ret) {
 			pr_warning("%s: Failed to enable DMA for "
@@ -809,7 +809,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					hose->global_number, frozen_pe_no);
 				pr_info("EEH: PHB location: %s\n",
 					eeh_pe_loc_get(phb_pe));
-				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
+				opal_pci_eeh_freeze_set(phb->opal_id, frozen_pe_no,
 					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 				ret = EEH_NEXT_ERR_NONE;
 			} else if ((*pe)->state & EEH_PE_ISOLATED) {
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4abbff2..abf5ffa 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -85,7 +85,7 @@ OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
 OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
 OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
-OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
+OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
 OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
 OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
 OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 851e615..31a5460 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -426,8 +426,8 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 				pe->pe_number, OPAL_ADD_PE_TO_DOMAIN);
 	if (rc)
 		pe_warn(pe, "OPAL error %d adding self to PELTV\n", rc);
-	opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
-				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	opal_pci_eeh_freeze_set(phb->opal_id, pe->pe_number,
+				OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 
 	/* Add to all parents PELT-V */
 	while (parent) {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f91a4e5..02f4bd9 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -327,8 +327,8 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
 					 PNV_PCI_DIAG_BUF_SIZE);
 	has_diag = (rc == OPAL_SUCCESS);
 
-	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
-				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	rc = opal_pci_eeh_freeze_set(phb->opal_id, pe_no,
+				     OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 	if (rc) {
 		pr_warning("PCI %d: Failed to clear EEH freeze state"
 			   " for PE#%d, err %ld\n",
-- 
1.8.3.1
