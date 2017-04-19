Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MNv5d7YzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:53:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCniYS068619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:52 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x752upab-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:50 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:46 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpJpJ14876698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:19 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqgNZ020239
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:43 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] powerpc: ftrace: restore LR from pt_regs
Date: Wed, 19 Apr 2017 18:22:24 +0530
In-Reply-To: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5aa5ca47d531a530285fe5b453f6921d0960bde3.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
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
