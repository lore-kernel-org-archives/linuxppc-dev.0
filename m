Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 46ACADDF41
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:53:01 +1000 (EST)
Date: Tue, 24 Apr 2007 13:51:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/5] [POWERPC] Remove old interface find_type_devices
Message-Id: <20070424135159.eea14773.sfr@canb.auug.org.au>
In-Reply-To: <20070424134841.cee3ff4e.sfr@canb.auug.org.au>
References: <20070413171422.c19353e2.sfr@canb.auug.org.au>
	<20070424134841.cee3ff4e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replaced by of_find_node_by_type.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c                   |   19 -------------------
 arch/powerpc/platforms/chrp/setup.c          |    6 ++++--
 arch/powerpc/platforms/powermac/cpufreq_32.c |    3 ++-
 arch/powerpc/platforms/powermac/setup.c      |    5 +++--
 drivers/macintosh/via-pmu.c                  |    5 ++++-
 include/asm-powerpc/prom.h                   |    1 -
 6 files changed, 13 insertions(+), 26 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 17c41fe..860c88b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1091,25 +1091,6 @@ struct device_node *find_devices(const char *name)
 }
 EXPORT_SYMBOL(find_devices);
 
-/**
- * Construct and return a list of the device_nodes with a given type.
- */
-struct device_node *find_type_devices(const char *type)
-{
-	struct device_node *head, **prevp, *np;
-
-	prevp = &head;
-	for (np = allnodes; np != 0; np = np->allnext) {
-		if (np->type != 0 && strcasecmp(np->type, type) == 0) {
-			*prevp = np;
-			prevp = &np->next;
-		}
-	}
-	*prevp = NULL;
-	return head;
-}
-EXPORT_SYMBOL(find_type_devices);
-
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index e46c4d4..9c1b231 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -226,12 +226,12 @@ static void __init pegasos_set_l2cr(void)
 		return;
 
 	/* Enable L2 cache if needed */
-	np = find_type_devices("cpu");
+	np = of_find_node_by_type(NULL, "cpu");
 	if (np != NULL) {
 		const unsigned int *l2cr = of_get_property(np, "l2cr", NULL);
 		if (l2cr == NULL) {
 			printk ("Pegasos l2cr : no cpu l2cr property found\n");
-			return;
+			goto out;
 		}
 		if (!((*l2cr) & 0x80000000)) {
 			printk ("Pegasos l2cr : L2 cache was not active, "
@@ -240,6 +240,8 @@ static void __init pegasos_set_l2cr(void)
 			_set_L2CR((*l2cr) | 0x80000000);
 		}
 	}
+out:
+	of_node_put(np);
 }
 
 static void briq_restart(char *cmd)
diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index 76eda9f..8943a94 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -658,7 +658,7 @@ static int __init pmac_cpufreq_setup(void)
 		return 0;
 
 	/* Assume only one CPU */
-	cpunode = find_type_devices("cpu");
+	cpunode = of_find_node_by_type(NULL, "cpu");
 	if (!cpunode)
 		goto out;
 
@@ -708,6 +708,7 @@ static int __init pmac_cpufreq_setup(void)
 	else if (PVR_VER(mfspr(SPRN_PVR)) == 0x7000)
 		pmac_cpufreq_init_750FX(cpunode);
 out:
+	of_node_put(cpunode);
 	if (set_speed_proc == NULL)
 		return -ENODEV;
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 8c96f24..ae37d3e 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -250,9 +250,9 @@ static void __init l2cr_init(void)
 {
 	/* Checks "l2cr-value" property in the registry */
 	if (cpu_has_feature(CPU_FTR_L2CR)) {
-		struct device_node *np = find_devices("cpus");
+		struct device_node *np = of_find_node_by_name(NULL, "cpus");
 		if (np == 0)
-			np = find_type_devices("cpu");
+			np = of_find_node_by_type(NULL, "cpu");
 		if (np != 0) {
 			const unsigned int *l2cr =
 				of_get_property(np, "l2cr-value", NULL);
@@ -262,6 +262,7 @@ static void __init l2cr_init(void)
 				_set_L2CR(0);
 				_set_L2CR(ppc_override_l2cr_value);
 			}
+			of_node_put(np);
 		}
 	}
 
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 75623fd..7b7db5d 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -319,10 +319,13 @@ int __init find_via_pmu(void)
 	else if (device_is_compatible(vias->parent, "Keylargo")
 		 || device_is_compatible(vias->parent, "K2-Keylargo")) {
 		struct device_node *gpiop;
+		struct device_node *adbp;
 		u64 gaddr = OF_BAD_ADDR;
 
 		pmu_kind = PMU_KEYLARGO_BASED;
-		pmu_has_adb = (find_type_devices("adb") != NULL);
+		adbp = of_find_node_by_type(NULL, "adb");
+		pmu_has_adb = (adbp != NULL);
+		of_node_put(adbp);
 		pmu_intr_mask =	PMU_INT_PCEJECT |
 				PMU_INT_SNDBRT |
 				PMU_INT_ADB |
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 7c510a7..052b613 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -113,7 +113,6 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 
 /* OBSOLETE: Old style node lookup */
 extern struct device_node *find_devices(const char *name);
-extern struct device_node *find_type_devices(const char *type);
 
 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,
-- 
1.5.1.1
