Return-Path: <geoff@white.local.net>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B119DDE9B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:38:17 +1000 (EST)
Message-Id: <20071006213542.684568871@am.sony.com>
References: <20071006213542.311447584@am.sony.com>
Date: Sat, 06 Oct 2007 14:35:45 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 3/6] PS3: os-area workqueue processing
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a workqueue to the PS3 os-area support.  This is needed to
support writing updates to flash memory and to update the /proc
device tree entries from the timer tick interrupt context.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/workqueue.h>
 
 #include <asm/lmb.h>
 
@@ -187,6 +188,28 @@ static int __init verify_header(const st
 }
 
 /**
+ * os_area_queue_work_handler - Asynchronous write handler.
+ *
+ * An asynchronous write for flash memory and the device tree.  Do not
+ * call directly, use os_area_queue_work().
+ */
+
+static void os_area_queue_work_handler(struct work_struct *work)
+{
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+
+static void os_area_queue_work(void)
+{
+	static DECLARE_WORK(q, os_area_queue_work_handler);
+
+	wmb();
+	schedule_work(&q);
+}
+
+/**
  * ps3_os_area_save_params - Copy data from os area mirror to @saved_params.
  *
  * For the convenience of the guest, the HV makes a copy of the os area in

-- 
