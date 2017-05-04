Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhY1WdvzDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:48 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444Xx6D040502
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:39 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7m0qv9dv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:39 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:37 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bP2520512994
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:33 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444b1SV009276
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:01 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc/ftrace: Remove redundant saving of LR in
 ftrace[_graph]_caller
Date: Thu,  4 May 2017 10:06:16 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <96ba8e287a76fe6051215474d5a1ebecf2fd92c7.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For -mprofile-kernel, there is no need to save LR into the ABI save
location on entry into ftrace_caller(). It is sufficient to have the
(possibly updated) return address in LR (and r0?). On return from
ftrace, this value is stored in the ABI save location if necessary.

Furthermore, we can also remove the redundant saving of LR in
ftrace_graph_caller() for similar reasons. It is sufficient to ensure
LR and r0 point to the new return address.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index fa0921410fa4..d8d75f4eb853 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -38,9 +38,6 @@
  * and then arrange for the ftrace function to be called.
  */
 _GLOBAL(ftrace_caller)
-	/* Save the original return address in A's stack frame */
-	std	r0,LRSAVE(r1)
-
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -271,6 +268,5 @@ _GLOBAL(ftrace_graph_caller)
 
 	addi	r1, r1, 112
 	mflr	r0
-	std	r0, LRSAVE(r1)
 	bctr
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.12.2
