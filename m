Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0CFDB70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Mar 2011 15:02:39 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p2742WZr004522
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Mar 2011 22:02:34 -0600
Subject: [PATCH] powerpc/iseries: Fix early init access to lppaca
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 15:02:31 +1100
Message-ID: <1299470551.8833.1032.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The combination of commit

8154c5d22d91cd16bd9985b0638c8957e4688d0e and
93c22703efa72c7527dbd586d1951c1f4a85fd70

Broke boot on iSeries.

The problem is that iSeries very early boot code, which generates
the device-tree and runs before our normal early initializations
does need access the lppaca's very early, before the PACA array is
initialized, and in fact even before the boot PACA has been
initialized (it contains all 0's at this stage).

However, the first patch above makes that code use the new
llpaca_of(cpu) accessor, which itself is changed by the second patch to
use the PACA array.

We fix that by reverting iSeries to directly dereferencing the array. In
addition, we fix all iterators in the iSeries code to always skip CPU
whose number is above 63 which is the maximum size of that array and
the maximum number of supported CPUs on these machines.

Additionally, we make sure the boot_paca is properly initialized
in our early startup code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 380d48b..26b8c80 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -33,9 +33,25 @@
 //
 //----------------------------------------------------------------------------
 #include <linux/cache.h>
+#include <linux/threads.h>
 #include <asm/types.h>
 #include <asm/mmu.h>
 
+/*
+ * We only have to have statically allocated lppaca structs on
+ * legacy iSeries, which supports at most 64 cpus.
+ */
+#ifdef CONFIG_PPC_ISERIES
+#if NR_CPUS < 64
+#define NR_LPPACAS	NR_CPUS
+#else
+#define NR_LPPACAS	64
+#endif
+#else /* not iSeries */
+#define NR_LPPACAS	1
+#endif
+
+
 /* The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
  * alignment is sufficient to prevent this */
 struct lppaca {
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index ebf9846..f4adf89 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -27,20 +27,6 @@ extern unsigned long __toc_start;
 #ifdef CONFIG_PPC_BOOK3S
 
 /*
- * We only have to have statically allocated lppaca structs on
- * legacy iSeries, which supports at most 64 cpus.
- */
-#ifdef CONFIG_PPC_ISERIES
-#if NR_CPUS < 64
-#define NR_LPPACAS	NR_CPUS
-#else
-#define NR_LPPACAS	64
-#endif
-#else /* not iSeries */
-#define NR_LPPACAS	1
-#endif
-
-/*
  * The structure which the hypervisor knows about - this structure
  * should not cross a page boundary.  The vpa_init/register_vpa call
  * is now known to fail if the lppaca structure crosses a page
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index fdb7384..f0491cc 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -242,8 +242,8 @@ static void __init dt_cpus(struct iseries_flat_dt *dt)
 	pft_size[0] = 0; /* NUMA CEC cookie, 0 for non NUMA  */
 	pft_size[1] = __ilog2(HvCallHpt_getHptPages() * HW_PAGE_SIZE);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (lppaca_of(i).dyn_proc_status >= 2)
+	for (i = 0; i < NR_LPPACAS; i++) {
+		if (lppaca[i].dyn_proc_status >= 2)
 			continue;
 
 		snprintf(p, 32 - (p - buf), "@%d", i);
@@ -251,7 +251,7 @@ static void __init dt_cpus(struct iseries_flat_dt *dt)
 
 		dt_prop_str(dt, "device_type", device_type_cpu);
 
-		index = lppaca_of(i).dyn_hv_phys_proc_index;
+		index = lppaca[i].dyn_hv_phys_proc_index;
 		d = &xIoHriProcessorVpd[index];
 
 		dt_prop_u32(dt, "i-cache-size", d->xInstCacheSize * 1024);
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index b086341..2946ae1 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -680,6 +680,7 @@ void * __init iSeries_early_setup(void)
 	 * on but calling this function multiple times is fine.
 	 */
 	identify_cpu(0, mfspr(SPRN_PVR));
+	initialise_paca(&boot_paca, 0);
 
 	powerpc_firmware_features |= FW_FEATURE_ISERIES;
 	powerpc_firmware_features |= FW_FEATURE_LPAR;
