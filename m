Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8B698DE55E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:40:27 +1100 (EST)
Message-ID: <45B81895.7070401@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 11/14] ps3: get av_multi_out params
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Allow the PS3 AV settings driver to access the default video mode stored in
the OS area.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/os-area.c |   17 ++++++++++-------
 include/asm-powerpc/ps3.h            |   11 +++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/os-area.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/os-area.c
@@ -67,13 +67,6 @@ enum {
 };
 
 enum {
-	PARAM_AV_MULTI_OUT_NTSC = 0,
-	PARAM_AV_MULTI_OUT_PAL_RGB = 1,
-	PARAM_AV_MULTI_OUT_PAL_YCBCR = 2,
-	PARAM_AV_MULTI_OUT_SECAM = 3,
-};
-
-enum {
 	PARAM_CTRL_BUTTON_O_IS_YES = 0,
 	PARAM_CTRL_BUTTON_X_IS_YES = 1,
 };
@@ -257,3 +250,13 @@ u64 ps3_os_area_rtc_diff(void)
 {
 	return saved_params.rtc_diff ? saved_params.rtc_diff : 946684800UL;
 }
+
+/**
+ * ps3_os_area_get_av_multi_out - Returns the default video mode.
+ */
+
+enum ps3_param_av_multi_out ps3_os_area_get_av_multi_out(void)
+{
+    return saved_params.av_multi_out;
+}
+EXPORT_SYMBOL_GPL(ps3_os_area_get_av_multi_out);
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -36,6 +36,17 @@ struct ps3_firmware_version {
 
 int ps3_get_firmware_version(struct ps3_firmware_version *v);
 
+/* 'Other OS' area */
+
+enum ps3_param_av_multi_out {
+	PS3_PARAM_AV_MULTI_OUT_NTSC = 0,
+	PS3_PARAM_AV_MULTI_OUT_PAL_RGB = 1,
+	PS3_PARAM_AV_MULTI_OUT_PAL_YCBCR = 2,
+	PS3_PARAM_AV_MULTI_OUT_SECAM = 3,
+};
+
+enum ps3_param_av_multi_out ps3_os_area_get_av_multi_out(void);
+
 /**
  * struct ps3_device_id - HV bus device identifier from the system repository
  * @bus_id: HV bus id, {1..} (zero invalid)
