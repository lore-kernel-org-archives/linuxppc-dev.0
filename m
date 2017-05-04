Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhX3mT6zDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:48 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444Y04R093579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:41 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7u1ad2sd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:41 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:38 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bSdY60883178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:36 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444b3i6009345
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:04 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] powerpc/kprobes_on_ftrace: Skip livepatch_handler() for
 jprobes
Date: Thu,  4 May 2017 10:06:17 +0530
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <afea3d1eee9eb546e52cd91b2a9b6be062800b95.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ftrace_caller() depends on a modified regs->nip to detect if a certain
function has been livepatched. However, with KPROBES_ON_FTRACE, it is
possible for regs->nip to have been modified by the jprobes pre_handler.
In this case, we do not want to invoke the livepatch_handler so as not
to consume the livepatch stack.

To distinguish between the two (jprobes and livepatch), we compare the
returned NIP with R12. Jprobes setjmp_pre_handler() sets up both NIP
and R12 to the global entry point of the jprobes hook, while livepatch
handler only sets up NIP and R12 is setup in livepatch_handler.

So, if NIP == R12, we know we came here due to jprobes and we just
branch to the new IP. Otherwise, we continue with livepatch processing
as usual.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index d8d75f4eb853..b1bad68ea6db 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -153,8 +153,18 @@ _GLOBAL(ftrace_stub)
 	 *
 	 * r0 can't be used as the base register for a DS-form load or store, so
 	 * we temporarily shuffle r1 (stack pointer) into r0 and then put it back.
+	 *
+	 * But, before we can do all that, we first need to confirm that we are
+	 * indeed here due to livepatch and not due to jprobes. The difference
+	 * between the two handlers is that jprobes additionally sets up r12.
+	 * So, we can compare nip with r12 as a test to determine if we are here
+	 * due to livepatch or due to jprobes.
 	 */
 livepatch_handler:
+	mfctr	r0
+	cmpd	r0, r12
+	beqctr
+
 	CURRENT_THREAD_INFO(r12, r1)
 
 	/* Save stack pointer into r0 */
-- 
2.12.2
