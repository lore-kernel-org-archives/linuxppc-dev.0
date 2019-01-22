Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A8C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568FB20861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APz9f3kH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568FB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kJtz3MNvzDqJ1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 17:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="APz9f3kH"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kJqD2TThzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 17:46:32 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id z9so11293460pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GACnOcTq6UBcCOxBWk8lBl/9NIcSndIx9BCZr1LyEms=;
 b=APz9f3kHdnWOYFWw0zwqOlGdafuS0Z1t8tH9kOP1oLn/Ap9tOBQs+Lp15BLXgsBCxw
 443FqLLTsmMzrr2s94w2cxYAL6X5XYgowRZDoVfkljuZTyT42WmmWHkn/h5p+zSyHCH3
 yXbAlhn8aZLpdgQq2XEaw3TmEqt83/LtuhXLTpOxaCg3qiVQD2WJrlPPMXCDfGc1iWns
 SWsZ65sn3zb5TBKlbWaa039dV3AaCMiH1PHf2XbJZzc/ZxPHyTi0MLPjvT7coSBGCxvI
 pztvPBLPA9fBjoB3ZUkENq6LQfD4hiVX8Wsdod8fASv8kJdhFfO4B2Knw3wmgvKENKb2
 4B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GACnOcTq6UBcCOxBWk8lBl/9NIcSndIx9BCZr1LyEms=;
 b=YZr1CxLEZetwp+UMuFyU85jDxxOWExeT3rgwScYaLd7L1tDwjFQqAT5t18s0tD3Ap9
 WjuBlDaKXMop12h8f9uVZ+pc+kBM0BJvMNoUguP4BBhJzSgAEL46Jkzb1jodbAlb4BAw
 QcLXw9C17ic2QOwnag6CJCntDFlyxLQAczMo9dek/LC+G4C+eqEqDeMHXJV4cNePPzas
 6XMtHSOXyWU2u34D0zcwU9vBd9kQ32QeII8xhTzLJEHldtJ+0upaAQBgN4XEKdgV52Dl
 ZGIk8lrGKJ1vCvFS7yQ4EGsT1xW7+1z5lLNwOPvmReDf7gNeVVJxqIWdIae8bnzFweTx
 /xpQ==
X-Gm-Message-State: AJcUukf8fKSPlCvqEnTLYIVMYh10BYSQp6sKGwSBdDjxiEIr1biHlkDQ
 CoRxcAqFolMSscicUE9QEcDEUq3y
X-Google-Smtp-Source: ALg8bN5I0WavsxEgudoHs5EOOzqYUY3BUtcYKXwEREosQO8YuTqwW9YkiJViXCqV6mu2Mzb58F8t1Q==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr26701043pfk.144.1548139590227; 
 Mon, 21 Jan 2019 22:46:30 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
 by smtp.gmail.com with ESMTPSA id v15sm18341830pfn.94.2019.01.21.22.46.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 22:46:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/64s: Fix HV NMI vs HV interrupt recoverability
 test
Date: Tue, 22 Jan 2019 16:46:15 +1000
Message-Id: <20190122064618.1510-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122064618.1510-1-npiggin@gmail.com>
References: <20190122064618.1510-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

HV interrupts that use HSRR registers do not clear MSR[RI], but
NMI entry code is not recoverable early on due to both using HSPRG
for a scratch register.

This bug means that a system reset or machine check can cause silent
data corruption (due to loss of r13 register) if it hits in a small
window when taking an HV interrupt.

Fix this by marking NMIs non-recoverable if they land in HV interrupt
ranges.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/nmi.h |  2 ++
 arch/powerpc/kernel/mce.c      |  3 ++
 arch/powerpc/kernel/traps.c    | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index bd9ba8defd72..84b4cfe73edd 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -14,4 +14,6 @@ extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
+extern void hv_nmi_check_nonrecoverable(struct pt_regs *regs);
+
 #endif /* _ASM_NMI_H */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index bd933a75f0bc..d653b5de4537 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -31,6 +31,7 @@
 
 #include <asm/machdep.h>
 #include <asm/mce.h>
+#include <asm/nmi.h>
 
 static DEFINE_PER_CPU(int, mce_nest_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
@@ -488,6 +489,8 @@ long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 
+	hv_nmi_check_nonrecoverable(regs);
+
 	/*
 	 * See if platform is capable of handling machine check.
 	 */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 64936b60d521..b429b2264a1f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -376,6 +376,66 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	force_sig_fault(signr, code, (void __user *)addr, current);
 }
 
+/*
+ * The interrupt architecture has a quirk in that the HV interrupts excluding
+ * the NMIs (0x100 and 0x200) do not clear MSR[RI] at entry. The first thing
+ * that an interrupt handler must do is save off a GPR into a scratch register,
+ * and all interrupts on POWERNV (HV=1) use the same HSPRG register as scratch.
+ * Therefore an NMI can clobber an HV interrupt's live HSPRG without noticing
+ * that it is non-reentrant, which leads to random data corruption.
+ *
+ * The solution is for NMI interrupts in HV mode to check if they originated
+ * from these critical HV interrupt regions. If so, then mark them not
+ * recoverable.
+ *
+ * An alternative would be for HV NMIs to use SPRG for scratch to avoid the
+ * HSPRG clobber, however this would cause guest SPRG to be clobbered. Linux
+ * guests should always have MSR[RI]=0 when its scratch SPRG is in use, so
+ * that would work. However any other guest OS that may have the SPRG live
+ * and MSR[RI]=1 could encounter silent corruption.
+ *
+ * Builds that do not support KVM could take this second option to increase
+ * the recoverability of NMIs.
+ */
+void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
+{
+#ifdef CONFIG_POWERNV
+	unsigned long kbase = (unsigned long)_stext;
+	unsigned long nip = regs->nip;
+
+	if (!(regs->msr & MSR_RI))
+		return;
+	if (!(regs->msr & MSR_HV))
+		return;
+	if (regs->msr & MSR_PR)
+		return;
+again:
+	if (nip >= 0x500 && nip < 0x600)
+		goto nonrecoverable;
+	if (nip >= 0x980 && nip < 0xa00)
+		goto nonrecoverable;
+	if (nip >= 0xe00 && nip < 0xec0)
+		goto nonrecoverable;
+	if (nip >= 0xf80 && nip < 0xfa0)
+		goto nonrecoverable;
+	/* Trampolines are not relocated. */
+	if (nip >= real_trampolines_start - kbase &&
+			nip < real_trampolines_end - kbase)
+		goto nonrecoverable;
+	if (nip >= virt_trampolines_start - kbase &&
+			nip < virt_trampolines_end - kbase)
+		goto nonrecoverable;
+	if (nip >= 0xc000000000000000ULL) {
+		nip -= 0xc000000000000000ULL;
+		goto again;
+	}
+	return;
+
+nonrecoverable:
+	regs->msr &= ~MSR_RI;
+#endif
+}
+
 void system_reset_exception(struct pt_regs *regs)
 {
 	/*
@@ -386,6 +446,8 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_enter();
 
+	hv_nmi_check_nonrecoverable(regs);
+
 	__this_cpu_inc(irq_stat.sreset_irqs);
 
 	/* See if any machine dependent calls */
-- 
2.18.0

