Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FF0B1A0B5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 16:55:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Revert "powerpc/tm: Abort syscalls in active transactions"
Date: Thu, 30 Apr 2015 16:55:30 +1000
Message-Id: <1430376930-31868-1-git-send-email-mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit feba40362b11341bee6d8ed58d54b896abbd9f84.

Although the principle of this change is good, the implementation has a
few issues.

Firstly we can sometimes fail to abort a syscall because r12 may have
been clobbered by C code if we went down the virtual CPU accounting
path, or if syscall tracing was enabled.

Secondly we have decided that it is safer to abort the syscall even
earlier in the syscall entry path, so that we avoid the syscall tracing
path when we are transactional.

So that we have time to thoroughly test those changes we have decided to
revert this for this merge window and will merge the fixed version in
the next window.

NB. Rather than reverting the selftest we just drop tm-syscall from
TEST_PROGS so that it's not run by default.

Fixes: feba40362b11 ("powerpc/tm: Abort syscalls in active transactions")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/powerpc/transactional_memory.txt | 32 +++++++++++++-------------
 arch/powerpc/include/uapi/asm/tm.h             |  2 +-
 arch/powerpc/kernel/entry_64.S                 | 19 ---------------
 tools/testing/selftests/powerpc/tm/Makefile    |  2 +-
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index ba0a2a4a54ba..ded69794a5c0 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -74,23 +74,22 @@ Causes of transaction aborts
 Syscalls
 ========
 
-Syscalls made from within an active transaction will not be performed and the
-transaction will be doomed by the kernel with the failure code TM_CAUSE_SYSCALL
-| TM_CAUSE_PERSISTENT.
+Performing syscalls from within transaction is not recommended, and can lead
+to unpredictable results.
 
-Syscalls made from within a suspended transaction are performed as normal and
-the transaction is not explicitly doomed by the kernel.  However, what the
-kernel does to perform the syscall may result in the transaction being doomed
-by the hardware.  The syscall is performed in suspended mode so any side
-effects will be persistent, independent of transaction success or failure.  No
-guarantees are provided by the kernel about which syscalls will affect
-transaction success.
+Syscalls do not by design abort transactions, but beware: The kernel code will
+not be running in transactional state.  The effect of syscalls will always
+remain visible, but depending on the call they may abort your transaction as a
+side-effect, read soon-to-be-aborted transactional data that should not remain
+invisible, etc.  If you constantly retry a transaction that constantly aborts
+itself by calling a syscall, you'll have a livelock & make no progress.
 
-Care must be taken when relying on syscalls to abort during active transactions
-if the calls are made via a library.  Libraries may cache values (which may
-give the appearance of success) or perform operations that cause transaction
-failure before entering the kernel (which may produce different failure codes).
-Examples are glibc's getpid() and lazy symbol resolution.
+Simple syscalls (e.g. sigprocmask()) "could" be OK.  Even things like write()
+from, say, printf() should be OK as long as the kernel does not access any
+memory that was accessed transactionally.
+
+Consider any syscalls that happen to work as debug-only -- not recommended for
+production use.  Best to queue them up till after the transaction is over.
 
 
 Signals
@@ -177,7 +176,8 @@ kernel aborted a transaction:
  TM_CAUSE_RESCHED       Thread was rescheduled.
  TM_CAUSE_TLBI          Software TLB invalid.
  TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
- TM_CAUSE_SYSCALL       Syscall from active transaction.
+ TM_CAUSE_SYSCALL       Currently unused; future syscalls that must abort
+                        transactions for consistency will use this.
  TM_CAUSE_SIGNAL        Signal delivered.
  TM_CAUSE_MISC          Currently unused.
  TM_CAUSE_ALIGNMENT     Alignment fault.
diff --git a/arch/powerpc/include/uapi/asm/tm.h b/arch/powerpc/include/uapi/asm/tm.h
index 5047659815a5..5d836b7c1176 100644
--- a/arch/powerpc/include/uapi/asm/tm.h
+++ b/arch/powerpc/include/uapi/asm/tm.h
@@ -11,7 +11,7 @@
 #define TM_CAUSE_RESCHED	0xde
 #define TM_CAUSE_TLBI		0xdc
 #define TM_CAUSE_FAC_UNAV	0xda
-#define TM_CAUSE_SYSCALL	0xd8
+#define TM_CAUSE_SYSCALL	0xd8  /* future use */
 #define TM_CAUSE_MISC		0xd6  /* future use */
 #define TM_CAUSE_SIGNAL		0xd4
 #define TM_CAUSE_ALIGNMENT	0xd2
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8ca9434c40e6..afbc20019c2e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -34,7 +34,6 @@
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
-#include <asm/tm.h>
 
 /*
  * System calls.
@@ -146,24 +145,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	syscall_dotrace
 .Lsyscall_dotrace_cont:
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-BEGIN_FTR_SECTION
-	b	1f
-END_FTR_SECTION_IFCLR(CPU_FTR_TM)
-	extrdi.	r11, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
-	beq+	1f
-
-	/* Doom the transaction and don't perform the syscall: */
-	mfmsr	r11
-	li	r12, 1
-	rldimi	r11, r12, MSR_TM_LG, 63-MSR_TM_LG
-	mtmsrd	r11, 0
-	li	r11, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
-	TABORT(R11)
-
-	b	.Lsyscall_exit
-1:
-#endif
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 1b616fa79e93..6bff955e1d55 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall
+TEST_PROGS := tm-resched-dscr
 
 all: $(TEST_PROGS)
 
-- 
2.1.0
