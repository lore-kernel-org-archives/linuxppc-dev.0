Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRT6M30q6zDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:06:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FI03mF118023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:06:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afb6pbrs4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:06:10 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 May 2017 04:06:08 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4FI5vw16947162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:06:05 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4FI5WRY020835
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:05:33 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/jprobes: Validate break handler invocation as
 being due to a jprobe_return()
Date: Mon, 15 May 2017 23:35:04 +0530
In-Reply-To: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d6b0691226623b3499d43dff1e31971ea46df9f9.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
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

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 19b053475758..1ebeb8c482db 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -627,25 +627,23 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
 
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
 	unsigned long sp;
 
-	/*
-	 * FIXME - we should ideally be validating that we got here 'cos
-	 * of the "trap" in jprobe_return() above, before restoring the
-	 * saved regs...
-	 */
+	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
+		WARN(1, "longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
+				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
+		return 0;
+	}
+
 	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
 	sp = kernel_stack_pointer(regs);
 	memcpy((void *)sp, &kcb->jprobes_stack, MIN_STACK_SIZE(sp));
-- 
2.12.2
