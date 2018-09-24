Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jpgr22YYzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:55:20 +1000 (AEST)
Message-Id: <292bcc355e44fe1cac5819a424543da12ebc82e4.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 7/9] powerpc: 'current_set' is now a table of
 task_struct pointers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Sep 2018 15:52:33 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The table of pointers 'current_set' has been used for retrieving
the stack and current. They used to be thread_info pointers as
they were pointing to the stack and current was taken from the
'task' field of the thread_info.

Now, the pointers of 'current_set' table are now both pointers
to task_struct and pointers to thread_info.

As they are used to get current, and the stack pointer is
retrieved from current's stack field, this patch changes
their type to task_struct, and renames secondary_ti to
secondary_current.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h |  4 ++--
 arch/powerpc/kernel/head_32.S             |  6 +++---
 arch/powerpc/kernel/head_44x.S            |  4 ++--
 arch/powerpc/kernel/head_fsl_booke.S      |  4 ++--
 arch/powerpc/kernel/smp.c                 | 10 ++++------
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 78ed3c3f879a..e74d24821931 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -23,8 +23,8 @@
 #include <uapi/asm/ucontext.h>
 
 /* SMP */
-extern struct thread_info *current_set[NR_CPUS];
-extern struct thread_info *secondary_ti;
+extern struct task_struct *current_set[NR_CPUS];
+extern struct task_struct *secondary_current;
 void start_secondary(void *unused);
 
 /* kexec */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 44dfd73b2a62..ba0341bd5a00 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -842,9 +842,9 @@ __secondary_start:
 #endif /* CONFIG_6xx */
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	tophys(r1,r1)
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	tophys(r2,r2)
+	lwz	r2,secondary_current@l(r2)
 	tophys(r1,r2)
 	lwz	r1,TASK_STACK(r1)
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 2c7e90f36358..48e4de4dfd0c 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1021,8 +1021,8 @@ _GLOBAL(start_secondary_47x)
 	/* Now we can get our task struct and real stack pointer */
 
 	/* Get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* Current stack pointer */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index b8a2b789677e..0d27bfff52dd 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1076,8 +1076,8 @@ __secondary_start:
 	bl	call_setup_cpu
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f22fcbeb9898..00193643f0da 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -74,7 +74,7 @@
 static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 #endif
 
-struct thread_info *secondary_ti;
+struct task_struct *secondary_current;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
@@ -644,7 +644,7 @@ void smp_send_stop(void)
 }
 #endif /* CONFIG_NMI_IPI */
 
-struct thread_info *current_set[NR_CPUS];
+struct task_struct *current_set[NR_CPUS];
 
 static void smp_store_cpu_info(int id)
 {
@@ -724,7 +724,7 @@ void smp_prepare_boot_cpu(void)
 	paca_ptrs[boot_cpuid]->__current = current;
 #endif
 	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
-	current_set[boot_cpuid] = task_thread_info(current);
+	current_set[boot_cpuid] = current;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -809,15 +809,13 @@ static bool secondaries_inhibited(void)
 
 static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 {
-	struct thread_info *ti = task_thread_info(idle);
-
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
 	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
 				  THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
 	idle->cpu = cpu;
-	secondary_ti = current_set[cpu] = ti;
+	secondary_current = current_set[cpu] = idle;
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.13.3
