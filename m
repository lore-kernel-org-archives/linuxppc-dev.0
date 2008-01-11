Return-Path: <dwalker@mvista.com>
Received: from dwalker1.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA23ADE0C5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 15:26:05 +1100 (EST)
Message-Id: <20080111042137.378247237@mvista.com>
Date: Thu, 10 Jan 2008 20:21:37 -0800
Message-Id: <20080111041959.337397837@mvista.com>
Date: Thu, 10 Jan 2008 20:19:59 -0800
From: Daniel Walker <dwalker@mvista.com>
To: geoffrey.levand@am.sony.com
Subject: [PATCH] ps3: vuart: semaphore to mutex
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This probe_mutex conforms to the new struct mutex type.
This patch converts it from the old semaphore to the new struct mutex.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 drivers/ps3/ps3-vuart.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: linux-2.6.23/drivers/ps3/ps3-vuart.c
===================================================================
--- linux-2.6.23.orig/drivers/ps3/ps3-vuart.c
+++ linux-2.6.23/drivers/ps3/ps3-vuart.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 #include <asm/ps3.h>
 
 #include <asm/firmware.h>
@@ -877,7 +878,7 @@ static int ps3_vuart_handle_port_interru
 struct vuart_bus_priv {
 	struct ports_bmp *bmp;
 	unsigned int virq;
-	struct semaphore probe_mutex;
+	struct mutex probe_mutex;
 	int use_count;
 	struct ps3_system_bus_device *devices[PORT_COUNT];
 } static vuart_bus_priv;
@@ -1015,7 +1016,7 @@ static int ps3_vuart_probe(struct ps3_sy
 		return -EINVAL;
 	}
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	result = ps3_vuart_bus_interrupt_get();
 
@@ -1075,7 +1076,7 @@ static int ps3_vuart_probe(struct ps3_sy
 		goto fail_probe;
 	}
 
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 
 	return result;
 
@@ -1088,7 +1089,7 @@ fail_dev_malloc:
 fail_busy:
 	ps3_vuart_bus_interrupt_put();
 fail_setup_interrupt:
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	dev_dbg(&dev->core, "%s:%d: failed\n", __func__, __LINE__);
 	return result;
 }
@@ -1127,7 +1128,7 @@ static int ps3_vuart_remove(struct ps3_s
 
 	BUG_ON(!dev);
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	dev_dbg(&dev->core, " -> %s:%d: match_id %d\n", __func__, __LINE__,
 		dev->match_id);
@@ -1135,7 +1136,7 @@ static int ps3_vuart_remove(struct ps3_s
 	if (!dev->core.driver) {
 		dev_dbg(&dev->core, "%s:%d: no driver bound\n", __func__,
 			__LINE__);
-		up(&vuart_bus_priv.probe_mutex);
+		mutex_unlock(&vuart_bus_priv.probe_mutex);
 		return 0;
 	}
 
@@ -1158,7 +1159,7 @@ static int ps3_vuart_remove(struct ps3_s
 	priv = NULL;
 
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -1178,7 +1179,7 @@ static int ps3_vuart_shutdown(struct ps3
 
 	BUG_ON(!dev);
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	dev_dbg(&dev->core, " -> %s:%d: match_id %d\n", __func__, __LINE__,
 		dev->match_id);
@@ -1186,7 +1187,7 @@ static int ps3_vuart_shutdown(struct ps3
 	if (!dev->core.driver) {
 		dev_dbg(&dev->core, "%s:%d: no driver bound\n", __func__,
 			__LINE__);
-		up(&vuart_bus_priv.probe_mutex);
+		mutex_unlock(&vuart_bus_priv.probe_mutex);
 		return 0;
 	}
 
@@ -1210,7 +1211,7 @@ static int ps3_vuart_shutdown(struct ps3
 
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -1221,7 +1222,7 @@ static int __init ps3_vuart_bus_init(voi
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
 		return -ENODEV;
 
-	init_MUTEX(&vuart_bus_priv.probe_mutex);
+	mutex_init(&vuart_bus_priv.probe_mutex);
 
 	return 0;
 }
-- 

-- 
