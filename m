Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73542ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:33:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA5C20836
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA5C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c2Lx1JkGzF3Sr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 21:33:29 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c2JS03JDzF3SV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 21:31:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42c2JM2H94z9ttFs;
 Fri, 19 Oct 2018 12:31:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kKSO2KcjeTIX; Fri, 19 Oct 2018 12:31:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42c2JM1cq9z9ttBP;
 Fri, 19 Oct 2018 12:31:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A6D9D8B912;
 Fri, 19 Oct 2018 12:31:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jxpMXR9qskEF; Fri, 19 Oct 2018 12:31:16 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B0938B90C;
 Fri, 19 Oct 2018 12:31:16 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 493E06F469; Fri, 19 Oct 2018 10:31:16 +0000 (UTC)
Message-Id: <285fcf8852b5924cb01de00be1152ea617527c52.1539944940.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] idle/x86: remove the call to boot_init_stack_canary() from
 cpu_startup_entry()
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Date: Fri, 19 Oct 2018 10:31:16 +0000 (UTC)
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

Instead of modifying the #ifdef CONFIG_X86 in an
 #if defined(CONFIG_X86) || defined(CONFIG_PPC), powerpc
implemented the call to boot_init_stack_canary() in the function
calling cpu_startup_entry()

On x86, we have two functions calling cpu_startup_entry():
- start_secondary()
- cpu_bringup_and_idle()

start_secondary() already calls boot_init_stack_canary().

This patch adds the call to boot_init_stack_canary() in
cpu_bringup_and_idle() and removes it from cpu_startup_entry()

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Revised commit log (#if defined  had been droped by 'git commit')

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

