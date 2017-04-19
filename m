Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MhQ665kzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:30 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id e132so2677488ite.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 9/9] powerpc/64s: Simplify POWER9 DD1 idle workaround code
Date: Wed, 19 Apr 2017 23:05:51 +1000
Message-Id: <20170419130551.32378-10-npiggin@gmail.com>
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

The idle workaround does not need to load PACATOC, and it does not
need to be called within a nested function that requires LR to be
saved.

Load the PACATOC at entry to the idle wakeup. It does not matter which
PACA this comes from, so it's okay to call before the workaround. Then
apply the workaround to get the right PACA.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/feature-fixups.h |  3 +++
 arch/powerpc/kernel/idle_book3s.S         | 16 +++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index ddf54f5bbdd1..2de2319b99e2 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -66,6 +66,9 @@ label##5:							\
 #define END_FTR_SECTION(msk, val)		\
 	END_FTR_SECTION_NESTED(msk, val, 97)
 
+#define END_FTR_SECTION_NESTED_IFSET(msk, label)	\
+	END_FTR_SECTION_NESTED((msk), (msk), label)
+
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 97c014de0ca3..a4c058f99164 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -411,7 +411,6 @@ power9_dd1_recover_paca:
 	/* Load paca->thread_sibling_pacas[i] into r13 */
 	ldx	r13, r4, r5
 	SET_PACA(r13)
-	ld	r2, PACATOC(r13)
 	/*
 	 * Indicate that we have lost NVGPR state
 	 * which needs to be restored from the stack.
@@ -451,7 +450,12 @@ pnv_powersave_wakeup_mce:
  */
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
+	ld	r2, PACATOC(r13)
+
 BEGIN_FTR_SECTION
+BEGIN_FTR_SECTION_NESTED(70)
+	bl	power9_dd1_recover_paca
+END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
 	bl	pnv_restore_hyp_resource_arch207
@@ -488,14 +492,6 @@ pnv_restore_hyp_resource_arch300:
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
 	 */
-BEGIN_FTR_SECTION
-	mflr 	r6
-	bl	power9_dd1_recover_paca
-	mtlr	r6
-FTR_SECTION_ELSE
-	ld	r2, PACATOC(r13)
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_POWER9_DD1)
-
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 
@@ -516,8 +512,6 @@ pnv_restore_hyp_resource_arch207:
 	 * POWER ISA 2.07 or less.
 	 * Check if we slept with sleep or winkle.
 	 */
-	ld	r2,PACATOC(r13);
-
 	lbz	r4,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr2,r4,PNV_THREAD_NAP
 	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
-- 
2.11.0
