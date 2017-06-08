Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk90511rdzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:49 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y7so5581474pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 06/14] powerpc/64s: interrupt replay balance the return branch
 predictor
Date: Fri,  9 Jun 2017 01:51:05 +1000
Message-Id: <20170608155113.21300-7-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The __replay_interrupt code is branched to with bl, but the caller is
returned to directly with rfid from the interrupt.

Instead return to a return stub that returns to the caller with blr,
which should do better with the return predictor.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9cc34547c3b6..52ad0789fa89 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1646,7 +1646,7 @@ _GLOBAL(__replay_interrupt)
 	 * we don't give a damn about, so we don't bother storing them.
 	 */
 	mfmsr	r12
-	mflr	r11
+	LOAD_REG_ADDR(r11, __replay_interrupt_return)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
@@ -1664,6 +1664,7 @@ FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common_msgclr
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+__replay_interrupt_return:
 	blr
 
 /*
@@ -1673,7 +1674,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 _GLOBAL(__replay_wakeup_interrupt)
 	extrdi	r3,r3,42,4	/* Get SRR1 wake reason in low bits */
 	mfmsr	r12
-	mflr	r11
+	LOAD_REG_ADDR(r11, __replay_wakeup_interrupt_return)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x6
@@ -1692,4 +1693,5 @@ FTR_SECTION_ELSE
 	beq	doorbell_super_common_msgclr
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	mtmsrd	r12,1
+__replay_wakeup_interrupt_return:
 	blr
-- 
2.11.0
