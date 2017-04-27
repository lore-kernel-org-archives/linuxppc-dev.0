Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD9M01ytzzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:38:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R8Y6ME017602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:37:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a3aqweex9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:37:59 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 18:37:56 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R8bj9R33620054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R8bFJq030418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:37:16 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc/kprobes: cleanup system_call_common and
 blacklist it from kprobes
Date: Thu, 27 Apr 2017 14:06:52 +0530
In-Reply-To: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5964964467e939a21f3f308d4e17c2f6adfaaa59.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert some of the labels into private labels and blacklist
system_call_common() and system_call() from kprobes. We can't take a
trap at parts of these functions as either MSR_RI is unset or the
kernel stack pointer is not yet setup.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9b541d22595a..380361c0bb6a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -52,12 +52,11 @@ exception_marker:
 	.section	".text"
 	.align 7
 
-	.globl system_call_common
-system_call_common:
+_GLOBAL(system_call_common)
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 BEGIN_FTR_SECTION
 	extrdi.	r10, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
-	bne	tabort_syscall
+	bne	.Ltabort_syscall
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 	andi.	r10,r12,MSR_PR
@@ -152,9 +151,9 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
-	bne	syscall_dotrace		/* does not return */
+	bne	.Lsyscall_dotrace		/* does not return */
 	cmpldi	0,r0,NR_syscalls
-	bge-	syscall_enosys
+	bge-	.Lsyscall_enosys
 
 system_call:			/* label this so stack traces look sane */
 /*
@@ -208,7 +207,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
-	bne-	syscall_exit_work
+	bne-	.Lsyscall_exit_work
 
 	andi.	r0,r8,MSR_FP
 	beq 2f
@@ -232,7 +231,7 @@ system_call:			/* label this so stack traces look sane */
 
 3:	cmpld	r3,r11
 	ld	r5,_CCR(r1)
-	bge-	syscall_error
+	bge-	.Lsyscall_error
 .Lsyscall_error_cont:
 	ld	r7,_NIP(r1)
 BEGIN_FTR_SECTION
@@ -258,14 +257,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	RFI
 	b	.	/* prevent speculative execution */
 
-syscall_error:	
+.Lsyscall_error:
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
 	neg	r3,r3
 	std	r5,_CCR(r1)
 	b	.Lsyscall_error_cont
 	
 /* Traced system call support */
-syscall_dotrace:
+.Lsyscall_dotrace:
 	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_syscall_trace_enter
@@ -298,11 +297,11 @@ syscall_dotrace:
 	b	.Lsyscall_exit
 
 
-syscall_enosys:
+.Lsyscall_enosys:
 	li	r3,-ENOSYS
 	b	.Lsyscall_exit
 	
-syscall_exit_work:
+.Lsyscall_exit_work:
 #ifdef CONFIG_PPC_BOOK3S
 	li	r10,MSR_RI
 	mtmsrd	r10,1		/* Restore RI */
@@ -362,7 +361,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	b	ret_from_except
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-tabort_syscall:
+.Ltabort_syscall:
 	/* Firstly we need to enable TM in the kernel */
 	mfmsr	r10
 	li	r9, 1
@@ -388,6 +387,8 @@ tabort_syscall:
 	rfid
 	b	.	/* prevent speculative execution */
 #endif
+_ASM_NOKPROBE_SYMBOL(system_call_common);
+_ASM_NOKPROBE_SYMBOL(system_call);
 
 /* Save non-volatile GPRs, if not already saved. */
 _GLOBAL(save_nvgprs)
-- 
2.12.2
