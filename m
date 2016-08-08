Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s79rL0K2LzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 18:41:54 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s79rK2smJz9sR9
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 18:41:53 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u788dgal051380
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 04:41:51 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbvvtch2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 04:41:51 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 14:11:47 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AE132E005F
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 14:16:08 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u788fhIO27066552
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 14:11:43 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u788ffwa006127
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 14:11:43 +0530
Subject: [RESEND PATCH v3 1/2] powernv: Move IDLE_STATE_ENTER_SEQ macro to
 cpuidle.h
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Date: Mon, 08 Aug 2016 14:11:39 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147064569946.6908.3260124681746222838.stgit@jupiter.in.ibm.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
Change in v3:
- Rebase to Linus' master.
---
 arch/powerpc/include/asm/cpuidle.h |   13 +++++++++++++
 arch/powerpc/kernel/idle_book3s.S  |   12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 3d7fc06..01b8a13 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -19,4 +19,17 @@ extern u64 pnv_first_deep_stop_state;
 
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
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 45784ec..748b912 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -44,18 +44,6 @@
 				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
 				PSSCR_MTL_MASK
 
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
