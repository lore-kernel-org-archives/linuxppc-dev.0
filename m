Return-Path: <geoff@white.local.net>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F1802DDE37
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:38:17 +1000 (EST)
Message-Id: <20071006213542.509952005@am.sony.com>
References: <20071006213542.311447584@am.sony.com>
Date: Sat, 06 Oct 2007 14:35:43 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 1/6] PS3: Cleanup of os-area.c
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minor cleanup of the PS3 file os-area.c:
 o Correct file text header.
 o Add type names enum os_area_ldr_format, enum os_area_boot_flag,
   enum os_area_ctrl_button.
 o Change struct os_area_header.magic_num type to u8.
 o Add preprocessor macro SECONDS_FROM_1970_TO_2000.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -1,5 +1,5 @@
 /*
- *  PS3 'Other OS' area data.
+ *  PS3 flash memory os area.
  *
  *  Copyright (C) 2006 Sony Computer Entertainment Inc.
  *  Copyright 2006 Sony Corp.
@@ -29,7 +29,7 @@ enum {
 	OS_AREA_SEGMENT_SIZE = 0X200,
 };
 
-enum {
+enum os_area_ldr_format {
 	HEADER_LDR_FORMAT_RAW = 0,
 	HEADER_LDR_FORMAT_GZIP = 1,
 };
@@ -50,7 +50,7 @@ enum {
  */
 
 struct os_area_header {
-	s8 magic_num[16];
+	u8 magic_num[16];
 	u32 hdr_version;
 	u32 os_area_offset;
 	u32 ldr_area_offset;
@@ -60,12 +60,12 @@ struct os_area_header {
 	u32 _reserved_2[6];
 };
 
-enum {
+enum os_area_boot_flag {
 	PARAM_BOOT_FLAG_GAME_OS = 0,
 	PARAM_BOOT_FLAG_OTHER_OS = 1,
 };
 
-enum {
+enum os_area_ctrl_button {
 	PARAM_CTRL_BUTTON_O_IS_YES = 0,
 	PARAM_CTRL_BUTTON_X_IS_YES = 1,
 };
@@ -84,6 +84,9 @@ enum {
  * @dns_primary: User preference of static primary dns server.
  * @dns_secondary: User preference of static secondary dns server.
  *
+ * The ps3 rtc maintains a read-only value that approximates seconds since
+ * 2000-01-01 00:00:00 UTC.
+ *
  * User preference of zero for static_ip_addr means use dhcp.
  */
 
@@ -108,6 +111,8 @@ struct os_area_params {
 	u8 _reserved_5[8];
 };
 
+#define SECONDS_FROM_1970_TO_2000 946684800LL
+
 /**
  * struct saved_params - Static working copies of data from the 'Other OS' area.
  *
@@ -213,7 +218,8 @@ int __init ps3_os_area_init(void)
 	}
 
 	header = (struct os_area_header *)__va(lpar_addr);
-	params = (struct os_area_params *)__va(lpar_addr + OS_AREA_SEGMENT_SIZE);
+	params = (struct os_area_params *)__va(lpar_addr
+		+ OS_AREA_SEGMENT_SIZE);
 
 	result = verify_header(header);
 
@@ -238,16 +244,13 @@ int __init ps3_os_area_init(void)
 }
 
 /**
- * ps3_os_area_rtc_diff - Returns the ps3 rtc diff value.
- *
- * The ps3 rtc maintains a value that approximates seconds since
- * 2000-01-01 00:00:00 UTC.  Returns the exact number of seconds from 1970 to
- * 2000 when saved_params.rtc_diff has not been properly set up.
+ * ps3_os_area_rtc_diff - Returns the rtc diff value.
  */
 
 u64 ps3_os_area_rtc_diff(void)
 {
-	return saved_params.rtc_diff ? saved_params.rtc_diff : 946684800UL;
+	return saved_params.rtc_diff ? saved_params.rtc_diff
+		: SECONDS_FROM_1970_TO_2000;
 }
 
 /**

-- 
