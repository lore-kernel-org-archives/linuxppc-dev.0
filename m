Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Mar 2006 12:00:45 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove oprofile spinlock backtrace code
Message-ID: <20060327010045.GD4962@krispykreme>
References: <20060327002329.GA4962@krispykreme>
	<20060327004618.GB4962@krispykreme>
	<20060327005701.GC4962@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060327005701.GC4962@krispykreme>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove oprofile spinlock backtrace code now we have proper calltrace
support. Also make MMCRA sihv and sipr bits a variable since they may
change in future cpus. Finally, MMCRA should be a 64bit quantity.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/op_model_power4.c	2006-03-26 17:55:19.000000000 +1100
+++ linux-2.6/arch/powerpc/oprofile/op_model_power4.c	2006-03-26 17:55:19.000000000 +1100
@@ -25,18 +25,14 @@ static unsigned long reset_value[OP_MAX_
 
 static int oprofile_running;
 static int mmcra_has_sihv;
+/* Unfortunately these bits vary between CPUs */
+static unsigned long mmcra_sihv = MMCRA_SIHV;
+static unsigned long mmcra_sipr = MMCRA_SIPR;
 
 /* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
 static u32 mmcr0_val;
 static u64 mmcr1_val;
-static u32 mmcra_val;
-
-/*
- * Since we do not have an NMI, backtracing through spinlocks is
- * only a best guess. In light of this, allow it to be disabled at
- * runtime.
- */
-static int backtrace_spinlocks;
+static u64 mmcra_val;
 
 static void power4_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
@@ -63,8 +59,6 @@ static void power4_reg_setup(struct op_c
 	mmcr1_val = sys->mmcr1;
 	mmcra_val = sys->mmcra;
 
-	backtrace_spinlocks = sys->backtrace_spinlocks;
-
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i)
 		reset_value[i] = 0x80000000UL - ctr[i].count;
 
@@ -197,25 +191,6 @@ static void __attribute_used__ kernel_un
 {
 }
 
-static unsigned long check_spinlock_pc(struct pt_regs *regs,
-				       unsigned long profile_pc)
-{
-	unsigned long pc = instruction_pointer(regs);
-
-	/*
-	 * If both the SIAR (sampled instruction) and the perfmon exception
-	 * occurred in a spinlock region then we account the sample to the
-	 * calling function. This isnt 100% correct, we really need soft
-	 * IRQ disable so we always get the perfmon exception at the
-	 * point at which the SIAR is set.
-	 */
-	if (backtrace_spinlocks && in_lock_functions(pc) &&
-			in_lock_functions(profile_pc))
-		return regs->link;
-	else
-		return profile_pc;
-}
-
 /*
  * On GQ and newer the MMCRA stores the HV and PR bits at the time
  * the SIAR was sampled. We use that to work out if the SIAR was sampled in
@@ -228,17 +203,17 @@ static unsigned long get_pc(struct pt_re
 
 	/* Cant do much about it */
 	if (!mmcra_has_sihv)
-		return check_spinlock_pc(regs, pc);
+		return pc;
 
 	mmcra = mfspr(SPRN_MMCRA);
 
 	/* Were we in the hypervisor? */
-	if (firmware_has_feature(FW_FEATURE_LPAR) && (mmcra & MMCRA_SIHV))
+	if (firmware_has_feature(FW_FEATURE_LPAR) && (mmcra & mmcra_sihv))
 		/* function descriptor madness */
 		return *((unsigned long *)hypervisor_bucket);
 
 	/* We were in userspace, nothing to do */
-	if (mmcra & MMCRA_SIPR)
+	if (mmcra & mmcra_sipr)
 		return pc;
 
 #ifdef CONFIG_PPC_RTAS
@@ -257,7 +232,7 @@ static unsigned long get_pc(struct pt_re
 		/* function descriptor madness */
 		return *((unsigned long *)kernel_unknown_bucket);
 
-	return check_spinlock_pc(regs, pc);
+	return pc;
 }
 
 static int get_kernel(unsigned long pc)
@@ -268,7 +243,7 @@ static int get_kernel(unsigned long pc)
 		is_kernel = is_kernel_addr(pc);
 	} else {
 		unsigned long mmcra = mfspr(SPRN_MMCRA);
-		is_kernel = ((mmcra & MMCRA_SIPR) == 0);
+		is_kernel = ((mmcra & mmcra_sipr) == 0);
 	}
 
 	return is_kernel;
Index: linux-2.6/arch/powerpc/oprofile/common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/common.c	2006-03-26 17:55:19.000000000 +1100
+++ linux-2.6/arch/powerpc/oprofile/common.c	2006-03-26 17:55:19.000000000 +1100
@@ -117,17 +117,10 @@ static int op_powerpc_create_files(struc
 
 	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
 	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
-#ifdef CONFIG_PPC64
-	oprofilefs_create_ulong(sb, root, "backtrace_spinlocks",
-				&sys.backtrace_spinlocks);
-#endif
 
 	/* Default to tracing both kernel and user */
 	sys.enable_kernel = 1;
 	sys.enable_user = 1;
-#ifdef CONFIG_PPC64
-	sys.backtrace_spinlocks = 0;
-#endif
 
 	return 0;
 }
Index: linux-2.6/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/oprofile_impl.h	2006-03-26 17:55:19.000000000 +1100
+++ linux-2.6/include/asm-powerpc/oprofile_impl.h	2006-03-26 17:55:19.000000000 +1100
@@ -35,9 +35,6 @@ struct op_system_config {
 #endif
 	unsigned long enable_kernel;
 	unsigned long enable_user;
-#ifdef CONFIG_PPC64
-	unsigned long backtrace_spinlocks;
-#endif
 };
 
 /* Per-arch configuration */
