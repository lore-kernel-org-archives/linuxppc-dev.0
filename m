Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 16/16] powerpc: Documentation for transactional memory on
 powerpc
Date: Tue, 27 Nov 2012 13:48:08 +1100
Message-Id: <1353984488-1283-17-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 Documentation/powerpc/transactional_memory.txt |  119 ++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/powerpc/transactional_memory.txt

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
new file mode 100644
index 0000000..881df6b
--- /dev/null
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -0,0 +1,119 @@
+Transactional Memory support
+============================
+
+POWER kernel support for this feature is currently limited to supporting
+its use by user programs.  It is not currently used by the kernel itself.
+
+This file aims to sum up how it is supported by Linux and what behaviour you
+can expect from your user programs.
+
+
+Basic overview
+==============
+
+Hardware Transactional Memory is supported on POWER8 processors, and is a
+feature that enables a different form of atomic memory access.  Several new
+instructions are presented to delimit transactions; transactions are
+guaranteed to either complete atomically or roll back and undo any partial
+changes.
+
+A simple transaction looks like this:
+
+begin_move_money:
+  tbegin
+  beq   abort_handler
+
+  ld    r4, SAVINGS_ACCT(r3)
+  ld    r5, CURRENT_ACCT(r3)
+  subi  r5, r5, 1
+  addi  r4, r4, 1
+  std   r4, SAVINGS_ACCT(r3)
+  std   r5, CURRENT_ACCT(r3)
+
+  tend
+
+  b     continue
+
+abort_handler:
+  ... test for odd failures ...
+
+  /* Retry the transaction if it failed because it conflicted with
+   * someone else: */
+  b     begin_move_money
+
+
+The 'tbegin' instruction denotes the start point, and 'tend' the end point.
+Between these points the processor is in 'Transactional' state; any memory
+references will complete in one go if there are no conflicts with other
+transactional or non-transactional accesses within the system.  In this
+example, the transaction completes as though it were normal straight-line code
+IF no other processor has touched SAVINGS_ACCT(r3) or CURRENT_ACCT(r3); an
+atomic move of money from the current account to the savings account has been
+performed.  Even though the normal ld/std instructions are used (note no
+lwarx/stwcx), either *both* SAVINGS_ACCT(r3) and CURRENT_ACCT(r3) will be
+updated, or neither will be updated.
+
+If, in the meantime, there is a conflict with the locations accessed by the
+transaction, the transaction will be aborted by the CPU.  Register and memory
+state will roll back to that at the 'tbegin', and control will continue from
+'tbegin+4'.  The branch to abort_handler will be taken this second time; the
+abort handler can check the cause of the failure, and retry.
+
+Checkpointed registers include all GPRs, FPRs, VRs/VSRs, LR, CCR/CR, CTR, FPCSR
+and a few other status/flag regs; see the ISA for details.
+
+Causes of transaction aborts
+============================
+
+- Conflicts with cache lines used by other processors
+- Signals
+- Context switches
+- See the ISA for full documentation of everything that will abort transactions.
+
+
+Syscalls
+========
+
+Performing syscalls from within transaction is not recommended, and can lead
+to unpredictable results.
+
+Syscalls do not by design abort transactions, but beware: The kernel code will
+not be running in transactional state.  The effect of syscalls will always
+remain visible, but depending on the call they may abort your transaction as a
+side-effect, read soon-to-be-aborted transactional data that should not remain
+invisible, etc.  If you constantly retry a transaction that constantly aborts
+itself by calling a syscall, you'll have a livelock & make no progress.
+
+Simple syscalls (e.g. sigprocmask()) "could" be OK.  Even things like write()
+from, say, printf() should be OK as long as the kernel does not access any
+memory that was accessed transactionally.
+
+Consider any syscalls that happen to work as debug-only -- not recommended for
+production use.  Best to queue them up till after the transaction is over.
+
+
+Failure cause codes used by kernel
+==================================
+
+These are defined in <asm/reg.h>, and distinguish different reasons why the
+kernel aborted a transaction:
+
+ TM_CAUSE_RESCHED       Thread was rescheduled.
+ TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
+ TM_CAUSE_SYSCALL       Currently unused; future syscalls that must abort
+                        transactions for consistency will use this.
+ TM_CAUSE_SIGNAL        Signal delivered.
+ TM_CAUSE_MISC          Currently unused.
+
+These can be checked by the user program's abort handler as TEXASR[0:7].
+
+
+GDB
+===
+
+GDB and ptrace are not currently TM-aware.  If one stops during a transaction,
+it looks like the transaction has just started (the checkpointed state is
+presented).  The transaction cannot then be continued and will take the failure
+handler route.  Furthermore, the transactional 2nd register state will be
+inaccessible.  GDB can currently be used on programs using TM, but not sensibly
+in parts within transactions.
-- 
1.7.9.5
