Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/17] powerpc: Hardware transactional memory support for
 POWER8
Date: Wed, 13 Feb 2013 15:31:18 +1100
Message-Id: <1360729895-304-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1358488117-17363-1-git-send-email-mikey@neuling.org>
References: <1358488117-17363-1-git-send-email-mikey@neuling.org>
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

POWER8 implements hardware transactional memory support.  This patch series
adds kernel support so that user programs can use this hardware transactional
memory and the new state is properly context switched.  It is not currently
used by the kernel itself.

This patch series was originally developed by Matt Evans.

v3 changes:
 Incorporate review from benh (offline conversation):
   - Improve IRQ disabling for tm_reclaim
   - Improve IRQ disabling for early fp/vmx/vsx unavail handling
   - Change CONFIG option to add PPC (now PPC_TRANSACTIONAL_MEM)
   - strip some unneeded #defines
   - micro optimisation to asm in  early fp/vmx/vsx
      -       srdi    r0, r12, MSR_TS_LG
      -       andi.   r0, r0, 3
      +       rldicl. r0, r12, (64-MSR_TS_LG), (64-2)
   - do tabort on unmap only when current is using TM
   - removed unneeded patch which moved when writing MSR back to the stack

v2 changes:
 Adds signal handling
 Removes some code for detecting when to restore all register or not
 Added tabort for local tlb invalidates 
 Rebased on benh's next tree

Basic overview of a POWER8 hardware transaction memory
=====================================================
Hardware transactional memory is a feature that enables a different form of
atomic memory access.  Several new instructions are presented to delimit
transactions; transactions are guaranteed to either complete atomically or roll
back and undo any partial changes.

A simple transaction looks like this:

begin_move_money:
  tbegin
  beq   abort_handler

  ld    r4, SAVINGS_ACCT(r3)
  ld    r5, CURRENT_ACCT(r3)
  subi  r5, r5, 1
  addi  r4, r4, 1
  std   r4, SAVINGS_ACCT(r3)
  std   r5, CURRENT_ACCT(r3)

  tend

  b     continue

abort_handler:
  ... test for odd failures ...

  /* Retry the transaction if it failed because it conflicted with
   * someone else: */
  b     begin_move_money


The 'tbegin' instruction denotes the start point, and 'tend' the end point.
Between these points the processor is in 'Transactional' state; any memory
references will complete in one go if there are no conflicts with other
transactional or non-transactional accesses within the system.  In this
example, the transaction completes as though it were normal straight-line code
IF no other processor has touched SAVINGS_ACCT(r3) or CURRENT_ACCT(r3); an
atomic move of money from the current account to the savings account has been
performed.  Even though the normal ld/std instructions are used (note no
lwarx/stwcx), either *both* SAVINGS_ACCT(r3) and CURRENT_ACCT(r3) will be
updated, or neither will be updated.

If, in the meantime, there is a conflict with the locations accessed by the
transaction, the transaction will be aborted by the CPU.  Register and memory
state will roll back to that at the 'tbegin', and control will continue from
'tbegin+4'.  The branch to abort_handler will be taken this second time; the
abort handler can check the cause of the failure, and retry.

Checkpointed registers include all GPRs, FPRs, VRs/VSRs, LR, CCR/CR, CTR, FPCSR
and a few other status/flag regs; 

A preliminary ISA for TM can be found here:
  https://www.power.org/documentation/power-isa-transactional-memory/

-- 
1.7.10.4
