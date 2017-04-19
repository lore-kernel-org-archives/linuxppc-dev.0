Return-Path: <npiggin@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Mh70gjTzDqwK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:15 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id x86so3491822ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/9] powerpc/64s: use alternative feature patching
Date: Wed, 19 Apr 2017 23:05:46 +1000
Message-Id: <20170419130551.32378-5-npiggin@gmail.com>
In-Reply-To: <20170419130551.32378-1-npiggin@gmail.com>
References: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reduces the number of nops for POWER8.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index effc02d8cd8a..695cff40b0fe 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -421,7 +421,11 @@ power9_dd1_recover_paca:
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
@@ -449,7 +453,11 @@ pnv_powersave_wakeup:
  *
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-pnv_restore_hyp_resource:
+pnv_restore_hyp_resource_arch300:
+	/*
+	 * POWER ISA 3. Use PSSCR to determine if we
+	 * are waking up from deep idle state
+	 */
 BEGIN_FTR_SECTION
 	mflr 	r6
 	bl	power9_dd1_recover_paca
@@ -458,11 +466,6 @@ FTR_SECTION_ELSE
 	ld	r2, PACATOC(r13)
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_POWER9_DD1)
 
-BEGIN_FTR_SECTION
-	/*
-	 * POWER ISA 3. Use PSSCR to determine if we
-	 * are waking up from deep idle state
-	 */
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 
@@ -477,12 +480,14 @@ BEGIN_FTR_SECTION
 
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
