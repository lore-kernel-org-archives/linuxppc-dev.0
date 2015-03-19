Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 282C21A09CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 19 Mar 2015 14:44:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4261E2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2J4iccj43974720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2J4iCJW008533
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:12 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
Date: Thu, 19 Mar 2015 15:43:46 +1100
Message-Id: <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
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
 Documentation/powerpc/transactional_memory.txt |   33 ++++++++++++------------
 arch/powerpc/include/uapi/asm/tm.h             |    2 +-
 arch/powerpc/kernel/entry_64.S                 |   19 ++++++++++++++
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index 9791e98..4167bc2 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -74,22 +74,23 @@ Causes of transaction aborts
 Syscalls
 ========
 
-Performing syscalls from within transaction is not recommended, and can lead
-to unpredictable results.
-
-Syscalls do not by design abort transactions, but beware: The kernel code will
-not be running in transactional state.  The effect of syscalls will always
-remain visible, but depending on the call they may abort your transaction as a
-side-effect, read soon-to-be-aborted transactional data that should not remain
-invisible, etc.  If you constantly retry a transaction that constantly aborts
-itself by calling a syscall, you'll have a livelock & make no progress.
-
-Simple syscalls (e.g. sigprocmask()) "could" be OK.  Even things like write()
-from, say, printf() should be OK as long as the kernel does not access any
-memory that was accessed transactionally.
-
-Consider any syscalls that happen to work as debug-only -- not recommended for
-production use.  Best to queue them up till after the transaction is over.
+Syscalls made from within an active transaction will not be performed and the
+transaction will be doomed by the kernel with the failure code TM_CAUSE_SYSCALL
+| TM_CAUSE_PERSISTENT.
+
+Syscalls made from within a suspended transaction are performed as normal and
+the transaction is not explicitly doomed by the kernel.  However, what the
+kernel does to perform the syscall may result in the transaction being doomed
+by the hardware.  The syscall is performed in suspended mode so any side
+effects will be persistent, independent of transaction success or failure.  No
+guarantees are provided by the kernel about which syscalls will affect
+transaction success.
+
+Care must be taken when relying on syscalls to abort during active transactions
+if the calls are made via a library.  Libraries may cache values (which may
+give the appearence of success) or perform operations that cause transaction
+failure before entering the kernel (which may produce different failure codes).
+Examples are glibc's getpid() and lazy symbol resolution.
 
 
 Signals
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
