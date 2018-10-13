Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F8C71122
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:47:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857AE20835
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857AE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XKcF1TdDzF3DR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 20:47:09 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XKZ40bP2zF0dW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 20:45:16 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42XKYv4RqDz9ttFt;
 Sat, 13 Oct 2018 11:45:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GDSymDLByBox; Sat, 13 Oct 2018 11:45:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42XKYv3cJsz9ttFr;
 Sat, 13 Oct 2018 11:45:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C5FD18B782;
 Sat, 13 Oct 2018 11:45:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IWppLi9istWc; Sat, 13 Oct 2018 11:45:12 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 936E88B74B;
 Sat, 13 Oct 2018 11:45:12 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 574C16F433; Sat, 13 Oct 2018 09:45:12 +0000 (UTC)
Message-Id: <a2694b8ffeb6c52d1c755d8a7bfaac689c4e1c6d.1539423893.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64: properly initialise the stackprotector canary on
 SMP.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 abdhalee@linux.vnet.ibm.com
Date: Sat, 13 Oct 2018 09:45:12 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit 06ec27aea9fc ("powerpc/64: add stack protector support")
doesn't initialise the stack canary on SMP secondary CPU's paca,
leading to the following false positive report from the
stack protector.

smp: Bringing up secondary CPUs ...
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
Call Trace:
[c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
[c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
[c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
[c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
[c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
[c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
[c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
[c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
[c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14

This patch properly initialises the stack_canary of the secondary
idle tasks.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Fixes: 06ec27aea9fc ("powerpc/64: add stack protector support")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 61c1fadbc644..e774d3bf3a03 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -34,6 +34,7 @@
 #include <linux/topology.h>
 #include <linux/profile.h>
 #include <linux/processor.h>
+#include <linux/random.h>
 
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
@@ -810,9 +811,16 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 {
 	struct thread_info *ti = task_thread_info(idle);
 
+#ifdef CONFIG_STACKPROTECTOR
+	idle->stack_canary = get_random_canary();
+#endif
+
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
 	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+#ifdef CONFIG_STACKPROTECTOR
+	paca_ptrs[cpu]->canary = idle->stack_canary;
+#endif
 #endif
 	ti->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
-- 
2.13.3

