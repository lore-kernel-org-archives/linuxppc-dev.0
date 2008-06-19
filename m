Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 3008BDE2D7
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 10:30:56 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 3/3] adjust cpu power for secondary threads on POWER6
Date: Wed, 18 Jun 2008 19:29:34 -0500
Message-Id: <1213835374-10868-4-git-send-email-ntl@pobox.com>
In-Reply-To: <1213835374-10868-1-git-send-email-ntl@pobox.com>
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On POWER6 processors, cpu-bound programs generally perform better on
the primary thread when the secondary thread is idle than they do on
the secondary thread while the primary thread is idle.  This
difference can be observed by timing a simple shell loop:

for cpumask in 0x1 0x2 ; do
	taskset $cpumask /usr/bin/time -f "%e elapsed, %U user, %S sys" \
		/bin/sh -c "i=1000000 ; while (( i-- )) ; do : ; done"
done

17.05 elapsed, 16.83 user, 0.22 sys
17.54 elapsed, 17.32 user, 0.22 sys

(The first result is for a primary thread; the second result for a
secondary thread.)

So we want the CPU scheduler to slightly favor primary threads on
POWER6.

Add a new cpu feature bit which indicates the need to override the
scheduler's cpu power calculation.

Implement ppc_md.cpu_power for the pseries platform, and scale
secondary threads' cpu power to 97% of the (default) primary threads'
cpu power.  Allow this percentage to be overriden on the kernel
command line via "sec_thread_power_scale=".

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/pseries/setup.c |   37 ++++++++++++++++++++++++++++++++
 include/asm-powerpc/cputable.h         |    3 +-
 2 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f5d29f5..a1141c0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -501,6 +501,42 @@ void pSeries_power_off(void)
 	for (;;);
 }
 
+/* Percentage by which the cpu power of secondary threads is adjusted */
+static unsigned int sec_thread_power_scale = 97;
+static int __init setup_sec_thread_power_scale(char *str)
+{
+	int power;
+
+	if (get_option(&str, &power) && power > 0 && power <= 100)
+		sec_thread_power_scale = power;
+
+	return 1;
+}
+__setup("sec_thread_power_scale=", setup_sec_thread_power_scale);
+
+static unsigned int pseries_cpu_power(int cpu, unsigned int default_power)
+{
+	struct device_node *np;
+	unsigned int thread, power;
+
+	if (!cpu_has_feature(CPU_FTR_ASYM_POWER))
+		return default_power;
+
+	power = default_power;
+
+	np = of_get_cpu_node(cpu, &thread);
+	WARN_ON(!np);
+	if (!np)
+		goto out;
+
+	/* If this isn't a primary thread, scale the power */
+	if (thread != 0)
+		power = default_power * sec_thread_power_scale / 100;
+out:
+	of_node_put(np);
+	return power;
+}
+
 #ifndef CONFIG_PCI
 void pSeries_final_fixup(void) { }
 #endif
@@ -525,4 +561,5 @@ define_machine(pseries) {
 	.progress		= rtas_progress,
 	.system_reset_exception = pSeries_system_reset_exception,
 	.machine_check_exception = pSeries_machine_check_exception,
+	.cpu_power = pseries_cpu_power,
 };
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 1e79673..eb886a9 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -152,6 +152,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
 #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
 #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
+#define CPU_FTR_ASYM_POWER		ASM_CONST(0x0000000008000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -375,7 +376,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR)
+	    CPU_FTR_DSCR | CPU_FTR_ASYM_POWER)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-- 
1.5.5
