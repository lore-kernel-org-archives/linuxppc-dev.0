Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31SF6Qs7zDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:53 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CB4O4f016783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:42 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sesmug8b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:41 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:10:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBAQ0V32440434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBA1Q5001373
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:01 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] powerpc: ftrace: restore LR from pt_regs
Date: Wed, 12 Apr 2017 16:39:23 +0530
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <8a519a574def9af2bd861f56a7a9fcc94d22adc1.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.12.1
