Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 173D32C038C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:36 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 02:34:34 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3AB0538C8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:32 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YWPg248998
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YW7q018182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:32 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 29/31] powerpc/eeh: Register OPAL notifier for PCI error
Date: Tue, 18 Jun 2013 16:33:53 +0800
Message-Id: <1371544435-4943-30-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/eeh-ioda.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index a3eebd1..4961270 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -43,6 +43,13 @@
 
 static char *hub_diag = NULL;
 
+static void ioda_eeh_event(u64 events)
+{
+	/* We simply send special EEH event */
+	if (events & OPAL_EVENT_PCI_ERROR)
+		eeh_send_failure_event(NULL);
+}
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -54,6 +61,16 @@ static char *hub_diag = NULL;
 static int ioda_eeh_post_init(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
+	int ret;
+
+	/* Register OPAL event notifier */
+	ret = opal_notifier_register(OPAL_EVENT_PCI_ERROR,
+				     ioda_eeh_event);
+	if (ret) {
+		pr_err("%s: Failed to register OPAL event notifier (%d)\n",
+		       __func__, ret);
+		return ret;
+	}
 
 	/* FIXME: Enable it for PHB3 later */
 	if (phb->type == PNV_PHB_IODA1) {
@@ -736,8 +753,13 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
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
