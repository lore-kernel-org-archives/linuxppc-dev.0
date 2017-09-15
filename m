Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtrhV440fzDrYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 20:08:41 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8FA6GkX129567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 06:08:39 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d0a0xqrfv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 06:08:39 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 15 Sep 2017 20:08:36 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8FA8YUl23986304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 20:08:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8FA8XMO013101
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 20:08:34 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kprobes: Update optprobes to use emulate_update_regs()
Date: Fri, 15 Sep 2017 15:38:21 +0530
Message-Id: <20170915100821.7254-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Optprobes depended on an updated regs->nip from analyse_instr() to
identify the location to branch back from the optprobes trampoline.
However, since commit 3cdfcbfd32b9d ("powerpc: Change analyse_instr so
it doesn't modify *regs"), analyse_instr() doesn't update the registers
anymore.  Due to this, we end up branching back from the optprobes
trampoline to the same branch into the trampoline resulting in a loop.

Fix this by calling out to emulate_update_regs() before using the nip.
Additionally, explicitly compare the return value from analyse_instr()
to 1, rather than just checking for !0 so as to guard against any
future changes to analyse_instr() that may result in -1 being returned
in more scenarios.

Fixes: 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't modify *regs")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/optprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 6f8273f5e988..91e037ab20a1 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -104,8 +104,10 @@ static unsigned long can_optimize(struct kprobe *p)
 	 * and that can be emulated.
 	 */
 	if (!is_conditional_branch(*p->ainsn.insn) &&
-			analyse_instr(&op, &regs, *p->ainsn.insn))
+			analyse_instr(&op, &regs, *p->ainsn.insn) == 1) {
+		emulate_update_regs(&regs, &op);
 		nip = regs.nip;
+	}
 
 	return nip;
 }
-- 
2.14.1
