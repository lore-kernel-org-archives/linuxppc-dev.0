Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz74v265czDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M999oS135936
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:08 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4pnfk08q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:08 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 19:11:04 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M9B3tv40304748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:03 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M9ArWj020431
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:54 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/6] powerpc/kprobes: Some cosmetic updates to
 try_to_emulate()
Date: Fri, 22 Sep 2017 14:40:43 +0530
In-Reply-To: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. This is only used in kprobes.c, so make it static.
2. Remove the un-necessary (ret == 0) comparison in the else clause.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 367494dc67d9..c2a6ab38a67f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -239,7 +239,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
-int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
+static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
 {
 	int ret;
 	unsigned int insn = *p->ainsn.insn;
@@ -261,7 +261,7 @@ int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
 		 */
 		printk("Can't step on instruction %x\n", insn);
 		BUG();
-	} else if (ret == 0)
+	} else
 		/* This instruction can't be boosted */
 		p->ainsn.boostable = -1;
 
-- 
2.14.1
