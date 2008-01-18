Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail85-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51531DE02F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:15 +1100 (EST)
Message-ID: <47910CF5.1090300@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:53 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 14/16] PS3: Vuart change semaphore to mutex
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A general housekeeping change of the PS3 vuart variable
vuart_bus_priv.probe_mutex from semaphore to mutex.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-vuart.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -877,7 +877,7 @@ static int ps3_vuart_handle_port_interru
 struct vuart_bus_priv {
 	struct ports_bmp *bmp;
 	unsigned int virq;
-	struct semaphore probe_mutex;
+	struct mutex probe_mutex;
 	int use_count;
 	struct ps3_system_bus_device *devices[PORT_COUNT];
 } static vuart_bus_priv;
@@ -1015,7 +1015,7 @@ static int ps3_vuart_probe(struct ps3_sy
 		return -EINVAL;
 	}
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	result = ps3_vuart_bus_interrupt_get();
 
@@ -1076,7 +1076,7 @@ static int ps3_vuart_probe(struct ps3_sy
 		goto fail_probe;
 	}
 
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 
 	return result;
 
@@ -1089,7 +1089,7 @@ fail_dev_malloc:
 fail_busy:
 	ps3_vuart_bus_interrupt_put();
 fail_setup_interrupt:
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	dev_dbg(&dev->core, "%s:%d: failed\n", __func__, __LINE__);
 	return result;
 }
@@ -1128,7 +1128,7 @@ static int ps3_vuart_remove(struct ps3_s
 
 	BUG_ON(!dev);
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	dev_dbg(&dev->core, " -> %s:%d: match_id %d\n", __func__, __LINE__,
 		dev->match_id);
@@ -1136,7 +1136,7 @@ static int ps3_vuart_remove(struct ps3_s
 	if (!dev->core.driver) {
 		dev_dbg(&dev->core, "%s:%d: no driver bound\n", __func__,
 			__LINE__);
-		up(&vuart_bus_priv.probe_mutex);
+		mutex_unlock(&vuart_bus_priv.probe_mutex);
 		return 0;
 	}
 
@@ -1159,7 +1159,7 @@ static int ps3_vuart_remove(struct ps3_s
 	priv = NULL;
 
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -1179,7 +1179,7 @@ static int ps3_vuart_shutdown(struct ps3
 
 	BUG_ON(!dev);
 
-	down(&vuart_bus_priv.probe_mutex);
+	mutex_lock(&vuart_bus_priv.probe_mutex);
 
 	dev_dbg(&dev->core, " -> %s:%d: match_id %d\n", __func__, __LINE__,
 		dev->match_id);
@@ -1187,7 +1187,7 @@ static int ps3_vuart_shutdown(struct ps3
 	if (!dev->core.driver) {
 		dev_dbg(&dev->core, "%s:%d: no driver bound\n", __func__,
 			__LINE__);
-		up(&vuart_bus_priv.probe_mutex);
+		mutex_unlock(&vuart_bus_priv.probe_mutex);
 		return 0;
 	}
 
@@ -1211,7 +1211,7 @@ static int ps3_vuart_shutdown(struct ps3
 
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 
-	up(&vuart_bus_priv.probe_mutex);
+	mutex_unlock(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -1222,7 +1222,7 @@ static int __init ps3_vuart_bus_init(voi
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
 		return -ENODEV;
 
-	init_MUTEX(&vuart_bus_priv.probe_mutex);
+	mutex_init(&vuart_bus_priv.probe_mutex);
 
 	return 0;
 }

-- 
