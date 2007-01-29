Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F26B5DE24C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:16:52 +1100 (EST)
Date: Sun, 28 Jan 2007 21:23:14 -0600
To: paulus@samba.org
Subject: [PATCH] [1/4] powerpc: Oprofile cleanup [v2]
Message-ID: <20070129032314.GD6412@lixom.net>
References: <20070129032143.GC6412@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070129032143.GC6412@lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean up the ctr_read/write a bit. It's currently defined in the
include but only used in one C file each. The only exception is the
classic version, so keep that in the include and define in the C file
as appropriate.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/arch/powerpc/oprofile/op_model_7450.c
===================================================================
--- merge.orig/arch/powerpc/oprofile/op_model_7450.c
+++ merge/arch/powerpc/oprofile/op_model_7450.c
@@ -137,9 +137,9 @@ static void fsl7450_start(struct op_coun
 
 	for (i = 0; i < NUM_CTRS; ++i) {
 		if (ctr[i].enabled)
-			ctr_write(i, reset_value[i]);
+			classic_ctr_write(i, reset_value[i]);
 		else
-			ctr_write(i, 0);
+			classic_ctr_write(i, 0);
 	}
 
 	/* Clear the freeze bit, and enable the interrupt.
@@ -179,13 +179,13 @@ static void fsl7450_handle_interrupt(str
 	is_kernel = is_kernel_addr(pc);
 
 	for (i = 0; i < NUM_CTRS; ++i) {
-		val = ctr_read(i);
+		val = classic_ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
 				oprofile_add_ext_sample(pc, regs, i, is_kernel);
-				ctr_write(i, reset_value[i]);
+				classic_ctr_write(i, reset_value[i]);
 			} else {
-				ctr_write(i, 0);
+				classic_ctr_write(i, 0);
 			}
 		}
 	}
Index: merge/arch/powerpc/oprofile/op_model_fsl_booke.c
===================================================================
--- merge.orig/arch/powerpc/oprofile/op_model_fsl_booke.c
+++ merge/arch/powerpc/oprofile/op_model_fsl_booke.c
@@ -32,6 +32,87 @@ static unsigned long reset_value[OP_MAX_
 static int num_counters;
 static int oprofile_running;
 
+static inline u32 get_pmlca(int ctr)
+{
+	u32 pmlca;
+
+	switch (ctr) {
+		case 0:
+			pmlca = mfpmr(PMRN_PMLCA0);
+			break;
+		case 1:
+			pmlca = mfpmr(PMRN_PMLCA1);
+			break;
+		case 2:
+			pmlca = mfpmr(PMRN_PMLCA2);
+			break;
+		case 3:
+			pmlca = mfpmr(PMRN_PMLCA3);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+
+	return pmlca;
+}
+
+static inline void set_pmlca(int ctr, u32 pmlca)
+{
+	switch (ctr) {
+		case 0:
+			mtpmr(PMRN_PMLCA0, pmlca);
+			break;
+		case 1:
+			mtpmr(PMRN_PMLCA1, pmlca);
+			break;
+		case 2:
+			mtpmr(PMRN_PMLCA2, pmlca);
+			break;
+		case 3:
+			mtpmr(PMRN_PMLCA3, pmlca);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+}
+
+static inline unsigned int ctr_read(unsigned int i)
+{
+	switch(i) {
+		case 0:
+			return mfpmr(PMRN_PMC0);
+		case 1:
+			return mfpmr(PMRN_PMC1);
+		case 2:
+			return mfpmr(PMRN_PMC2);
+		case 3:
+			return mfpmr(PMRN_PMC3);
+		default:
+			return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, unsigned int val)
+{
+	switch(i) {
+		case 0:
+			mtpmr(PMRN_PMC0, val);
+			break;
+		case 1:
+			mtpmr(PMRN_PMC1, val);
+			break;
+		case 2:
+			mtpmr(PMRN_PMC2, val);
+			break;
+		case 3:
+			mtpmr(PMRN_PMC3, val);
+			break;
+		default:
+			break;
+	}
+}
+
+
 static void init_pmc_stop(int ctr)
 {
 	u32 pmlca = (PMLCA_FC | PMLCA_FCS | PMLCA_FCU |
Index: merge/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- merge.orig/arch/powerpc/oprofile/op_model_power4.c
+++ merge/arch/powerpc/oprofile/op_model_power4.c
@@ -121,9 +121,9 @@ static void power4_start(struct op_count
 
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
 		if (ctr[i].enabled) {
-			ctr_write(i, reset_value[i]);
+			classic_ctr_write(i, reset_value[i]);
 		} else {
-			ctr_write(i, 0);
+			classic_ctr_write(i, 0);
 		}
 	}
 
@@ -254,13 +254,13 @@ static void power4_handle_interrupt(stru
 	mtmsrd(mfmsr() | MSR_PMM);
 
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
-		val = ctr_read(i);
+		val = classic_ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
 				oprofile_add_ext_sample(pc, regs, i, is_kernel);
-				ctr_write(i, reset_value[i]);
+				classic_ctr_write(i, reset_value[i]);
 			} else {
-				ctr_write(i, 0);
+				classic_ctr_write(i, 0);
 			}
 		}
 	}
Index: merge/arch/powerpc/oprofile/op_model_rs64.c
===================================================================
--- merge.orig/arch/powerpc/oprofile/op_model_rs64.c
+++ merge/arch/powerpc/oprofile/op_model_rs64.c
@@ -137,10 +137,10 @@ static void rs64_start(struct op_counter
 
 	for (i = 0; i < num_counters; ++i) {
 		if (ctr[i].enabled) {
-			ctr_write(i, reset_value[i]);
+			classic_ctr_write(i, reset_value[i]);
 			ctrl_write(i, ctr[i].event);
 		} else {
-			ctr_write(i, 0);
+			classic_ctr_write(i, 0);
 		}
 	}
 
@@ -186,13 +186,13 @@ static void rs64_handle_interrupt(struct
 	mtmsrd(mfmsr() | MSR_PMM);
 
 	for (i = 0; i < num_counters; ++i) {
-		val = ctr_read(i);
+		val = classic_ctr_read(i);
 		if (val < 0) {
 			if (ctr[i].enabled) {
 				oprofile_add_ext_sample(pc, regs, i, is_kernel);
-				ctr_write(i, reset_value[i]);
+				classic_ctr_write(i, reset_value[i]);
 			} else {
-				ctr_write(i, 0);
+				classic_ctr_write(i, 0);
 			}
 		}
 	}
Index: merge/include/asm-powerpc/oprofile_impl.h
===================================================================
--- merge.orig/include/asm-powerpc/oprofile_impl.h
+++ merge/include/asm-powerpc/oprofile_impl.h
@@ -58,10 +58,8 @@ extern struct op_powerpc_model op_model_
 extern struct op_powerpc_model op_model_7450;
 extern struct op_powerpc_model op_model_cell;
 
-#ifndef CONFIG_FSL_BOOKE
-
 /* All the classic PPC parts use these */
-static inline unsigned int ctr_read(unsigned int i)
+static inline unsigned int classic_ctr_read(unsigned int i)
 {
 	switch(i) {
 	case 0:
@@ -89,7 +87,7 @@ static inline unsigned int ctr_read(unsi
 	}
 }
 
-static inline void ctr_write(unsigned int i, unsigned int val)
+static inline void classic_ctr_write(unsigned int i, unsigned int val)
 {
 	switch(i) {
 	case 0:
@@ -124,89 +122,6 @@ static inline void ctr_write(unsigned in
 		break;
 	}
 }
-#else /* CONFIG_FSL_BOOKE */
-static inline u32 get_pmlca(int ctr)
-{
-	u32 pmlca;
-
-	switch (ctr) {
-		case 0:
-			pmlca = mfpmr(PMRN_PMLCA0);
-			break;
-		case 1:
-			pmlca = mfpmr(PMRN_PMLCA1);
-			break;
-		case 2:
-			pmlca = mfpmr(PMRN_PMLCA2);
-			break;
-		case 3:
-			pmlca = mfpmr(PMRN_PMLCA3);
-			break;
-		default:
-			panic("Bad ctr number\n");
-	}
-
-	return pmlca;
-}
-
-static inline void set_pmlca(int ctr, u32 pmlca)
-{
-	switch (ctr) {
-		case 0:
-			mtpmr(PMRN_PMLCA0, pmlca);
-			break;
-		case 1:
-			mtpmr(PMRN_PMLCA1, pmlca);
-			break;
-		case 2:
-			mtpmr(PMRN_PMLCA2, pmlca);
-			break;
-		case 3:
-			mtpmr(PMRN_PMLCA3, pmlca);
-			break;
-		default:
-			panic("Bad ctr number\n");
-	}
-}
-
-static inline unsigned int ctr_read(unsigned int i)
-{
-	switch(i) {
-		case 0:
-			return mfpmr(PMRN_PMC0);
-		case 1:
-			return mfpmr(PMRN_PMC1);
-		case 2:
-			return mfpmr(PMRN_PMC2);
-		case 3:
-			return mfpmr(PMRN_PMC3);
-		default:
-			return 0;
-	}
-}
-
-static inline void ctr_write(unsigned int i, unsigned int val)
-{
-	switch(i) {
-		case 0:
-			mtpmr(PMRN_PMC0, val);
-			break;
-		case 1:
-			mtpmr(PMRN_PMC1, val);
-			break;
-		case 2:
-			mtpmr(PMRN_PMC2, val);
-			break;
-		case 3:
-			mtpmr(PMRN_PMC3, val);
-			break;
-		default:
-			break;
-	}
-}
-
-
-#endif /* CONFIG_FSL_BOOKE */
 
 
 extern void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth);
