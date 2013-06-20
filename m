Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41FFE2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:44:22 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 04:13:40 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A38B619D8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:13:28 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5KADZ9C154324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:13:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5KADYHG003959
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:13:34 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/eeh: Register OPAL notifier for PCI error
Date: Thu, 20 Jun 2013 18:13:24 +0800
Message-Id: <1371723206-26190-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch registers OPAL event notifier and process the PCI errors
from firmware. If we have pending PCI errors, special EEH event
(without binding PE) will be sent to EEH core for processing.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   41 ++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index a3eebd1..2b7689e 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 
@@ -42,6 +43,26 @@
 #endif
 
 static char *hub_diag = NULL;
+static int ioda_eeh_nb_init = 0;
+
+static int ioda_eeh_event(struct notifier_block *nb,
+			  unsigned long events, void *change)
+{
+	uint64_t changed_evts = (uint64_t)change;
+
+	/* We simply send special EEH event */
+	if ((changed_evts & OPAL_EVENT_PCI_ERROR) &&
+	    (events & OPAL_EVENT_PCI_ERROR))
+		eeh_send_failure_event(NULL);
+
+	return 0;
+}
+
+static struct notifier_block ioda_eeh_nb = {
+	.notifier_call	= ioda_eeh_event,
+	.next		= NULL,
+	.priority	= 0
+};
 
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
@@ -54,6 +75,19 @@ static char *hub_diag = NULL;
 static int ioda_eeh_post_init(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
+	int ret;
+
+	/* Register OPAL event notifier */
+	if (!ioda_eeh_nb_init) {
+		ret = opal_notifier_register(&ioda_eeh_nb);
+		if (ret) {
+			pr_err("%s: Can't register OPAL event notifier (%d)\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		ioda_eeh_nb_init = 1;
+	}
 
 	/* FIXME: Enable it for PHB3 later */
 	if (phb->type == PNV_PHB_IODA1) {
@@ -736,8 +770,13 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	long rc;
 	int ret = 1;
 
-	/* While running here, it's safe to purge the event queue */
+	/*
+	 * While running here, it's safe to purge the event queue.
+	 * And we should keep the cached OPAL notifier event sychronized
+	 * between the kernel and firmware.
+	 */
 	eeh_remove_event(NULL);
+	opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		/*
-- 
1.7.5.4
