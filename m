Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 8EB36DDF9B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:13:45 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 31C7514311
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:46 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15423-07 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:13:44 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id B80FC142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:44 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 03/11] [POWERPC] Add common mpc52xx_setup_pci() routine
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:13:21 +0200
Message-ID: <20071023231321.29359.96506.stgit@hekate.izotz.org>
In-Reply-To: <20071023231302.29359.27417.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
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

 arch/powerpc/platforms/52xx/lite5200.c    |    6 +-----
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |   15 +++++++++++++++
 include/asm-powerpc/mpc52xx.h             |    1 +
 3 files changed, 17 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 25d2bfa..0262a9f 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -155,11 +155,7 @@ static void __init lite5200_setup_arch(void)
 #endif
 
 #ifdef CONFIG_PCI
-	np = of_find_node_by_type(NULL, "pci");
-	if (np) {
-		mpc52xx_add_bridge(np);
-		of_node_put(np);
-	}
+	mpc52xx_setup_pci();
 #endif
 }
 
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
index 39f619f..859ffb0 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -251,6 +251,7 @@ extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
 extern int __init mpc52xx_add_bridge(struct device_node *node);
+extern void __init mpc52xx_setup_pci(void);
 
 extern void __init mpc52xx_map_wdt(void);
 extern void mpc52xx_restart(char *cmd);
