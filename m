Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD9MB55nrzDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:38:14 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R8YIKY066325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:38:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a32j3xp7b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:38:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 18:37:57 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R8blk051642462
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R8bHqP030507
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:17 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc/kprobes: un-blacklist system_call() from
 kprobes
Date: Thu, 27 Apr 2017 14:06:53 +0530
In-Reply-To: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e15c0617dbf4ff85d3e8f91b7a3ef8e2071b581d.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is actually safe to probe system_call() in entry_64.S, but only till
.Lsyscall_exit. To allow this, convert .Lsyscall_exit to a non-local
symbol __system_call() and blacklist that symbol, rather than
system_call().

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 380361c0bb6a..e030ce34dd66 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -176,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
 	mtctr   r12
 	bctrl			/* Call handler */
 
-.Lsyscall_exit:
+__system_call:
 	std	r3,RESULT(r1)
 	CURRENT_THREAD_INFO(r12, r1)
 
@@ -294,12 +294,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	blt+	system_call
 
 	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
-	b	.Lsyscall_exit
+	b	__system_call
 
 
 .Lsyscall_enosys:
 	li	r3,-ENOSYS
-	b	.Lsyscall_exit
+	b	__system_call
 	
 .Lsyscall_exit_work:
 #ifdef CONFIG_PPC_BOOK3S
@@ -388,7 +388,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	b	.	/* prevent speculative execution */
 #endif
 _ASM_NOKPROBE_SYMBOL(system_call_common);
-_ASM_NOKPROBE_SYMBOL(system_call);
+_ASM_NOKPROBE_SYMBOL(__system_call);
 
 /* Save non-volatile GPRs, if not already saved. */
 _GLOBAL(save_nvgprs)
@@ -413,38 +413,38 @@ _GLOBAL(save_nvgprs)
 _GLOBAL(ppc_fork)
 	bl	save_nvgprs
 	bl	sys_fork
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ppc_vfork)
 	bl	save_nvgprs
 	bl	sys_vfork
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ppc_clone)
 	bl	save_nvgprs
 	bl	sys_clone
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ppc32_swapcontext)
 	bl	save_nvgprs
 	bl	compat_sys_swapcontext
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ppc64_swapcontext)
 	bl	save_nvgprs
 	bl	sys_swapcontext
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ppc_switch_endian)
 	bl	save_nvgprs
 	bl	sys_switch_endian
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ret_from_fork)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
 	li	r3,0
-	b	.Lsyscall_exit
+	b	__system_call
 
 _GLOBAL(ret_from_kernel_thread)
 	bl	schedule_tail
@@ -456,7 +456,7 @@ _GLOBAL(ret_from_kernel_thread)
 #endif
 	blrl
 	li	r3,0
-	b	.Lsyscall_exit
+	b	__system_call
 
 /*
  * This routine switches between two different tasks.  The process
-- 
2.12.2
