Return-Path: <ruscur@russell.cc>
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7DRh0BdszDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:40:00 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH v3 2/2] powerpc/eeh: Clean up and document event handling
 functions
Date: Wed, 19 Apr 2017 17:39:27 +1000
Message-Id: <20170419073927.29224-2-ruscur@russell.cc>
In-Reply-To: <20170419073927.29224-1-ruscur@russell.cc>
References: <20170419073927.29224-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove unnecessary tags in eeh_handle_normal_event(), and add function
comments for eeh_handle_normal_event() and eeh_handle_special_event().

The only functional difference is that in the case of a PE reaching the
maximum number of failures, rather than one message telling you of this
and suggesting you reseat the device, there are two separate messages.

Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
V3: new.  Thanks to Alexey for the suggestions.
---
 arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index e50d1470714f..c405c79e50cd 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -724,6 +724,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
  */
 #define MAX_WAIT_FOR_RECOVERY 300
 
+/**
+ * eeh_handle_normal_event - Handle EEH events on a specific PE
+ * @pe: EEH PE
+ *
+ * Attempts to recover the given PE.  If recovery fails or the PE has failed
+ * too many times, remove the PE.
+ *
+ * Returns true if @pe should no longer be used, else false.
+ */
 static bool eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *frozen_bus;
@@ -741,8 +750,13 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
 
 	eeh_pe_update_time_stamp(pe);
 	pe->freeze_count++;
-	if (pe->freeze_count > eeh_max_freezes)
-		goto excess_failures;
+	if (pe->freeze_count > eeh_max_freezes) {
+		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
+		       "last hour and has been permanently disabled.\n",
+		       pe->phb->global_number, pe->addr,
+		       pe->freeze_count);
+		goto hard_fail;
+	}
 	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
 
@@ -872,25 +886,16 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
 
 	return false;
 
-excess_failures:
+hard_fail:
 	/*
 	 * About 90% of all real-life EEH failures in the field
 	 * are due to poorly seated PCI cards. Only 10% or so are
 	 * due to actual, failed cards.
 	 */
-	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
-	       "last hour and has been permanently disabled.\n"
-	       "Please try reseating or replacing it.\n",
-		pe->phb->global_number, pe->addr,
-		pe->freeze_count);
-	goto perm_error;
-
-hard_fail:
 	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
 	       "Please try reseating or replacing it\n",
 		pe->phb->global_number, pe->addr);
 
-perm_error:
 	eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
 	/* Notify all devices that they're about to go down. */
@@ -923,6 +928,13 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
 	return false;
 }
 
+/**
+ * eeh_handle_special_event - Handle EEH events without a specific failing PE
+ *
+ * Called when an EEH event is detected but can't be narrowed down to a
+ * specific PE.  Iterates through possible failures and handles them as
+ * necessary.
+ */
 static void eeh_handle_special_event(void)
 {
 	struct eeh_pe *pe, *phb_pe;
-- 
2.12.2
