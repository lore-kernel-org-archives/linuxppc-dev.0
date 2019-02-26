Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FFC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:54:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA2E2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2IkJh/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2E2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447t0v3RJ4zDqV8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:54:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2IkJh/C"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sxB6gbyzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:51:26 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id d25so5899511pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9RiWTkkAYduX2IpkAdj2MO/14l5OaPZQyH+cGdRbUXQ=;
 b=M2IkJh/CQsk7cYqdcm02DaPKMjlVtuJvE5dekzRGMJqV5H47LJRe86Fja9sVn5o2Rm
 gG/dMquFhXD2jSttjh7/pqqeLv+RPmIYPDLo1e6M23YXlP7xDdvsY3zkgTVR++S5KHwM
 r4SEVl/XcCWgemE3ilCAY9cJixQezJqf1SFpIdfa+VccOIZpKWjVrIvw7yRu4evbMeU9
 4WgwPnH4wlND1KE3A1Jfl6dIN0Fu5u4fIcz/0kZ4HK/ws27WqS6BlDGxONFiuZW13zlI
 NWtcODt2o4zTUjngsHF2WOxRhxXeRuu1zhNptXLaO2L+LTjMauKZ7kKrc6Lj49q50ADP
 Qbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9RiWTkkAYduX2IpkAdj2MO/14l5OaPZQyH+cGdRbUXQ=;
 b=t3aRYUC93s97K9cWq9hFP/zJOjOiTeQg461+RxMHqXg2FZ7feLqZzbXBUwBa+KB5Rn
 uHdonSjhSReWcEeSFf4O3s3Uz8QoXrIvE4mr9J40O/n8KqA5XHP6+EIE/7+rA6G30VEk
 qYrw34H8iZ9sVK2WkyOjMb1DDafS6jEGDowvQo3CS9sqW1AMjxPy0+IkhEX6kw5bjPLy
 M5HiCH9mzkM4g5CsGXGGW1rZXXcBurind6sUPl2irvBl5GeZcgnVA3ST1qxxbu6UHyty
 Hgs9UqANN0UWji05zZDqa4mpPsOvBXHpyjhg3NhaGsPbmOeSQX7XS4jmDx+y7vksYDiA
 iM7Q==
X-Gm-Message-State: AHQUAuawd+UyHBfOsxFUtZU3uDNu3ocV60H8pce+fxCleL5Fw+TkokQn
 Wn4nueiDj8DyBXqY9/ePRVcjoATb
X-Google-Smtp-Source: AHgI3IZh6WUbSvusuEafIODZPFw8poxF2oDpuyxssAABjTCvKwc6jlYfQbbAoioWL/Y5AZ1+jNqRLQ==
X-Received: by 2002:a63:2224:: with SMTP id i36mr23204152pgi.169.1551171084095; 
 Tue, 26 Feb 2019 00:51:24 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id t10sm29217103pfa.151.2019.02.26.00.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:51:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/4] powerpc/64s: Fix HV NMI vs HV interrupt recoverability
 test
Date: Tue, 26 Feb 2019 18:51:07 +1000
Message-Id: <20190226085110.29653-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226085110.29653-1-npiggin@gmail.com>
References: <20190226085110.29653-1-npiggin@gmail.com>
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

HV interrupts that use HSRR registers do not enter with MSR[RI] clear,
but their entry code is not recoverable vs NMI, due to shared use of
HSPRG1 as a scratch register to save r13.

This means that a system reset or machine check that hits in HSRR
interrupt entry can cause r13 to be silently corrupted.

Fix this by marking NMIs non-recoverable if they land in HV interrupt
ranges.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |  8 +++
 arch/powerpc/include/asm/nmi.h            |  2 +
 arch/powerpc/kernel/exceptions-64s.S      |  8 +++
 arch/powerpc/kernel/mce.c                 |  3 ++
 arch/powerpc/kernel/traps.c               | 66 +++++++++++++++++++++++
 5 files changed, 87 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 1d911f68a23b..0f8326644fa4 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -51,6 +51,14 @@ int exit_vmx_usercopy(void);
 int enter_vmx_ops(void);
 void *exit_vmx_ops(void *dest);
 
+/* Exceptions */
+#ifdef CONFIG_PPC_POWERNV
+extern unsigned long real_trampolines_start;
+extern unsigned long real_trampolines_end;
+extern unsigned long virt_trampolines_start;
+extern unsigned long virt_trampolines_end;
+#endif
+
 /* Traps */
 long machine_check_early(struct pt_regs *regs);
 long hmi_exception_realmode(struct pt_regs *regs);
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
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..d2e9fc968655 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -68,6 +68,14 @@ OPEN_FIXED_SECTION(real_vectors,        0x0100, 0x1900)
 OPEN_FIXED_SECTION(real_trampolines,    0x1900, 0x4000)
 OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x5900)
 OPEN_FIXED_SECTION(virt_trampolines,    0x5900, 0x7000)
+
+#ifdef CONFIG_PPC_POWERNV
+	.globl real_trampolines_start
+	.globl real_trampolines_end
+	.globl virt_trampolines_start
+	.globl virt_trampolines_end
+#endif
+
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
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
index 64936b60d521..12b54908c15d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -376,6 +376,70 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	force_sig_fault(signr, code, (void __user *)addr, current);
 }
 
+/*
+ * The interrupt architecture has a quirk in that the HV interrupts excluding
+ * the NMIs (0x100 and 0x200) do not clear MSR[RI] at entry. The first thing
+ * that an interrupt handler must do is save off a GPR into a scratch register,
+ * and all interrupts on POWERNV (HV=1) use the HSPRG1 register as scratch.
+ * Therefore an NMI can clobber an HV interrupt's live HSPRG1 without noticing
+ * that it is non-reentrant, which leads to random data corruption.
+ *
+ * The solution is for NMI interrupts in HV mode to check if they originated
+ * from these critical HV interrupt regions. If so, then mark them not
+ * recoverable.
+ *
+ * An alternative would be for HV NMIs to use SPRG for scratch to avoid the
+ * HSPRG1 clobber, however this would cause guest SPRG to be clobbered. Linux
+ * guests should always have MSR[RI]=0 when its scratch SPRG is in use, so
+ * that would work. However any other guest OS that may have the SPRG live
+ * and MSR[RI]=1 could encounter silent corruption.
+ *
+ * Builds that do not support KVM could take this second option to increase
+ * the recoverability of NMIs.
+ */
+void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
+{
+#ifdef CONFIG_PPC_POWERNV
+	unsigned long kbase = (unsigned long)_stext;
+	unsigned long nip = regs->nip;
+
+	if (!(regs->msr & MSR_RI))
+		return;
+	if (!(regs->msr & MSR_HV))
+		return;
+	if (regs->msr & MSR_PR)
+		return;
+
+	/*
+	 * Now test if the interrupt has hit a range that may be using
+	 * HSPRG1 without having RI=0 (i.e., an HSRR interrupt). The
+	 * problem ranges all run un-relocated. Test real and virt modes
+	 * at the same time by droping the high bit of the nip (virt mode
+	 * entry points still have the +0x4000 offset).
+	 */
+	nip &= ~0xc000000000000000ULL;
+	if ((nip >= 0x500 && nip < 0x600) || (nip >= 0x4500 && nip < 0x4600))
+		goto nonrecoverable;
+	if ((nip >= 0x980 && nip < 0xa00) || (nip >= 0x4980 && nip < 0x4a00))
+		goto nonrecoverable;
+	if ((nip >= 0xe00 && nip < 0xec0) || (nip >= 0x4e00 && nip < 0x4ec0))
+		goto nonrecoverable;
+	if ((nip >= 0xf80 && nip < 0xfa0) || (nip >= 0x4f80 && nip < 0x4fa0))
+		goto nonrecoverable;
+	/* Trampoline code runs un-relocated so subtract kbase. */
+	if (nip >= real_trampolines_start - kbase &&
+			nip < real_trampolines_end - kbase)
+		goto nonrecoverable;
+	if (nip >= virt_trampolines_start - kbase &&
+			nip < virt_trampolines_end - kbase)
+		goto nonrecoverable;
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
@@ -386,6 +450,8 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_enter();
 
+	hv_nmi_check_nonrecoverable(regs);
+
 	__this_cpu_inc(irq_stat.sreset_irqs);
 
 	/* See if any machine dependent calls */
-- 
2.18.0

