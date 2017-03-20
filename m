Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmlhm6zQgzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:02:16 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n11so4314380pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 23:02:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 3/7] powerpc/64s: use alternative feature patching
Date: Mon, 20 Mar 2017 16:01:48 +1000
Message-Id: <20170320060152.1016-4-npiggin@gmail.com>
In-Reply-To: <20170320060152.1016-1-npiggin@gmail.com>
References: <20170320060152.1016-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reduces the number of nops for POWER8

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 9f21f84ae49a..819e64104469 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -383,7 +383,11 @@ _GLOBAL(power9_idle_stop)
  */
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
-	bl	pnv_restore_hyp_resource
+BEGIN_FTR_SECTION
+	bl	pnv_restore_hyp_resource_arch300
+FTR_SECTION_ELSE
+	bl	pnv_restore_hyp_resource_arch207
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
@@ -411,14 +415,13 @@ pnv_powersave_wakeup:
  *
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-pnv_restore_hyp_resource:
-	ld	r2,PACATOC(r13);
-
-BEGIN_FTR_SECTION
+pnv_restore_hyp_resource_arch300:
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
 	 */
+	ld	r2,PACATOC(r13);
+
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 
@@ -433,12 +436,14 @@ BEGIN_FTR_SECTION
 
 	blr	/* Waking up without hypervisor state loss. */
 
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-
+/* Same calling convention as arch300 */
+pnv_restore_hyp_resource_arch207:
 	/*
 	 * POWER ISA 2.07 or less.
 	 * Check if we slept with winkle.
 	 */
+	ld	r2,PACATOC(r13);
+
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi   cr2,r0,PNV_THREAD_NAP
 	cmpwi   cr4,r0,PNV_THREAD_WINKLE
-- 
2.11.0
