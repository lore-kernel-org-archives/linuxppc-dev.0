Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJGgL3bwqzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:51:10 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v189nHx3003257
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 04:51:08 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28g0fj1dn6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 04:51:07 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 15:21:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4FBB7394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 15:21:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v189p1q829753422
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 15:21:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v189ow26002221
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 15:21:00 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: [PATCH v4 2/2] arch/powerpc: Optimize kprobe in kretprobe_trampoline
Date: Wed,  8 Feb 2017 15:20:52 +0530
In-Reply-To: <1486547452-13510-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1486547452-13510-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1486547452-13510-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kprobe placed on the  kretprobe_trampoline during boot time can be 
optimized, since the instruction at probe point is a 'nop'.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/powerpc/kernel/kprobes.c   | 8 ++++++++
 arch/powerpc/kernel/optprobes.c | 7 +++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e785cc9..5b0fd07 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -282,6 +282,7 @@ asm(".global kretprobe_trampoline\n"
 	".type kretprobe_trampoline, @function\n"
 	"kretprobe_trampoline:\n"
 	"nop\n"
+	"blr\n"
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n");
 
 /*
@@ -334,6 +335,13 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
 	regs->nip = orig_ret_address;
+	/*
+	 * Make LR point to the orig_ret_address.
+	 * When the 'nop' inside the kretprobe_trampoline
+	 * is optimized, we can do a 'blr' after executing the
+	 * detour buffer code.
+	 */
+	regs->link = orig_ret_address;
 
 	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index ecba221..5e4c254 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -72,12 +72,11 @@ static unsigned long can_optimize(struct kprobe *p)
 
 	/*
 	 * kprobe placed for kretprobe during boot time
-	 * is not optimizing now.
-	 *
-	 * TODO: Optimize kprobe in kretprobe_trampoline
+	 * has a 'nop' instruction, which can be emulated.
+	 * So further checks can be skipped.
 	 */
 	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
-		return 0;
+		return (unsigned long)p->addr + sizeof(kprobe_opcode_t);
 
 	/*
 	 * We only support optimizing kernel addresses, but not
-- 
2.7.4
