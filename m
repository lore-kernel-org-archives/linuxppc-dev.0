Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFFE4DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 00:41:06 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH v2 2/3] powerpc: setup default archdata for {of_}platform via
	bus_register_notifier
Date: Thu, 19 Mar 2009 08:40:51 -0500
Message-Id: <1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
References: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>
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

Rather than having to add a bus_notify to each platform we add a default
one at the highest priority (called first) to set the default dma_ops for
of_platform and platform devices to dma_direct_ops.  This allows platform
code to override the ops by providing their own notifier call back.

In the future to enable >4G DMA support on ppc32 we can hook swiotlb ops.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

* Use bus notifiers instead of platform_notify

 arch/powerpc/kernel/setup-common.c        |   36 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/qpace_setup.c |   13 ----------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 705fc4b..9774f9f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,6 +35,8 @@
 #include <linux/debugfs.h>
 #include <linux/percpu.h>
 #include <linux/lmb.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -669,3 +671,37 @@ static int powerpc_debugfs_init(void)
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
+
+static int ppc_dflt_bus_notify(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	/* We are only intereted in device addition */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	set_dma_ops(dev, &dma_direct_ops);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_dflt_plat_bus_notifier = {
+	.notifier_call = ppc_dflt_bus_notify,
+	.priority = INT_MAX,
+};
+
+static struct notifier_block ppc_dflt_of_bus_notifier = {
+	.notifier_call = ppc_dflt_bus_notify,
+	.priority = INT_MAX,
+};
+
+static int __init setup_bus_notifier(void)
+{
+	bus_register_notifier(&platform_bus_type, &ppc_dflt_plat_bus_notifier);
+	bus_register_notifier(&of_platform_bus_type, &ppc_dflt_of_bus_notifier);
+
+	return 0;
+}
+
+arch_initcall(setup_bus_notifier);
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index c75b662..c5ce02e 100644
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
