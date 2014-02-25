Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71FC72C00D5
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:28:55 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:28:52 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6E7723E4003E
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:50 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7SPRK3015150
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 08:28:25 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7SnCO017932
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:50 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/eeh: Remove EEH_PE_PHB_DEAD
Date: Tue, 25 Feb 2014 15:28:34 +0800
Message-Id: <1393313318-6341-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE state (for eeh_pe instance) EEH_PE_PHB_DEAD is duplicate to
EEH_PE_ISOLATED. Originally, those PHBs (PHB PE) with EEH_PE_PHB_DEAD
would be removed from the system. However, it's safe to replace
that with EEH_PE_ISOLATED.

The patch also clear EEH_PE_RECOVERING after fenced PHB has been handled,
either failure or success. It makes the PHB PE state consistent with:

	PHB functions normally		  NONE
	PHB has been removed		  EEH_PE_ISOLATED
	PHB fenced, recovery in progress  EEH_PE_ISOLATED | RECOVERING

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    1 -
 arch/powerpc/kernel/eeh.c        |   10 ++--------
 arch/powerpc/kernel/eeh_driver.c |   10 +++++-----
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d4dd41f..a61b06f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -53,7 +53,6 @@ struct device_node;
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
-#define EEH_PE_PHB_DEAD		(1 << 2)	/* Dead PHB		*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e7b76a6..f167676 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -232,7 +232,6 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 {
 	size_t loglen = 0;
 	struct eeh_dev *edev, *tmp;
-	bool valid_cfg_log = true;
 
 	/*
 	 * When the PHB is fenced or dead, it's pointless to collect
@@ -240,12 +239,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	 * 0xFF's. For ER, we still retrieve the data from the PCI
 	 * config space.
 	 */
-	if (eeh_probe_mode_dev() &&
-	    (pe->type & EEH_PE_PHB) &&
-	    (pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)))
-		valid_cfg_log = false;
-
-	if (valid_cfg_log) {
+	if (!(pe->type & EEH_PE_PHB)) {
 		eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 		eeh_ops->configure_bridge(pe);
 		eeh_pe_restore_bars(pe);
@@ -309,7 +303,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 
 	/* If the PHB has been in problematic state */
 	eeh_serialize_lock(&flags);
-	if (phb_pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)) {
+	if (phb_pe->state & EEH_PE_ISOLATED) {
 		ret = 0;
 		goto out;
 	}
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index fdc679d..4cf0467 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -665,8 +665,7 @@ static void eeh_handle_special_event(void)
 				phb_pe = eeh_phb_pe_get(hose);
 				if (!phb_pe) continue;
 
-				eeh_pe_state_mark(phb_pe,
-					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+				eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
 			}
 
 			eeh_serialize_unlock(flags);
@@ -682,8 +681,7 @@ static void eeh_handle_special_event(void)
 			eeh_remove_event(pe);
 
 			if (rc == EEH_NEXT_ERR_DEAD_PHB)
-				eeh_pe_state_mark(pe,
-					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+				eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 			else
 				eeh_pe_state_mark(pe,
 					EEH_PE_ISOLATED | EEH_PE_RECOVERING);
@@ -707,12 +705,14 @@ static void eeh_handle_special_event(void)
 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
 			eeh_handle_normal_event(pe);
+			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		} else {
 			pci_lock_rescan_remove();
 			list_for_each_entry(hose, &hose_list, list_node) {
 				phb_pe = eeh_phb_pe_get(hose);
 				if (!phb_pe ||
-				    !(phb_pe->state & EEH_PE_PHB_DEAD))
+				    !(phb_pe->state & EEH_PE_ISOLATED) ||
+				    (phb_pe->state & EEH_PE_RECOVERING))
 					continue;
 
 				/* Notify all devices to be down */
-- 
1.7.10.4
