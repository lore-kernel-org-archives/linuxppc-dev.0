Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 07672DE250
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:05:23 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 57E8814399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:15 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09143-10 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:06:14 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 5A59F14377
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:12 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 03/13] [POWERPC] Add common mpc52xx_setup_pci() routine
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:05:12 +0100
Message-ID: <20071106200512.10913.78165.stgit@hekate.izotz.org>
In-Reply-To: <20071106200446.10913.29338.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
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

This patch moves a generic pci init code from lite5200
platform file to a common mpc52xx_setup_pci() routine
and adds additional compatibility property verification.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/platforms/52xx/lite5200.c    |   12 +-----------
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |   15 +++++++++++++++
 include/asm-powerpc/mpc52xx.h             |    5 +++++
 3 files changed, 21 insertions(+), 11 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 25d2bfa..ce903be 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -131,10 +131,6 @@ static void lite5200_resume_finish(void __iomem *mbar)
 
 static void __init lite5200_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("lite5200_setup_arch()", 0);
 
@@ -154,13 +150,7 @@ static void __init lite5200_setup_arch(void)
 	lite5200_pm_init();
 #endif
 
-#ifdef CONFIG_PCI
-	np = of_find_node_by_type(NULL, "pci");
-	if (np) {
-		mpc52xx_add_bridge(np);
-		of_node_put(np);
-	}
-#endif
+	mpc52xx_setup_pci();
 }
 
 /*
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 4c6c82a..89304f2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -406,3 +406,18 @@ mpc52xx_add_bridge(struct device_node *node)
 
 	return 0;
 }
+
+void __init mpc52xx_setup_pci(void)
+{
+	struct device_node *pci;
+
+	pci = of_find_node_by_type(NULL, "pci");
+	if (!pci)
+		return;
+
+	if (of_device_is_compatible(pci, "fsl,mpc5200-pci") ||
+		of_device_is_compatible(pci, "mpc5200-pci"))
+		mpc52xx_add_bridge(pci);
+
+	of_node_put(pci);
+}
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index fcb2ebb..d7efbe0 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -257,7 +257,12 @@ extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
+#ifdef CONFIG_PCI
 extern int __init mpc52xx_add_bridge(struct device_node *node);
+extern void __init mpc52xx_setup_pci(void);
+#else
+static inline void mpc52xx_setup_pci(void) { }
+#endif
 
 extern void __init mpc52xx_map_wdt(void);
 extern void mpc52xx_restart(char *cmd);
