Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNXhl4XNtzDvr1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 04:36:55 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMHXv0T015631
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:36:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26vn5m384s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:36:52 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 12:36:52 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2] powernv: Handle wakeup from idle due to SRESET
Date: Tue, 22 Nov 2016 23:06:32 +0530
In-Reply-To: <1479753469-10625-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1479753469-10625-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1479836192-21233-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The existing code doesn't handle the case when CPU which was in a
hardware-idle state (nap,sleep,winkle on POWER8 and various stop
states on POWER9) gets woken up due to a System Reset interrupt.

This patch checks if the CPU was woken up due to System Reset, in
which case, after restoring the required hardware state, it jumps to
the system reset handler.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v1 -> v2: Set r9,r11,r12 to CR,SRR0,SRR1 values
before jumping to system_reset_common as expected by
EXCEPTION_PROLOG_COMMON

 arch/powerpc/kernel/idle_book3s.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72dac0b..06afe0e 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -353,6 +353,22 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
+#define CHECK_SRESET_INTERRUPT                                          \
+BEGIN_FTR_SECTION_NESTED(67);						\
+	mfspr	r0,SPRN_SRR1;						\
+	rlwinm	r0,r0,45-31,0xf; /* Extract wake reason field (P8,9) */ \
+	cmpwi	r0,0x4;		  /* System Reset ? 	*/		\
+	bne	21f;							\
+	ld	r1,PACAR1(r13);						\
+	ld	r9,_CCR(r1);						\
+	ld	r11,_NIP(r1);						\
+	mfspr	r12, SPRN_SRR1;						\
+	b	system_reset_common ;					\
+	b	.; 		/* We shouldn't return here */		\
+FTR_SECTION_ELSE_NESTED(67);						\
+	nop		   ;						\
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 67); \
+21:	nop;
 
 /*
  * r3 - requested stop state
@@ -644,6 +660,7 @@ _GLOBAL(pnv_wakeup_loss)
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
+	CHECK_SRESET_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
@@ -666,6 +683,7 @@ _GLOBAL(pnv_wakeup_noloss)
 	bne	pnv_wakeup_loss
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
+	CHECK_SRESET_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	ld	r1,PACAR1(r13)
 	ld	r6,_CCR(r1)
-- 
1.8.3.1
