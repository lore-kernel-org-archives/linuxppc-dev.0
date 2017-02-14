Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwml0PDSzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:38:30 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8Sval034294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:28 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kv2dnv3n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:28 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 14:08:25 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CAFA2E005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:09:54 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E8bMl927394206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:07:22 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E8cMsL011285
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: kprobes: factor out code to emulate instruction
 into a helper
Date: Tue, 14 Feb 2017 14:08:02 +0530
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <f7c2116b556de0a764e1c7c5369c13fc9139566b.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This helper will be used in a subsequent patch to emulate instructions
on re-entering the kprobe handler. No functional change.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index fce05a38851c..9cdf2de31e9e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -140,6 +140,35 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	regs->link = (unsigned long)kretprobe_trampoline;
 }
 
+int __kprobes try_to_emulate(struct kprobe *p, struct pt_regs *regs)
+{
+	int ret;
+	unsigned int insn = *p->ainsn.insn;
+
+	/* regs->nip is also adjusted if emulate_step returns 1 */
+	ret = emulate_step(regs, insn);
+	if (ret > 0) {
+		/*
+		 * Once this instruction has been boosted
+		 * successfully, set the boostable flag
+		 */
+		if (unlikely(p->ainsn.boostable == 0))
+			p->ainsn.boostable = 1;
+	} else if (ret < 0) {
+		/*
+		 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
+		 * So, we should never get here... but, its still
+		 * good to catch them, just in case...
+		 */
+		printk("Can't step on instruction %x\n", insn);
+		BUG();
+	} else if (ret == 0)
+		/* This instruction can't be boosted */
+		p->ainsn.boostable = -1;
+
+	return ret;
+}
+
 int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
@@ -235,18 +264,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 
 ss_probe:
 	if (p->ainsn.boostable >= 0) {
-		unsigned int insn = *p->ainsn.insn;
+		ret = try_to_emulate(p, regs);
 
-		/* regs->nip is also adjusted if emulate_step returns 1 */
-		ret = emulate_step(regs, insn);
 		if (ret > 0) {
-			/*
-			 * Once this instruction has been boosted
-			 * successfully, set the boostable flag
-			 */
-			if (unlikely(p->ainsn.boostable == 0))
-				p->ainsn.boostable = 1;
-
 			if (p->post_handler)
 				p->post_handler(p, regs, 0);
 
@@ -254,17 +274,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 			reset_current_kprobe();
 			preempt_enable_no_resched();
 			return 1;
-		} else if (ret < 0) {
-			/*
-			 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
-			 * So, we should never get here... but, its still
-			 * good to catch them, just in case...
-			 */
-			printk("Can't step on instruction %x\n", insn);
-			BUG();
-		} else if (ret == 0)
-			/* This instruction can't be boosted */
-			p->ainsn.boostable = -1;
+		}
 	}
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
-- 
2.11.0
