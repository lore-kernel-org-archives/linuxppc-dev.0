Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKrr5SYvzDr77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:36 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:34 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 95975C40004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:16 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDoVsn33488966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:31 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDoUEc002780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:30 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 1/9] powerpc/powernv: Move CHECK_HMI_INTERRUPT to
 exception-64s header
Date: Thu, 21 Apr 2016 19:19:51 +0530
Message-Id: <1461246599-6098-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CHECK_HMI_INTERRUPT is used to check for HMI's in reset vector. Move
the macro to a common location (exception-64s.h)
This patch does not change any functionality.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 18 ++++++++++++++++++
 arch/powerpc/kernel/idle_power7.S        | 20 +-------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809..6a625af 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -545,4 +545,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define FINISH_NAP
 #endif
 
+#define CHECK_HMI_INTERRUPT						\
+	mfspr	r0,SPRN_SRR1;						\
+BEGIN_FTR_SECTION_NESTED(66);						\
+	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
+FTR_SECTION_ELSE_NESTED(66);						\
+	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
+	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
+	bne	20f;							\
+	/* Invoke opal call to handle hmi */				\
+	ld	r2,PACATOC(r13);					\
+	ld	r1,PACAR1(r13);						\
+	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
+	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
+	bl	opal_call_realmode;					\
+	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
+20:	nop;
+
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 470ceeb..6b3404b 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -19,6 +19,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/opal.h>
 #include <asm/cpuidle.h>
+#include <asm/exception-64s.h>
 #include <asm/book3s/64/mmu-hash.h>
 
 #undef DEBUG
@@ -257,25 +258,6 @@ _GLOBAL(power7_winkle)
 	b	power7_powersave_common
 	/* No return */
 
-#define CHECK_HMI_INTERRUPT						\
-	mfspr	r0,SPRN_SRR1;						\
-BEGIN_FTR_SECTION_NESTED(66);						\
-	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
-FTR_SECTION_ELSE_NESTED(66);						\
-	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
-ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
-	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
-	bne	20f;							\
-	/* Invoke opal call to handle hmi */				\
-	ld	r2,PACATOC(r13);					\
-	ld	r1,PACAR1(r13);						\
-	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
-	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
-	bl	opal_call_realmode;					\
-	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
-20:	nop;
-
-
 _GLOBAL(power7_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
-- 
2.1.4
