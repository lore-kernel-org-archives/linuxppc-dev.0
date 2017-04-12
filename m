Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31Cb68DmzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:59:55 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CAweYB071234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 06:59:54 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sb7cadku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 06:59:54 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 20:59:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CAxeT941353256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:59:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CAxBa5019280
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:59:11 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
Date: Wed, 12 Apr 2017 16:28:28 +0530
In-Reply-To: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7021f79a5738ecb25ee3e07931e927138e9493eb.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
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
2.12.1
