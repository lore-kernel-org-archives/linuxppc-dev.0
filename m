Return-Path: <geoff@white.local.net>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B0A3DDE9A
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:38:17 +1000 (EST)
Message-Id: <20071006213542.867445085@am.sony.com>
References: <20071006213542.311447584@am.sony.com>
Date: Sat, 06 Oct 2007 14:35:47 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 5/6] PS3: Save os-area params to device tree
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the PS3 os-area startup params to the device tree.  This allows
a second stage kernel loaded with kexec to use these values.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c  |  104 +++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/ps3/platform.h |    1 
 arch/powerpc/platforms/ps3/setup.c    |    1 
 3 files changed, 104 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -119,10 +119,65 @@ struct os_area_params {
  */
 
 struct saved_params {
+	unsigned int valid;
 	s64 rtc_diff;
 	unsigned int av_multi_out;
 } static saved_params;
 
+static struct property property_rtc_diff = {
+	.name = "linux,rtc_diff",
+	.length = sizeof(saved_params.rtc_diff),
+	.value = &saved_params.rtc_diff,
+};
+
+static struct property property_av_multi_out = {
+	.name = "linux,av_multi_out",
+	.length = sizeof(saved_params.av_multi_out),
+	.value = &saved_params.av_multi_out,
+};
+
+/**
+ * os_area_set_property - Add or overwrite a saved_params value to the device tree.
+ *
+ * Overwrites an existing property.
+ */
+
+static void os_area_set_property(struct device_node *node,
+	struct property *prop)
+{
+	int result;
+	struct property *tmp = of_find_property(node, prop->name, NULL);
+
+	if (tmp) {
+		pr_debug("%s:%d found %s\n", __func__, __LINE__, prop->name);
+		prom_remove_property(node, tmp);
+	}
+
+	result = prom_add_property(node, prop);
+
+	if (result)
+		pr_debug("%s:%d prom_set_property failed\n", __func__,
+			__LINE__);
+}
+
+/**
+ * os_area_get_property - Get a saved_params value from the device tree.
+ *
+ */
+
+static void __init os_area_get_property(struct device_node *node,
+	struct property *prop)
+{
+	const struct property *tmp = of_find_property(node, prop->name, NULL);
+
+	if (tmp) {
+		BUG_ON(prop->length != tmp->length);
+		memcpy(prop->value, tmp->value, prop->length);
+	} else
+		pr_debug("%s:%d not found %s\n", __func__, __LINE__,
+			prop->name);
+}
+
 #define dump_header(_a) _dump_header(_a, __func__, __LINE__)
 static void _dump_header(const struct os_area_header *h, const char *func,
 	int line)
@@ -196,8 +251,19 @@ static int __init verify_header(const st
 
 static void os_area_queue_work_handler(struct work_struct *work)
 {
+	struct device_node *node;
+
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
+	node = of_find_node_by_path("/");
+
+	if (node) {
+		os_area_set_property(node, &property_rtc_diff);
+		of_node_put(node);
+	} else
+		pr_debug("%s:%d of_find_node_by_path failed\n",
+			__func__, __LINE__);
+
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 }
 
@@ -244,6 +310,8 @@ void __init ps3_os_area_save_params(void
 	result = verify_header(header);
 
 	if (result) {
+		/* Second stage kernels exit here. */
+
 		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
 		dump_header(header);
 		return;
@@ -254,6 +322,7 @@ void __init ps3_os_area_save_params(void
 
 	saved_params.rtc_diff = params->rtc_diff;
 	saved_params.av_multi_out = params->av_multi_out;
+	saved_params.valid = 1;
 
 	memset(header, 0, sizeof(*header));
 
@@ -261,13 +330,44 @@ void __init ps3_os_area_save_params(void
 }
 
 /**
+ * ps3_os_area_init - Setup os area device tree properties as needed.
+ */
+
+void __init ps3_os_area_init(void)
+{
+	struct device_node *node;
+
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	node = of_find_node_by_path("/");
+
+	if (!saved_params.valid && node) {
+		/* Second stage kernels should have a dt entry. */
+		os_area_get_property(node, &property_rtc_diff);
+		os_area_get_property(node, &property_av_multi_out);
+	}
+
+	if(!saved_params.rtc_diff)
+		saved_params.rtc_diff = SECONDS_FROM_1970_TO_2000;
+
+	if (node) {
+		os_area_set_property(node, &property_rtc_diff);
+		os_area_set_property(node, &property_av_multi_out);
+		of_node_put(node);
+	} else
+		pr_debug("%s:%d of_find_node_by_path failed\n",
+			__func__, __LINE__);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+
+/**
  * ps3_os_area_get_rtc_diff - Returns the rtc diff value.
  */
 
 u64 ps3_os_area_get_rtc_diff(void)
 {
-	return saved_params.rtc_diff ? saved_params.rtc_diff
-		: SECONDS_FROM_1970_TO_2000;
+	return saved_params.rtc_diff;
 }
 
 /**
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -63,6 +63,7 @@ int ps3_set_rtc_time(struct rtc_time *ti
 /* os area */
 
 void __init ps3_os_area_save_params(void);
+void __init ps3_os_area_init(void);
 u64 ps3_os_area_get_rtc_diff(void);
 void ps3_os_area_set_rtc_diff(u64 rtc_diff);
 
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -206,6 +206,7 @@ static void __init ps3_setup_arch(void)
 	prealloc_ps3flash_bounce_buffer();
 
 	ppc_md.power_save = ps3_power_save;
+	ps3_os_area_init();
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }

-- 
