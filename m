Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 18E14DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 12:18:41 +1100 (EST)
Message-ID: <45F74D69.5070600@am.sony.com>
Date: Tue, 13 Mar 2007 18:18:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix hardware watchpoints
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Add PS3 support for the PowerPC processor's Data Address Breakpoint
Register (DABR).

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Paul, please consider for 2.6.21.


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
