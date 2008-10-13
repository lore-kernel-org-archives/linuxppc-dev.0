Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F0ADDDF59
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 22:10:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DBAaVU002487
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 07:10:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DBAa5j211616
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 05:10:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DBAahX004860
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 05:10:36 -0600
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, general@lists.openfabrics.org,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH]IB/ehca:reject dynamic memory add/remove
Date: Mon, 13 Oct 2008 13:10:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810131310.34413.ossrosch@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the ehca device driver does not support dynamic memory add and remove
operations, the driver must explicitly reject such requests in order to prevent
unpredictable behaviors related to memory regions already occupied and being
used by InfiniBand applications.
The solution is to add a memory notifier to the ehca device driver and if a request
for dynamic memory add or remove comes in, ehca will always reject it.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---

diff -Nurp linux-2.6.27-rc6-7/drivers/infiniband/hw/ehca/ehca_main.c linux-2.6.27-rc6-7.new/drivers/infiniband/hw/ehca/ehca_main.c
--- linux-2.6.27-rc6-7/drivers/infiniband/hw/ehca/ehca_main.c	2008-09-16 18:19:27.000000000 +0200
+++ linux-2.6.27-rc6-7.new/drivers/infiniband/hw/ehca/ehca_main.c	2008-10-03 13:52:50.000000000 +0200
@@ -44,6 +44,8 @@
 #include <linux/slab.h>
 #endif
 
+#include <linux/notifier.h>
+#include <linux/memory.h>
 #include "ehca_classes.h"
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
@@ -964,6 +966,41 @@ void ehca_poll_eqs(unsigned long data)
 	spin_unlock(&shca_list_lock);
 }
 
+static int ehca_mem_notifier(struct notifier_block *nb,
+                             unsigned long action, void *data)
+{
+	static unsigned long ehca_dmem_warn_time;
+
+	switch (action) {
+	case MEM_CANCEL_OFFLINE:
+	case MEM_CANCEL_ONLINE:
+	case MEM_ONLINE:
+	case MEM_OFFLINE:
+		return NOTIFY_OK;
+	case MEM_GOING_ONLINE:
+	case MEM_GOING_OFFLINE:
+		/* only ok if no hca is attached to the lpar */
+		spin_lock(&shca_list_lock);
+		if (list_empty(&shca_list)) {
+			spin_unlock(&shca_list_lock);
+			return NOTIFY_OK;
+		} else {
+			spin_unlock(&shca_list_lock);
+			if (printk_timed_ratelimit(&ehca_dmem_warn_time,
+						   30 * 1000))
+				ehca_gen_err("DMEM operations are not allowed"
+					     "as long as an ehca adapter is"
+					     "attached to the LPAR");
+			return NOTIFY_BAD;
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ehca_mem_nb = {
+	.notifier_call = ehca_mem_notifier,
+};
+
 static int __init ehca_module_init(void)
 {
 	int ret;
@@ -991,6 +1028,12 @@ static int __init ehca_module_init(void)
 		goto module_init2;
 	}
 
+	ret = register_memory_notifier(&ehca_mem_nb);
+	if (ret) {
+		ehca_gen_err("Failed registering memory add/remove notifier");
+		goto module_init3;
+	}
+
 	if (ehca_poll_all_eqs != 1) {
 		ehca_gen_err("WARNING!!!");
 		ehca_gen_err("It is possible to lose interrupts.");
@@ -1003,6 +1046,9 @@ static int __init ehca_module_init(void)
 
 	return 0;
 
+module_init3:
+	ibmebus_unregister_driver(&ehca_driver);
+
 module_init2:
 	ehca_destroy_slab_caches();
 
@@ -1018,6 +1064,8 @@ static void __exit ehca_module_exit(void
 
 	ibmebus_unregister_driver(&ehca_driver);
 
+	unregister_memory_notifier(&ehca_mem_nb);
+
 	ehca_destroy_slab_caches();
 
 	ehca_destroy_comp_pool();
