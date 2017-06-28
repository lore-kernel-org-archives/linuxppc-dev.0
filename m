Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy4dj2rc8zDr3d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:17:13 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S1DrwU047621
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:17:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bby4pen4x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:17:10 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 11:17:08 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5S1H6ro63569966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:17:06 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5S1H5fg017150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:17:06 +1000
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] powernv:idle: Clear r12 on wakeup from stop lite
Date: Wed, 28 Jun 2017 06:46:49 +0530
Message-Id: <1498612609-13677-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_wakeup_noloss expects R12 to contain SRR1 value to determine if
the wakeup reason is an HMI in CHECK_HMI_INTERRUPT.

When we wakeup with ESL=0, SRR1 will not contain the wakeup reason, so
there is no point setting R12 to SRR1.

However, we don't set R12 at all and R12 contains garbage, and still
being used to check HMI assuming that it had SRR1. causing the
OPAL msglog to be filled with the following print:
	HMI: Received HMI interrupt: HMER = 0x0040000000000000

This patch clears R12 after waking up from stop with ESL=EC=0, so that
we don't accidentally enter the HMI handler in pnv_wakeup_noloss if
the R12[42:45] corresponds to HMI as wakeup reason.

Bug existed prior to "commit 9d29250136f6 ("powerpc/64s/idle: Avoid SRR
usage in idle sleep/wake paths")  but was never hit in practice

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Fixes: 9d29250136f6 ("powerpc/64s/idle: Avoid SRR usage in idle
sleep/wake paths")
---
 arch/powerpc/kernel/idle_book3s.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 1ea14b9..34794fd 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -256,6 +256,21 @@ power_enter_stop:
 	bne	 .Lhandle_esl_ec_set
 	IDLE_STATE_ENTER_SEQ(PPC_STOP)
 	li	r3,0  /* Since we didn't lose state, return 0 */
+	/*
+	 * pnv_wakeup_noloss expects R12 to contain SRR1 value
+	 * to determine if the wakeup reason is an HMI in
+	 * CHECK_HMI_INTERRUPT.
+	 *
+	 * However, when we wakeup with ESL=0,
+	 * SRR1 will not contain the wakeup reason,
+	 * so there is no point setting R12 to SRR1.
+	 *
+	 * Further, we clear R12 here, so that we
+	 * don't accidentally enter the HMI
+	 * in pnv_wakeup_noloss if the
+	 * R12[42:45] == WAKE_HMI.
+	 */
+	li	r12, 0
 	b 	pnv_wakeup_noloss
 
 .Lhandle_esl_ec_set:
-- 
2.5.5
