Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 782901A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 12:02:55 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2 3/3] powerpc/pseries: Switch pseries drivers to use
 machine_xxx_initcall()
Date: Wed, 16 Jul 2014 12:02:43 +1000
Message-Id: <1405476163-23292-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1405426945-19058-3-git-send-email-mpe@ellerman.id.au>
References: <1405426945-19058-3-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A lot of the code in platforms/pseries is using non-machine initcalls.
That means if a kernel built with pseries support runs on another
platform, for example powernv, the initcalls will still run.

Most of these cases are OK, though sometimes only due to luck. Some were
having more effect:

 * hcall_inst_init
  - Checking FW_FEATURE_LPAR which is set on ps3 & celleb.
 * mobility_sysfs_init
  - created sysfs files unconditionally
  - but no effect due to ENOSYS from rtas_ibm_suspend_me()
 * apo_pm_init
  - created sysfs, allows write
  - nothing checks the value written to though
 * alloc_dispatch_log_kmem_cache
  - creating kmem_cache on non-pseries machines

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Add missing includes of machdep.h

 arch/powerpc/platforms/pseries/dtl.c         | 3 ++-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 8 ++------
 arch/powerpc/platforms/pseries/hvCall_inst.c | 3 ++-
 arch/powerpc/platforms/pseries/mobility.c    | 3 ++-
 arch/powerpc/platforms/pseries/msi.c         | 4 ++--
 arch/powerpc/platforms/pseries/power.c       | 5 +++--
 arch/powerpc/platforms/pseries/ras.c         | 2 +-
 arch/powerpc/platforms/pseries/reconfig.c    | 5 +----
 arch/powerpc/platforms/pseries/rng.c         | 2 +-
 arch/powerpc/platforms/pseries/setup.c       | 2 +-
 arch/powerpc/platforms/pseries/suspend.c     | 5 ++---
 11 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 7d61498e45c0..1062f71f5a85 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -29,6 +29,7 @@
 #include <asm/lppaca.h>
 #include <asm/debug.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/machdep.h>
 
 struct dtl {
 	struct dtl_entry	*buf;
@@ -391,4 +392,4 @@ err_remove_dir:
 err:
 	return rc;
 }
-arch_initcall(dtl_init);
+machine_arch_initcall(pseries, dtl_init);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 0bec0c02c5e7..476a5d8b0b36 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -743,10 +743,7 @@ static struct eeh_ops pseries_eeh_ops = {
  */
 static int __init eeh_pseries_init(void)
 {
-	int ret = -EINVAL;
-
-	if (!machine_is(pseries))
-		return ret;
+	int ret;
 
 	ret = eeh_ops_register(&pseries_eeh_ops);
 	if (!ret)
@@ -757,5 +754,4 @@ static int __init eeh_pseries_init(void)
 
 	return ret;
 }
-
-early_initcall(eeh_pseries_init);
+machine_early_initcall(pseries, eeh_pseries_init);
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index cf4e7736e4f1..4575f0c9e521 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -27,6 +27,7 @@
 #include <asm/firmware.h>
 #include <asm/cputable.h>
 #include <asm/trace.h>
+#include <asm/machdep.h>
 
 DEFINE_PER_CPU(struct hcall_stats[HCALL_STAT_ARRAY_SIZE], hcall_stats);
 
@@ -162,4 +163,4 @@ static int __init hcall_inst_init(void)
 
 	return 0;
 }
-__initcall(hcall_inst_init);
+machine_device_initcall(pseries, hcall_inst_init);
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index bde7ebad3949..d146fef038b8 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 
+#include <asm/machdep.h>
 #include <asm/rtas.h>
 #include "pseries.h"
 
@@ -362,4 +363,4 @@ static int __init mobility_sysfs_init(void)
 
 	return rc;
 }
-device_initcall(mobility_sysfs_init);
+machine_device_initcall(pseries, mobility_sysfs_init);
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 0c882e83c4ce..18ff4626d74e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -16,6 +16,7 @@
 #include <asm/rtas.h>
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
+#include <asm/machdep.h>
 
 static int query_token, change_token;
 
@@ -532,5 +533,4 @@ static int rtas_msi_init(void)
 
 	return 0;
 }
-arch_initcall(rtas_msi_init);
-
+machine_arch_initcall(pseries, rtas_msi_init);
diff --git a/arch/powerpc/platforms/pseries/power.c b/arch/powerpc/platforms/pseries/power.c
index 6d6266236446..c26eadde434c 100644
--- a/arch/powerpc/platforms/pseries/power.c
+++ b/arch/powerpc/platforms/pseries/power.c
@@ -25,6 +25,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <asm/machdep.h>
 
 unsigned long rtas_poweron_auto; /* default and normal state is 0 */
 
@@ -71,11 +72,11 @@ static int __init pm_init(void)
 		return -ENOMEM;
 	return sysfs_create_group(power_kobj, &attr_group);
 }
-core_initcall(pm_init);
+machine_core_initcall(pseries, pm_init);
 #else
 static int __init apo_pm_init(void)
 {
 	return (sysfs_create_file(power_kobj, &auto_poweron_attr.attr));
 }
-__initcall(apo_pm_init);
+machine_device_initcall(pseries, apo_pm_init);
 #endif
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 9c5778e6ed4b..dff05b9eb946 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -71,7 +71,7 @@ static int __init init_ras_IRQ(void)
 
 	return 0;
 }
-subsys_initcall(init_ras_IRQ);
+machine_subsys_initcall(pseries, init_ras_IRQ);
 
 #define EPOW_SHUTDOWN_NORMAL				1
 #define EPOW_SHUTDOWN_ON_UPS				2
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 0435bb65d0aa..982165955c40 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -445,13 +445,10 @@ static int proc_ppc64_create_ofdt(void)
 {
 	struct proc_dir_entry *ent;
 
-	if (!machine_is(pseries))
-		return 0;
-
 	ent = proc_create("powerpc/ofdt", S_IWUSR, NULL, &ofdt_fops);
 	if (ent)
 		proc_set_size(ent, 0);
 
 	return 0;
 }
-__initcall(proc_ppc64_create_ofdt);
+machine_device_initcall(pseries, proc_ppc64_create_ofdt);
diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index 72a102758d4e..e09608770909 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -42,4 +42,4 @@ static __init int rng_init(void)
 
 	return 0;
 }
-subsys_initcall(rng_init);
+machine_subsys_initcall(pseries, rng_init);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f2f40e64658f..cfe8a6389a51 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -351,7 +351,7 @@ static int alloc_dispatch_log_kmem_cache(void)
 
 	return alloc_dispatch_logs();
 }
-early_initcall(alloc_dispatch_log_kmem_cache);
+machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
 
 static void pseries_lpar_idle(void)
 {
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index b87b97849d4c..e76aefae2aa2 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -265,7 +265,7 @@ static int __init pseries_suspend_init(void)
 {
 	int rc;
 
-	if (!machine_is(pseries) || !firmware_has_feature(FW_FEATURE_LPAR))
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
 	suspend_data.token = rtas_token("ibm,suspend-me");
@@ -280,5 +280,4 @@ static int __init pseries_suspend_init(void)
 	suspend_set_ops(&pseries_suspend_ops);
 	return 0;
 }
-
-__initcall(pseries_suspend_init);
+machine_device_initcall(pseries, pseries_suspend_init);
-- 
1.9.1
