Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 6204FDDF65
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 05:17:26 +1100 (EST)
Message-ID: <4909FA2E.80202@am.sony.com>
Date: Thu, 30 Oct 2008 11:17:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] powerpc/ps3: Fix memory leak in device init
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Masakazu Mokuno <mokuno@sm.sony.co.jp>

Free dynamically allocated device data structures when device registration
fails.  This fixes memory leakage when the registration fails.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/device-init.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -314,11 +314,17 @@ static int __init ps3_setup_vuart_device
 
 	result = ps3_system_bus_device_register(&p->dev);
 
-	if (result)
+	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-
+		goto fail_device_register;
+	}
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return 0;
+
+fail_device_register:
+	kfree(p);
+	pr_debug(" <- %s:%d fail\n", __func__, __LINE__);
 	return result;
 }
 
@@ -463,11 +469,17 @@ static int __init ps3_register_sound_dev
 
 	result = ps3_system_bus_device_register(&p->dev);
 
-	if (result)
+	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
-
+		goto fail_device_register;
+	}
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return 0;
+
+fail_device_register:
+	kfree(p);
+	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
 	return result;
 }
 
@@ -491,11 +503,18 @@ static int __init ps3_register_graphics_
 
 	result = ps3_system_bus_device_register(&p->dev);
 
-	if (result)
+	if (result) {
 		pr_debug("%s:%d ps3_system_bus_device_register failed\n",
 			__func__, __LINE__);
+		goto fail_device_register;
+	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return 0;
+
+fail_device_register:
+	kfree(p);
+	pr_debug(" <- %s:%d failed\n", __func__, __LINE__);
 	return result;
 }
 
