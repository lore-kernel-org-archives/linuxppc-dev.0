Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vktly2Wx3zDqp4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:13:34 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r137so4184828pfr.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:13:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s: fix idle wakeup potential to clobber registers
Date: Fri, 17 Mar 2017 15:13:20 +1000
Message-Id: <20170317051320.7069-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We concluded there may be a window where the idle wakeup code could
get to pnv_wakeup_tb_loss (which clobbers non-volatile GPRs), but the
hardware may set SRR1[46:47] to 01b (no state loss) which would
result in the wakeup code failing to restore non-volatile GPRs.

I was not able to trigger this condition with trivial tests on
real hardware or simulator, but the ISA (at least 2.07) seems to
allow for it, and Gautham says that it can happen if there is an
exception pending when the sleep/winkle instruction is executed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 995728736677..6fd08219248d 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -449,9 +449,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 _GLOBAL(pnv_wakeup_tb_loss)
 	ld	r1,PACAR1(r13)
 	/*
-	 * Before entering any idle state, the NVGPRs are saved in the stack
-	 * and they are restored before switching to the process context. Hence
-	 * until they are restored, they are free to be used.
+	 * Before entering any idle state, the NVGPRs are saved in the stack.
+	 * If there was a state loss, or PACA_NAPSTATELOST was set, then the
+	 * NVGPRs are restored. If we are here, it is likely that state is lost,
+	 * but not guaranteed -- neither ISA207 nor ISA300 tests to reach
+	 * here are the same as the test to restore NVGPRS:
+	 * PACA_THREAD_IDLE_STATE test for ISA207, PSSCR test for ISA300,
+	 * and SRR1 test for restoring NVGPRs.
+	 *
+	 * We are about to clobber NVGPRs now, so set NAPSTATELOST to
+	 * guarantee they will always be restored. This might be tightened
+	 * with careful reading of specs (particularly for ISA300) but this
+	 * is already a slow wakeup path and it's simpler to be safe.
+	 */
+	li	r0,1
+	stb	r0,PACA_NAPSTATELOST(r13)
+
+	/*
 	 *
 	 * Save SRR1 and LR in NVGPRs as they might be clobbered in
 	 * opal_call() (called in CHECK_HMI_INTERRUPT). SRR1 is required
-- 
2.11.0
