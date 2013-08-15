Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/6] powerpc: Skip emulating & leave interrupts off for kernel
 program checks
Date: Thu, 15 Aug 2013 15:22:19 +1000
Message-Id: <1376544139-26783-6-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
References: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the program check handler we handle some causes with interrupts off
and others with interrupts on.

We need to enable interrupts to handle the emulation cases, because they
access userspace memory and might sleep.

For faults in the kernel we don't want to do any emulation, and
emulate_instruction() enforces that. do_mathemu() doesn't but probably
should.

The other disadvantage of enabling interrupts for kernel faults is that
we may take another interrupt, and recurse. As seen below:

  --- Exception: e40 at c000000000004ee0 performance_monitor_relon_pSeries_1
  [link register   ] c00000000000f858 .arch_local_irq_restore+0x38/0x90
  [c000000fb185dc10] 0000000000000000 (unreliable)
  [c000000fb185dc80] c0000000007d8558 .program_check_exception+0x298/0x2d0
  [c000000fb185dd00] c000000000002f40 emulation_assist_common+0x140/0x180
  --- Exception: e40 at c000000000004ee0 performance_monitor_relon_pSeries_1
  [link register   ] c00000000000f858 .arch_local_irq_restore+0x38/0x90
  [c000000fb185dff0] 00000000008b9190 (unreliable)
  [c000000fb185e060] c0000000007d8558 .program_check_exception+0x298/0x2d0

So avoid both problems by checking if the fault was in the kernel and
skipping the enable of interrupts and the emulation. Go straight to
delivering the SIGILL, which for kernel faults calls die() and so on,
dropping us in the debugger etc.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e435bc0..9515bde 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1116,6 +1116,16 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	}
 #endif
 
+	/*
+	 * If we took the program check in the kernel skip down to sending a
+	 * SIGILL. The subsequent cases all relate to emulating instructions
+	 * which we should only do for userspace. We also do not want to enable
+	 * interrupts for kernel faults because that might lead to further
+	 * faults, and loose the context of the original exception.
+	 */
+	if (!user_mode(regs))
+		goto sigill;
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
@@ -1168,6 +1178,7 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 		}
 	}
 
+sigill:
 	if (reason & REASON_PRIVILEGED)
 		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
 	else
-- 
1.8.1.2
