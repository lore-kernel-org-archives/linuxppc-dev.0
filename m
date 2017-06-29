Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyx6d2lxDzDr53
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TAcog0066148
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 06:41:42 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcx8gvcnk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 06:41:42 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 20:41:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TAfUQ74260346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TAfLeL029222
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:41:22 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/7] powerpc/64s: Move system_call() symbol to just after
 setting MSR_EE
Date: Thu, 29 Jun 2017 16:11:07 +0530
In-Reply-To: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <1082922913c4f3eb1927bed9ed8eaf23318408c5.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is common to get a PMU interrupt right after the mtmsr instruction that
enables interrupts. Due to this, the stack trace profile gets needlessly split
across system_call_common() and system_call().

Previously, system_call() symbol was at the current place to hide a few
earlier symbols which have since been made private or removed entirely.

So, let's move system_call() slightly higher up, right after the mtmsr
instruction that enables interrupts. Convert existing references to
system_call to a local syscall symbol.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ef8e6615b8ba..c39436706555 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -142,6 +142,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
+system_call:			/* label this so stack traces look sane */
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
@@ -155,7 +156,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	cmpldi	0,r0,NR_syscalls
 	bge-	.Lsyscall_enosys
 
-system_call:			/* label this so stack traces look sane */
+.Lsyscall:
 /*
  * Need to vector to 32 Bit or default sys_call_table here,
  * based on caller's run-mode / personality.
@@ -309,13 +310,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r7,GPR7(r1)
 	ld	r8,GPR8(r1)
 
-	/* Repopulate r9 and r10 for the system_call path */
+	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	CURRENT_THREAD_INFO(r10, r1)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
-	blt+	system_call
+	blt+	.Lsyscall
 
 	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
 	b	.Lsyscall_exit
-- 
2.13.1
