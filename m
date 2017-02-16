Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPChK5FMLzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:54:09 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GAroxF051428
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:54:05 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28n823psd1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:54:05 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:54:02 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3ECE02BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GArpGj7209120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GArQS3005809
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 21:53:27 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc: kprobes: emulate instructions on kprobe handler
 re-entry
Date: Thu, 16 Feb 2017 16:22:43 +0530
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
References: <49dae0da9b7cee3f1747b116cd59854ece84bf02.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <8471fff08f4118b0dbec7893d86a01a2c8856f40.1487239680.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On kprobe handler re-entry, try to emulate the instruction rather than
single stepping always.

As a related change, remove the duplicate saving of msr as that is
already done in set_current_kprobe()

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 8b48f7d046bd..005bd4a75902 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -273,10 +273,17 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 			 */
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
-			kcb->kprobe_saved_msr = regs->msr;
 			kprobes_inc_nmissed_count(p);
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
+			if (p->ainsn.boostable >= 0) {
+				ret = try_to_emulate(p, regs);
+
+				if (ret > 0) {
+					restore_previous_kprobe(kcb);
+					return 1;
+				}
+			}
 			return 1;
 		} else {
 			if (*addr != BREAKPOINT_INSTRUCTION) {
-- 
2.11.0
