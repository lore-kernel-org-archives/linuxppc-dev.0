Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWdPY1X89zDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 08:33:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1QLXXtj139421
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 16:33:33 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28u862ryjq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 16:33:33 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 26 Feb 2017 14:33:31 -0700
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv:idle: Fix bug due to labeling ambiguity in
 power_enter_stop
Date: Mon, 27 Feb 2017 03:03:07 +0530
Message-Id: <1488144787-26010-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Commit 09206b600c76 ("powernv: Pass PSSCR value and mask to
power9_idle_stop") added additional code in power_enter_stop() to
distinguish between stop requests whose PSSCR had ESL=EC=1 from those
which did not. When ESL=EC=1, we do a forward-jump to a location
labelled by "1", which had the code to handle the ESL=EC=1 case.

Unforunately just a couple of instructions before this label, is the
macro IDLE_STATE_ENTER_SEQ() which also has a label "1" in its
expansion.

As a result, the current code can result in directly executing stop
instruction for deep stop requests with PSSCR ESL=EC=1, without saving
the hypervisor state.

Fix this BUG by labeling the location that handles ESL=EC=1 case with
a more descriptive label.

For a good measure, change the label in IDLE_STATE_ENTER_SEQ() macro
to an not-so commonly used value.

Fixes: 09206b600c76 ("powernv: Pass PSSCR value and mask to
power9_idle_stop")

Cc: Michael Neuling <mikey@neuling.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h | 4 ++--
 arch/powerpc/kernel/idle_book3s.S  | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 31192d8..3989d94 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -85,8 +85,8 @@ static inline void report_invalid_psscr_val(u64 psscr_val, int err)
 	std	r0,0(r1);					\
 	ptesync;						\
 	ld	r0,0(r1);					\
-1:	cmpd	cr0,r0,r0;					\
-	bne	1b;						\
+236:	cmpd	cr0,r0,r0;					\
+	bne	236b;						\
 	IDLE_INST;						\
 
 #define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 9f6bce5..95889af 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -276,14 +276,16 @@ power_enter_stop:
  */
 	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
 	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
-	bne	 1f
+	bne	 handle_esl_ec_set
 	IDLE_STATE_ENTER_SEQ(PPC_STOP)
 	li	r3,0  /* Since we didn't lose state, return 0 */
 	b 	pnv_wakeup_noloss
+
+handle_esl_ec_set:
 /*
  * Check if the requested state is a deep idle state.
  */
-1:	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	2f
-- 
1.8.3.1
