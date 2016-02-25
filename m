Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 798441A040D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:54:51 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D097F140322
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:54:50 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 10:24:47 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1P4saxQ12714350
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 10:24:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1P4sgXT029063
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 10:24:43 +0530
Subject: [PATCH 1/3] powernv: Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 10:24:41 +0530
Message-ID: <20160225045420.6543.55495.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h so that MCE handler changes
in subsequent patch can use it.

No functionality change.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h |   14 ++++++++++++++
 arch/powerpc/kernel/idle_power7.S  |   12 ------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index d2f99ca..5894ad6 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -17,4 +17,18 @@ extern u32 pnv_fastsleep_workaround_at_exit[];
 
 #endif
 
+/* Idle state entry routines */
+#ifdef	CONFIG_PPC_P7_NAP
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
+
 #endif
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index cedc4ef..cd43c90 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -37,18 +37,6 @@
 #define _WORT	GPR10
 #define _WORC	GPR11
 
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
