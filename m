Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH][RFC] powerpc/powernv: Taking non-maskable interrupts in OPAL
Date: Wed, 17 Jan 2018 22:08:30 +1000
Message-Id: <20180117120831.22533-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Linux uses r13 as a per-cpu register.
- Does not restore r13 when returning from interrupt to kernel context
  (MSR[PR]=0), to accommodate migrating to a different CPU.
- OPAL runs with MSR[PR]=0.
- OPAL uses r13 for its own register.
- OPAL runs with MSR[RI]=1.

This means that if we take an interrupt in OPAL (sreset or machine
check), Linux may return to OPAL context with the wrong r13.

I propose to fix this for now by restoring r13 of interrupted kernel
context if MSR[EE]=0. Linux process context won't migrate between CPUs
if interrupts are disabled. Possibly we do something a bit smarter in
future like paca->in_opal, but this may be a minimal fix.

Another issue I ran into when testing this stuff is that our machine
check platform error shutdown code that we call from machine check
makes various OPAL calls (write nvram, flush console, reboot). Upstream
skiboot now has some checks to detect re-entrant calls and reject them.
This causes a few issues (infinite loops due to OPAL_BUSY mainly, but
we could change that to a different error code).

So we can avoid the unnecessary calls if our regs came from "in_opal",
but we may still want to perform a few calls. OPAL_SIGNAL_SYSTEM_RESET,
OPAL_QUIESCE, and OPAL_CEC_REBOOT/REBOOT2/SHUTDOWN come to mind. Once
we make such a re-entrant call, the interrupted OPAL stack is destroyed
so we can never return. That's probably okay for the machine check error
shutdown path, better to attempt a reboot than leave the machine hung.
It's not clear exactly what we want to allow and exclude though. Should
we try to write to the console? NVRAM? The more we do the more chance
we have of getting stuck somewhere or corrupting things further.

What I've done is a quick proof of concept for Linux and skiboot which
gives some idea of what we can do. It works, but it feels a bit ad hoc.
Not sure. It would be good to have us decide how to deal with all this.
There's actually several other questions that open up if we consider that
we may want to get debugging information out of opal if it's interrupted
by a system reset or machine check -- we can't re-enter and trash the
stack because we'd be unable to get a backtrace, maybe a special crash
call could tidy things up for us and print useful information.

Anyway, I think we can get some minimal fixes in which mostly make
things work, but needs more careful thinking in the longer term.

Haven't finished the patches completely yet, so I'll repost more
polished versions hopefully after comments.

Thanks,
Nick
---
 arch/powerpc/kernel/entry_64.S        | 16 +++++++++++++---
 arch/powerpc/platforms/powernv/opal.c | 10 ++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2748584b767d..ca25d1056874 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -266,7 +266,7 @@ BEGIN_FTR_SECTION
 	HMT_MEDIUM_LOW
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
-	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
+	ld	r13,GPR13(r1)	/* restore r13 if returning to usermode */
 	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
@@ -277,7 +277,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	b	.	/* prevent speculative execution */
 
 	/* exit to kernel */
-1:	ld	r2,GPR2(r1)
+1:
+	andi.	r6,r8,MSR_EE
+	bne	2f
+	ld	r13,GPR13(r1)	/* also restore r13 if EE=0 */
+2:
+	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
@@ -908,7 +913,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
-1:	mtspr	SPRN_SRR1,r3
+1:
+	andi.	r0,r3,MSR_EE
+	bne+	2f
+	REST_GPR(13, r1)
+2:
+	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
 	mtcrf	0xFF,r2
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 041ddbd1fc57..5b2997d6e894 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -475,10 +475,12 @@ void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
 		show_regs(regs);
 	smp_send_stop();
 	printk_safe_flush_on_panic();
-	kmsg_dump(KMSG_DUMP_PANIC);
-	bust_spinlocks(0);
-	debug_locks_off();
-	console_flush_on_panic();
+	if (!(regs->nip >= opal.base && regs->nip < opal.base + opal.size)) {
+		kmsg_dump(KMSG_DUMP_PANIC);
+		bust_spinlocks(0);
+		debug_locks_off();
+		console_flush_on_panic();
+	}
 
 	/*
 	 * Don't bother to shut things down because this will
-- 
2.15.1
