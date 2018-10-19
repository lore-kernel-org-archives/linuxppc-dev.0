Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BDCECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 09:31:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A1C21470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 09:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A1C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c0zT0GzhzF3Vp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 20:31:33 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c0xC3tb4zF3Vp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 20:29:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42c0wx3HM5z9ttFp;
 Fri, 19 Oct 2018 11:29:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id PTkX-FbHhTio; Fri, 19 Oct 2018 11:29:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42c0wx1y8Nz9ttBP;
 Fri, 19 Oct 2018 11:29:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A18798B902;
 Fri, 19 Oct 2018 11:29:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5_R4DiSewkGy; Fri, 19 Oct 2018 11:29:22 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 724CB8B8F6;
 Fri, 19 Oct 2018 11:29:22 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4907B6F496; Fri, 19 Oct 2018 09:29:22 +0000 (UTC)
Message-Id: <f1b058d6a73cfb68b36dc755df5aaa7a064875b1.1539935852.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] idle/x86: remove the call to boot_init_stack_canary() from
 cpu_startup_entry()
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Date: Fri, 19 Oct 2018 09:29:22 +0000 (UTC)
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
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit d7880812b359 ("idle: Add the stack canary init to
cpu_startup_entry()") added the call to boot_init_stack_canary()
in cpu_startup_entry() in an #ifdef CONFIG_X86 statement, with
the intention to remove that #ifdef later.

While implementing stack protector for powerpc, it has been
observed that calling boot_init_stack_canary() is also needed
for powerpc which uses per task (TLS) stack canary like the X86.

However, calling boot_init_stack_canary() would break arches
using global stack canary (ARM, SH, MIPS and XTENSA).

Instead of adding modifying the #ifdef in a
implemented the call to boot_init_stack_canary() in the function
calling cpu_startup_entry()

On x86, we have two functions calling cpu_startup_entry():
- start_secondary()
- cpu_bringup_and_idle()

start_secondary() already calls boot_init_stack_canary().

This patch adds the call to boot_init_stack_canary() in
cpu_bringup_and_idle() and removes it from cpu_startup_entry()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/x86/xen/smp_pv.c |  1 +
 kernel/sched/idle.c   | 15 ---------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index e3b18ad49889..0e05e8e23998 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -88,6 +88,7 @@ static void cpu_bringup(void)
 asmlinkage __visible void cpu_bringup_and_idle(void)
 {
 	cpu_bringup();
+	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 16f84142f2f4..f5516bae0c1b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -347,21 +347,6 @@ EXPORT_SYMBOL_GPL(play_idle);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	/*
-	 * This #ifdef needs to die, but it's too late in the cycle to
-	 * make this generic (ARM and SH have never invoked the canary
-	 * init for the non boot CPUs!). Will be fixed in 3.11
-	 */
-#ifdef CONFIG_X86
-	/*
-	 * If we're the non-boot CPU, nothing set the stack canary up
-	 * for us. The boot CPU already has it initialized but no harm
-	 * in doing it again. This is a good place for updating it, as
-	 * we wont ever return from this function (so the invalid
-	 * canaries already on the stack wont ever trigger).
-	 */
-	boot_init_stack_canary();
-#endif
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
-- 
2.13.3

