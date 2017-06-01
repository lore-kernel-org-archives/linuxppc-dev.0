Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdkck3xYHzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 20:49:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51AmlA3140456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 06:49:32 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ateqd1aun-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 06:49:32 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 20:49:29 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51AnJwT1311072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:49:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51Amscg026999
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:48:54 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] powerpc/ftrace: Pass the correct stack pointer for
 DYNAMIC_FTRACE_WITH_REGS
Date: Thu,  1 Jun 2017 16:18:16 +0530
In-Reply-To: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7a91bf93179afb3ada72948e8feb5e5f09fb64c4.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For DYNAMIC_FTRACE_WITH_REGS, we should be passing-in the original set
of registers in pt_regs, to capture the state _before_ ftrace_caller.
However, we are instead passing the stack pointer *after* allocating a
stack frame in ftrace_caller. Fix this by saving the proper value of r1
in pt_regs. Also, use SAVE_10GPRS() to simplify the code.

Fixes: 153086644fd1f ("powerpc/ftrace: Add support for -mprofile-kernel
ftrace ABI")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: No changes since v1.

 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 7c933a99f5d5..fa0921410fa4 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -45,10 +45,14 @@ _GLOBAL(ftrace_caller)
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
 	/* Save all gprs to pt_regs */
-	SAVE_8GPRS(0,r1)
-	SAVE_8GPRS(8,r1)
-	SAVE_8GPRS(16,r1)
-	SAVE_8GPRS(24,r1)
+	SAVE_GPR(0, r1)
+	SAVE_10GPRS(2, r1)
+	SAVE_10GPRS(12, r1)
+	SAVE_10GPRS(22, r1)
+
+	/* Save previous stack pointer (r1) */
+	addi	r8, r1, SWITCH_FRAME_SIZE
+	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
 	mfmsr   r8
@@ -103,10 +107,10 @@ ftrace_call:
 #endif
 
 	/* Restore gprs */
-	REST_8GPRS(0,r1)
-	REST_8GPRS(8,r1)
-	REST_8GPRS(16,r1)
-	REST_8GPRS(24,r1)
+	REST_GPR(0,r1)
+	REST_10GPRS(2,r1)
+	REST_10GPRS(12,r1)
+	REST_10GPRS(22,r1)
 
 	/* Restore possibly modified LR */
 	ld	r0, _LINK(r1)
-- 
2.12.2
