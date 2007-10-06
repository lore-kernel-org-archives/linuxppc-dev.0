Return-Path: <geoff@white.local.net>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0AFEFDDE3C
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:38:17 +1000 (EST)
Message-Id: <20071006213542.595771597@am.sony.com>
References: <20071006213542.311447584@am.sony.com>
Date: Sat, 06 Oct 2007 14:35:44 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 2/6] PS3: Remove unused os-area params
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates for PS3 os-area startup params
o Remove some unused PS3 os-area startup params from struct saved_params.
o Rename ps3_os_area_init() to ps3_os_area_save_params().
o Zero mirrored header after saving params.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c  |   44 ++++++++++++++--------------------
 arch/powerpc/platforms/ps3/platform.h |    2 -
 arch/powerpc/platforms/ps3/setup.c    |    2 -
 3 files changed, 21 insertions(+), 27 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -114,27 +114,12 @@ struct os_area_params {
 #define SECONDS_FROM_1970_TO_2000 946684800LL
 
 /**
- * struct saved_params - Static working copies of data from the 'Other OS' area.
- *
- * For the convinience of the guest, the HV makes a copy of the 'Other OS' area
- * in flash to a high address in the boot memory region and then puts that RAM
- * address and the byte count into the repository for retreval by the guest.
- * We copy the data we want into a static variable and allow the memory setup
- * by the HV to be claimed by the lmb manager.
+ * struct saved_params - Static working copies of data from the PS3 'os area'.
  */
 
 struct saved_params {
-	/* param 0 */
 	s64 rtc_diff;
 	unsigned int av_multi_out;
-	unsigned int ctrl_button;
-	/* param 1 */
-	u8 static_ip_addr[4];
-	u8 network_mask[4];
-	u8 default_gateway[4];
-	/* param 2 */
-	u8 dns_primary[4];
-	u8 dns_secondary[4];
 } static saved_params;
 
 #define dump_header(_a) _dump_header(_a, __func__, __LINE__)
@@ -201,7 +186,17 @@ static int __init verify_header(const st
 	return 0;
 }
 
-int __init ps3_os_area_init(void)
+/**
+ * ps3_os_area_save_params - Copy data from os area mirror to @saved_params.
+ *
+ * For the convenience of the guest, the HV makes a copy of the os area in
+ * flash to a high address in the boot memory region and then puts that RAM
+ * address and the byte count into the repository for retreval by the guest.
+ * We copy the data we want into a static variable and allow the memory setup
+ * by the HV to be claimed by the lmb manager.
+ */
+
+void __init ps3_os_area_save_params(void)
 {
 	int result;
 	u64 lpar_addr;
@@ -209,12 +204,14 @@ int __init ps3_os_area_init(void)
 	struct os_area_header *header;
 	struct os_area_params *params;
 
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
 	result = ps3_repository_read_boot_dat_info(&lpar_addr, &size);
 
 	if (result) {
 		pr_debug("%s:%d ps3_repository_read_boot_dat_info failed\n",
 			__func__, __LINE__);
-		return result;
+		return;
 	}
 
 	header = (struct os_area_header *)__va(lpar_addr);
@@ -226,7 +223,7 @@ int __init ps3_os_area_init(void)
 	if (result) {
 		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
 		dump_header(header);
-		return -EIO;
+		return;
 	}
 
 	dump_header(header);
@@ -234,13 +231,10 @@ int __init ps3_os_area_init(void)
 
 	saved_params.rtc_diff = params->rtc_diff;
 	saved_params.av_multi_out = params->av_multi_out;
-	saved_params.ctrl_button = params->ctrl_button;
-	memcpy(saved_params.static_ip_addr, params->static_ip_addr, 4);
-	memcpy(saved_params.network_mask, params->network_mask, 4);
-	memcpy(saved_params.default_gateway, params->default_gateway, 4);
-	memcpy(saved_params.dns_secondary, params->dns_secondary, 4);
 
-	return result;
+	memset(header, 0, sizeof(*header));
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 }
 
 /**
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -62,7 +62,7 @@ int ps3_set_rtc_time(struct rtc_time *ti
 
 /* os area */
 
-int __init ps3_os_area_init(void);
+void __init ps3_os_area_save_params(void);
 u64 ps3_os_area_rtc_diff(void);
 
 /* spu */
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -228,7 +228,7 @@ static int __init ps3_probe(void)
 
 	powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
 
-	ps3_os_area_init();
+	ps3_os_area_save_params();
 	ps3_mm_init();
 	ps3_mm_vas_create(&htab_size);
 	ps3_hpte_init(htab_size);

-- 
