Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1801CDDFC4
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:00:58 +1000 (EST)
Message-ID: <46365902.5030400@am.sony.com>
Date: Mon, 30 Apr 2007 14:00:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 2/6] PS3: Add DABR support
References: <20070430202420.872228544@am.sony.com>
In-Reply-To: <20070430202420.872228544@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add PS3 support for the PowerPC processor's Data Address Breakpoint Register
(DABR).

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/setup.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -137,6 +137,12 @@ early_param("ps3fb", early_parse_ps3fb);
 #define prealloc_ps3fb_videomemory()	do { } while (0)
 #endif
 
+static int ps3_set_dabr(u64 dabr)
+{
+	enum {DABR_USER = 1, DABR_KERNEL = 2,};
+
+	return lv1_set_dabr(dabr, DABR_KERNEL | DABR_USER) ? -1 : 0;
+}
 
 static void __init ps3_setup_arch(void)
 {
@@ -234,6 +240,7 @@ define_machine(ps3) {
 	.get_boot_time			= ps3_get_boot_time,
 	.set_rtc_time			= ps3_set_rtc_time,
 	.get_rtc_time			= ps3_get_rtc_time,
+	.set_dabr			= ps3_set_dabr,
 	.calibrate_decr			= ps3_calibrate_decr,
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,

-- 
