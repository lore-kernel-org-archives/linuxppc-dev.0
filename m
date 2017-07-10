Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ZnV0qwGzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 16:19:58 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id z6so13152963pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 23:19:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <masriniv@in.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH] POWER9 PMU interrupt after idle workaround
Date: Mon, 10 Jul 2017 16:19:38 +1000
Message-Id: <20170710061938.22513-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 DD2 can see spurious PMU interrupts after state-loss idle in
some conditions.

A solution is to save and reload MMCR0 over state-loss idle.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 5adb390e773b..516ebef905c0 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -30,6 +30,7 @@
  * Use unused space in the interrupt stack to save and restore
  * registers for winkle support.
  */
+#define _MMCR0	GPR0
 #define _SDR1	GPR3
 #define _PTCR	GPR3
 #define _RPR	GPR4
@@ -272,6 +273,14 @@ power_enter_stop:
 	b 	pnv_wakeup_noloss
 
 .Lhandle_esl_ec_set:
+	/*
+	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
+	 * state-loss idle. Saving and restoring MMCR0 over idle is a
+	 * workaround.
+	 */
+	mfspr	r4,SPRN_MMCR0
+	std	r4,_MMCR0(r1)
+
 /*
  * Check if the requested state is a deep idle state.
  */
@@ -450,10 +459,14 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 pnv_restore_hyp_resource_arch300:
 	/*
 	 * Workaround for POWER9, if we lost resources, the ERAT
-	 * might have been mixed up and needs flushing.
+	 * might have been mixed up and needs flushing. We also need
+	 * to reload MMCR0 (see comment above).
 	 */
 	blt	cr3,1f
 	PPC_INVALIDATE_ERAT
+	ld	r1,PACAR1(r13)
+	ld	r4,_MMCR0(r1)
+	mtspr	SPRN_MMCR0,r4
 1:
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
-- 
2.11.0
