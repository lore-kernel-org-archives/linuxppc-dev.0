Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99F96DE1D8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 04:19:09 +1100 (EST)
Date: Thu, 13 Dec 2007 11:19:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] mpc834x_mds: Fix whitespace and call of_platform_bus_probe().
Message-ID: <20071213171905.GA4630@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc834x_mds.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index a81bb3c..459fb72 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -106,14 +107,30 @@ static void __init mpc834x_mds_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+static struct of_device_id mpc834x_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc834x_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_mds))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc834x_ids, NULL);
+	return 0;
+}
+device_initcall(mpc834x_declare_of_platform_devices);
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc834x_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC834xMDS");
+	return of_flat_dt_is_compatible(root, "MPC834xMDS");
 }
 
 define_machine(mpc834x_mds) {
-- 
1.5.3.7
