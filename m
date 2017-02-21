Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSQrN4X0bzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:16 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LGO1BK049428
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:14 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rpx1y6b3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 11:27:14 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 02:27:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7224E2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:09 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LGR19M53018830
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:27:09 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LGQafA012281
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 03:26:37 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] powerpc: ftrace: restore LR from pt_regs
Date: Tue, 21 Feb 2017 21:56:03 +0530
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
References: <657c6623953f6cce52f929a93cc250b7ee76d7cc.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <dc6a909433e2fac491237bbd7525eb9bdd2ad1a6.1487692624.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pass the real LR to the ftrace handler. This is needed for
KPROBES_ON_FTRACE for the pre handlers.

Also, with KPROBES_ON_FTRACE, the link register may be updated by the
pre handlers or by a registed kretprobe. Honor updated LR by restoring
it from pt_regs, rather than from the stack save area.

Live patch and function graph continue to work fine with this change.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8fd8718722a1..744b2f91444a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1248,9 +1248,10 @@ _GLOBAL(ftrace_caller)
 
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
-	/* Save it as pt_regs->nip & pt_regs->link */
+	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
-	std     r7, _LINK(r1)
+	/* Save the read LR in pt_regs->link */
+	std     r0, _LINK(r1)
 
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
@@ -1297,16 +1298,16 @@ ftrace_call:
 	REST_8GPRS(16,r1)
 	REST_8GPRS(24,r1)
 
+	/* Restore possibly modified LR */
+	ld	r0, _LINK(r1)
+	mtlr	r0
+
 	/* Restore callee's TOC */
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
 	addi r1, r1, SWITCH_FRAME_SIZE
 
-	/* Restore original LR for return to B */
-	ld	r0, LRSAVE(r1)
-	mtlr	r0
-
 #ifdef CONFIG_LIVEPATCH
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
-- 
2.11.0
