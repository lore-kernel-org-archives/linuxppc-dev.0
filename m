Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwjtq4KQKzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 06:08:51 +1000 (AEST)
Message-ID: <1498421326.31581.113.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Only do ERAT invalidate on radix context switch on
 P9 DD1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Sun, 25 Jun 2017 15:08:46 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

On P9 (Nimbus) DD2 and later, in radix mode, the move to the PID
register will implicitly invalidate the user space ERAT entries
and leave the kernel ones alone. Thus the only thing needed is
an isync() to synchronize this with subsequent uaccess's 

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index a3edf813d4..71de2c6d88 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -235,10 +235,15 @@ void destroy_context(struct mm_struct *mm)
 #ifdef CONFIG_PPC_RADIX_MMU
 void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-	asm volatile("isync": : :"memory");
-	mtspr(SPRN_PID, next->context.id);
-	asm volatile("isync \n"
-		     PPC_SLBIA(0x7)
-		     : : :"memory");
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		isync();
+		mtspr(SPRN_PID, next->context.id);
+		isync();
+		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
+	} else {
+		mtspr(SPRN_PID, next->context.id);
+		isync();
+	}
 }
 #endif
