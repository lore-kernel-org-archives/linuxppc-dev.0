Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A211B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 16:22:30 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linux-watchdog@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/watchdog: move booke watchdog param related code
 to prom.c
Date: Tue, 8 May 2012 14:07:11 +0800
Message-ID: <1336457231-32513-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is
in setup_32.c, it cannot be used in 64-bit, so move it to a common place
prom.c, which will be shared by 32-bit and 64-bit.

Also, replace the simple_strtoul with kstrtol.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/kernel/prom.c     |   27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c |   24 ------------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f191bf0..49e1bdf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -84,6 +84,33 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+#ifdef CONFIG_BOOKE_WDT
+extern u32 booke_wdt_enabled;
+extern u32 booke_wdt_period;
+
+/* Checks wdt=x and wdt_period=xx command-line option */
+notrace int __init early_parse_wdt(char *p)
+{
+	if (p && strncmp(p, "0", 1) != 0)
+		booke_wdt_enabled = 1;
+
+	return 0;
+}
+early_param("wdt", early_parse_wdt);
+
+int __init early_parse_wdt_period(char *p)
+{
+	unsigned long ret;
+	if (p) {
+		if (!kstrtol(p, 0, &ret))
+			booke_wdt_period = ret;
+	}
+
+	return 0;
+}
+early_param("wdt_period", early_parse_wdt_period);
+#endif	/* CONFIG_BOOKE_WDT */
+
 /*
  * overlaps_initrd - check for overlap with page aligned extension of
  * initrd.
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ec8a53f..a8f54ec 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -149,30 +149,6 @@ notrace void __init machine_init(u64 dt_ptr)
 		ppc_md.progress("id mach(): done", 0x200);
 }
 
-#ifdef CONFIG_BOOKE_WDT
-extern u32 booke_wdt_enabled;
-extern u32 booke_wdt_period;
-
-/* Checks wdt=x and wdt_period=xx command-line option */
-notrace int __init early_parse_wdt(char *p)
-{
-	if (p && strncmp(p, "0", 1) != 0)
-	       booke_wdt_enabled = 1;
-
-	return 0;
-}
-early_param("wdt", early_parse_wdt);
-
-int __init early_parse_wdt_period (char *p)
-{
-	if (p)
-		booke_wdt_period = simple_strtoul(p, NULL, 0);
-
-	return 0;
-}
-early_param("wdt_period", early_parse_wdt_period);
-#endif	/* CONFIG_BOOKE_WDT */
-
 /* Checks "l2cr=xxxx" command-line option */
 int __init ppc_setup_l2cr(char *str)
 {
-- 
1.6.4
