Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MMP3kZYzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:45 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnFeW143592
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:35 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x6x0v43h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:35 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:21:31 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpSQj21561504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:28 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCpRdY026860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:28 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] powerpc: kprobes: remove duplicate saving of msr
Date: Wed, 19 Apr 2017 18:21:06 +0530
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <bdf0464c4b7f0d4aa0099d3e60ebeb63ba4b07d1.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

set_current_kprobe() already saves regs->msr into kprobe_saved_msr. Remove
the redundant save.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 067e9863bfdf..5c0a1ffcbcf9 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -272,7 +272,6 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 			 */
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
-			kcb->kprobe_saved_msr = regs->msr;
 			kprobes_inc_nmissed_count(p);
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
-- 
2.12.1
