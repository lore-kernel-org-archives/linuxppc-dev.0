Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58EC32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:11:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9078320827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZIPdUi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9078320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qSzW3vkpzF3Fh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:11:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZIPdUi/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZIPdUi/";
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qSqP1mvMzF1fK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 12:04:17 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id n4-v6so7061951plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 17:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ScJlRoOrd6+1KGabrahH6IK5C6npk55iYYxUa/QmbRo=;
 b=fZIPdUi/+CMv1IoXrMqLttVjfbUF0CQAy/QTO4DIO7j0UTajPDol0YyPyjV6N1K/gp
 nAJ16Nmsk3FBEODhKCetMUbGi6ZVn8WBMj/pFWS/A4cuPYPD2J/J7tQFqFYMpoOwCANV
 Ea/XtWT/GeDPuYtxrNYhCl+fHec9LdBSB4UYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ScJlRoOrd6+1KGabrahH6IK5C6npk55iYYxUa/QmbRo=;
 b=UJ8k+TGGxO835cDBYbk+1GKroLLr0GbzkLL7YquGuAL3pH7xMIGwtCY90xYWZWqXG1
 R77t8c7OtvlDm4m8G14/sn6kI8s8z0kXEUt9TjV7ANrNEos658AtZOcQvHUDm6TdOHsa
 zOLxZc48ce0X6fXr6TrY6xbMVGM/be5nVR8AeuzR3MalgVHCK+EySZde/4xAC71kmYqT
 E2Hh4MGIH0nJjxHzu7Cs4CZYOfqEvm9m9grxtRuRi98TzkI+8L9gy63FicOro9OR8A0a
 0SD9VPHP54EXkWjKH9HxeyQAcQsubdvECeq+oQpNS5A89hstyg5squddyY9N7Oku3RJB
 z2xw==
X-Gm-Message-State: AGRZ1gKDRwmf5KNHBCiXSzRwd3rx+3dlkA64E7lTrAOMbb1uzlrOa2ZN
 GM89/Pm9uyVhhefre8cXwyvAtQ==
X-Google-Smtp-Source: AJdET5cDw0ywYnyuZLa4wQUxTtJoLF9l6tC+ELRDMnuPWU/AtBq5dJcp8W39VvZLw8ptnxHIR1UjtA==
X-Received: by 2002:a17:902:6f16:: with SMTP id
 w22-v6mr9616813plk.235.1541552655366; 
 Tue, 06 Nov 2018 17:04:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 17:04:14 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v3 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Date: Tue,  6 Nov 2018 17:00:26 -0800
Message-Id: <20181107010028.184543-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181107010028.184543-1-dianders@chromium.org>
References: <20181107010028.184543-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>,
 linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When I had lockdep turned on and dropped into kgdb I got a nice splat
on my system.  Specifically it hit:
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)

Specifically it looked like this:
  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Looking closely at it, it seems like a really bad idea to be calling
local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
like it could violate spinlock semantics and cause a deadlock.

Instead, let's use a private csd alongside
smp_call_function_single_async() to round up the other CPUs.  Using
smp_call_function_single_async() doesn't require interrupts to be
enabled so we can remove the offending bit of code.

In order to avoid duplicating this across all the architectures that
use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
to debug_core.c.

Looking at all the people who previously had copies of this code,
there were a few variants.  I've attempted to keep the variants
working like they used to.  Specifically:
* For arch/arc we passed NULL to kgdb_nmicallback() instead of
  get_irq_regs().
* For arch/mips there was a bit of extra code around
  kgdb_nmicallback()

NOTE: In this patch we will still get into trouble if we try to round
up a CPU that failed to round up before.  We'll try to round it up
again and potentially hang when we try to grab the csd lock.  That's
not new behavior but we'll still try to do better in a future patch.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 27 ---------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  4 ++--
 arch/sh/kernel/kgdb.c      | 12 ------------
 include/linux/kgdb.h       | 15 +++++++++++++--
 kernel/debug/debug_core.c  | 35 +++++++++++++++++++++++++++++++++++
 9 files changed, 53 insertions(+), 83 deletions(-)

diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
index 0932851028e0..68d9fe4b5aa7 100644
--- a/arch/arc/kernel/kgdb.c
+++ b/arch/arc/kernel/kgdb.c
@@ -192,18 +192,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 	instruction_pointer(regs) = ip;
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
+void kgdb_call_nmi_hook(void *ignored)
 {
+	/* Default implementation passes get_irq_regs() but we don't */
 	kgdb_nmicallback(raw_smp_processor_id(), NULL);
 }
 
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 struct kgdb_arch arch_kgdb_ops = {
 	/* breakpoint instruction: TRAP_S 0x3 */
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index f21077b077be..d9a69e941463 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -170,18 +170,6 @@ static struct undef_hook kgdb_compiled_brkpt_hook = {
 	.fn			= kgdb_compiled_brk_fn
 };
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-       local_irq_enable();
-       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-       local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	struct pt_regs *regs = args->regs;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 12c339ff6e75..da880247c734 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -284,18 +284,6 @@ static struct step_hook kgdb_step_hook = {
 	.fn		= kgdb_step_brk_fn
 };
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	struct pt_regs *regs = args->regs;
diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 012e0e230ac2..b95d12038a4e 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -115,33 +115,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	instruction_pointer(regs) = pc;
 }
 
-#ifdef CONFIG_SMP
-
-/**
- * kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *
- * On SMP systems, we need to get the attention of the other CPUs
- * and get them be in a known state.  This should do what is needed
- * to get the other CPUs to call kgdb_wait(). Note that on some arches,
- * the NMI approach is not used for rounding up all the CPUs. For example,
- * in case of MIPS, smp_call_function() is used to roundup CPUs.
- *
- * On non-SMP systems, this is not called.
- */
-
-static void hexagon_kgdb_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-#endif
-
 
 /*  Not yet working  */
 void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index 2b05effc17b4..42f057a6c215 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -207,7 +207,7 @@ void arch_kgdb_breakpoint(void)
 		".set\treorder");
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
+void kgdb_call_nmi_hook(void *ignored)
 {
 	mm_segment_t old_fs;
 
@@ -219,13 +219,6 @@ static void kgdb_call_nmi_hook(void *ignored)
 	set_fs(old_fs);
 }
 
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int compute_signal(int tt)
 {
 	struct hard_trap_info *ht;
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index b0e804844be0..b4ce54d73337 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -117,7 +117,7 @@ int kgdb_skipexception(int exception, struct pt_regs *regs)
 	return kgdb_isremovedbreak(regs->nip);
 }
 
-static int kgdb_call_nmi_hook(struct pt_regs *regs)
+static int kgdb_debugger_ipi(struct pt_regs *regs)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), regs);
 	return 0;
@@ -502,7 +502,7 @@ int kgdb_arch_init(void)
 	old__debugger_break_match = __debugger_break_match;
 	old__debugger_fault_handler = __debugger_fault_handler;
 
-	__debugger_ipi = kgdb_call_nmi_hook;
+	__debugger_ipi = kgdb_debugger_ipi;
 	__debugger = kgdb_debugger;
 	__debugger_bpt = kgdb_handle_breakpoint;
 	__debugger_sstep = kgdb_singlestep;
diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index cc57630f6bf2..14e012ad7c57 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -314,18 +314,6 @@ BUILD_TRAP_HANDLER(singlestep)
 	local_irq_restore(flags);
 }
 
-static void kgdb_call_nmi_hook(void *ignored)
-{
-	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
-}
-
-void kgdb_roundup_cpus(void)
-{
-	local_irq_enable();
-	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
-}
-
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
 	int ret;
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 05e5b2eb0d32..24422865cd18 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -176,14 +176,25 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
 			   char *remcom_out_buffer,
 			   struct pt_regs *regs);
 
+/**
+ *	kgdb_call_nmi_hook - Call kgdb_nmicallback() on the current CPU
+ *	@ignored: This parameter is only here to match the prototype.
+ *
+ *	If you're using the default implementation of kgdb_roundup_cpus()
+ *	this function will be called per CPU.  If you don't implement
+ *	kgdb_call_nmi_hook() a default will be used.
+ */
+
+extern void kgdb_call_nmi_hook(void *ignored);
+
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them into a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
- *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs.
+ *	the NMI approach is not used for rounding up all the CPUs.  Normally
+ *	those architectures can just not implement this and get the default.
  *
  *	On non-SMP systems, this is not called.
  */
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index f3cadda45f07..23f2b5613afa 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -55,6 +55,7 @@
 #include <linux/mm.h>
 #include <linux/vmacache.h>
 #include <linux/rcupdate.h>
+#include <linux/irq.h>
 
 #include <asm/cacheflush.h>
 #include <asm/byteorder.h>
@@ -220,6 +221,40 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+
+/*
+ * Default (weak) implementation for kgdb_roundup_cpus
+ */
+
+static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
+
+void __weak kgdb_call_nmi_hook(void *ignored)
+{
+	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
+}
+
+void __weak kgdb_roundup_cpus(void)
+{
+	call_single_data_t *csd;
+	int this_cpu = get_cpu();
+	int cpu;
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		/* No need to roundup ourselves */
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(kgdb_roundup_csd, cpu);
+		csd->func = kgdb_call_nmi_hook;
+		smp_call_function_single_async(cpu, csd);
+	}
+
+	put_cpu();
+}
+
+#endif
+
 /*
  * Some architectures need cache flushes when we set/clear a
  * breakpoint:
-- 
2.19.1.930.g4563a0d9d0-goog

