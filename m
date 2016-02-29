Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078701A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 23:25:00 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 05:24:58 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 10CE61FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:13:05 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1TCOtdn38010912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:55 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1TCOsl0023712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:55 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/powernv: Move CHECK_HMI_INTERRUPT to
 exception-64s header
Date: Mon, 29 Feb 2016 17:52:58 +0530
Message-Id: <1456748580-10519-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/exception-64s.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/idle_power7.S        | 20 +-------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809fe5ea..0082290314eb 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -254,6 +254,25 @@ do_kvm_##n:								\
 #define KVM_HANDLER_SKIP(area, h, n)
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
+
 #define NOTEST(n)
 
 /*
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index cf4fb5429cf1..abc53e88a5b4 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -20,6 +20,7 @@
 #include <asm/opal.h>
 #include <asm/cpuidle.h>
 #include <asm/mmu-hash64.h>
+#include <asm/exception-64s.h>
 
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
1.9.3
