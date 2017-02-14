Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwmn4W3yzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:38:33 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8UScP015455
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:31 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kwv49kfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:38:30 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 14:08:27 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D1E193940033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:25 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E8cPu942139808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:25 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E8cO4B011298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:08:25 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: kprobes: emulate instructions on kprobe handler
 re-entry
Date: Tue, 14 Feb 2017 14:08:03 +0530
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <55ae0ad405a254c9ec60d5912b2a53095185e219.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
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

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9cdf2de31e9e..c213637b9d25 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -206,10 +206,17 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
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
