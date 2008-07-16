Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id B9B2ADE01A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:28:24 +1000 (EST)
Message-ID: <487E668B.2010600@am.sony.com>
Date: Wed, 16 Jul 2008 14:22:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 1/2] powerpc/ps3: Add a sub-match id to ps3_system_bus
References: <487E654C.9030001@am.sony.com>
In-Reply-To: <487E654C.9030001@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Masakazu Mokuno <mokuno@sm.sony.co.jp>

Add sub match id for ps3 system bus so that two different system bus
devices can be connected to a shared device.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/device-init.c |    1 +
 arch/powerpc/platforms/ps3/system-bus.c  |   21 ++++++++++++++-------
 drivers/video/ps3fb.c                    |    1 +
 include/asm-powerpc/ps3.h                |    7 +++++++
 4 files changed, 23 insertions(+), 7 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -486,6 +486,7 @@ static int __init ps3_register_graphics_
 		return -ENOMEM;
 
 	p->dev.match_id = PS3_MATCH_ID_GRAPHICS;
+	p->dev.match_sub_id = PS3_MATCH_SUB_ID_FB;
 	p->dev.dev_type = PS3_DEVICE_TYPE_IOC0;
 
 	result = ps3_system_bus_device_register(&p->dev);
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -347,16 +347,23 @@ static int ps3_system_bus_match(struct d
 	struct ps3_system_bus_driver *drv = ps3_drv_to_system_bus_drv(_drv);
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 
-	result = dev->match_id == drv->match_id;
+	if (!dev->match_sub_id)
+		result = dev->match_id == drv->match_id;
+	else
+		result = dev->match_sub_id == drv->match_sub_id &&
+			dev->match_id == drv->match_id;
 
 	if (result)
-		pr_info("%s:%d: dev=%u(%s), drv=%u(%s): match\n", __func__,
-			__LINE__, dev->match_id, dev->core.bus_id,
-			drv->match_id, drv->core.name);
+		pr_info("%s:%d: dev=%u.%u(%s), drv=%u.%u(%s): match\n",
+			__func__, __LINE__,
+			dev->match_id, dev->match_sub_id, dev->core.bus_id,
+			drv->match_id, drv->match_sub_id, drv->core.name);
 	else
-		pr_debug("%s:%d: dev=%u(%s), drv=%u(%s): miss\n", __func__,
-			__LINE__, dev->match_id, dev->core.bus_id,
-			drv->match_id, drv->core.name);
+		pr_debug("%s:%d: dev=%u.%u(%s), drv=%u.%u(%s): miss\n",
+			__func__, __LINE__,
+			dev->match_id, dev->match_sub_id, dev->core.bus_id,
+			drv->match_id, drv->match_sub_id, drv->core.name);
+
 	return result;
 }
 
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1297,6 +1297,7 @@ static int ps3fb_shutdown(struct ps3_sys
 
 static struct ps3_system_bus_driver ps3fb_driver = {
 	.match_id	= PS3_MATCH_ID_GRAPHICS,
+	.match_sub_id	= PS3_MATCH_SUB_ID_FB,
 	.core.name	= DEVICE_NAME,
 	.core.owner	= THIS_MODULE,
 	.probe		= ps3fb_probe,
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -337,12 +337,18 @@ enum ps3_system_bus_device_type {
 	PS3_DEVICE_TYPE_LPM,
 };
 
+enum ps3_match_sub_id {
+	/* for PS3_MATCH_ID_GRAPHICS */
+	PS3_MATCH_SUB_ID_FB		= 1,
+};
+
 /**
  * struct ps3_system_bus_device - a device on the system bus
  */
 
 struct ps3_system_bus_device {
 	enum ps3_match_id match_id;
+	enum ps3_match_sub_id match_sub_id;
 	enum ps3_system_bus_device_type dev_type;
 
 	u64 bus_id;                       /* SB */
@@ -371,6 +377,7 @@ int ps3_close_hv_device(struct ps3_syste
 
 struct ps3_system_bus_driver {
 	enum ps3_match_id match_id;
+	enum ps3_match_sub_id match_sub_id;
 	struct device_driver core;
 	int (*probe)(struct ps3_system_bus_device *);
 	int (*remove)(struct ps3_system_bus_device *);
