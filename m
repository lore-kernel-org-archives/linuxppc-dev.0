Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ5zk6kB2zDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:18:58 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id f8so20582953pag.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 23:18:58 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/pseries: Remove MPIC from pseries cpu hotplug
Date: Mon, 30 May 2016 16:18:14 +1000
Message-Id: <1464589095-442-4-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC was only used by Power3 which is now unsupported, so remove MPIC
code.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 282837a1d74b..a1b63e00b2f7 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -903,8 +903,6 @@ static int parse_cede_parameters(void)
 
 static int __init pseries_cpu_hotplug_init(void)
 {
-	struct device_node *np;
-	const char *typep;
 	int cpu;
 	int qcss_tok;
 
@@ -913,17 +911,6 @@ static int __init pseries_cpu_hotplug_init(void)
 	ppc_md.cpu_release = dlpar_cpu_release;
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
-	for_each_node_by_name(np, "interrupt-controller") {
-		typep = of_get_property(np, "compatible", NULL);
-		if (strstr(typep, "open-pic")) {
-			of_node_put(np);
-
-			printk(KERN_INFO "CPU Hotplug not supported on "
-				"systems using MPIC\n");
-			return 0;
-		}
-	}
-
 	rtas_stop_self_token = rtas_token("stop-self");
 	qcss_tok = rtas_token("query-cpu-stopped-state");
 
-- 
2.5.0
