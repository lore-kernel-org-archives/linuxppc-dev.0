Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkFYC3J62zDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 05:17:19 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58JE4pu094267
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:17:16 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ay49hfx65-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 15:17:16 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 05:17:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58JHB3858130464
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 05:17:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58JH3A6020922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 05:17:03 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kprobes: Don't save/restore DAR/DSISR to/from pt_regs
 for optprobes
Date: Fri,  9 Jun 2017 00:46:55 +0530
Message-Id: <20170608191655.19469-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't save/restore these across a trap, or with KPROBES_ON_FTRACE.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/optprobes_head.S | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 4937bef7652f..52fc864cdec4 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -60,10 +60,6 @@ optprobe_template_entry:
 	std	r5,_CCR(r1)
 	lbz     r5,PACASOFTIRQEN(r13)
 	std     r5,SOFTE(r1)
-	mfdar	r5
-	std	r5,_DAR(r1)
-	mfdsisr	r5
-	std	r5,_DSISR(r1)
 
 	/*
 	 * We may get here from a module, so load the kernel TOC in r2.
@@ -122,10 +118,6 @@ optprobe_template_call_emulate:
 	mtxer	r5
 	ld	r5,_CCR(r1)
 	mtcr	r5
-	ld	r5,_DAR(r1)
-	mtdar	r5
-	ld	r5,_DSISR(r1)
-	mtdsisr	r5
 	REST_GPR(0,r1)
 	REST_10GPRS(2,r1)
 	REST_10GPRS(12,r1)
-- 
2.12.2
