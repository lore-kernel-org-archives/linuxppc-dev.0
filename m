Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 20/33] powerpc: Fix SMP issues with ppc64le ABIv2
Date: Tue, 25 Mar 2014 22:44:26 +1100
Message-Id: <1395747879-5948-21-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to put a function descriptor in
__secondary_hold_spinloop. Use ppc_function_entry to get the
instruction address and put it in __secondary_hold_spinloop instead.

Also fix an issue where we assumed cur_cpu_spec held a function
descriptor.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/head_64.S         | 18 ++++++++----------
 arch/powerpc/kernel/setup_64.c        |  2 +-
 arch/powerpc/platforms/85xx/smp.c     |  3 ++-
 arch/powerpc/platforms/cell/smp.c     |  5 +++--
 arch/powerpc/platforms/powernv/smp.c  |  5 +++--
 arch/powerpc/platforms/pseries/smp.c  |  5 +++--
 arch/powerpc/platforms/wsp/scom_smp.c |  3 ++-
 7 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 97329a1..a95145d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -76,10 +76,9 @@ END_FTR_SECTION(0, 1)
 	/* Catch branch to 0 in real mode */
 	trap
 
-	/* Secondary processors spin on this value until it becomes nonzero.
-	 * When it does it contains the real address of the descriptor
-	 * of the function that the cpu should jump to to continue
-	 * initialization.
+	/* Secondary processors spin on this value until it becomes non-zero.
+	 * When non-zero, it contains the real address of the function the cpu
+	 * should jump to.
 	 */
 	.balign 8
 	.globl  __secondary_hold_spinloop
@@ -148,9 +147,6 @@ __secondary_hold:
 #ifdef CONFIG_PPC_BOOK3E
 	tovirt(r12,r12)
 #endif
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
-	ld	r12,0(r12)		/* deref function descriptor */
-#endif
 	mtctr	r12
 	mr	r3,r24
 	/*
@@ -266,10 +262,12 @@ generic_secondary_common_init:
 	/* See if we need to call a cpu state restore handler */
 	LOAD_REG_ADDR(r23, cur_cpu_spec)
 	ld	r23,0(r23)
-	ld	r23,CPU_SPEC_RESTORE(r23)
-	cmpdi	0,r23,0
+	ld	r12,CPU_SPEC_RESTORE(r23)
+	cmpdi	0,r12,0
 	beq	3f
-	ld	r12,0(r23)
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+	ld	r12,0(r12)
+#endif
 	mtctr	r12
 	bctrl
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4933909..b694504 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -314,7 +314,7 @@ void smp_release_cpus(void)
 
 	ptr  = (unsigned long *)((unsigned long)&__secondary_hold_spinloop
 			- PHYSICAL_START);
-	*ptr = __pa(generic_secondary_smp_init);
+	*ptr = ppc_function_entry(generic_secondary_smp_init);
 
 	/* And wait a bit for them to catch up */
 	for (i = 0; i < 100000; i++) {
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 6382098..ba093f5 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -27,6 +27,7 @@
 #include <asm/cacheflush.h>
 #include <asm/dbell.h>
 #include <asm/fsl_guts.h>
+#include <asm/code-patching.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
@@ -267,7 +268,7 @@ out:
 	flush_spin_table(spin_table);
 	out_be32(&spin_table->pir, hw_cpu);
 	out_be64((u64 *)(&spin_table->addr_h),
-	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
+		__pa(ppc_function_entry(generic_secondary_smp_init)));
 	flush_spin_table(spin_table);
 #endif
 
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 90745ea..c8017a7 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -40,6 +40,7 @@
 #include <asm/firmware.h>
 #include <asm/rtas.h>
 #include <asm/cputhreads.h>
+#include <asm/code-patching.h>
 
 #include "interrupt.h"
 #include <asm/udbg.h>
@@ -70,8 +71,8 @@ static cpumask_t of_spin_map;
 static inline int smp_startup_cpu(unsigned int lcpu)
 {
 	int status;
-	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       generic_secondary_smp_init));
+	unsigned long start_here =
+			__pa(ppc_function_entry(generic_secondary_smp_init));
 	unsigned int pcpu;
 	int start_cpu;
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 908672b..b370b86 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -30,6 +30,7 @@
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
 #include <asm/opal.h>
+#include <asm/code-patching.h>
 
 #include "powernv.h"
 
@@ -49,8 +50,8 @@ static void pnv_smp_setup_cpu(int cpu)
 int pnv_smp_kick_cpu(int nr)
 {
 	unsigned int pcpu = get_hard_smp_processor_id(nr);
-	unsigned long start_here = __pa(*((unsigned long *)
-					  generic_secondary_smp_init));
+	unsigned long start_here =
+			__pa(ppc_function_entry(generic_secondary_smp_init));
 	long rc;
 
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 24f58cb..a3555b1 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -44,6 +44,7 @@
 #include <asm/xics.h>
 #include <asm/dbell.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/code-patching.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -96,8 +97,8 @@ int smp_query_cpu_stopped(unsigned int pcpu)
 static inline int smp_startup_cpu(unsigned int lcpu)
 {
 	int status;
-	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       generic_secondary_smp_init));
+	unsigned long start_here =
+			__pa(ppc_function_entry(generic_secondary_smp_init));
 	unsigned int pcpu;
 	int start_cpu;
 
diff --git a/arch/powerpc/platforms/wsp/scom_smp.c b/arch/powerpc/platforms/wsp/scom_smp.c
index 268bc89..8c79ce0 100644
--- a/arch/powerpc/platforms/wsp/scom_smp.c
+++ b/arch/powerpc/platforms/wsp/scom_smp.c
@@ -20,6 +20,7 @@
 #include <asm/reg_a2.h>
 #include <asm/scom.h>
 #include <asm/udbg.h>
+#include <asm/code-patching.h>
 
 #include "wsp.h"
 
@@ -405,7 +406,7 @@ int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx, struct device_node *np)
 			goto fail;
 	}
 
-	start_here = *(unsigned long *)(core_setup ? generic_secondary_smp_init
+	start_here = ppc_function_entry(core_setup ? generic_secondary_smp_init
 					: generic_secondary_thread_init);
 	pr_devel("CPU%d entry point at 0x%lx...\n", lcpu, start_here);
 
-- 
1.8.3.2
