Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5831A30A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:47:51 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC v3 10/10] fsl_qman: Add HOTPLUG_CPU support
Date: Mon, 9 Mar 2015 09:41:55 -0500
Message-ID: <1425912115-27398-11-git-send-email-Emilian.Medve@Freescale.com>
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
 drivers/soc/fsl/qman_portal.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/fsl/qman_portal.c b/drivers/soc/fsl/qman_portal.c
index c4b96cc..27372d4 100644
--- a/drivers/soc/fsl/qman_portal.c
+++ b/drivers/soc/fsl/qman_portal.c
@@ -29,6 +29,9 @@
  */
 
 #include "qman_priv.h"
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpu.h>
+#endif
 
 /* Global variable containing revision id (even on non-control plane systems
  * where CCSR isn't available) */
@@ -380,6 +383,45 @@ static void qman_offline_cpu(unsigned int cpu)
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
@@ -498,5 +540,8 @@ __init int qman_init(void)
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
