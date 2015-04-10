Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB4CA1A1BCC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Fri, 10 Apr 2015 18:26:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AABC02BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8Pq8519464242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8PREX019034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:25:27 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 4/8] powernv/eeh: Update the EEH code to use the opal irq
 domain
Date: Fri, 10 Apr 2015 18:24:50 +1000
Message-Id: <1428654294-9177-4-git-send-email-alistair@popple.id.au>
In-Reply-To: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
References: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The eeh code currently uses the old notifier method to get eeh events
from OPAL. It also contains some logic to filter opal events which has
been moved into the virtual irqchip. This patch converts the eeh code
to the new event interface which simplifies event handling.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 58 +++++++++++++++++--------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2809c98..6dffc31 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/notifier.h>
@@ -35,35 +36,24 @@
 #include "pci.h"
 
 static int ioda_eeh_nb_init = 0;
+static int eeh_event_irq = -EINVAL;
 
-static int ioda_eeh_event(struct notifier_block *nb,
-			  unsigned long events, void *change)
+static irqreturn_t ioda_eeh_event(int irq, void *data)
 {
-	uint64_t changed_evts = (uint64_t)change;
-
 	/*
-	 * We simply send special EEH event if EEH has
-	 * been enabled, or clear pending events in
-	 * case that we enable EEH soon
+	 * We simply send special EEH event if EEH has been
+	 * enabled. We don't care about EEH events until we've
+	 * finished processing the outstanding ones. Event processing
+	 * gets unmasked in next_error() if EEH is enabled.
 	 */
-	if (!(changed_evts & OPAL_EVENT_PCI_ERROR) ||
-	    !(events & OPAL_EVENT_PCI_ERROR))
-		return 0;
+	disable_irq_nosync(irq);
 
 	if (eeh_enabled())
 		eeh_send_failure_event(NULL);
-	else
-		opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
-static struct notifier_block ioda_eeh_nb = {
-	.notifier_call	= ioda_eeh_event,
-	.next		= NULL,
-	.priority	= 0
-};
-
 #ifdef CONFIG_DEBUG_FS
 static ssize_t ioda_eeh_ei_write(struct file *filp,
 				 const char __user *user_buf,
@@ -185,16 +175,28 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 
 	/* Register OPAL event notifier */
 	if (!ioda_eeh_nb_init) {
-		ret = opal_notifier_register(&ioda_eeh_nb);
-		if (ret) {
-			pr_err("%s: Can't register OPAL event notifier (%d)\n",
-			       __func__, ret);
+		eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
+		if (eeh_event_irq < 0) {
+			pr_err("%s: Can't register OPAL event interrupt (%d)\n",
+			       __func__, eeh_event_irq);
+			return eeh_event_irq;
+		}
+
+		ret = request_irq(eeh_event_irq, ioda_eeh_event, IRQ_TYPE_LEVEL_HIGH,
+				"opal-eeh", NULL);
+		if (ret < 0) {
+			irq_dispose_mapping(eeh_event_irq);
+			pr_err("%s: Can't request OPAL event interrupt (%d)\n",
+			       __func__, eeh_event_irq);
 			return ret;
 		}
 
 		ioda_eeh_nb_init = 1;
 	}
 
+	if (!eeh_enabled())
+		disable_irq(eeh_event_irq);
+
 #ifdef CONFIG_DEBUG_FS
 	if (!phb->has_dbgfs && phb->dbgfs) {
 		phb->has_dbgfs = 1;
@@ -964,12 +966,10 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	int state, ret = EEH_NEXT_ERR_NONE;
 
 	/*
-	 * While running here, it's safe to purge the event queue.
-	 * And we should keep the cached OPAL notifier event sychronized
-	 * between the kernel and firmware.
+	 * While running here, it's safe to purge the event queue. The
+	 * event should still be masked.
 	 */
 	eeh_remove_event(NULL, false);
-	opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
 	list_for_each_entry(hose, &hose_list, list_node) {
 		/*
@@ -1134,6 +1134,10 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			break;
 	}
 
+	/* Unmask the event */
+	if (eeh_enabled())
+		enable_irq(eeh_event_irq);
+
 	return ret;
 }
 
-- 
1.8.3.2
