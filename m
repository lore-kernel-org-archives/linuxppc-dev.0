Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8SZj0N0RzDr1r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:49:33 +1000 (AEST)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8SZh34MTz9sR9
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:49:32 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ez1so2666695pab.3
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 03:49:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pseries: PACA save area fix for MCE vs MCE
Date: Wed, 10 Aug 2016 20:48:43 +1000
Message-Id: <1470826123-14699-3-git-send-email-npiggin@gmail.com>
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

MCE must not enable MSR_RI until PACA_EXMC is no longer being used.
---
 arch/powerpc/kernel/exceptions-64s.S | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4174c4e..e20ad27 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -500,7 +500,23 @@ machine_check_fwnmi:
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST, 0x200)
-	EXCEPTION_PROLOG_PSERIES_1(machine_check_common, EXC_STD)
+	/*
+	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
+	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
+	 * used, so nested machine check corrupts it. machine_check_common
+	 * enables MSR_RI.
+	 */
+	ld	r12,PACAKBASE(r13)
+	ld	r10,PACAKMSR(r13)
+	xori	r10,r10,MSR_RI
+	mfspr	r11,SPRN_SRR0
+	LOAD_HANDLER(r12, machine_check_common)
+	mtspr	SPRN_SRR0,r12
+	mfspr	r12,SPRN_SRR1
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.	/* prevent speculative execution */
+
 	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
 	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
@@ -992,6 +1008,9 @@ machine_check_common:
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r3,PACA_EXMC+EX_DAR(r13)
 	lwz	r4,PACA_EXMC+EX_DSISR(r13)
+	/* Enable MSR_RI when finished with PACA_EXMC */
+	li	r10,MSR_RI
+	mtmsrd 	r10,1
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
-- 
2.8.1
