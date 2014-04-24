Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B67CF14011F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:27 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 640C9357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O8087310748360
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80MhV003971
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 01/25] powerpc/eeh: Remove EEH_PE_PHB_DEAD
Date: Thu, 24 Apr 2014 18:00:07 +1000
Message-Id: <1398326431-24305-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  1 -
 arch/powerpc/kernel/eeh.c        | 10 ++--------
 arch/powerpc/kernel/eeh_driver.c | 10 +++++-----
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
index bb61ca5..1ddc046 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -682,8 +682,7 @@ static void eeh_handle_special_event(void)
 				phb_pe = eeh_phb_pe_get(hose);
 				if (!phb_pe) continue;
 
-				eeh_pe_state_mark(phb_pe,
-					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+				eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
 			}
 
 			eeh_serialize_unlock(flags);
@@ -699,8 +698,7 @@ static void eeh_handle_special_event(void)
 			eeh_remove_event(pe);
 
 			if (rc == EEH_NEXT_ERR_DEAD_PHB)
-				eeh_pe_state_mark(pe,
-					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+				eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 			else
 				eeh_pe_state_mark(pe,
 					EEH_PE_ISOLATED | EEH_PE_RECOVERING);
@@ -724,12 +722,14 @@ static void eeh_handle_special_event(void)
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
1.8.3.2
