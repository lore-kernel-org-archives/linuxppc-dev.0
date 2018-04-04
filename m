Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GMvZ6N9HzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 20:41:30 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w34AdobN127431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Apr 2018 06:41:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4vs6h5y8-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 06:41:28 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 4 Apr 2018 11:41:25 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/hw_breakpoint: Only disable hw breakpoint if cpu
 supports it
Date: Wed,  4 Apr 2018 16:11:16 +0530
Message-Id: <20180404104116.27819-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We get the below warning if we try to use kexec on P9:
    kexec_core: Starting new kernel
    WARNING: CPU: 0 PID: 1223 at arch/powerpc/kernel/process.c:826 __set_breakpoint+0xb4/0x140
    [snip]
    NIP [c00000000001bf44] __set_breakpoint+0xb4/0x140
    LR [c000000000061268] kexec_prepare_cpus_wait+0x58/0x150
    Call Trace:
    [c0000000ee70fad0] [c0000000ee70fb20] 0xc0000000ee70fb20 (unreliable)
    [c0000000ee70faf0] [c0000000ee70fb20] 0xc0000000ee70fb20
    [c0000000ee70fbb0] [c000000000061884] default_machine_kexec+0x234/0x2c0
    [c0000000ee70fc40] [c0000000000605c4] machine_kexec+0x84/0x90
    [c0000000ee70fc70] [c000000000206548] kernel_kexec+0xd8/0xe0
    [c0000000ee70fce0] [c000000000169e74] SyS_reboot+0x214/0x2c0
    [c0000000ee70fe30] [c00000000000bd60] system_call+0x58/0x6c

This happens since we are trying to clear hw breakpoint on POWER9, though
we don't have CPU_FTR_DAWR enabled. Guard __set_breakpoint() within
hw_breakpoint_disable() with ppc_breakpoint_available() to address this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 90c708e5e7c4..8e7b09703ca4 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -80,7 +80,8 @@ static inline void hw_breakpoint_disable(void)
 	brk.address = 0;
 	brk.type = 0;
 	brk.len = 0;
-	__set_breakpoint(&brk);
+	if (ppc_breakpoint_available())
+		__set_breakpoint(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 int hw_breakpoint_handler(struct die_args *args);
-- 
2.16.2
