Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzZ3y2q1kzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:25:18 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 3 May 2016 02:25:16 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v2 5/9] powerpc/powernv: Move idle related macros to cpuidle.h
Date: Tue,  3 May 2016 13:54:34 +0530
Message-Id: <1462263878-25237-6-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
2.4.11
