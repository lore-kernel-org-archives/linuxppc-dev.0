Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix null pointer deref in perf hardware breakpoints
In-reply-to: <1345620143-17289-3-git-send-email-mikey@neuling.org>
References: <1345620143-17289-1-git-send-email-mikey@neuling.org>
 <1345620143-17289-3-git-send-email-mikey@neuling.org>
Date: Thu, 23 Aug 2012 16:30:43 +1000
Message-ID: <8695.1345703443@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if you are doing a global perf recording with hardware
breakpoints (ie perf record -e mem:0xdeadbeef -a), you can oops with:

  Faulting instruction address: 0xc000000000738890
  cpu 0xc: Vector: 300 (Data Access) at [c0000003f76af8d0]
      pc: c000000000738890: .hw_breakpoint_handler+0xa0/0x1e0
      lr: c000000000738830: .hw_breakpoint_handler+0x40/0x1e0
      sp: c0000003f76afb50
     msr: 8000000000001032
     dar: 6f0
   dsisr: 42000000
    current = 0xc0000003f765ac00
    paca    = 0xc00000000f262a00   softe: 0        irq_happened: 0x01
    pid   = 6810, comm = loop-read
  enter ? for help
  [c0000003f76afbe0] c00000000073cd04 .notifier_call_chain.isra.0+0x84/0xe0
  [c0000003f76afc80] c00000000073cdbc .notify_die+0x3c/0x60
  [c0000003f76afd20] c0000000000139f0 .do_dabr+0x40/0xf0
  [c0000003f76afe30] c000000000005a9c handle_dabr_fault+0x14/0x48
  --- Exception: 300 (Data Access) at 0000000010000480
  SP (ff8679e0) is in userspace

This is because we don't check to see if the break point is associated
with task before we deference the task_struct pointer.

This changes the update to use current. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2: mpe pointed out that we should be using current here so that once we
single step the next instruction, we know where to store the perf event.
Confirming this, the original patch didn't actually record any data when
we used -a even when we hit.

This new patch fixes this so that -a doesn't oops and records data too!

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f3a82dd..956a4c4 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -253,7 +253,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 
 	/* Do not emulate user-space instructions, instead single-step them */
 	if (user_mode(regs)) {
-		bp->ctx->task->thread.last_hit_ubp = bp;
+		current->thread.last_hit_ubp = bp;
 		regs->msr |= MSR_SE;
 		goto out;
 	}
