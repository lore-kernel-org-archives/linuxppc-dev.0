Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E3061A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 21:05:20 +1000 (EST)
Message-ID: <1401879919.400.11.camel@ale.ozlabs.ibm.com>
Subject: [PATCH v2 2/2] powerpc/powernv: Enable POWER8 doorbell IPIs
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Jun 2014 21:05:19 +1000
In-Reply-To: <1401868995.9903.4.camel@concordia>
References: <1401692223-28337-1-git-send-email-mikey@neuling.org>
 <1401692223-28337-2-git-send-email-mikey@neuling.org>
 <1401868995.9903.4.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables POWER8 doorbell IPIs on powernv.

Since doorbells can only IPI within a core, we test to see when we can use
doorbells and if not we fall back to XICS.  This also enables hypervisor
doorbells to wakeup us up from nap/sleep via the LPCR PECEDH bit.

Based on tests by Anton, the best case IPI latency between two threads drop=
ped
from 894ns to 512ns.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2:
  Adds select of PPC_DOORBELL for PSERIES and POWERNV as suggested by mpe.

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cp=
u_setup_power.S
index 1557e7c..4673353 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -56,6 +56,7 @@ _GLOBAL(__setup_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
@@ -74,6 +75,7 @@ _GLOBAL(__restore_cpu_power8)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power8
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platform=
s/powernv/Kconfig
index c252ee9..45a8ed0 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -17,6 +17,7 @@ config PPC_POWERNV
 	select CPU_FREQ_GOV_USERSPACE
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_CONSERVATIVE
+	select PPC_DOORBELL
 	default y
=20
 config PPC_POWERNV_RTAS
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/=
powernv/smp.c
index 0062a43..5fcfcf4 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -32,6 +32,7 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 #include <asm/code-patching.h>
+#include <asm/dbell.h>
=20
 #include "powernv.h"
=20
@@ -46,6 +47,11 @@ static void pnv_smp_setup_cpu(int cpu)
 {
 	if (cpu !=3D boot_cpuid)
 		xics_setup_cpu();
+
+#ifdef CONFIG_PPC_DOORBELL
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		doorbell_setup_this_cpu();
+#endif
 }
=20
 int pnv_smp_kick_cpu(int nr)
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platform=
s/pseries/Kconfig
index 2cb8b77..756b482 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HAVE_CONTEXT_TRACKING
 	select HOTPLUG_CPU if SMP
 	select ARCH_RANDOM
+	select PPC_DOORBELL
 	default y
=20
 config PPC_SPLPAR
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xi=
cs/icp-native.c
index 9dee470..de8d948 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -26,6 +26,7 @@
 #include <asm/errno.h>
 #include <asm/xics.h>
 #include <asm/kvm_ppc.h>
+#include <asm/dbell.h>
=20
 struct icp_ipl {
 	union {
@@ -145,7 +146,13 @@ static unsigned int icp_native_get_irq(void)
 static void icp_native_cause_ipi(int cpu, unsigned long data)
 {
 	kvmppc_set_host_ipi(cpu, 1);
-	icp_native_set_qirr(cpu, IPI_PRIORITY);
+#ifdef CONFIG_PPC_DOORBELL
+	if (cpu_has_feature(CPU_FTR_DBELL) &&
+	    (cpumask_test_cpu(cpu, cpu_sibling_mask(smp_processor_id()))))
+		doorbell_cause_ipi(cpu, data);
+	else
+#endif
+		icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
=20
 void xics_wake_cpu(int cpu)
