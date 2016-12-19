Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cF5dpHzDwPx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:37 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g1so7405157pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 05/10] powerpc/64s: dedicated system reset interrupt stack
Date: Tue, 20 Dec 2016 04:30:06 +1000
Message-Id: <20161219183011.28310-6-npiggin@gmail.com>
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

The system reset interrupt is used for crash/debug situations, so it is
desirable to have as little impact on the normal state of the system as
possible.

Currently it uses the current kernel stack to process the exception.
This stores into the stack which may be involved with the crash. The
stack pointer may be corrupted, or it may have overflowed.

Avoid or minimise these problems by creating a dedicated NMI stack for
the system reset interrupt to use.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 13 +++++++++++++
 arch/powerpc/include/asm/paca.h          |  3 ++-
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kernel/exceptions-64s.S     |  8 +++++---
 arch/powerpc/kernel/setup_64.c           |  5 +++++
 arch/powerpc/xmon/xmon.c                 |  1 +
 6 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 7e47fb67c696..7884d9263b98 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -542,6 +542,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	bl	hdlr;						\
 	b	ret
 
+/*
+ * Exception where stack is already set in r1, r1 is saved in r10, and it
+ * continues rather than returns.
+ */
+#define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
+	EXCEPTION_PROLOG_COMMON_1();				\
+	EXCEPTION_PROLOG_COMMON_2(area);			\
+	EXCEPTION_PROLOG_COMMON_3(trap);			\
+	/* Volatile regs are potentially clobbered here */	\
+	additions;						\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr
+
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
 	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
 		ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 98da152b257b..c4887c67157b 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -179,7 +179,8 @@ struct paca_struct {
 	u64 exmc[13];		/* used for machine checks */
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
-	/* Exclusive emergency stack pointer for machine check exception. */
+	/* Exclusive stacks for system reset and machine check exception. */
+	void *nmi_emergency_sp;
 	void *mc_emergency_sp;
 
 	u16 in_nmi;			/* In nmi handler */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 893da286ecc3..ba1e3bb09f9f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -242,6 +242,7 @@ int main(void)
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
 #ifdef CONFIG_PPC_BOOK3S_64
+	DEFINE(PACANMIEMERGSP, offsetof(struct paca_struct, nmi_emergency_sp));
 	DEFINE(PACAMCEMERGSP, offsetof(struct paca_struct, mc_emergency_sp));
 	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
 	DEFINE(PACA_IN_NMI, offsetof(struct paca_struct, in_nmi));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4034f7db73b7..59f1a53f45c7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -170,10 +170,12 @@ EXC_COMMON_BEGIN(system_reset_common)
 	li	r10,MSR_RI
 	mtmsrd 	r10,1
 
-	EXCEPTION_COMMON(PACA_EXNMI, 0x100,
-			system_reset, system_reset_exception, 1f,
+	mr	r10,r1
+	ld	r1,PACANMIEMERGSP(r13)
+	subi	r1,r1,INT_FRAME_SIZE
+	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100,
+			system_reset, system_reset_exception,
 			ADD_NVGPRS;ADD_RECONCILE)
-1: /* EXCEPTION_COMMON continues here */
 
 	/*
 	 * The stack is no longer in use, decrement in_nmi.
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6824157e4d2e..0823064c57c1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -573,6 +573,11 @@ void __init emergency_stack_init(void)
 		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
+		/* emergency stack for NMI exception handling. */
+		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+		klp_init_thread_info(ti);
+		paca[i].nmi_emergency_sp = (void *)ti + THREAD_SIZE;
+
 		/* emergency stack for machine check exception handling. */
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
 		klp_init_thread_info(ti);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 832cbc097416..77a88319f494 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2227,6 +2227,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, kernel_msr, "lx");
 	DUMP(p, emergency_sp, "p");
 #ifdef CONFIG_PPC_BOOK3S_64
+	DUMP(p, nmi_emergency_sp, "p");
 	DUMP(p, mc_emergency_sp, "p");
 	DUMP(p, in_nmi, "x");
 	DUMP(p, in_mce, "x");
-- 
2.11.0
