Return-Path: <klebers@linux.vnet.ibm.com>
Received: from oc3035817862.ibm.com (unknown [201.82.72.230])
 by ozlabs.org (Postfix) with ESMTP id 16ED12C02C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:23:28 +1000 (EST)
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: check handle_eeh_events() return value
Date: Fri, 13 Jul 2012 00:14:36 -0300
Message-Id: <1342149276-18435-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function eeh_event_handler() dereferences the pointer returned by
handle_eeh_events() without checking, causing a crash if NULL was
returned, which is expected in some situations.

This patch fixes this bug by checking for the value returned by
handle_eeh_events() before dereferencing it.

Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_event.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index 4cb375c..fb50631 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -85,8 +85,10 @@ static int eeh_event_handler(void * dummy)
 	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
 	edev = handle_eeh_events(event);
 
-	eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
-	pci_dev_put(edev->pdev);
+	if (edev) {
+		eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
+		pci_dev_put(edev->pdev);
+	}
 
 	kfree(event);
 	mutex_unlock(&eeh_event_mutex);
-- 
1.7.1
