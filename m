Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKsG1YJ1zDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:58 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:56 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2CECC19D804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:38:38 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDol4Y44564714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDokN6003933
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:47 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 5/9] powerpc/powernv: Move idle related macros to cpuidle.h
Date: Thu, 21 Apr 2016 19:19:55 +0530
Message-Id: <1461246599-6098-6-git-send-email-shreyas@linux.vnet.ibm.com>
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

Move idle related macros to a common location asm/cpuidle.h so that
they can be used for stop instruction support.

Signed-off-by: Shreyas B. Prabhy <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h | 27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/idle_power7.S  | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index d2f99ca..faa97b7 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -17,4 +17,31 @@ extern u32 pnv_fastsleep_workaround_at_exit[];
 
 #endif
 
+/* Idle state entry routines */
+#ifdef CONFIG_PPC_P7_NAP
+#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
+	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
+	std	r0,0(r1);					\
+	ptesync;						\
+	ld	r0,0(r1);					\
+1:	cmp	cr0,r0,r0;					\
+	bne	1b;						\
+	IDLE_INST;						\
+	b	.
+#endif /* CONFIG_PPC_P7_NAP */
+
+/*
+ * Use unused space in the interrupt stack to save and restore
+ * registers for deep-idle support.
+ */
+#define _SDR1	GPR3
+#define _RPR	GPR4
+#define _SPURR	GPR5
+#define _PURR	GPR6
+#define _TSCR	GPR7
+#define _DSCR	GPR8
+#define _AMOR	GPR9
+#define _WORT	GPR10
+#define _WORC	GPR11
+
 #endif
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 1ea71d4..6a24769 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -24,32 +24,6 @@
 
 #undef DEBUG
 
-/*
- * Use unused space in the interrupt stack to save and restore
- * registers for winkle support.
- */
-#define _SDR1	GPR3
-#define _RPR	GPR4
-#define _SPURR	GPR5
-#define _PURR	GPR6
-#define _TSCR	GPR7
-#define _DSCR	GPR8
-#define _AMOR	GPR9
-#define _WORT	GPR10
-#define _WORC	GPR11
-
-/* Idle state entry routines */
-
-#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
-	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
-	std	r0,0(r1);					\
-	ptesync;						\
-	ld	r0,0(r1);					\
-1:	cmp	cr0,r0,r0;					\
-	bne	1b;						\
-	IDLE_INST;						\
-	b	.
-
 	.text
 
 /*
-- 
2.1.4
