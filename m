Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C61AE1A0F21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:51:27 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 10/10] fsl_qman: Add HOTPLUG_CPU support
Date: Mon, 16 Feb 2015 09:46:21 -0600
Message-ID: <1424101581-22109-11-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
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

Change-Id: Ica4d1b2b0fd3c3ae5e043663febd9f4cb7c762cf
Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
---
 drivers/soc/freescale/qman_portal.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/freescale/qman_portal.c b/drivers/soc/freescale/qman_portal.c
index 7216de1..b008b41 100644
--- a/drivers/soc/freescale/qman_portal.c
+++ b/drivers/soc/freescale/qman_portal.c
@@ -30,6 +30,9 @@
  */
 
 #include "qman_priv.h"
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpu.h>
+#endif
 
 /* Global variable containing revision id (even on non-control plane systems
  * where CCSR isn't available) */
@@ -381,6 +384,45 @@ static void qman_offline_cpu(unsigned int cpu)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void qman_online_cpu(unsigned int cpu)
+{
+	struct qman_portal *p;
+	const struct qm_portal_config *pcfg;
+	p = (struct qman_portal *)affine_portals[cpu];
+	if (p) {
+		pcfg = qman_get_qm_portal_config(p);
+		if (pcfg) {
+			irq_set_affinity(pcfg->public_cfg.irq, cpumask_of(cpu));
+			qman_portal_update_sdest(pcfg, cpu);
+		}
+	}
+}
+
+static int __cpuinit qman_hotplug_cpu_callback(struct notifier_block *nfb,
+				unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_ONLINE_FROZEN:
+		qman_online_cpu(cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		qman_offline_cpu(cpu);
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block qman_hotplug_cpu_notifier = {
+	.notifier_call = qman_hotplug_cpu_callback,
+};
+#endif /* CONFIG_HOTPLUG_CPU */
+
 __init int qman_init(void)
 {
 	struct cpumask slave_cpus;
@@ -499,5 +541,8 @@ __init int qman_init(void)
 	cpumask_andnot(&offline_cpus, cpu_possible_mask, cpu_online_mask);
 	for_each_cpu(cpu, &offline_cpus)
 		qman_offline_cpu(cpu);
+#ifdef CONFIG_HOTPLUG_CPU
+	register_hotcpu_notifier(&qman_hotplug_cpu_notifier);
+#endif
 	return 0;
 }
-- 
2.3.0
