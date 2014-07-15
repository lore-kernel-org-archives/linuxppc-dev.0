Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB4E1A02DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 22:22:35 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/powernv: Switch powernv drivers to use
 machine_xxx_initcall()
Date: Tue, 15 Jul 2014 22:22:24 +1000
Message-Id: <1405426945-19058-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1405426945-19058-1-git-send-email-mpe@ellerman.id.au>
References: <1405426945-19058-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A lot of the code in platforms/powernv is using non-machine initcalls.
That means if a kernel built with powernv support runs on another
platform, for example pseries, the initcalls will still run.

That is usually OK, because the initcalls will check for something in
the device tree or elsewhere before doing anything, so on other
platforms they will usually just return.

But it's fishy for powernv code to be running on other platforms, so
switch them all to be machine initcalls. If we want any of them to run
on other platforms in future they should move to sysdev.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c        | 6 +-----
 arch/powerpc/platforms/powernv/opal-async.c         | 3 ++-
 arch/powerpc/platforms/powernv/opal-lpc.c           | 2 +-
 arch/powerpc/platforms/powernv/opal-memory-errors.c | 3 ++-
 arch/powerpc/platforms/powernv/opal-xscom.c         | 2 +-
 arch/powerpc/platforms/powernv/opal.c               | 9 +++++----
 arch/powerpc/platforms/powernv/pci.c                | 3 +--
 arch/powerpc/platforms/powernv/rng.c                | 2 +-
 8 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 56a206f32f77..998bcc18a491 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -398,9 +398,6 @@ static int __init eeh_powernv_init(void)
 {
 	int ret = -EINVAL;
 
-	if (!machine_is(powernv))
-		return ret;
-
 	ret = eeh_ops_register(&powernv_eeh_ops);
 	if (!ret)
 		pr_info("EEH: PowerNV platform initialized\n");
@@ -409,5 +406,4 @@ static int __init eeh_powernv_init(void)
 
 	return ret;
 }
-
-early_initcall(eeh_powernv_init);
+machine_early_initcall(powernv, eeh_powernv_init);
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 32e2adfa5320..e462ab947d16 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -20,6 +20,7 @@
 #include <linux/wait.h>
 #include <linux/gfp.h>
 #include <linux/of.h>
+#include <asm/machdep.h>
 #include <asm/opal.h>
 
 #define N_ASYNC_COMPLETIONS	64
@@ -201,4 +202,4 @@ out_opal_node:
 out:
 	return err;
 }
-subsys_initcall(opal_async_comp_init);
+machine_subsys_initcall(powernv, opal_async_comp_init);
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index f04b4d8aca5a..ad4b31df779a 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -324,7 +324,7 @@ static int opal_lpc_init_debugfs(void)
 	rc |= opal_lpc_debugfs_create_type(root, "fw", OPAL_LPC_FW);
 	return rc;
 }
-device_initcall(opal_lpc_init_debugfs);
+machine_device_initcall(powernv, opal_lpc_init_debugfs);
 #endif  /* CONFIG_DEBUG_FS */
 
 void opal_lpc_init(void)
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index b17a34b695ef..43db2136dbff 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
+#include <asm/machdep.h>
 #include <asm/opal.h>
 #include <asm/cputable.h>
 
@@ -143,4 +144,4 @@ static int __init opal_mem_err_init(void)
 	}
 	return 0;
 }
-subsys_initcall(opal_mem_err_init);
+machine_subsys_initcall(powernv, opal_mem_err_init);
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 4cd2ea6c0dbe..7634d1c62299 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -130,4 +130,4 @@ static int opal_xscom_init(void)
 		scom_init(&opal_scom_controller);
 	return 0;
 }
-arch_initcall(opal_xscom_init);
+machine_arch_initcall(powernv, opal_xscom_init);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 199975613fe9..6ef2e5c5bc64 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -22,6 +22,8 @@
 #include <linux/kobject.h>
 #include <linux/delay.h>
 #include <linux/memblock.h>
+
+#include <asm/machdep.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
@@ -200,8 +202,7 @@ static int __init opal_register_exception_handlers(void)
 
 	return 0;
 }
-
-early_initcall(opal_register_exception_handlers);
+machine_early_initcall(powernv, opal_register_exception_handlers);
 
 int opal_notifier_register(struct notifier_block *nb)
 {
@@ -368,7 +369,7 @@ static int __init opal_message_init(void)
 	}
 	return 0;
 }
-early_initcall(opal_message_init);
+machine_early_initcall(powernv, opal_message_init);
 
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
@@ -630,7 +631,7 @@ static int __init opal_init(void)
 
 	return 0;
 }
-subsys_initcall(opal_init);
+machine_subsys_initcall(powernv, opal_init);
 
 void opal_shutdown(void)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f91a4e5d872e..493570c2e963 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -842,5 +842,4 @@ static int __init tce_iommu_bus_notifier_init(void)
 	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
 	return 0;
 }
-
-subsys_initcall_sync(tce_iommu_bus_notifier_init);
+machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 1cb160dc1609..80db43944afe 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -123,4 +123,4 @@ static __init int rng_init(void)
 
 	return 0;
 }
-subsys_initcall(rng_init);
+machine_subsys_initcall(powernv, rng_init);
-- 
1.9.1
