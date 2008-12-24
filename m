Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 79BABDDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 06:13:43 +1100 (EST)
Date: Wed, 24 Dec 2008 22:13:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH -mm 3/3] USB: FHCI: Fix memory leaks in fhci_mem_{init,free}
Message-ID: <20081224191342.GC21815@oksana.dev.rtsoft.ru>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes few memory leaks. Particulary:

- On errors fhci_mem_init() leaks fhci->hc_list;
- fhci_mem_free() doesn't free the allocated eds/tds.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/fhci-hcd.c |   57 ++++++++++++++++++++++--------------------
 1 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 269af3c..ba622cc 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -167,27 +167,35 @@ int fhci_ioports_check_bus_state(struct fhci_hcd *fhci)
 
 static void fhci_mem_free(struct fhci_hcd *fhci)
 {
-	struct list_head *lh;
-	struct list_head *next_lh;
+	struct ed *ed;
+	struct ed *next_ed;
+	struct td *td;
+	struct td *next_td;
 
-	list_for_each_safe(lh, next_lh, &fhci->empty_eds)
-		list_del(lh);
+	list_for_each_entry_safe(ed, next_ed, &fhci->empty_eds, node) {
+		list_del(&ed->node);
+		kfree(ed);
+	}
 
-	list_for_each_safe(lh, next_lh, &fhci->empty_tds)
-		list_del(lh);
+	list_for_each_entry_safe(td, next_td, &fhci->empty_tds, node) {
+		list_del(&td->node);
+		kfree(td);
+	}
 
 	kfree(fhci->vroot_hub);
+	fhci->vroot_hub = NULL;
+
 	kfree(fhci->hc_list);
+	fhci->hc_list = NULL;
 }
 
 static int fhci_mem_init(struct fhci_hcd *fhci)
 {
 	int i;
-	int error = 0;
 
 	fhci->hc_list = kzalloc(sizeof(*fhci->hc_list), GFP_KERNEL);
 	if (!fhci->hc_list)
-		return -ENOMEM;
+		goto err;
 
 	INIT_LIST_HEAD(&fhci->hc_list->ctrl_list);
 	INIT_LIST_HEAD(&fhci->hc_list->bulk_list);
@@ -197,7 +205,7 @@ static int fhci_mem_init(struct fhci_hcd *fhci)
 
 	fhci->vroot_hub = kzalloc(sizeof(*fhci->vroot_hub), GFP_KERNEL);
 	if (!fhci->vroot_hub)
-		return -ENOMEM;
+		goto err;
 
 	INIT_LIST_HEAD(&fhci->empty_eds);
 	INIT_LIST_HEAD(&fhci->empty_tds);
@@ -207,32 +215,27 @@ static int fhci_mem_init(struct fhci_hcd *fhci)
 	fhci->process_done_task = &fhci_tasklet;
 
 	for (i = 0; i < MAX_TDS; i++) {
-		struct td *td = kmalloc(sizeof(*td), GFP_KERNEL);
+		struct td *td;
 
-		if (!td) {
-			error = 1;
-			break;
-		}
+		td = kmalloc(sizeof(*td), GFP_KERNEL);
+		if (!td)
+			goto err;
 		fhci_recycle_empty_td(fhci, td);
 	}
 	for (i = 0; i < MAX_EDS; i++) {
-		struct ed *ed = kmalloc(sizeof(*ed), GFP_KERNEL);
+		struct ed *ed;
 
-		if (!ed) {
-			error = 1;
-			break;
-		}
+		ed = kmalloc(sizeof(*ed), GFP_KERNEL);
+		if (!ed)
+			goto err;
 		fhci_recycle_empty_ed(fhci, ed);
 	}
 
-	if (error) {
-		fhci_mem_free(fhci);
-		return -ENOMEM;
-	}
-
 	fhci->active_urbs = 0;
-
-	return error;
+	return 0;
+err:
+	fhci_mem_free(fhci);
+	return -ENOMEM;
 }
 
 /* destroy the fhci_usb structure */
-- 
1.5.6.5
