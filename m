Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2P15PdNzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:21 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so14494197pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/9] powerpc/64s: SLB miss already has CTR saved for
 relocatable kernel
Date: Sun, 21 May 2017 23:15:44 +1000
Message-Id: <20170521131550.25813-4-npiggin@gmail.com>
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

The EXCEPTION_PROLOG_1 used by SLB miss already saves CTR when the
kernel is built with CONFIG_RELOCATABLE. So it does not have to be
saved and reloaded when branching to slb_miss_realmode. It can be
restored from the PACA as usual.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a4a71bce35d6..486e205cc762 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -519,7 +519,7 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	 * because the distance from here to there depends on where
 	 * the kernel ends up being put.
 	 */
-	mfctr	r11
+	/* CTR is saved if RELOCATABLE */
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -542,7 +542,7 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	 * because the distance from here to there depends on where
 	 * the kernel ends up being put.
 	 */
-	mfctr	r11
+	/* CTR is saved if RELOCATABLE */
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -582,7 +582,7 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
-	mfctr	r11
+	/* CTR is saved if RELOCATABLE */
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -600,7 +600,7 @@ EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
-	mfctr	r11
+	/* CTR is saved if RELOCATABLE */
 	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
@@ -622,10 +622,6 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
 	 * procedure.
 	 */
 	mflr	r10
-#ifdef CONFIG_RELOCATABLE
-	mtctr	r11
-#endif
-
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
@@ -654,6 +650,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
+	RESTORE_CTR(r9, PACA_EXSLB)
 	RESTORE_PPR_PACA(PACA_EXSLB, r9)
 	ld	r3,PACA_EXSLB+EX_R3(r13)
 	ld	r9,PACA_EXSLB+EX_R9(r13)
-- 
2.11.0
