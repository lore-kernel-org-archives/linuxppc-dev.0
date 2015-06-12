Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E78A11A06AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 11:07:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 12 Jun 2015 11:07:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D96A53578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 11:07:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C17LMw58916880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 11:07:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C16vS3006242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 11:06:57 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, matt@ozlabs.org,
 azanella@linux.vnet.ibm.com
Subject: [PATCH 1/1] powerpc/tm: Abort syscalls in active transactions (v2)
Date: Fri, 12 Jun 2015 11:06:32 +1000
Message-Id: <dd848073cfae511453b9f558c0fbb3859909f268.1434071179.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the syscall handler to doom (tabort) active
transactions when a syscall is made and return very early without
performing the syscall and keeping side effects to a minimum (no CPU
accounting or system call tracing is performed). Also included is a
new HWCAP2 bit, PPC_FEATURE2_HTM_NOSC, to indicate this
behaviour to userspace.

Currently, the system call instruction automatically suspends an
active transaction which causes side effects to persist when an active
transaction fails.

This does change the kernel's behaviour, but in a way that was
documented as unsupported.  It doesn't reduce functionality as
syscalls will still be performed after tsuspend; it just requires that
the transaction be explicitly suspended.  It also provides a
consistent interface and makes the behaviour of user code
substantially the same across powerpc and platforms that do not
support suspended transactions (e.g. x86 and s390).

Performance measurements using
http://ozlabs.org/~anton/junkcode/null_syscall.c indicate the cost of
a normal (non-aborted) system call increases by about 0.25%.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 Documentation/powerpc/transactional_memory.txt  | 32 ++++++++++++-------------
 arch/powerpc/include/asm/cputable.h             | 10 ++++----
 arch/powerpc/include/uapi/asm/cputable.h        |  1 +
 arch/powerpc/include/uapi/asm/tm.h              |  2 +-
 arch/powerpc/kernel/cputable.c                  |  4 +++-
 arch/powerpc/kernel/entry_64.S                  | 28 ++++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-syscall.c |  3 ++-
 7 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index ded6979..ba0a2a4 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -74,22 +74,23 @@ Causes of transaction aborts
 Syscalls
 ========
 
-Performing syscalls from within transaction is not recommended, and can lead
-to unpredictable results.
+Syscalls made from within an active transaction will not be performed and the
+transaction will be doomed by the kernel with the failure code TM_CAUSE_SYSCALL
+| TM_CAUSE_PERSISTENT.
 
-Syscalls do not by design abort transactions, but beware: The kernel code will
-not be running in transactional state.  The effect of syscalls will always
-remain visible, but depending on the call they may abort your transaction as a
-side-effect, read soon-to-be-aborted transactional data that should not remain
-invisible, etc.  If you constantly retry a transaction that constantly aborts
-itself by calling a syscall, you'll have a livelock & make no progress.
+Syscalls made from within a suspended transaction are performed as normal and
+the transaction is not explicitly doomed by the kernel.  However, what the
+kernel does to perform the syscall may result in the transaction being doomed
+by the hardware.  The syscall is performed in suspended mode so any side
+effects will be persistent, independent of transaction success or failure.  No
+guarantees are provided by the kernel about which syscalls will affect
+transaction success.
 
-Simple syscalls (e.g. sigprocmask()) "could" be OK.  Even things like write()
-from, say, printf() should be OK as long as the kernel does not access any
-memory that was accessed transactionally.
-
-Consider any syscalls that happen to work as debug-only -- not recommended for
-production use.  Best to queue them up till after the transaction is over.
+Care must be taken when relying on syscalls to abort during active transactions
+if the calls are made via a library.  Libraries may cache values (which may
+give the appearance of success) or perform operations that cause transaction
+failure before entering the kernel (which may produce different failure codes).
+Examples are glibc's getpid() and lazy symbol resolution.
 
 
 Signals
@@ -176,8 +177,7 @@ kernel aborted a transaction:
  TM_CAUSE_RESCHED       Thread was rescheduled.
  TM_CAUSE_TLBI          Software TLB invalid.
  TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
- TM_CAUSE_SYSCALL       Currently unused; future syscalls that must abort
-                        transactions for consistency will use this.
+ TM_CAUSE_SYSCALL       Syscall from active transaction.
  TM_CAUSE_SIGNAL        Signal delivered.
  TM_CAUSE_MISC          Currently unused.
  TM_CAUSE_ALIGNMENT     Alignment fault.
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6367b83..4994648 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -242,11 +242,13 @@ enum {
 
 /* We only set the TM feature if the kernel was compiled with TM supprt */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-#define CPU_FTR_TM_COMP		CPU_FTR_TM
-#define PPC_FEATURE2_HTM_COMP	PPC_FEATURE2_HTM
+#define CPU_FTR_TM_COMP			CPU_FTR_TM
+#define PPC_FEATURE2_HTM_COMP		PPC_FEATURE2_HTM
+#define PPC_FEATURE2_HTM_NOSC_COMP	PPC_FEATURE2_HTM_NOSC
 #else
-#define CPU_FTR_TM_COMP		0
-#define PPC_FEATURE2_HTM_COMP	0
+#define CPU_FTR_TM_COMP			0
+#define PPC_FEATURE2_HTM_COMP		0
+#define PPC_FEATURE2_HTM_NOSC_COMP	0
 #endif
 
 /* We need to mark all pages as being coherent if we're SMP or we have a
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index de2c0e4..4368604 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -42,5 +42,6 @@
 #define PPC_FEATURE2_ISEL		0x08000000
 #define PPC_FEATURE2_TAR		0x04000000
 #define PPC_FEATURE2_VEC_CRYPTO		0x02000000
+#define PPC_FEATURE2_HTM_NOSC		0x01000000
 
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/include/uapi/asm/tm.h b/arch/powerpc/include/uapi/asm/tm.h
index 5d836b7..5047659 100644
--- a/arch/powerpc/include/uapi/asm/tm.h
+++ b/arch/powerpc/include/uapi/asm/tm.h
@@ -11,7 +11,7 @@
 #define TM_CAUSE_RESCHED	0xde
 #define TM_CAUSE_TLBI		0xdc
 #define TM_CAUSE_FAC_UNAV	0xda
-#define TM_CAUSE_SYSCALL	0xd8  /* future use */
+#define TM_CAUSE_SYSCALL	0xd8
 #define TM_CAUSE_MISC		0xd6  /* future use */
 #define TM_CAUSE_SIGNAL		0xd4
 #define TM_CAUSE_ALIGNMENT	0xd2
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 60262fd..7d80bfd 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -108,7 +108,9 @@ extern void __restore_cpu_e6500(void);
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER2_POWER8	(PPC_FEATURE2_ARCH_2_07 | \
-				 PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
+				 PPC_FEATURE2_HTM_COMP | \
+				 PPC_FEATURE2_HTM_NOSC_COMP | \
+				 PPC_FEATURE2_DSCR | \
 				 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
 				 PPC_FEATURE2_VEC_CRYPTO)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index afbc200..aa36f01 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -34,6 +34,7 @@
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
+#include <asm/tm.h>
 
 /*
  * System calls.
@@ -51,6 +52,12 @@ exception_marker:
 
 	.globl system_call_common
 system_call_common:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	extrdi.	r10, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
+	bne	tabort_syscall
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
+#endif
 	andi.	r10,r12,MSR_PR
 	mr	r10,r1
 	addi	r1,r1,-INT_FRAME_SIZE
@@ -311,6 +318,27 @@ syscall_exit_work:
 	bl	do_syscall_trace_leave
 	b	ret_from_except
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+tabort_syscall:
+	/* Doom the transaction and don't perform the syscall: */
+	mfmsr	r10
+	li	r13, 1
+	rldimi	r10, r13, MSR_TM_LG, 63-MSR_TM_LG
+	mtmsrd	r10, 0
+
+	li	r13, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
+	TABORT(R13)
+
+	li	r13, MSR_RI
+	andc	r10, r10, r13
+	mtmsrd	r10, 1
+	mtspr	SPRN_SRR0, r11
+	mtspr	SPRN_SRR1, r12
+
+	rfid
+	b	.	/* prevent speculative execution */
+#endif
+
 /* Save non-volatile GPRs, if not already saved. */
 _GLOBAL(save_nvgprs)
 	ld	r11,_TRAP(r1)
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 3ed8d4b..1276e23 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -82,7 +82,8 @@ int tm_syscall(void)
 	unsigned count = 0;
 	struct timeval end, now;
 
-	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2)
+		  & PPC_FEATURE2_HTM_NOSC));
 	setbuf(stdout, NULL);
 
 	printf("Testing transactional syscalls for %d seconds...\n", TEST_DURATION);
-- 
2.1.4
