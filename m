Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEC102C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 20:17:21 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linux-watchdog@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v2] powerpc/watchdog: move booke watchdog param related code
 to setup-common.c
Date: Wed, 11 Jul 2012 17:56:08 +0800
Message-ID: <1342000568-5605-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is
in setup_32.c, it cannot be used in 64-bit, so move it to a common place
setup-common.c, which will be shared by 32-bit and 64-bit.

Also, replace the simple_strtoul with kstrtol.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
changes for v2:
use setup-common.c instead of prom.c

 arch/powerpc/kernel/setup-common.c |   27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c     |   24 ------------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index afd4f05..bdc499c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -720,6 +720,33 @@ static int powerpc_debugfs_init(void)
 arch_initcall(powerpc_debugfs_init);
 #endif
 
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
 void ppc_printk_progress(char *s, unsigned short hex)
 {
 	pr_info("%s\n", s);
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
