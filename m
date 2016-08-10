Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8SZC6g1YzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:49:07 +1000 (AEST)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8SZC2lpkz9t0m
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:49:07 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id vy10so2659804pac.0
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 03:49:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/pseries: PACA save area fix for general exception
 vs MCE
Date: Wed, 10 Aug 2016 20:48:42 +1000
Message-Id: <1470826123-14699-2-git-send-email-npiggin@gmail.com>
In-Reply-To: <1470826005-14520-1-git-send-email-npiggin@gmail.com>
References: <1470826005-14520-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MCE must not use PACA_EXGEN. When a general exception enables MSR_RI,
that means SPRN_SRR[01] and SPRN_SPRG are no longer used. However the
PACA save area is still in use.
---
 arch/powerpc/kernel/exceptions-64s.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 694def6..4174c4e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -984,14 +984,14 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 machine_check_common:
 
 	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
+	std	r10,PACA_EXMC+EX_DAR(r13)
 	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	stw	r10,PACA_EXMC+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
 	FINISH_NAP
 	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	ld	r3,PACA_EXMC+EX_DAR(r13)
+	lwz	r4,PACA_EXMC+EX_DSISR(r13)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
-- 
2.8.1
