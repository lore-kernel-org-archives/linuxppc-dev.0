Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E522E1A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:37 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 14:42:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7AE312CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L4Ji7o60162188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:19:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L4gXAu020667
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/6] powerpc/powernv: Allow to freeze PE
Date: Mon, 21 Jul 2014 14:42:31 +1000
Message-Id: <1405917755-28830-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: yan@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch synchronizes header file with firmware to have new OPAL
API opal_pci_eeh_freeze_set(), which is used to freeze the specified
PE in order to support "compound" PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v3: separate API to freeze PE
---
 arch/powerpc/include/asm/opal.h                | 9 ++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ae885cc..49bab65 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -147,6 +147,7 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_PCI_EEH_FREEZE_SET			97
 
 #ifndef __ASSEMBLY__
 
@@ -170,7 +171,11 @@ enum OpalFreezeState {
 enum OpalEehFreezeActionToken {
 	OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO = 1,
 	OPAL_EEH_ACTION_CLEAR_FREEZE_DMA = 2,
-	OPAL_EEH_ACTION_CLEAR_FREEZE_ALL = 3
+	OPAL_EEH_ACTION_CLEAR_FREEZE_ALL = 3,
+
+	OPAL_EEH_ACTION_SET_FREEZE_MMIO = 1,
+	OPAL_EEH_ACTION_SET_FREEZE_DMA  = 2,
+	OPAL_EEH_ACTION_SET_FREEZE_ALL  = 3
 };
 
 enum OpalPciStatusToken {
@@ -764,6 +769,8 @@ int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
 				   __be64 *phb_status);
 int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
 				  uint64_t eeh_action_token);
+int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
+				uint64_t eeh_action_token);
 int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
 
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4abbff2..7943c8a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -86,6 +86,7 @@ OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
 OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
 OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
+OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
 OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
 OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
 OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
-- 
1.8.3.2
