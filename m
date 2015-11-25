Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DA21A0336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 14:25:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc/kernel: Open code SET_DEFAULT_THREAD_PPR
Date: Wed, 25 Nov 2015 14:25:18 +1100
Message-Id: <1448421919-30426-3-git-send-email-mpe@ellerman.id.au>
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

This is only used in one location, open code it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h | 13 -------------
 arch/powerpc/kernel/entry_64.S     |  8 +++++++-
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 67f05d4935a0..499d9f89435a 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -413,19 +413,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	FTR_SECTION_ELSE_NESTED(848);	\
 	mtocrf (FXM), RS;		\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
-
-/*
- * PPR restore macros used in entry_64.S
- * Used for P7 or later processors
- */
-#define SET_DEFAULT_THREAD_PPR(ra, rb)					\
-BEGIN_FTR_SECTION_NESTED(945)						\
-	lis	ra,INIT_PPR@highest;	/* default ppr=3 */		\
-	ld	rb,PACACURRENT(r13);					\
-	sldi	ra,ra,32;	/* 11- 13 bits are used for ppr */	\
-	std	ra,TASKTHREADPPR(rb);					\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
-
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c8a60aa07aa5..a4b0f03cf124 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -316,7 +316,13 @@ syscall_exit_work:
 	subi	r12,r12,TI_FLAGS
 
 4:	/* Anything else left to do? */
-	SET_DEFAULT_THREAD_PPR(r3, r10)		/* Set thread.ppr = 3 */
+BEGIN_FTR_SECTION
+	lis	r3,INIT_PPR@highest	/* Set thread.ppr = 3 */
+	ld	r10,PACACURRENT(r13)
+	sldi	r3,r3,32	/* bits 11-13 are used for ppr */
+	std	r3,TASKTHREADPPR(r10)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
 	beq	ret_from_except_lite
 
-- 
2.5.0
