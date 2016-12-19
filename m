Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cD0nQBzDwQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:36 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 144so7867916pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 04/10] powerpc/64s: disallow system reset vs system reset
 reentrancy
Date: Tue, 20 Dec 2016 04:30:05 +1000
Message-Id: <20161219183011.28310-5-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for using a dedicated stack for system reset interrupts,
prevent a nested system reset from recovering, in order to simplify
code that is called in crash/debug path. This allows a system reset
interrupt to just use the base stack pointer.

Keep an in_nmi nesting counter similarly to the in_mce counter. Consider
the interrrupt non-recoverable if it is taken inside another system
reset.

Interrupt nesting could be allowed similarly to MCE, but system reset
is a special case that's not for normal operation, so simplicity wins
until there is requirement for nested system reset interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 11 ++++++++++
 arch/powerpc/include/asm/paca.h          |  5 ++++-
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kernel/exceptions-64s.S     | 37 +++++++++++++++++++++++++++-----
 arch/powerpc/kernel/traps.c              |  8 ++++++-
 arch/powerpc/xmon/xmon.c                 |  1 +
 6 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 18eceba135cb..7e47fb67c696 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -214,12 +214,23 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
+/* Do not enable RI */
+#define EXCEPTION_PROLOG_PSERIES_NORI(area, label, h, extra, vec)	\
+	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_PSERIES_1_NORI(label, h);
+
 /* Have the PACA in r13 already */
 #define EXCEPTION_PROLOG_PSERIES_PACA(area, label, h, extra, vec)	\
 	EXCEPTION_PROLOG_0_PACA(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
+#define EXCEPTION_PROLOG_PSERIES_PACA_NORI(area, label, h, extra, vec)	\
+	EXCEPTION_PROLOG_0_PACA(area);					\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_PSERIES_1_NORI(label, h);
+
 #define __KVMTEST(h, n)							\
 	lbz	r10,HSTATE_IN_GUEST(r13);				\
 	cmpwi	r10,0;							\
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 06e96648c1cb..98da152b257b 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -181,12 +181,15 @@ struct paca_struct {
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
 	void *mc_emergency_sp;
+
+	u16 in_nmi;			/* In nmi handler */
+
 	/*
 	 * Flag to check whether we are in machine check early handler
 	 * and already using emergency stack.
 	 */
 	u16 in_mce;
-	u8 hmi_event_available;		 /* HMI event is available */
+	u8 hmi_event_available;		/* HMI event is available */
 #endif
 
 	/* Stuff for accurate time accounting */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index fa7087a2d825..893da286ecc3 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -244,6 +244,7 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	DEFINE(PACAMCEMERGSP, offsetof(struct paca_struct, mc_emergency_sp));
 	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
+	DEFINE(PACA_IN_NMI, offsetof(struct paca_struct, in_nmi));
 #endif
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
 	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index dd2bb0d785c6..4034f7db73b7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -118,7 +118,11 @@ EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrrdi	r13,r13,1 /* Last bit of HSPRG0 is set if waking from winkle */
-	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXNMI, system_reset_common,
+	/*
+	 * MSR_RI is not enabled, because PACA_EXNMI and nmi stack is
+	 * being used, so a nested NMI exception would corrupt it.
+	 */
+	EXCEPTION_PROLOG_PSERIES_PACA_NORI(PACA_EXNMI, system_reset_common,
 						EXC_STD, IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x200)
@@ -154,9 +158,31 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #endif
 
 EXC_COMMON_BEGIN(system_reset_common)
+	/*
+	 * Increment paca->in_nmi then enable MSR_RI. SLB or MCE will be able
+	 * to recover, but nested NMI will notice in_nmi and not recover
+	 * because of the use of the NMI stack. in_nmi reentrancy is tested in
+	 * system_reset_exception.
+	 */
+	lhz	r10,PACA_IN_NMI(r13)
+	addi	r10,r10,1
+	sth	r10,PACA_IN_NMI(r13)
+	li	r10,MSR_RI
+	mtmsrd 	r10,1
+
 	EXCEPTION_COMMON(PACA_EXNMI, 0x100,
-			system_reset, system_reset_exception,
-			ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
+			system_reset, system_reset_exception, 1f,
+			ADD_NVGPRS;ADD_RECONCILE)
+1: /* EXCEPTION_COMMON continues here */
+
+	/*
+	 * The stack is no longer in use, decrement in_nmi.
+	 */
+	lhz	r10,PACA_IN_NMI(r13)
+	subi	r10,r10,1
+	sth	r10,PACA_IN_NMI(r13)
+
+	b	ret_from_except
 
 #ifdef CONFIG_PPC_PSERIES
 /*
@@ -164,8 +190,9 @@ EXC_COMMON_BEGIN(system_reset_common)
  */
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXNMI, system_reset_common, EXC_STD,
-				 NOTEST, 0x100)
+	/* See comment at system_reset exception */
+	EXCEPTION_PROLOG_PSERIES_NORI(PACA_EXNMI, system_reset_common,
+						EXC_STD, NOTEST, 0x100)
 #endif /* CONFIG_PPC_PSERIES */
 
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4239aaf74886..802aa6bbe97b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -281,11 +281,17 @@ void system_reset_exception(struct pt_regs *regs)
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
 		if (ppc_md.system_reset_exception(regs))
-			return;
+			goto out;
 	}
 
 	die("System Reset", regs, SIGABRT);
 
+out:
+#ifdef CONFIG_PPC_BOOK3S_64
+	BUG_ON(get_paca()->in_nmi == 0);
+	if (get_paca()->in_nmi > 1)
+		panic("Unrecoverable nested System Reset");
+#endif
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17cf6886..832cbc097416 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2228,6 +2228,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, emergency_sp, "p");
 #ifdef CONFIG_PPC_BOOK3S_64
 	DUMP(p, mc_emergency_sp, "p");
+	DUMP(p, in_nmi, "x");
 	DUMP(p, in_mce, "x");
 	DUMP(p, hmi_event_available, "x");
 #endif
-- 
2.11.0
