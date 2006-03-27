Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Mar 2006 12:03:17 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add oprofile calltrace support to all powerpc cpus
Message-ID: <20060327010317.GE4962@krispykreme>
References: <20060327002329.GA4962@krispykreme>
	<20060327004618.GB4962@krispykreme>
	<20060327005701.GC4962@krispykreme>
	<20060327010045.GD4962@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060327010045.GD4962@krispykreme>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add calltrace support for other powerpc cpus. Tested on 7450.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/oprofile/op_model_7450.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/op_model_7450.c	2006-01-19 12:29:53.000000000 +1100
+++ linux-2.6/arch/powerpc/oprofile/op_model_7450.c	2006-03-26 23:00:02.000000000 +1100
@@ -176,13 +176,13 @@ static void fsl7450_handle_interrupt(str
 	mtmsr(mfmsr() | MSR_PMM);
 
 	pc = mfspr(SPRN_SIAR);
-	is_kernel = (pc >= KERNELBASE);
+	is_kernel = is_kernel_addr(pc);
 
 	for (i = 0; i < NUM_CTRS; ++i) {
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
+				oprofile_add_ext_sample(pc, regs, i, is_kernel);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
Index: linux-2.6/arch/powerpc/oprofile/op_model_fsl_booke.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/op_model_fsl_booke.c	2005-11-16 03:21:49.000000000 +1100
+++ linux-2.6/arch/powerpc/oprofile/op_model_fsl_booke.c	2006-03-26 22:58:08.000000000 +1100
@@ -154,13 +154,13 @@ static void fsl_booke_handle_interrupt(s
 	mtmsr(mfmsr() | MSR_PMM);
 
 	pc = regs->nip;
-	is_kernel = (pc >= KERNELBASE);
+	is_kernel = is_kernel_addr(pc);
 
 	for (i = 0; i < num_counters; ++i) {
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
+				oprofile_add_ext_sample(pc, regs, i, is_kernel);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
Index: linux-2.6/arch/powerpc/oprofile/op_model_rs64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/op_model_rs64.c	2006-01-19 12:29:53.000000000 +1100
+++ linux-2.6/arch/powerpc/oprofile/op_model_rs64.c	2006-03-26 23:01:55.000000000 +1100
@@ -175,10 +175,13 @@ static void rs64_handle_interrupt(struct
 				  struct op_counter_config *ctr)
 {
 	unsigned int mmcr0;
+	int is_kernel;
 	int val;
 	int i;
 	unsigned long pc = mfspr(SPRN_SIAR);
 
+	is_kernel = is_kernel_addr(pc);
+
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
 
@@ -186,7 +189,7 @@ static void rs64_handle_interrupt(struct
 		val = ctr_read(i);
 		if (val < 0) {
 			if (ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel_addr(pc), i);
+				oprofile_add_ext_sample(pc, regs, i, is_kernel);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
