Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJT7d524DzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 18:43:09 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v448d1rH008991
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 04:43:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vc3bsdy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 04:43:01 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 18:42:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v448glGQ65274072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 18:42:55 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v448gHeb005205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 18:42:17 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/3] powerpc/kprobes: un-blacklist system_call() from
 kprobes
Date: Thu,  4 May 2017 14:11:59 +0530
In-Reply-To: <87k25xyx8x.fsf@concordia.ellerman.id.au>
References: <87k25xyx8x.fsf@concordia.ellerman.id.au>
Message-Id: <20170504084159.22617-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is actually safe to probe system_call() in entry_64.S, but only till
we unset MSR_RI. To allow this, add a new label system_call_exit after
the mtmsrd and blacklist that. Though the mtmsrd instruction itself is
now whitelisted, we won't be allowed to probe on it as we don't allow
probing on rfi and mtmsr instructions (checked for in arch_prepare_kprobe).

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Michael,
I have named the new label system_call_exit so as to follow the
existing labels (system_call and system_call_common) and to not
conflict with the syscall_exit private label.

- Naveen


 arch/powerpc/kernel/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 380361c0bb6a..e255221b0ec0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -204,6 +204,7 @@ system_call:			/* label this so stack traces look sane */
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
+system_call_exit:
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
@@ -388,7 +389,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	b	.	/* prevent speculative execution */
 #endif
 _ASM_NOKPROBE_SYMBOL(system_call_common);
-_ASM_NOKPROBE_SYMBOL(system_call);
+_ASM_NOKPROBE_SYMBOL(system_call_exit);
 
 /* Save non-volatile GPRs, if not already saved. */
 _GLOBAL(save_nvgprs)
-- 
2.12.2
