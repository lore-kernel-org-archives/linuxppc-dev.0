Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C715DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 07:49:43 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH 2/3] powerpc: setup archdata for {of_}platform via a single
	platform_notify
Date: Thu, 19 Feb 2009 14:49:16 -0600
Message-Id: <1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since a number of powerpc chips are SoCs we end up having dma-able
devices that are registered as platform or of_platform devices.  We need
to hook the archdata to setup proper dma_ops for these devices.

In the short term the majority of these devices only need the
direct_dma_ops as the platforms don't have any IOMMUs.

In the future to enable >4G DMA support on ppc32 we can hook swiotlb ops.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h        |    4 ++++
 arch/powerpc/kernel/setup-common.c        |   22 ++++++++++++++++++++++
 arch/powerpc/kernel/setup.h               |    4 ++++
 arch/powerpc/kernel/setup_32.c            |    3 +++
 arch/powerpc/kernel/setup_64.c            |    3 +++
 arch/powerpc/platforms/cell/qpace_setup.c |   13 -------------
 6 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6c34a0d..9a28e5b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -262,6 +262,10 @@ struct machdep_calls {
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
 #endif
+	/* These are called via the driver core.  They mainly exist
+	 * for setting up archdata properly */
+	int (*platform_notify)(struct device *dev);
+	int (*platform_notify_remove)(struct device *dev);
 };
 
 extern void e500_idle(void);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 705fc4b..62dfa75 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -669,3 +669,25 @@ static int powerpc_debugfs_init(void)
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
+
+int ppc_platform_notify(struct device *dev)
+{
+	if (ppc_md.platform_notify)
+		return ppc_md.platform_notify(dev);
+
+	/* set dma_ops for platform or of_platform bus */
+	if (dev->bus && dev->bus->name &&
+			(!strcmp(dev->bus->name, "platform") ||
+			 !strcmp(dev->bus->name, "of_platform")))
+		set_dma_ops(dev, &dma_direct_ops);
+
+	return 0;
+}
+
+int ppc_platform_notify_remove(struct device *dev)
+{
+	if (ppc_md.platform_notify_remove)
+		return ppc_md.platform_notify_remove(dev);
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 4c67ad7..34899cf 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -1,9 +1,13 @@
 #ifndef _POWERPC_KERNEL_SETUP_H
 #define _POWERPC_KERNEL_SETUP_H
 
+#include <linux/device.h>
+
 void check_for_initrd(void);
 void do_init_bootmem(void);
 void setup_panic(void);
+int ppc_platform_notify(struct device *dev);
+int ppc_platform_notify_remove(struct device *dev);
 extern int do_early_xmon;
 
 #endif /* _POWERPC_KERNEL_SETUP_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9e1ca74..c20a49d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -328,6 +328,9 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
+	platform_notify = &ppc_platform_notify;
+	platform_notify_remove = &ppc_platform_notify_remove;
+
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 73e16e2..b22a3d9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -546,6 +546,9 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
+	platform_notify = &ppc_platform_notify;
+	platform_notify_remove = &ppc_platform_notify_remove;
+
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index be84e6a..775cd80 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -81,16 +81,6 @@ static int __init qpace_publish_devices(void)
 }
 machine_subsys_initcall(qpace, qpace_publish_devices);
 
-extern int qpace_notify(struct device *dev)
-{
-	/* set dma_ops for of_platform bus */
-	if (dev->bus && dev->bus->name
-			&& !strcmp(dev->bus->name, "of_platform"))
-		set_dma_ops(dev, &dma_direct_ops);
-
-	return 0;
-}
-
 static void __init qpace_setup_arch(void)
 {
 #ifdef CONFIG_SPU_BASE
@@ -115,9 +105,6 @@ static void __init qpace_setup_arch(void)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-
-	/* set notifier function */
-	platform_notify = &qpace_notify;
 }
 
 static int __init qpace_probe(void)
-- 
1.5.6.6
