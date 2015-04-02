Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C99C41A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:23:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CC3622BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323NkgX41025646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NLXl017332
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:21 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] powernv/eeh: Update the EEH code to use the opal irq
 domain
Date: Thu,  2 Apr 2015 14:22:28 +1100
Message-Id: <1427944952-17452-4-git-send-email-alistair@popple.id.au>
In-Reply-To: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
References: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
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
 arch/powerpc/platforms/powernv/eeh-ioda.c | 39 ++++++++++++++-----------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2809c98..6eee1d1 100644
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
@@ -36,34 +37,20 @@
 
 static int ioda_eeh_nb_init = 0;
 
-static int ioda_eeh_event(struct notifier_block *nb,
-			  unsigned long events, void *change)
+static irqreturn_t ioda_eeh_event(int irq, void *data)
 {
-	uint64_t changed_evts = (uint64_t)change;
-
 	/*
 	 * We simply send special EEH event if EEH has
 	 * been enabled, or clear pending events in
 	 * case that we enable EEH soon
 	 */
-	if (!(changed_evts & OPAL_EVENT_PCI_ERROR) ||
-	    !(events & OPAL_EVENT_PCI_ERROR))
-		return 0;
 
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
@@ -181,14 +168,23 @@ DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
 static int ioda_eeh_post_init(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
-	int ret;
+	int irq, ret;
 
 	/* Register OPAL event notifier */
 	if (!ioda_eeh_nb_init) {
-		ret = opal_notifier_register(&ioda_eeh_nb);
-		if (ret) {
-			pr_err("%s: Can't register OPAL event notifier (%d)\n",
-			       __func__, ret);
+		irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
+		if (irq < 0) {
+			pr_err("%s: Can't register OPAL event interrupt (%d)\n",
+			       __func__, irq);
+			return irq;
+		}
+
+		ret = request_irq(irq, ioda_eeh_event, IRQ_TYPE_EDGE_RISING,
+				"opal-eeh", NULL);
+		if (ret < 0) {
+			irq_dispose_mapping(irq);
+			pr_err("%s: Can't request OPAL event interrupt (%d)\n",
+			       __func__, irq);
 			return ret;
 		}
 
@@ -969,7 +965,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	 * between the kernel and firmware.
 	 */
 	eeh_remove_event(NULL, false);
-	opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
 	list_for_each_entry(hose, &hose_list, list_node) {
 		/*
-- 
1.8.3.2
