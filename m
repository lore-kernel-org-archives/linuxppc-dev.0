Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1n24GBzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:41 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y129so3500031pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 05/14] powerpc/64s: irq replay merge HV and non-HV paths
 for doorbell replay
Date: Sat, 12 Aug 2017 02:39:03 +1000
Message-Id: <20170811163912.28783-6-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This results in smaller code, and fewer branches.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S       | 6 +-----
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 arch/powerpc/kernel/irq.c            | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 49d8422767b4..ec67f67dafab 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -990,11 +990,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 #ifdef CONFIG_PPC_BOOK3E
 	cmpwi	cr0,r3,0x280
 #else
-	BEGIN_FTR_SECTION
-		cmpwi	cr0,r3,0xe80
-	FTR_SECTION_ELSE
-		cmpwi	cr0,r3,0xa00
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	cmpwi	cr0,r3,0xa00
 #endif /* CONFIG_PPC_BOOK3E */
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 67321be3122c..f9d0796fb2c9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1674,7 +1674,7 @@ _GLOBAL(__replay_interrupt)
 	cmpwi	r3,0x500
 	beq	hardware_interrupt_common
 BEGIN_FTR_SECTION
-	cmpwi	r3,0xe80
+	cmpwi	r3,0xa00
 	beq	h_doorbell_common_msgclr
 	cmpwi	r3,0xea0
 	beq	h_virt_irq_common
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 7c46e0cce054..60ee6d7251b8 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -207,8 +207,6 @@ notrace unsigned int __check_irq_replay(void)
 #else
 	if (happened & PACA_IRQ_DBELL) {
 		local_paca->irq_happened &= ~PACA_IRQ_DBELL;
-		if (cpu_has_feature(CPU_FTR_HVMODE))
-			return 0xe80;
 		return 0xa00;
 	}
 #endif /* CONFIG_PPC_BOOK3E */
-- 
2.13.3
