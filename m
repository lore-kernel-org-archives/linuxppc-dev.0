Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2Ny2fmDzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:18 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id s62so14736961pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/9] powerpc/64s: SLB miss handler avoid saving faulting
 address into EX_DAR
Date: Sun, 21 May 2017 23:15:43 +1000
Message-Id: <20170521131550.25813-3-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EX_DAR save area is only used in exceptional cases. With r3 no
longer clobbered by slb_allocate_realmode, saving faulting address to
EX_DAR can be deferred to those cases.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae418b85c17c..a4a71bce35d6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -628,7 +628,6 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
 
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
-	std	r3,PACA_EXSLB+EX_DAR(r13)
 
 	crset	4*cr0+eq
 #ifdef CONFIG_PPC_STD_MMU_64
@@ -638,11 +637,10 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 #endif
 
 	ld	r10,PACA_EXSLB+EX_LR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 	mtlr	r10
 
-	beq	8f		/* if bad address, make full stack frame */
+	beq-	8f		/* if bad address, make full stack frame */
 
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
@@ -657,6 +655,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 .machine	pop
 
 	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -665,7 +664,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	rfid
 	b	.	/* prevent speculative execution */
 
-2:	mfspr	r11,SPRN_SRR0
+2:	std     r3,PACA_EXSLB+EX_DAR(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r11,SPRN_SRR0
 	LOAD_HANDLER(r10,unrecov_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
@@ -673,7 +674,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	rfid
 	b	.
 
-8:	mfspr	r11,SPRN_SRR0
+8:	std     r3,PACA_EXSLB+EX_DAR(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r11,SPRN_SRR0
 	LOAD_HANDLER(r10,bad_addr_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
-- 
2.11.0
