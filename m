Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtD5B6M4wzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:10 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LIcX1I035232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:08 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7v51x3pc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:39:08 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 04:39:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5LId2Y541812066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:02 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LId2ir017852
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:39:02 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/6] powerpc/64s: Convert .L__replay_interrupt_return to a
 local label
Date: Thu, 22 Jun 2017 00:08:38 +0530
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e1a688655f74052b98ae9eed8cad864b4e8c8183.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b48bbb82e2b835 ("powerpc/64s: Don't unbalance the return branch
predictor in __replay_interrupt()") introduced __replay_interrupt_return
symbol with '.L' prefix in hopes of keeping it private. However, due to
the use of LOAD_REG_ADDR(), the assembler kept this symbol visible. Fix
the same by instead using the local label '1'.

Fixes: Commit b48bbb82e2b835 ("powerpc/64s: Don't unbalance the return branch
predictor in __replay_interrupt()")
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 07b79c2c70f8..2df6d7b3070f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1629,7 +1629,7 @@ _GLOBAL(__replay_interrupt)
 	 * we don't give a damn about, so we don't bother storing them.
 	 */
 	mfmsr	r12
-	LOAD_REG_ADDR(r11, .L__replay_interrupt_return)
+	LOAD_REG_ADDR(r11, 1f)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
@@ -1647,6 +1647,6 @@ FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common_msgclr
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-.L__replay_interrupt_return:
+1:
 	blr
 
-- 
2.13.1
