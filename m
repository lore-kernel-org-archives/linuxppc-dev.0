Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id DDC2FDDFC7
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:44:54 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id DB28014383
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:44:54 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16741-01 for <linuxppc-dev@ozlabs.org>;
	Thu, 18 Oct 2007 20:44:53 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 23D99142D3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:44:53 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2 3/4] [POWERPC] Add restart support for mpc52xx based
	platforms
To: linuxppc-dev@ozlabs.org
Date: Thu, 18 Oct 2007 20:44:33 +0200
Message-ID: <20071018184433.3584.77107.stgit@hekate.izotz.org>
In-Reply-To: <20071018184407.3584.3513.stgit@hekate.izotz.org>
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add common helper routines: mpc52xx_map_wdt() and mpc52xx_restart().

This patch relies on Sascha Hauer's patch published in:
http://patchwork.ozlabs.org/linuxppc/patch?id=8910.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |   50 ++++++++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h                |    3 ++
 2 files changed, 53 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 74b4b41..9850685 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -18,6 +18,13 @@
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
 
+/*
+ * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restart().
+ * Permanent mapping is required because mpc52xx_restart() can be called
+ * from interrupt context while node mapping (which calls ioremap())
+ * cannot be used at such point.
+ */
+static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
 
 static void __iomem *
 mpc52xx_map_node(struct device_node *ofn)
@@ -126,3 +133,46 @@ mpc52xx_declare_of_platform_devices(void)
 			"Error while probing of_platform bus\n");
 }
 
+void __init
+mpc52xx_map_wdt(void)
+{
+	const void *has_wdt;
+	struct device_node *np;
+
+	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
+	 * possibly from a interrupt context. wdt is only implement
+	 * on a gpt0, so check has-wdt property before mapping.
+	 */
+	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpt") {
+		has_wdt = of_get_property(np, "fsl,has-wdt", NULL);
+		if (has_wdt) {
+			mpc52xx_wdt = mpc52xx_map_node(np);
+			return;
+		}
+	}
+	for_each_compatible_node(np, NULL, "mpc5200-gpt") {
+		has_wdt = of_get_property(np, "has-wdt", NULL);
+		if (has_wdt) {
+			mpc52xx_wdt = mpc52xx_map_node(np);
+			return;
+		}
+	}
+}
+
+void
+mpc52xx_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Turn on the watchdog and wait for it to expire.
+	 * It effectively does a reset. */
+	if (mpc52xx_wdt) {
+		out_be32(&mpc52xx_wdt->mode, 0x00000000);
+		out_be32(&mpc52xx_wdt->count, 0x000000ff);
+		out_be32(&mpc52xx_wdt->mode, 0x00009004);
+	} else
+		printk("mpc52xx_restart: Can't access wdt. "
+			"Restart impossible, system halted.\n");
+
+	while (1);
+}
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 9cf05f9..39f619f 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -252,6 +252,9 @@ extern unsigned int mpc52xx_get_irq(void);
 
 extern int __init mpc52xx_add_bridge(struct device_node *node);
 
+extern void __init mpc52xx_map_wdt(void);
+extern void mpc52xx_restart(char *cmd);
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_PM
