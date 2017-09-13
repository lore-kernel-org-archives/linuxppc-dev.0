Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsvjN1D41zDrTD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:21:11 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DLKtRH016786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:21:09 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy9u7jeta-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:21:09 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 07:21:07 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8DLL4DU39714820
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:21:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8DLL53u026438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 07:21:06 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powerpc/jprobes: Validate break handler invocation as
 being due to a jprobe_return()
Date: Thu, 14 Sep 2017 02:50:36 +0530
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <58db21d55022d7fb95468f3b8fd3dbffec36a113.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
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
This is v2 of the patch posted previously (*) to change the WARN() to a 
pr_debug() as suggested by Masami.
(*) https://patchwork.ozlabs.org/patch/762670/

- Naveen

 arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index db40b13fd3d1..5b26d5202273 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -648,24 +648,22 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
 
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
