Return-Path: <ruscur@russell.cc>
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1hFj0RPWzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 17:12:09 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
Date: Mon, 10 Apr 2017 17:11:53 +1000
Message-Id: <20170410071153.21680-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh_handle_special_event() is called when an EEH event is detected but
can't be narrowed down to a specific PE.  This function looks through
every PE to find one in an erroneous state, then calls the regular event
handler eeh_handle_normal_event() once it knows which PE has an error.

However, if eeh_handle_normal_event() found that the PE cannot possibly
be recovered, it will free it, rendering the passed PE stale.
This leads to a use after free in eeh_handle_special_event() as it attempts to
clear the "recovering" state on the PE after eeh_handle_normal_event() returns.

Thus, make sure the PE is valid when attempting to clear state in
eeh_handle_special_event().

Cc: <stable@vger.kernel.org> #3.10+
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
V2: check a specific return path instead of looking at the PE itself
---
 arch/powerpc/kernel/eeh_driver.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b94887165a10..e510408e08e1 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -724,7 +724,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
  */
 #define MAX_WAIT_FOR_RECOVERY 300
 
-static void eeh_handle_normal_event(struct eeh_pe *pe)
+static int eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *frozen_bus;
 	struct eeh_dev *edev, *tmp;
@@ -736,7 +736,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	if (!frozen_bus) {
 		pr_err("%s: Cannot find PCI bus for PHB#%x-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
-		return;
+		return -EIO;
 	}
 
 	eeh_pe_update_time_stamp(pe);
@@ -870,7 +870,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_info("EEH: Notify device driver to resume\n");
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
-	return;
+	return rc;
 
 excess_failures:
 	/*
@@ -915,8 +915,12 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 			pci_lock_rescan_remove();
 			pci_hp_remove_devices(frozen_bus);
 			pci_unlock_rescan_remove();
+
+			/* The passed PE should no longer be used */
+			rc = -EFAULT;
 		}
 	}
+	return rc;
 }
 
 static void eeh_handle_special_event(void)
@@ -982,7 +986,14 @@ static void eeh_handle_special_event(void)
 		 */
 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
-			eeh_handle_normal_event(pe);
+			/*
+			 * eeh_handle_normal_event() can make the PE stale if it
+			 * determines that the PE cannot possibly be recovered.
+			 * Don't modify the PE state if that's the case.
+			 */
+			if (eeh_handle_normal_event(pe) == -EFAULT)
+				continue;
+
 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		} else {
 			pci_lock_rescan_remove();
-- 
2.12.2
