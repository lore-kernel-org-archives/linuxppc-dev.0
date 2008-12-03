Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 1629FDDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:54:26 +1100 (EST)
Message-ID: <49371BB5.4080406@am.sony.com>
Date: Wed, 3 Dec 2008 15:52:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 3/3] powerpc/ps3: Add sub-match id modalias support
References: <49371ACA.9040800@am.sony.com>
In-Reply-To: <49371ACA.9040800@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

commit 059e4938f8b060b10c4352e6c45739473bc73267 ("powerpc/ps3: Add a sub-match
id to ps3_system_bus") forgot to update the module alias support:
  - Add the sub-match ids to the module aliases, so udev can distinguish
    between different types of sub-devices.
  - Rename PS3_MODULE_ALIAS_GRAPHICS to PS3_MODULE_ALIAS_GPU_FB, as ps3fb
    binds to the "FB" sub-device.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/ps3.h           |   57 +++++++++++++++----------------
 arch/powerpc/platforms/ps3/device-init.c |    4 +-
 arch/powerpc/platforms/ps3/system-bus.c  |   10 +++--
 drivers/video/ps3fb.c                    |    6 +--
 4 files changed, 39 insertions(+), 38 deletions(-)

--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -305,30 +305,34 @@ static inline const char* ps3_result(int
 /* system bus routines */
 
 enum ps3_match_id {
-	PS3_MATCH_ID_EHCI           = 1,
-	PS3_MATCH_ID_OHCI           = 2,
-	PS3_MATCH_ID_GELIC          = 3,
-	PS3_MATCH_ID_AV_SETTINGS    = 4,
-	PS3_MATCH_ID_SYSTEM_MANAGER = 5,
-	PS3_MATCH_ID_STOR_DISK      = 6,
-	PS3_MATCH_ID_STOR_ROM       = 7,
-	PS3_MATCH_ID_STOR_FLASH     = 8,
-	PS3_MATCH_ID_SOUND          = 9,
-	PS3_MATCH_ID_GRAPHICS       = 10,
-	PS3_MATCH_ID_LPM            = 11,
-};
-
-#define PS3_MODULE_ALIAS_EHCI           "ps3:1"
-#define PS3_MODULE_ALIAS_OHCI           "ps3:2"
-#define PS3_MODULE_ALIAS_GELIC          "ps3:3"
-#define PS3_MODULE_ALIAS_AV_SETTINGS    "ps3:4"
-#define PS3_MODULE_ALIAS_SYSTEM_MANAGER "ps3:5"
-#define PS3_MODULE_ALIAS_STOR_DISK      "ps3:6"
-#define PS3_MODULE_ALIAS_STOR_ROM       "ps3:7"
-#define PS3_MODULE_ALIAS_STOR_FLASH     "ps3:8"
-#define PS3_MODULE_ALIAS_SOUND          "ps3:9"
-#define PS3_MODULE_ALIAS_GRAPHICS       "ps3:10"
-#define PS3_MODULE_ALIAS_LPM            "ps3:11"
+	PS3_MATCH_ID_EHCI		= 1,
+	PS3_MATCH_ID_OHCI		= 2,
+	PS3_MATCH_ID_GELIC		= 3,
+	PS3_MATCH_ID_AV_SETTINGS	= 4,
+	PS3_MATCH_ID_SYSTEM_MANAGER	= 5,
+	PS3_MATCH_ID_STOR_DISK		= 6,
+	PS3_MATCH_ID_STOR_ROM		= 7,
+	PS3_MATCH_ID_STOR_FLASH		= 8,
+	PS3_MATCH_ID_SOUND		= 9,
+	PS3_MATCH_ID_GPU		= 10,
+	PS3_MATCH_ID_LPM		= 11,
+};
+
+enum ps3_match_sub_id {
+	PS3_MATCH_SUB_ID_GPU_FB		= 1,
+};
+
+#define PS3_MODULE_ALIAS_EHCI		"ps3:1:0"
+#define PS3_MODULE_ALIAS_OHCI		"ps3:2:0"
+#define PS3_MODULE_ALIAS_GELIC		"ps3:3:0"
+#define PS3_MODULE_ALIAS_AV_SETTINGS	"ps3:4:0"
+#define PS3_MODULE_ALIAS_SYSTEM_MANAGER	"ps3:5:0"
+#define PS3_MODULE_ALIAS_STOR_DISK	"ps3:6:0"
+#define PS3_MODULE_ALIAS_STOR_ROM	"ps3:7:0"
+#define PS3_MODULE_ALIAS_STOR_FLASH	"ps3:8:0"
+#define PS3_MODULE_ALIAS_SOUND		"ps3:9:0"
+#define PS3_MODULE_ALIAS_GPU_FB		"ps3:10:1"
+#define PS3_MODULE_ALIAS_LPM		"ps3:11:0"
 
 enum ps3_system_bus_device_type {
 	PS3_DEVICE_TYPE_IOC0 = 1,
@@ -337,11 +341,6 @@ enum ps3_system_bus_device_type {
 	PS3_DEVICE_TYPE_LPM,
 };
 
-enum ps3_match_sub_id {
-	/* for PS3_MATCH_ID_GRAPHICS */
-	PS3_MATCH_SUB_ID_FB		= 1,
-};
-
 /**
  * struct ps3_system_bus_device - a device on the system bus
  */
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -497,8 +497,8 @@ static int __init ps3_register_graphics_
 	if (!p)
 		return -ENOMEM;
 
-	p->dev.match_id = PS3_MATCH_ID_GRAPHICS;
-	p->dev.match_sub_id = PS3_MATCH_SUB_ID_FB;
+	p->dev.match_id = PS3_MATCH_ID_GPU;
+	p->dev.match_sub_id = PS3_MATCH_SUB_ID_GPU_FB;
 	p->dev.dev_type = PS3_DEVICE_TYPE_IOC0;
 
 	result = ps3_system_bus_device_register(&p->dev);
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -175,7 +175,7 @@ int ps3_open_hv_device(struct ps3_system
 		return ps3_open_hv_device_sb(dev);
 
 	case PS3_MATCH_ID_SOUND:
-	case PS3_MATCH_ID_GRAPHICS:
+	case PS3_MATCH_ID_GPU:
 		return ps3_open_hv_device_gpu(dev);
 
 	case PS3_MATCH_ID_AV_SETTINGS:
@@ -213,7 +213,7 @@ int ps3_close_hv_device(struct ps3_syste
 		return ps3_close_hv_device_sb(dev);
 
 	case PS3_MATCH_ID_SOUND:
-	case PS3_MATCH_ID_GRAPHICS:
+	case PS3_MATCH_ID_GPU:
 		return ps3_close_hv_device_gpu(dev);
 
 	case PS3_MATCH_ID_AV_SETTINGS:
@@ -453,7 +453,8 @@ static int ps3_system_bus_uevent(struct 
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 
-	if (add_uevent_var(env, "MODALIAS=ps3:%d", dev->match_id))
+	if (add_uevent_var(env, "MODALIAS=ps3:%d:%d", dev->match_id,
+			   dev->match_sub_id))
 		return -ENOMEM;
 	return 0;
 }
@@ -462,7 +463,8 @@ static ssize_t modalias_show(struct devi
 	char *buf)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
-	int len = snprintf(buf, PAGE_SIZE, "ps3:%d\n", dev->match_id);
+	int len = snprintf(buf, PAGE_SIZE, "ps3:%d:%d\n", dev->match_id,
+			   dev->match_sub_id);
 
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1289,8 +1289,8 @@ static int ps3fb_shutdown(struct ps3_sys
 }
 
 static struct ps3_system_bus_driver ps3fb_driver = {
-	.match_id	= PS3_MATCH_ID_GRAPHICS,
-	.match_sub_id	= PS3_MATCH_SUB_ID_FB,
+	.match_id	= PS3_MATCH_ID_GPU,
+	.match_sub_id	= PS3_MATCH_SUB_ID_GPU_FB,
 	.core.name	= DEVICE_NAME,
 	.core.owner	= THIS_MODULE,
 	.probe		= ps3fb_probe,
@@ -1348,4 +1348,4 @@ module_exit(ps3fb_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("PS3 GPU Frame Buffer Driver");
 MODULE_AUTHOR("Sony Computer Entertainment Inc.");
-MODULE_ALIAS(PS3_MODULE_ALIAS_GRAPHICS);
+MODULE_ALIAS(PS3_MODULE_ALIAS_GPU_FB);

-- 
