Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B021A04BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 14:21:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 30 Mar 2015 13:21:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6382C357804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 14:21:44 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2U3LabZ48496642
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 14:21:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2U3LA5O025829
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 14:21:11 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v2 1/4] powerpc/tm: Abort syscalls in active transactions
Date: Mon, 30 Mar 2015 14:20:44 +1100
Message-Id: <cb32074cdf25c5b5707904ea618f3c375daa6126.1427685637.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1427685637.git.sam.bobroff@au1.ibm.com>
References: <cover.1427685637.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1427685637.git.sam.bobroff@au1.ibm.com>
References: <cover.1427685637.git.sam.bobroff@au1.ibm.com>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the syscall handler to doom (tabort) active
transactions when a syscall is made and return immediately without
performing the syscall.

Currently, the system call instruction automatically suspends an
active transaction which causes side effects to persist when an active
transaction fails.

This does change the kernel's behaviour, but in a way that was
documented as unsupported. It doesn't reduce functionality because
syscalls will still be performed after tsuspend. It also provides a
consistent interface and makes the behaviour of user code
substantially the same across powerpc and platforms that do not
support suspended transactions (e.g. x86 and s390).

Performance measurements using
http://ozlabs.org/~anton/junkcode/null_syscall.c
indicate the cost of a system call increases by about 0.5%.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

Also update the failure code table.

 Documentation/powerpc/transactional_memory.txt |   32 ++++++++++++------------
 arch/powerpc/include/uapi/asm/tm.h             |    2 +-
 arch/powerpc/kernel/entry_64.S                 |   19 ++++++++++++++
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index 9791e98..98b39af 100644
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
  TM_CAUSE_TLBI          Software TLB invalide.
  TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
- TM_CAUSE_SYSCALL       Currently unused; future syscalls that must abort
-                        transactions for consistency will use this.
+ TM_CAUSE_SYSCALL       Syscall from active transaction.
  TM_CAUSE_SIGNAL        Signal delivered.
  TM_CAUSE_MISC          Currently unused.
  TM_CAUSE_ALIGNMENT     Alignment fault.
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
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d180caf2..85bf81d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -34,6 +34,7 @@
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
+#include <asm/tm.h>
 
 /*
  * System calls.
@@ -145,6 +146,24 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	syscall_dotrace
 .Lsyscall_dotrace_cont:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	b	1f
+END_FTR_SECTION_IFCLR(CPU_FTR_TM)
+	extrdi.	r11, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
+	beq+	1f
+
+	/* Doom the transaction and don't perform the syscall: */
+	mfmsr	r11
+	li	r12, 1
+	rldimi	r11, r12, MSR_TM_LG, 63-MSR_TM_LG
+	mtmsrd	r11, 0
+	li	r11, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
+	tabort. r11
+
+	b	.Lsyscall_exit
+1:
+#endif
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
-- 
1.7.10.4
