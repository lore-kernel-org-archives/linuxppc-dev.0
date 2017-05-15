Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRTDC439YzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:11:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FI9Dpq091257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:11:12 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afeqcymb8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 14:11:12 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 May 2017 04:11:07 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4FIAuj157278628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:11:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4FIAV4T021777
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:10:31 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kprobes: Fix handling of instruction emulation on
 probe re-entry
Date: Mon, 15 May 2017 23:40:05 +0530
Message-Id: <20170515181005.29517-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 22d8b3dec214c ("powerpc/kprobes: Emulate instructions on kprobe
handler re-entry") enabled emulating instructions on kprobe re-entry,
rather than single-stepping always. However, we didn't update the single
stepping code to only be run if the emulation fails. Also, we missed
re-enabling preemption if the instruction emulation was successful. Fix
those issues.

Fixes: 22d8b3dec214c ("powerpc/kprobes: Emulate instructions on kprobe
handler re-entry")

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Michael,
Sorry for letting this slip through. Between when I first wrote the
above commit to when I posted it, there was an issue with a rebase that
resulted in slightly different code getting through (in other words, I
messed up the rebase resolution). I have now tested this version and
verified that this works properly.

Thanks,
Naveen 

 arch/powerpc/kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 1ebeb8c482db..793c3385dfaa 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -299,16 +299,17 @@ int kprobe_handler(struct pt_regs *regs)
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
 			kprobes_inc_nmissed_count(p);
-			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			if (p->ainsn.boostable >= 0) {
 				ret = try_to_emulate(p, regs);
 
 				if (ret > 0) {
 					restore_previous_kprobe(kcb);
+					preempt_enable_no_resched();
 					return 1;
 				}
 			}
+			prepare_singlestep(p, regs);
 			return 1;
 		} else {
 			if (*addr != BREAKPOINT_INSTRUCTION) {
-- 
2.12.2
