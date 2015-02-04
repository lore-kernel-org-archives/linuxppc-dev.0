Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEBD61A16AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:53:13 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <devel@driverdev.osuosl.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC 09/10] fsl_bman: Add HOTPLUG_CPU support
Date: Wed, 4 Feb 2015 08:48:41 -0600
Message-ID: <1423061322-16059-10-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
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

From: Hai-Ying Wang <Haiying.Wang@freescale.com>

Change-Id: I863d5c15c7f35f9de4ea3d985e4ff467167924b7
Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
---
 drivers/staging/fsl_qbman/bman_driver.c | 45 ++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl_qbman/bman_driver.c b/drivers/staging/fsl_qbman/bman_driver.c
index bab2283..18a6cdd 100644
--- a/drivers/staging/fsl_qbman/bman_driver.c
+++ b/drivers/staging/fsl_qbman/bman_driver.c
@@ -30,6 +30,9 @@
  */
 
 #include "bman_private.h"
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpu.h>
+#endif
 
 /*
  * Global variables of the max portal/pool number this bman version supported
@@ -180,7 +183,7 @@ static int __init parse_bportals(char *str)
 }
 __setup("bportals=", parse_bportals);
 
-static void bman_offline_cpu(unsigned int cpu)
+static void __cold bman_offline_cpu(unsigned int cpu)
 {
 	struct bman_portal *p = (struct bman_portal *)affine_bportals[cpu];
 	const struct bm_portal_config *pcfg;
@@ -192,6 +195,42 @@ static void bman_offline_cpu(unsigned int cpu)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void __cold bman_online_cpu(unsigned int cpu)
+{
+	struct bman_portal *p = (struct bman_portal *)affine_bportals[cpu];
+	const struct bm_portal_config *pcfg;
+
+	if (p) {
+		pcfg = bman_get_bm_portal_config(p);
+		if (pcfg)
+			irq_set_affinity(pcfg->public_cfg.irq, cpumask_of(cpu));
+	}
+}
+
+static int __cold bman_hotplug_cpu_callback(struct notifier_block *nfb,
+					    unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_ONLINE_FROZEN:
+		bman_online_cpu(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		bman_offline_cpu(cpu);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block bman_hotplug_cpu_notifier = {
+	.notifier_call = bman_hotplug_cpu_callback,
+};
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /* Initialise the Bman driver. The meat of this function deals with portals. The
  * following describes the flow of portal-handling, the code "steps" refer to
  * this description;
@@ -326,5 +365,9 @@ int __init bman_init(void)
 	for_each_cpu(cpu, &offline_cpus)
 		bman_offline_cpu(cpu);
 
+#ifdef CONFIG_HOTPLUG_CPU
+	register_hotcpu_notifier(&bman_hotplug_cpu_notifier);
+#endif
+
 	return 0;
 }
-- 
2.2.2
