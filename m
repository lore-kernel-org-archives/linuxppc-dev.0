Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 347761A0331
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 14:25:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/kernel: Open code HMT_MEDIUM_LOW_HAS_PPR
Date: Wed, 25 Nov 2015 14:25:17 +1100
Message-Id: <1448421919-30426-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
References: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HMT_MEDIUM_LOW_HAS_PPR is only used in once place, open code it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h | 5 -----
 arch/powerpc/kernel/entry_64.S     | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index dd0fc18d8103..67f05d4935a0 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -418,11 +418,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
  * PPR restore macros used in entry_64.S
  * Used for P7 or later processors
  */
-#define HMT_MEDIUM_LOW_HAS_PPR						\
-BEGIN_FTR_SECTION_NESTED(944)						\
-	HMT_MEDIUM_LOW;							\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,944)
-
 #define SET_DEFAULT_THREAD_PPR(ra, rb)					\
 BEGIN_FTR_SECTION_NESTED(945)						\
 	lis	ra,INIT_PPR@highest;	/* default ppr=3 */		\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a94f155db78e..c8a60aa07aa5 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -223,7 +223,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
-	HMT_MEDIUM_LOW_HAS_PPR
+
+BEGIN_FTR_SECTION
+	HMT_MEDIUM_LOW
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
-- 
2.5.0
