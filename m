Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz759421WzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:25 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M9AxXQ019498
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:22 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4ynp808a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:22 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 19:11:20 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M9BHXJ36503728
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M9B7vS020832
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:08 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/6] powerpc/jprobes: Validate break handler invocation as
 being due to a jprobe_return()
Date: Fri, 22 Sep 2017 14:40:48 +0530
In-Reply-To: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e8e20b8b60f3140f74b92a7c9ef00c1c0f81b184.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a circa 2005 FIXME by implementing a check to ensure that we
actually got into the jprobe break handler() due to the trap in
jprobe_return().

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 48a81614f629..a14c61855705 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -639,24 +639,22 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
 
 void __used jprobe_return(void)
 {
-	asm volatile("trap" ::: "memory");
+	asm volatile("jprobe_return_trap:\n"
+		     "trap\n"
+		     ::: "memory");
 }
 NOKPROBE_SYMBOL(jprobe_return);
 
-static void __used jprobe_return_end(void)
-{
-}
-NOKPROBE_SYMBOL(jprobe_return_end);
-
 int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	/*
-	 * FIXME - we should ideally be validating that we got here 'cos
-	 * of the "trap" in jprobe_return() above, before restoring the
-	 * saved regs...
-	 */
+	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
+		pr_debug("longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
+				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
+		return 0;
+	}
+
 	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
 	/* It's OK to start function graph tracing again */
 	unpause_graph_tracing();
-- 
2.14.1
