Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnrXq4YbnzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 01:44:27 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5EFhwtT125132
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 11:44:25 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b37xy0976-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 11:44:24 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 15 Jun 2017 01:44:22 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5EFiKVa3801454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 01:44:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5EFiHMX017204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 01:44:18 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Gustavo Luiz Duarte <gduarte@redhat.com>, zsun@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/uprobes: Implement arch_uretprobe_is_alive()
Date: Wed, 14 Jun 2017 21:14:00 +0530
Message-Id: <20170614154400.17377-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This helper is used to detect if a uprobe'd function has returned
through a setjmp/longjmp, rather than branching to the LR that was
updated previously by us. This fixes a SIGSEGV that gets generated when
programs use setjmp/longjmp with uretprobes.

We use the arm64 model (arch/arm64/kernel/probes/uprobes.c:
arch_uretprobe_is_alive()) for detecting when stack frames have been
removed from under us.

Reference:
https://marc.info/?l=linux-kernel&m=143748610330073
commit 7b868e4802a86 ("uprobes/x86: Reimplement arch_uretprobe_is_alive()")
commit db087ef69a2b1 ("uprobes/x86: Make arch_uretprobe_is_alive(RP_CHECK_CALL) more
clever")

Tested with the test program from:
https://sourceware.org/git/gitweb.cgi?p=systemtap.git;a=blob;f=testsuite/systemtap.base/bz5274.c;hb=HEAD

And this script:
    $ cat test.sh
    #!/bin/bash

    perf probe -x ./bz5274 -a bz5274_main_return=main%return
    perf probe -x ./bz5274 -a bz5274_funca_return=funca%return
    perf probe -x ./bz5274 -a bz5274_funcb_return=funcb%return
    perf probe -x ./bz5274 -a bz5274_funcc_return=funcc%return
    perf probe -x ./bz5274 -a bz5274_funcd_return=funcd%return

    perf record -e 'probe_bz5274:*' -aR ./bz5274

Reported-by: Gustavo Luiz Duarte <gduarte@redhat.com>
Reported-by: zsun@redhat.com
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/uprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 003b20964ea0..5d105b8eeece 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -205,3 +205,12 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 
 	return orig_ret_vaddr;
 }
+
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+				struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return regs->gpr[1] <= ret->stack;
+	else
+		return regs->gpr[1] < ret->stack;
+}
-- 
2.12.2
