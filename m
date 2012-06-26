Return-Path: <anton@samba.org>
Date: Tue, 26 Jun 2012 21:01:36 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com
Subject: [PATCH 2/4] powerpc/perf: Move code to select SIAR or pt_regs into
 perf_read_regs
Message-ID: <20120626210136.4f616e0e@kryten>
In-Reply-To: <20120626210013.2fbb9044@kryten>
References: <20120626210013.2fbb9044@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The logic to choose whether to use the SIAR or get the information
out of pt_regs is going to get more complicated, so do it once in
perf_read_regs.

We overload regs->result which is gross but we are already doing it
with regs->dsisr.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Other architectures appear to be playing similar overloading tricks
so we should probably solve this in a nicer way.

Index: linux-build/arch/powerpc/include/asm/perf_event.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/perf_event.h	2012-06-26 10:26:40.000000000 +1000
+++ linux-build/arch/powerpc/include/asm/perf_event.h	2012-06-26 10:31:02.132149613 +1000
@@ -26,8 +26,13 @@
 #include <asm/ptrace.h>
 #include <asm/reg.h>
 
+/*
+ * Overload regs->result to specify whether we should use the MSR (result
+ * is zero) or the SIAR (result is non zero).
+ */
 #define perf_arch_fetch_caller_regs(regs, __ip)			\
 	do {							\
+		(regs)->result = 0;				\
 		(regs)->nip = __ip;				\
 		(regs)->gpr[1] = *(unsigned long *)__get_SP();	\
 		asm volatile("mfmsr %0" : "=r" ((regs)->msr));	\
Index: linux-build/arch/powerpc/perf/core-book3s.c
===================================================================
--- linux-build.orig/arch/powerpc/perf/core-book3s.c	2012-06-26 10:28:53.000000000 +1000
+++ linux-build/arch/powerpc/perf/core-book3s.c	2012-06-26 10:35:40.560886839 +1000
@@ -73,7 +73,10 @@ static inline u32 perf_get_misc_flags(st
 {
 	return 0;
 }
-static inline void perf_read_regs(struct pt_regs *regs) { }
+static inline void perf_read_regs(struct pt_regs *regs)
+{
+	regs->result = 0;
+}
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
 	return 0;
@@ -148,17 +151,9 @@ static inline u32 perf_flags_from_msr(st
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
+	unsigned long use_siar = regs->result;
 
-	/* Not a PMU interrupt: Make up flags from regs->msr */
-	if (TRAP(regs) != 0xf00)
-		return perf_flags_from_msr(regs);
-
-	/*
-	 * If we don't support continuous sampling and this
-	 * is not a marked event, same deal
-	 */
-	if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) &&
-	    !(mmcra & MMCRA_SAMPLE_ENABLE))
+	if (!use_siar)
 		return perf_flags_from_msr(regs);
 
 	/*
@@ -185,10 +180,24 @@ static inline u32 perf_get_misc_flags(st
 /*
  * Overload regs->dsisr to store MMCRA so we only need to read it once
  * on each interrupt.
+ * Overload regs->result to specify whether we should use the MSR (result
+ * is zero) or the SIAR (result is non zero).
  */
 static inline void perf_read_regs(struct pt_regs *regs)
 {
-	regs->dsisr = mfspr(SPRN_MMCRA);
+	unsigned long mmcra = mfspr(SPRN_MMCRA);
+	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
+	int use_siar;
+
+	if (TRAP(regs) != 0xf00)
+		use_siar = 0;
+	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) && !marked)
+		use_siar = 0;
+	else
+		use_siar = 1;
+
+	regs->dsisr = mmcra;
+	regs->result = use_siar;
 }
 
 /*
@@ -1342,18 +1351,12 @@ unsigned long perf_misc_flags(struct pt_
  */
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	unsigned long mmcra = regs->dsisr;
+	unsigned long use_siar = regs->result;
 
-	/* Not a PMU interrupt */
-	if (TRAP(regs) != 0xf00)
-		return regs->nip;
-
-	/* Processor doesn't support sampling non marked events */
-	if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) &&
-	    !(mmcra & MMCRA_SAMPLE_ENABLE))
+	if (use_siar)
+		return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
+	else
 		return regs->nip;
-
-	return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
 }
 
 static bool pmc_overflow(unsigned long val)
