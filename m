Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPChC1Np8zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:54:02 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GArUZj004769
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:54:00 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28napkg24p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:54:00 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:53:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9CD7D2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GArkRQ38273234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GArM3b005766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:22 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc: kprobes: factor out code to emulate instruction
 into a helper
Date: Thu, 16 Feb 2017 16:22:42 +0530
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <1def0c06fe2387edd925939b2bdc0d099ac249ae.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
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

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 0732a0291ace..8b48f7d046bd 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -207,6 +207,35 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
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
@@ -302,18 +331,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 
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
 
@@ -321,17 +341,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
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
