Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkpRc3k38zDqwY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:58:20 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: paulus@samba.org, cyrilbur@gmail.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Fix stack pointer corruption in __tm_recheckpoint
Date: Wed,  6 Jul 2016 14:58:06 +1000
Message-Id: <1467781086-21125-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the start of __tm_recheckpoint we save the kernel stack pointer
(r1) in SPRG SCRATCH0 (SPRG2) so that we can restore it after the
trecheckpoint.

Unfortunately, the same SPRG is used in the SLB miss handler.  If an
SLB miss is taken between the save and restore of r1 to the SPRG, the
SPRG is changed and hence r1 is also corrupted.  We can end up with
the following crash when we start using r1 again after the restore
from the SPRG:

  Oops: Bad kernel stack pointer, sig: 6 [#1]
  SMP NR_CPUS=2048 NUMA pSeries
   kernel:NMI watcModules linked in:h af_packet(E) dm_mod(E) <snipped>
  Supported: Yes, External
  CPU: 658 PID: 143777 Comm: htm_demo Tainted: G            EL   X 4.4.13-0-default #1
  task: c0000b56993a7810 ti: c00000000cfec000 task.ti: c0000b56993bc000
  NIP: c00000000004f188 LR: 00000000100040b8 CTR: 0000000010002570
  REGS: c00000000cfefd40 TRAP: 0300   Tainted: G            EL   X  (4.4.13-0-default)
  MSR: 8000000300001033 <SF,ME,IR,DR,RI,LE>  CR: 02000424  XER: 20000000
  CFAR: c000000000008468 DAR: 00003ffd84e66880 DSISR: 40000000 SOFTE: 0
  PACATMSCRATCH: 00003ffbc865e680
  GPR00: fffffffcfabc4268 00003ffd84e667a0 00000000100d8c38 000000030544bb80
  GPR04: 0000000000000002 00000000100cf200 0000000000000449 00000000100cf100
  GPR08: 000000000000c350 0000000000002569 0000000000002569 00000000100d6c30
  GPR12: 00000000100d6c28 c00000000e6a6b00 00003ffd84660000 0000000000000000
  GPR16: 0000000000000003 0000000000000449 0000000010002570 0000010009684f20
  GPR20: 0000000000800000 00003ffd84e5f110 00003ffd84e5f7a0 00000000100d0f40
  GPR24: 0000000000000000 0000000000000000 0000000000000000 00003ffff0673f50
  GPR28: 00003ffd84e5e960 00000000003d0f00 00003ffd84e667a0 00003ffd84e5e680
  NIP [c00000000004f188] restore_gprs+0x110/0x17c
  LR [00000000100040b8] 0x100040b8
  Call Trace:
  Instruction dump:
  f8a1fff0 e8e700a8 38a00000 7ca10164 e8a1fff8 e821fff0 7c0007dd 7c421378
  7db142a6 7c3242a6 38800002 7c810164 <e9c100e0> e9e100e8 ea0100f0 ea2100f8
  ---[ end trace 36596a45d92144a4 ]---

We hit this on large memory machines (> 2TB) but it can also be hit on
smaller machines when 1TB segments are disabled.

To hit this, you also need to be virtualised to ensure SLBs are
periodically removed by the hypervisor.

This patches moves the saving of r1 to the SPRG to the region where we
are guaranteed not to take any further SLB misses.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Cyril Bur <cyrilbur@gmail.com>
CC: stable@vger.kernel.org	# v3.9+
---
 arch/powerpc/kernel/tm.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b7019b5..298afcf 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -338,8 +338,6 @@ _GLOBAL(__tm_recheckpoint)
 	 */
 	subi	r7, r7, STACK_FRAME_OVERHEAD
 
-	SET_SCRATCH0(r1)
-
 	mfmsr	r6
 	/* R4 = original MSR to indicate whether thread used FP/Vector etc. */
 
@@ -468,6 +466,7 @@ restore_gprs:
 	 * until we turn MSR RI back on.
 	 */
 
+	SET_SCRATCH0(r1)
 	ld	r5, -8(r1)
 	ld	r1, -16(r1)
 
-- 
2.7.4
