Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdrDY75k0zDqmG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:01:33 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: paulus@samba.org, cyrilbur@gmail.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Avoid SLB faults in treclaim/trecheckpoint when
 RI=0
Date: Tue, 28 Jun 2016 13:01:04 +1000
Message-Id: <1467082864-7783-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have 2 segments that are bolted for the kernel linear
mapping (ie 0xc000... addresses). This is 0 to 1TB and also the kernel
stacks.  Anything accessed outside of these regions may need to be
faulted in.

If a machine has < 2TB of memory we never fault on the kernel linear
mapping as these two segments cover all physical memory. If a machine
has > 2TB of memory, there may be structures outside of these two
segments that need to be faulted in. This faulting can occur when
running as a guest as the hypervisor may remove any SLB that's not
bolted.

When we treclaim and trecheckpoint we have a window where we need to
run with the userspace GPRs. This means that we no longer have a valid
stack pointer in r1. For this window we therefore clear MSR RI to
indicate that any exceptions taken at this point won't be able to be
handled. This means that we can't take segment misses in this RI=0
window.

In this RI=0 region, we currently access the thread_struct for the
process being context switched to or from.  This thread_struct access
may cause a segment fault since it's not guaranteed to be covered by
the two bolted segment entries.

We've seen this with a crash when running as a guest with > 2TB of
memory on powervm:

  Unrecoverable exception 4100 at c00000000004f138
  Oops: Unrecoverable exception, sig: 6 [#1]
  SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: af_packet xfs libcrc32c ses enclosure tg3 .... <snipped>
  Supported: Yes, External
  CPU: 1280 PID: 7755 Comm: kworker/1280:1 Tainted: G                 X 4.4.13-46-default #1
  task: c000189001df4210 ti: c000189001d5c000 task.ti: c000189001d5c000
  NIP: c00000000004f138 LR: 0000000010003a24 CTR: 0000000010001b20
  REGS: c000189001d5f730 TRAP: 4100   Tainted: G                 X  (4.4.13-46-default)
  MSR: 8000000100001031 <SF,ME,IR,DR,LE>  CR: 24000048  XER: 00000000
  CFAR: c00000000004ed18 SOFTE: 0
  GPR00: ffffffffc58d7b60 c000189001d5f9b0 00000000100d7d00 000000003a738288
  GPR04: 0000000000002781 0000000000000006 0000000000000000 c0000d1f4d889620
  GPR08: 000000000000c350 00000000000008ab 00000000000008ab 00000000100d7af0
  GPR12: 00000000100d7ae8 00003ffe787e67a0 0000000000000000 0000000000000211
  GPR16: 0000000010001b20 0000000000000000 0000000000800000 00003ffe787df110
  GPR20: 0000000000000001 00000000100d1e10 0000000000000000 00003ffe787df050
  GPR24: 0000000000000003 0000000000010000 0000000000000000 00003fffe79e2e30
  GPR28: 00003fffe79e2e68 00000000003d0f00 00003ffe787e67a0 00003ffe787de680
  NIP [c00000000004f138] restore_gprs+0xd0/0x16c
  LR [0000000010003a24] 0x10003a24
  Call Trace:
  [c000189001d5f9b0] [c000189001d5f9f0] 0xc000189001d5f9f0 (unreliable)
  [c000189001d5fb90] [c00000000001583c] tm_recheckpoint+0x6c/0xa0
  [c000189001d5fbd0] [c000000000015c40] __switch_to+0x2c0/0x350
  [c000189001d5fc30] [c0000000007e647c] __schedule+0x32c/0x9c0
  [c000189001d5fcb0] [c0000000007e6b58] schedule+0x48/0xc0
  [c000189001d5fce0] [c0000000000deabc] worker_thread+0x22c/0x5b0
  [c000189001d5fd80] [c0000000000e7000] kthread+0x110/0x130
  [c000189001d5fe30] [c000000000009538] ret_from_kernel_thread+0x5c/0xa4
  Instruction dump:
  7cb103a6 7cc0e3a6 7ca222a6 78a58402 38c00800 7cc62838 08860000 7cc000a6
  38a00006 78c60022 7cc62838 0b060000 <e8c701a0> 7ccff120 e8270078 e8a70098
  ---[ end trace 602126d0a1dedd54 ]---

This fixes this by coping the required data from the thread_struct to
the stack before we clear MSR RI. Then once we clear RI, we only
access the stack, guaranteeing there's no segment miss.

We also tighten the region over which we set RI=0 on the treclaim
path. This may have a slight performance impact since we're adding an
mtmsr instruction.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
CC: stable@vger.kernel.org	# v3.11+
---
 arch/powerpc/kernel/tm.S | 59 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index bf8f34a..d92a9e8 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -110,17 +110,11 @@ _GLOBAL(tm_reclaim)
 	std	r3, STK_PARAM(R3)(r1)
 	SAVE_NVGPRS(r1)
 
-	/* We need to setup MSR for VSX register save instructions.  Here we
-	 * also clear the MSR RI since when we do the treclaim, we won't have a
-	 * valid kernel pointer for a while.  We clear RI here as it avoids
-	 * adding another mtmsr closer to the treclaim.  This makes the region
-	 * maked as non-recoverable wider than it needs to be but it saves on
-	 * inserting another mtmsrd later.
-	 */
+	/* We need to setup MSR for VSX register save instructions. */
 	mfmsr	r14
 	mr	r15, r14
 	ori	r15, r15, MSR_FP
-	li	r16, MSR_RI
+	li	r16, 0
 	ori	r16, r16, MSR_EE /* IRQs hard off */
 	andc	r15, r15, r16
 	oris	r15, r15, MSR_VEC@h
@@ -176,6 +170,17 @@ dont_backup_fp:
 1:	tdeqi   r6, 0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
 
+	/* Clear MSR RI since we are about to change R1. */
+	li	r4, 0
+	mtmsrd	r4, 1
+
+	/*
+	 * BE CAREFUL HERE:
+	 * At this point we can't take an SLB miss since we have RI
+	 * off. Load off the stack/paca which are in SLB bolted regions
+	 * until we turn MSR RI back on.
+	 */
+
 	/* The moment we treclaim, ALL of our GPRs will switch
 	 * to user register state.  (FPRs, CCR etc. also!)
 	 * Use an sprg and a tm_scratch in the PACA to shuffle.
@@ -197,6 +202,11 @@ dont_backup_fp:
 
 	/* Store the PPR in r11 and reset to decent value */
 	std	r11, GPR11(r1)			/* Temporary stash */
+
+	/* Reset MSR RI so we can take SLB faults again */
+	li	r11, MSR_RI
+	mtmsrd	r11, 1
+
 	mfspr	r11, SPRN_PPR
 	HMT_MEDIUM
 
@@ -397,11 +407,6 @@ restore_gprs:
 	ld	r5, THREAD_TM_DSCR(r3)
 	ld	r6, THREAD_TM_PPR(r3)
 
-	/* Clear the MSR RI since we are about to change R1.  EE is already off
-	 */
-	li	r4, 0
-	mtmsrd	r4, 1
-
 	REST_GPR(0, r7)				/* GPR0 */
 	REST_2GPRS(2, r7)			/* GPR2-3 */
 	REST_GPR(4, r7)				/* GPR4 */
@@ -439,10 +444,32 @@ restore_gprs:
 	ld	r6, _CCR(r7)
 	mtcr    r6
 
-	REST_GPR(1, r7)				/* GPR1 */
-	REST_GPR(5, r7)				/* GPR5-7 */
 	REST_GPR(6, r7)
-	ld	r7, GPR7(r7)
+
+	/*
+	 * Store r1 and r5 on the stack so that we can access them
+	 * after we clear MSR RI
+	*/
+
+	REST_GPR(5, r7)
+	std	r5, -8(r1)
+	ld	r5, GPR1(r7)
+	std	r5, -16(r1)
+
+	REST_GPR(7, r7)
+
+	/* Clear MSR RI since we are about to change R1.  EE is already off */
+	li	r5, 0
+	mtmsrd	r5, 1
+	/*
+	 * BE CAREFUL HERE:
+	* At this point we can't take an SLB miss we've cleared MSR
+	* RI. Load off the stack/paca which are in SLB bolted regions
+	* until we set RI again.
+	*/
+
+	ld	r5, -8(r1)
+	ld	r1, -16(r1)
 
 	/* Commit register state as checkpointed state: */
 	TRECHKPT
-- 
2.7.4
