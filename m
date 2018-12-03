Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DE4C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 17:08:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF74F2087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 17:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF74F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437s0F54gRzDqSF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 04:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ry13Dl8zDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 04:06:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 437rxt21XYz9tyyH;
 Mon,  3 Dec 2018 18:06:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WsU5Mv8NEi72; Mon,  3 Dec 2018 18:06:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 437rxt1XWHz9tyyF;
 Mon,  3 Dec 2018 18:06:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EEC18B7B8;
 Mon,  3 Dec 2018 18:06:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id NZNpV8gFRLuv; Mon,  3 Dec 2018 18:06:45 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 424A28B79E;
 Mon,  3 Dec 2018 18:06:45 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F15476BEF5; Mon,  3 Dec 2018 17:06:44 +0000 (UTC)
Message-Id: <b7a1ceeab24e088ef02b99037128bbe926267893.1543811917.git.christophe.leroy@c-s.fr>
In-Reply-To: <dd9ef91add7fcf5a9e369dde322b1822e90eb218.1543811917.git.christophe.leroy@c-s.fr>
References: <dd9ef91add7fcf5a9e369dde322b1822e90eb218.1543811917.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc: use probe_user_read() and probe_user_address()
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon,  3 Dec 2018 17:06:44 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Instead of opencoding, use probe_user_read() and probe_user_address()
to failessly read a user location.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/process.c   | 12 +-----------
 arch/powerpc/mm/fault.c         |  6 +-----
 arch/powerpc/perf/callchain.c   | 20 +++-----------------
 arch/powerpc/perf/core-book3s.c |  8 +-------
 arch/powerpc/sysdev/fsl_pci.c   |  9 +++------
 5 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..b77a2b4007e5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1298,16 +1298,6 @@ void show_user_instructions(struct pt_regs *regs)
 
 	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
-	/*
-	 * Make sure the NIP points at userspace, not kernel text/data or
-	 * elsewhere.
-	 */
-	if (!__access_ok(pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS)) {
-		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
-			current->comm, current->pid);
-		return;
-	}
-
 	seq_buf_init(&s, buf, sizeof(buf));
 
 	while (n) {
@@ -1318,7 +1308,7 @@ void show_user_instructions(struct pt_regs *regs)
 		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
 			int instr;
 
-			if (probe_kernel_address((const void *)pc, instr)) {
+			if (probe_user_address((const void *)pc, instr)) {
 				seq_buf_printf(&s, "XXXXXXXX ");
 				continue;
 			}
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..a87a2d2e7a8b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -274,12 +274,8 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
 		    access_ok(VERIFY_READ, nip, sizeof(*nip))) {
 			unsigned int inst;
-			int res;
 
-			pagefault_disable();
-			res = __get_user_inatomic(inst, nip);
-			pagefault_enable();
-			if (!res)
+			if (!probe_user_address(nip, inst))
 				return !store_updates_sp(inst);
 			*must_retry = true;
 		}
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 0af051a1974e..efe518c4e8c7 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -159,12 +159,8 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	    ((unsigned long)ptr & 7))
 		return -EFAULT;
 
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
+	if (!probe_user_address(ptr, *ret))
 		return 0;
-	}
-	pagefault_enable();
 
 	return read_user_stack_slow(ptr, ret, 8);
 }
@@ -175,12 +171,8 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
 	    ((unsigned long)ptr & 3))
 		return -EFAULT;
 
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
+	if (!probe_user_address(ptr, *ret))
 		return 0;
-	}
-	pagefault_enable();
 
 	return read_user_stack_slow(ptr, ret, 4);
 }
@@ -307,17 +299,11 @@ static inline int current_is_64bit(void)
  */
 static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
 {
-	int rc;
-
 	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
 	    ((unsigned long)ptr & 3))
 		return -EFAULT;
 
-	pagefault_disable();
-	rc = __get_user_inatomic(*ret, ptr);
-	pagefault_enable();
-
-	return rc;
+	return probe_user_address(ptr, *ret);
 }
 
 static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c838ae..25b28aa499b9 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -407,7 +407,6 @@ static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 static __u64 power_pmu_bhrb_to(u64 addr)
 {
 	unsigned int instr;
-	int ret;
 	__u64 target;
 
 	if (is_kernel_addr(addr)) {
@@ -418,13 +417,8 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	}
 
 	/* Userspace: need copy instruction here then translate it */
-	pagefault_disable();
-	ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
-	if (ret) {
-		pagefault_enable();
+	if (probe_user_address((unsigned int __user *)addr, instr))
 		return 0;
-	}
-	pagefault_enable();
 
 	target = branch_target(&instr);
 	if ((!target) || (instr & BRANCH_ABSOLUTE))
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 918be816b097..b8e2349910b7 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1068,13 +1068,10 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 	addr += mfspr(SPRN_MCAR);
 
 	if (is_in_pci_mem_space(addr)) {
-		if (user_mode(regs)) {
-			pagefault_disable();
-			ret = get_user(inst, (__u32 __user *)regs->nip);
-			pagefault_enable();
-		} else {
+		if (user_mode(regs))
+			ret = probe_user_address((void *)regs->nip, inst);
+		else
 			ret = probe_kernel_address((void *)regs->nip, inst);
-		}
 
 		if (!ret && mcheck_handle_load(regs, inst)) {
 			regs->nip += 4;
-- 
2.13.3

