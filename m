Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj1hW1BPtzDwM9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:50 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJDG31k047794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:49 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27eav1xyt7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 08:18:48 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 23:18:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 27E2A2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJDIhhn31784966
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJDIgnW011129
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 00:18:42 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 anju@linux.vnet.ibm.com
Subject: [PATCH V3 4/4] arch/powerpc: Optimize kprobe in kretprobe_trampoline
Date: Mon, 19 Dec 2016 18:48:25 +0530
In-Reply-To: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1482153507-17350-3-git-send-email-anju@linux.vnet.ibm.com>
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
