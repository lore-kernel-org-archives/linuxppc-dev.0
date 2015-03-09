Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 624331A1118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:47:50 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC v3 09/10] fsl_bman: Add HOTPLUG_CPU support
Date: Mon, 9 Mar 2015 09:41:54 -0500
Message-ID: <1425912115-27398-10-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1425912115-27398-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1425912115-27398-1-git-send-email-Emilian.Medve@Freescale.com>
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

Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
---
 drivers/soc/fsl/bman_portal.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/bman_portal.c b/drivers/soc/fsl/bman_portal.c
index b06339a..60c966e 100644
--- a/drivers/soc/fsl/bman_portal.c
+++ b/drivers/soc/fsl/bman_portal.c
@@ -29,6 +29,9 @@
  */
 
 #include "bman_priv.h"
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpu.h>
+#endif
 
 /*
  * Global variables of the max portal/pool number this bman version supported
@@ -179,7 +182,7 @@ static int __init parse_bportals(char *str)
 }
 __setup("bportals=", parse_bportals);
 
-static void bman_offline_cpu(unsigned int cpu)
+static void __cold bman_offline_cpu(unsigned int cpu)
 {
 	struct bman_portal *p = (struct bman_portal *)affine_bportals[cpu];
 	const struct bm_portal_config *pcfg;
@@ -191,6 +194,42 @@ static void bman_offline_cpu(unsigned int cpu)
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
 /* Initialise the BMan driver. The meat of this function deals with portals. The
  * following describes the flow of portal-handling, the code "steps" refer to
  * this description;
@@ -325,5 +364,9 @@ int __init bman_init(void)
 	for_each_cpu(cpu, &offline_cpus)
 		bman_offline_cpu(cpu);
 
+#ifdef CONFIG_HOTPLUG_CPU
+	register_hotcpu_notifier(&bman_hotplug_cpu_notifier);
+#endif
+
 	return 0;
 }
-- 
2.3.0
