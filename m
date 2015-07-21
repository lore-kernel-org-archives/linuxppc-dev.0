Return-Path: <yangbo.lu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0122.outbound.protection.outlook.com [207.46.100.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E8141A009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:06:19 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
CC: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 2/3] powerpc/85xx: add 'cpu-rev' property for cpus node
Date: Tue, 21 Jul 2015 17:45:23 +0800
Message-ID: <1437471923-34172-1-git-send-email-yangbo.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 'cpu-rev' property for cpus node to support getting cpu revision
from dts, since it's not good to get cpu revision using powerpc specific
function(like SVR_REV()) in common drivers.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/powerpc/platforms/85xx/common.c          | 34 +++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |  3 +++
 arch/powerpc/platforms/85xx/mpc85xx.h         |  1 +
 3 files changed, 38 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 7bfb9b1..5c55c0a4 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -8,8 +8,10 @@
 
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
 
 #include <asm/qe.h>
+#include <asm/mpc85xx.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
@@ -44,8 +46,40 @@ static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{},
 };
 
+/* Add 'cpu-rev' property into cpus node of device tree */
+int of_add_cpu_rev_property(void)
+{
+	struct device_node *cpus;
+	struct property *cpu_rev;
+	u8 *revision;
+	u32 svr;
+
+	svr = mfspr(SPRN_SVR);
+
+	revision = kzalloc(sizeof(*revision), GFP_KERNEL);
+	if (!revision)
+		return 0;
+	*revision = SVR_REV(svr);
+
+	cpu_rev = kzalloc(sizeof(*cpu_rev), GFP_KERNEL);
+	if (!cpu_rev)
+		return 0;
+	cpu_rev->name = "cpu-rev";
+	cpu_rev->value = revision;
+	cpu_rev->length = sizeof(*revision);
+
+	cpus = of_find_node_by_path("/cpus");
+	if (of_add_property(cpus, cpu_rev))
+		return 0;
+
+	return 1;
+}
+
 int __init mpc85xx_common_publish_devices(void)
 {
+	if (!of_add_cpu_rev_property())
+		pr_info("Add 'cpu-rev' property into cpus node: failed!\n");
+
 	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
 }
 #ifdef CONFIG_CPM2
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index bd839dc..880940f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -132,6 +132,9 @@ static const struct of_device_id of_device_ids[] = {
 
 int __init corenet_gen_publish_devices(void)
 {
+	if (!of_add_cpu_rev_property())
+		pr_info("Add 'cpu-rev' property into cpus node: failed!\n");
+
 	return of_platform_bus_probe(NULL, of_device_ids, NULL);
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 39056f6..bcc18e2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,5 +1,6 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
+extern int of_add_cpu_rev_property(void);
 extern int mpc85xx_common_publish_devices(void);
 
 #ifdef CONFIG_CPM2
-- 
2.1.0.27.g96db324
