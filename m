Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408BHK0wVLzF1p7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 20:07:07 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id z8so15948064wrh.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 02:07:07 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] xmon: Use __printf markup to silence compiler
Date: Sun, 25 Mar 2018 11:06:47 +0200
Message-Id: <20180325090648.1029-1-malat@debian.org>
In-Reply-To: <20180316110224.12260-2-malat@debian.org>
References: <20180316110224.12260-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the other prototype declarations in asm/xmon.h.

Silence warnings (triggered at W=1) by adding relevant __printf attribute.
Move #define at bottom of the file to prevent conflict with gcc attribute.

Solve the original warning:

  arch/powerpc/xmon/nonstdio.c:178:2: error: function might be possible candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

In turn this uncovered the following (partial list) warnings (treated as
errors with W=1):

  arch/powerpc/xmon/xmon.c:2866:17: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘unsigned char *’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1607:31: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘struct pt_regs *’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1611:9: error: too many arguments for format [-Werror=format-extra-args]
  arch/powerpc/xmon/xmon.c:1623:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘struct task_struct *’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:630:36: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1392:15: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:2570:16: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1629:25: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘pid_t {aka int}’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1168:18: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:3016:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pgd_t * {aka struct <anonymous> *}’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:3827:10: error: format ‘%p’ expects argument of type ‘void *’, but argument 4 has type ‘long long unsigned int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:3896:50: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/xmon/spu-dis.c:137:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:3827:10: error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:1665:17: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Werror=format=]
  arch/powerpc/xmon/xmon.c:2339:9: error: '#' flag used with ‘%p’ gnu_printf format [-Werror=format=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: resubmit patch series a single patch

 arch/powerpc/include/asm/xmon.h |   2 +-
 arch/powerpc/xmon/nonstdio.h    |   8 +--
 arch/powerpc/xmon/spu-dis.c     |  18 +++---
 arch/powerpc/xmon/xmon.c        | 133 ++++++++++++++++++++--------------------
 4 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
index eb42a0c6e1d9..30ff69bd8f43 100644
--- a/arch/powerpc/include/asm/xmon.h
+++ b/arch/powerpc/include/asm/xmon.h
@@ -29,7 +29,7 @@ static inline void xmon_register_spus(struct list_head *list) { };
 extern int cpus_are_in_xmon(void);
 #endif
 
-extern void xmon_printf(const char *format, ...);
+extern __printf(1, 2) void xmon_printf(const char *format, ...);
 
 #endif /* __KERNEL __ */
 #endif /* __ASM_POWERPC_XMON_H */
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 2202ec61972c..e8deac6c84e2 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define EOF	(-1)
 
-#define printf	xmon_printf
-#define putchar	xmon_putchar
-
 extern void xmon_set_pagination_lpp(unsigned long lpp);
 extern void xmon_start_pagination(void);
 extern void xmon_end_pagination(void);
 extern int xmon_putchar(int c);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
-extern void xmon_printf(const char *, ...);
+extern __printf(1, 2) void xmon_printf(const char *fmt, ...);
+
+#define printf	xmon_printf
+#define putchar	xmon_putchar
diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index e5f89837c82e..4cbc7da88524 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -102,7 +102,7 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 
   if (index == 0)
     {
-      printf(".long 0x%x", insn);
+      printf(".long 0x%lx", insn);
     }
   else
     {
@@ -134,27 +134,27 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 	  switch (arg)
 	    {
 	    case A_T:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RT (insn));
 	      break;
 	    case A_A:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_B:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RB (insn));
 	      break;
 	    case A_C:
-	      printf("$%d",
+	      printf("$%lu",
 				     DECODE_INSN_RC (insn));
 	      break;
 	    case A_S:
-	      printf("$sp%d",
+	      printf("$sp%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_H:
-	      printf("$ch%d",
+	      printf("$ch%lu",
 				     DECODE_INSN_RA (insn));
 	      break;
 	    case A_P:
@@ -162,11 +162,11 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 	      printf("(");
 	      break;
 	    case A_U7A:
-	      printf("%d",
+	      printf("%lu",
 				     173 - DECODE_INSN_U8 (insn));
 	      break;
 	    case A_U7B:
-	      printf("%d",
+	      printf("%lu",
 				     155 - DECODE_INSN_U8 (insn));
 	      break;
 	    case A_S3:
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ee113a6e008c..edd7ea85272f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -627,7 +627,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		excprint(regs);
 		bp = at_breakpoint(regs->nip);
 		if (bp) {
-			printf("Stopped at breakpoint %lx (", BP_NUM(bp));
+			printf("Stopped at breakpoint %tx (", BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
 		if (unrecoverable_excp(regs))
@@ -1165,7 +1165,7 @@ static int cpu_cmd(void)
 	}
 	/* try to switch to cpu specified */
 	if (!cpumask_test_cpu(cpu, &cpus_in_xmon)) {
-		printf("cpu 0x%x isn't in xmon\n", cpu);
+		printf("cpu 0x%lx isn't in xmon\n", cpu);
 		return 0;
 	}
 	xmon_taken = 0;
@@ -1179,7 +1179,7 @@ static int cpu_cmd(void)
 			/* take control back */
 			mb();
 			xmon_owner = smp_processor_id();
-			printf("cpu 0x%x didn't take control\n", cpu);
+			printf("cpu 0x%lx didn't take control\n", cpu);
 			return 0;
 		}
 		barrier();
@@ -1362,7 +1362,7 @@ bpt_cmds(void)
 			}
 		}
 
-		printf("Cleared breakpoint %lx (", BP_NUM(bp));
+		printf("Cleared breakpoint %tx (", BP_NUM(bp));
 		xmon_print_symbol(bp->address, " ", ")\n");
 		bp->enabled = 0;
 		break;
@@ -1389,7 +1389,7 @@ bpt_cmds(void)
 			for (bp = bpts; bp < &bpts[NBPTS]; ++bp) {
 				if (!bp->enabled)
 					continue;
-				printf("%2x %s   ", BP_NUM(bp),
+				printf("%tx %s   ", BP_NUM(bp),
 				    (bp->enabled & BP_CIABR) ? "inst": "trap");
 				xmon_print_symbol(bp->address, "  ", "\n");
 			}
@@ -1604,11 +1604,11 @@ static void excprint(struct pt_regs *fp)
 #endif /* CONFIG_SMP */
 
 	trap = TRAP(fp);
-	printf("Vector: %lx %s at [%lx]\n", fp->trap, getvecname(trap), fp);
+	printf("Vector: %lx %s at [%p]\n", fp->trap, getvecname(trap), fp);
 	printf("    pc: ");
 	xmon_print_symbol(fp->nip, ": ", "\n");
 
-	printf("    lr: ", fp->link);
+	printf("    lr: ");
 	xmon_print_symbol(fp->link, ": ", "\n");
 
 	printf("    sp: %lx\n", fp->gpr[1]);
@@ -1620,13 +1620,13 @@ static void excprint(struct pt_regs *fp)
 			printf(" dsisr: %lx\n", fp->dsisr);
 	}
 
-	printf("  current = 0x%lx\n", current);
+	printf("  current = 0x%p\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
+	printf("  paca    = 0x%p\t softe: %d\t irq_happened: 0x%02x\n",
 	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
 #endif
 	if (current) {
-		printf("    pid   = %ld, comm = %s\n",
+		printf("    pid   = %d, comm = %s\n",
 		       current->pid, current->comm);
 	}
 
@@ -1662,16 +1662,16 @@ static void prregs(struct pt_regs *fp)
 #ifdef CONFIG_PPC64
 	if (FULL_REGS(fp)) {
 		for (n = 0; n < 16; ++n)
-			printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
+			printf("R%.2d = "REG"   R%.2d = "REG"\n",
 			       n, fp->gpr[n], n+16, fp->gpr[n+16]);
 	} else {
 		for (n = 0; n < 7; ++n)
-			printf("R%.2ld = "REG"   R%.2ld = "REG"\n",
+			printf("R%.2d = "REG"   R%.2d = "REG"\n",
 			       n, fp->gpr[n], n+7, fp->gpr[n+7]);
 	}
 #else
 	for (n = 0; n < 32; ++n) {
-		printf("R%.2d = %.8x%s", n, fp->gpr[n],
+		printf("R%.2d = %.8lx%s", n, fp->gpr[n],
 		       (n & 3) == 3? "\n": "   ");
 		if (n == 12 && !FULL_REGS(fp)) {
 			printf("\n");
@@ -1775,9 +1775,9 @@ static void dump_206_sprs(void)
 
 	/* Actually some of these pre-date 2.06, but whatevs */
 
-	printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8x\n",
+	printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8lx\n",
 		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
-	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8x\n",
+	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8lx\n",
 		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
 	printf("amr    = %.16lx  uamor = %.16lx\n",
 		mfspr(SPRN_AMR), mfspr(SPRN_UAMOR));
@@ -1785,11 +1785,11 @@ static void dump_206_sprs(void)
 	if (!(mfmsr() & MSR_HV))
 		return;
 
-	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
+	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8lx\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
 	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec   = %.16lx\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
-	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8x\n",
+	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8lx\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
 	printf("hsprg0 = %.16lx hsprg1 = %.16lx amor   = %.16lx\n",
 		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1), mfspr(SPRN_AMOR));
@@ -1806,10 +1806,10 @@ static void dump_207_sprs(void)
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return;
 
-	printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8x\n",
+	printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8lx\n",
 		mfspr(SPRN_DPDES), mfspr(SPRN_TIR), mfspr(SPRN_CIR));
 
-	printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8x\n",
+	printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8lx\n",
 		mfspr(SPRN_FSCR), mfspr(SPRN_TAR), mfspr(SPRN_PSPB));
 
 	msr = mfmsr();
@@ -1822,12 +1822,12 @@ static void dump_207_sprs(void)
 
 	printf("mmcr0  = %.16lx  mmcr1 = %.16lx mmcr2  = %.16lx\n",
 		mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCR2));
-	printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
+	printf("pmc1   = %.8lx pmc2 = %.8lx  pmc3 = %.8lx  pmc4   = %.8lx\n",
 		mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
 		mfspr(SPRN_PMC3), mfspr(SPRN_PMC4));
-	printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8x\n",
+	printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8lx\n",
 		mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR), mfspr(SPRN_PMC5));
-	printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8x\n",
+	printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8lx\n",
 		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
 	printf("ebbhr  = %.16lx  ebbrr = %.16lx bescr  = %.16lx\n",
 		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
@@ -2337,22 +2337,25 @@ static void dump_one_paca(int cpu)
 
 #define DUMP(paca, name, format) \
 	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
-		offsetof(struct paca_struct, name));
+		offsetof(struct paca_struct, name))
+#define DUMPPTR(paca, name, format) \
+	printf(" %-*s = %-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
+		offsetof(struct paca_struct, name))
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
-	DUMP(p, kernel_toc, "lx");
-	DUMP(p, kernelbase, "lx");
-	DUMP(p, kernel_msr, "lx");
-	DUMP(p, emergency_sp, "px");
+	DUMP(p, kernel_toc, "llx");
+	DUMP(p, kernelbase, "llx");
+	DUMP(p, kernel_msr, "llx");
+	DUMPPTR(p, emergency_sp, "p");
 #ifdef CONFIG_PPC_BOOK3S_64
-	DUMP(p, nmi_emergency_sp, "px");
-	DUMP(p, mc_emergency_sp, "px");
+	DUMPPTR(p, nmi_emergency_sp, "p");
+	DUMPPTR(p, mc_emergency_sp, "p");
 	DUMP(p, in_nmi, "x");
 	DUMP(p, in_mce, "x");
 	DUMP(p, hmi_event_available, "x");
 #endif
-	DUMP(p, data_offset, "lx");
+	DUMP(p, data_offset, "llx");
 	DUMP(p, hw_cpu_id, "x");
 	DUMP(p, cpu_start, "x");
 	DUMP(p, kexec_state, "x");
@@ -2367,16 +2370,16 @@ static void dump_one_paca(int cpu)
 		vsid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid);
 
 		if (esid || vsid) {
-			printf(" slb_shadow[%d]:       = 0x%016lx 0x%016lx\n",
+			printf(" slb_shadow[%d]:       = 0x%016llx 0x%016llx\n",
 				i, esid, vsid);
 		}
 	}
 	DUMP(p, vmalloc_sllp, "x");
 	DUMP(p, slb_cache_ptr, "x");
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
-		printf(" slb_cache[%d]:        = 0x%016lx\n", i, p->slb_cache[i]);
+		printf(" slb_cache[%d]:        = 0x%016x\n", i, p->slb_cache[i]);
 
-	DUMP(p, rfi_flush_fallback_area, "px");
+	DUMPPTR(p, rfi_flush_fallback_area, "p");
 #endif
 	DUMP(p, dscr_default, "llx");
 #ifdef CONFIG_PPC_BOOK3E
@@ -2387,11 +2390,11 @@ static void dump_one_paca(int cpu)
 	DUMP(p, crit_kstack, "px");
 	DUMP(p, dbg_kstack, "px");
 #endif
-	DUMP(p, __current, "px");
-	DUMP(p, kstack, "lx");
-	printf(" kstack_base          = 0x%016lx\n", p->kstack & ~(THREAD_SIZE - 1));
-	DUMP(p, stab_rr, "lx");
-	DUMP(p, saved_r1, "lx");
+	DUMPPTR(p, __current, "p");
+	DUMP(p, kstack, "llx");
+	printf(" kstack_base          = 0x%016llx\n", p->kstack & ~(THREAD_SIZE - 1));
+	DUMP(p, stab_rr, "llx");
+	DUMP(p, saved_r1, "llx");
 	DUMP(p, trap_save, "x");
 	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
@@ -2405,20 +2408,20 @@ static void dump_one_paca(int cpu)
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DUMP(p, core_idle_state_ptr, "px");
+	DUMPPTR(p, core_idle_state_ptr, "p");
 	DUMP(p, thread_idle_state, "x");
 	DUMP(p, thread_mask, "x");
 	DUMP(p, subcore_sibling_mask, "x");
 #endif
 
-	DUMP(p, accounting.utime, "llx");
-	DUMP(p, accounting.stime, "llx");
-	DUMP(p, accounting.utime_scaled, "llx");
-	DUMP(p, accounting.starttime, "llx");
-	DUMP(p, accounting.starttime_user, "llx");
-	DUMP(p, accounting.startspurr, "llx");
-	DUMP(p, accounting.utime_sspurr, "llx");
-	DUMP(p, accounting.steal_time, "llx");
+	DUMP(p, accounting.utime, "lx");
+	DUMP(p, accounting.stime, "lx");
+	DUMP(p, accounting.utime_scaled, "lx");
+	DUMP(p, accounting.starttime, "lx");
+	DUMP(p, accounting.starttime_user, "lx");
+	DUMP(p, accounting.startspurr, "lx");
+	DUMP(p, accounting.utime_sspurr, "lx");
+	DUMP(p, accounting.steal_time, "lx");
 #undef DUMP
 
 	catch_memory_errors = 0;
@@ -2564,7 +2567,7 @@ static void dump_by_size(unsigned long addr, long count, int size)
 			default: val = 0;
 			}
 
-			printf("%0*lx", size * 2, val);
+			printf("%0*llx", size * 2, val);
 		}
 		printf("\n");
 	}
@@ -2728,7 +2731,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 		dotted = 0;
 		last_inst = inst;
 		if (praddr)
-			printf(REG"  %.8x", adr, inst);
+			printf(REG"  %.8lx", adr, inst);
 		printf("\t");
 		dump_func(inst, adr);
 		printf("\n");
@@ -2860,7 +2863,7 @@ memdiffs(unsigned char *p1, unsigned char *p2, unsigned nb, unsigned maxpr)
 	for( n = nb; n > 0; --n )
 		if( *p1++ != *p2++ )
 			if( ++prt <= maxpr )
-				printf("%.16x %.2x # %.16x %.2x\n", p1 - 1,
+				printf("%p %.2x # %p %.2x\n", p1 - 1,
 					p1[-1], p2 - 1, p2[-1]);
 	if( prt > maxpr )
 		printf("Total of %d differences\n", prt);
@@ -2920,13 +2923,13 @@ memzcan(void)
 		if (ok && !ook) {
 			printf("%.8x .. ", a);
 		} else if (!ok && ook)
-			printf("%.8x\n", a - mskip);
+			printf("%.8lx\n", a - mskip);
 		ook = ok;
 		if (a + mskip < a)
 			break;
 	}
 	if (ook)
-		printf("%.8x\n", a - mskip);
+		printf("%.8lx\n", a - mskip);
 }
 
 static void show_task(struct task_struct *tsk)
@@ -3010,13 +3013,13 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	printf("pgd  @ 0x%016lx\n", pgdir);
+	printf("pgd  @ 0x%p\n", pgdir);
 
 	if (pgd_huge(*pgdp)) {
 		format_pte(pgdp, pgd_val(*pgdp));
 		return;
 	}
-	printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
+	printf("pgdp @ 0x%p = 0x%016lx\n", pgdp, pgd_val(*pgdp));
 
 	pudp = pud_offset(pgdp, addr);
 
@@ -3030,7 +3033,7 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	printf("pudp @ 0x%016lx = 0x%016lx\n", pudp, pud_val(*pudp));
+	printf("pudp @ 0x%p = 0x%016lx\n", pudp, pud_val(*pudp));
 
 	pmdp = pmd_offset(pudp, addr);
 
@@ -3043,7 +3046,7 @@ static void show_pte(unsigned long addr)
 		format_pte(pmdp, pmd_val(*pmdp));
 		return;
 	}
-	printf("pmdp @ 0x%016lx = 0x%016lx\n", pmdp, pmd_val(*pmdp));
+	printf("pmdp @ 0x%p = 0x%016lx\n", pmdp, pmd_val(*pmdp));
 
 	ptep = pte_offset_map(pmdp, addr);
 	if (pte_none(*ptep)) {
@@ -3847,19 +3850,19 @@ static void dump_spu_fields(struct spu *spu)
 	DUMP_FIELD(spu, "0x%lx", ls_size);
 	DUMP_FIELD(spu, "0x%x", node);
 	DUMP_FIELD(spu, "0x%lx", flags);
-	DUMP_FIELD(spu, "%d", class_0_pending);
-	DUMP_FIELD(spu, "0x%lx", class_0_dar);
-	DUMP_FIELD(spu, "0x%lx", class_1_dar);
-	DUMP_FIELD(spu, "0x%lx", class_1_dsisr);
-	DUMP_FIELD(spu, "0x%lx", irqs[0]);
-	DUMP_FIELD(spu, "0x%lx", irqs[1]);
-	DUMP_FIELD(spu, "0x%lx", irqs[2]);
+	DUMP_FIELD(spu, "%llu", class_0_pending);
+	DUMP_FIELD(spu, "0x%llx", class_0_dar);
+	DUMP_FIELD(spu, "0x%llx", class_1_dar);
+	DUMP_FIELD(spu, "0x%llx", class_1_dsisr);
+	DUMP_FIELD(spu, "0x%x", irqs[0]);
+	DUMP_FIELD(spu, "0x%x", irqs[1]);
+	DUMP_FIELD(spu, "0x%x", irqs[2]);
 	DUMP_FIELD(spu, "0x%x", slb_replace);
 	DUMP_FIELD(spu, "%d", pid);
 	DUMP_FIELD(spu, "0x%p", mm);
 	DUMP_FIELD(spu, "0x%p", ctx);
 	DUMP_FIELD(spu, "0x%p", rq);
-	DUMP_FIELD(spu, "0x%p", timestamp);
+	DUMP_FIELD(spu, "0x%llx", timestamp);
 	DUMP_FIELD(spu, "0x%lx", problem_phys);
 	DUMP_FIELD(spu, "0x%p", problem);
 	DUMP_VALUE("0x%x", problem->spu_runcntl_RW,
@@ -3890,7 +3893,7 @@ static void dump_spu_ls(unsigned long num, int subcmd)
 		__delay(200);
 	} else {
 		catch_memory_errors = 0;
-		printf("*** Error: accessing spu info for spu %d\n", num);
+		printf("*** Error: accessing spu info for spu %ld\n", num);
 		return;
 	}
 	catch_memory_errors = 0;
-- 
2.11.0
