Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D46C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:00:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E045D206B2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XMF873lqzF3DR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 22:00:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XM8y6C3DzF368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 21:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XM8y5Svhz9s89; Sat, 13 Oct 2018 21:57:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XM8y4prQz9s9N; Sat, 13 Oct 2018 21:57:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/ptrace: Don't use sizeof(struct pt_regs) in
 ptrace code
Date: Sat, 13 Oct 2018 21:56:45 +1100
Message-Id: <20181013105646.5147-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013105646.5147-1-mpe@ellerman.id.au>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that we've split the user & kernel versions of pt_regs we need to
be more careful in the ptrace code.

For now we've ensured the location of the fields in both structs is
the same, so most of the ptrace code doesn't need updating.

But there are a few places where we use sizeof(pt_regs), and these
will be wrong as soon as we increase the size of the kernel structure.

So flip them all to use sizeof(user_pt_regs).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ptrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 939d7f81bbbe..c7d0d0c1e34d 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -297,7 +297,7 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	}
 #endif
 
-	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long))) {
+	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
 	}
@@ -360,10 +360,10 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.regs->orig_gpr3,
 					  offsetof(struct pt_regs, orig_gpr3),
-					  sizeof(struct pt_regs));
+					  sizeof(struct user_pt_regs));
 	if (!ret)
 		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct pt_regs), -1);
+					       sizeof(struct user_pt_regs), -1);
 
 	return ret;
 }
@@ -853,10 +853,10 @@ static int tm_cgpr_get(struct task_struct *target,
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.ckpt_regs.orig_gpr3,
 					  offsetof(struct pt_regs, orig_gpr3),
-					  sizeof(struct pt_regs));
+					  sizeof(struct user_pt_regs));
 	if (!ret)
 		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct pt_regs), -1);
+					       sizeof(struct user_pt_regs), -1);
 
 	return ret;
 }
@@ -3131,7 +3131,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PTRACE_GETREGS:	/* Get all pt_regs from the child. */
 		return copy_regset_to_user(child, &user_ppc_native_view,
 					   REGSET_GPR,
-					   0, sizeof(struct pt_regs),
+					   0, sizeof(struct user_pt_regs),
 					   datavp);
 
 #ifdef CONFIG_PPC64
@@ -3140,7 +3140,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		return copy_regset_from_user(child, &user_ppc_native_view,
 					     REGSET_GPR,
-					     0, sizeof(struct pt_regs),
+					     0, sizeof(struct user_pt_regs),
 					     datavp);
 
 	case PTRACE_GETFPREGS: /* Get the child FPU state (FPR0...31 + FPSCR) */
-- 
2.17.1

