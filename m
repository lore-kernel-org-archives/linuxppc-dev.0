Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD93C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:21:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9075E2064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI1I9Xac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075E2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RN4j4DcdzF3Mb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:21:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kI1I9Xac";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kI1I9Xac"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMw84WcCzF3Jg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:44 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id 193-v6so1016430wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Bsz7BDS1SKX9gHYXcW+7Yci+Ue2vSEITfG0cme0MbDA=;
 b=kI1I9XaciHUjWQntHHKbdAEv8Lm6aYT5IbNk7lfmiPNfZV7PrVjSNpmFq2Jb0VlwbE
 ZuX3XeBgMPpPy+wOgvVxMR/QHwgKKUOYnCADUKvUpr9aZKOY7+D76TJkI/VCLKkKNez8
 +gmvc8uxFGNprC67bkbat2uDXwlxiRbel6D0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Bsz7BDS1SKX9gHYXcW+7Yci+Ue2vSEITfG0cme0MbDA=;
 b=udixxlwdj7tXsfDGWP5/7YmxCRy7ZpHikxbZa90nvFv+GsnRs/cwJbEB+/22Mb0Wxd
 oUDlRGJboMMtvAU8B6FY5vE/hKr6BnFqccfpM74DyeYTiB8IhYAnHDxskM5izX3AD4RR
 1LwnSW6OvXzCxzvXg67NqTcxKHsnNwQ+hgRRU1CDpA0F2slFFxol9K9QnW8HyrJw5UTc
 XX4FH+N6bL9JASPTHHeo4qM+9MboUvpZE+y6orX1kSadId5otHanJZ9aBnT03Na8+7Nt
 22YkJHoxfp0CWrL61znJwnyiN0eVbCMCrXmGiXnhVX2ZaiPq6zrSQM5lcgg/xGDIR1rF
 Jz7w==
X-Gm-Message-State: ABuFfoi14XRs0JMg5Fv4+lb9EnB9x2S6CCOmbqI5CiLpy+50u5tXaWsf
 snt9K6x8KzjkGWYzItjWIYzR0w==
X-Google-Smtp-Source: ACcGV62etp+lM1HN/t1sYejJBWMbHx2UjdBHB+cI2jGegnJnCQHI4XozZ0fBzC1R8f1Ib4p8VBAR+g==
X-Received: by 2002:a1c:14d1:: with SMTP id
 200-v6mr7367930wmu.106.1538727221719; 
 Fri, 05 Oct 2018 01:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:40 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/9] arm64: kernel: add arch support for patchable
 function pointers
Date: Fri,  5 Oct 2018 10:13:26 +0200
Message-Id: <20181005081333.15018-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implement arm64 support for patchable function pointers by emitting
them as branch instructions (and a couple of NOPs in case the new
target is out of range of a normal branch instruction.)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/ffp.h | 35 ++++++++++++++++++++
 arch/arm64/kernel/insn.c     | 22 ++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..db8c9e51c56d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -102,6 +102,7 @@ config ARM64
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_FFP
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
diff --git a/arch/arm64/include/asm/ffp.h b/arch/arm64/include/asm/ffp.h
new file mode 100644
index 000000000000..678dc1262218
--- /dev/null
+++ b/arch/arm64/include/asm/ffp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_FFP_H
+#define __ASM_FFP_H
+
+struct ffp {
+	u32	insn[5];
+	u32	def_branch;
+};
+
+#define DECLARE_FFP(_fn, _def)						\
+	extern typeof(_def) _fn;					\
+	extern struct ffp const __ffp_ ## _fn
+
+#define DEFINE_FFP(_fn, _def)						\
+	DECLARE_FFP(_fn, _def);						\
+	asm("	.pushsection	\".text\", \"ax\", %progbits	\n"	\
+	    "	.align		3				\n"	\
+	    "	.globl		" #_fn "			\n"	\
+	    "	.globl		__ffp_" #_fn "			\n"	\
+	    #_fn " :						\n"	\
+	    "__ffp_" #_fn " :					\n"	\
+	    "		b	" #_def "			\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		nop					\n"	\
+	    "		b	" #_def "			\n"	\
+	    "	.popsection					\n");	\
+	EXPORT_SYMBOL(__ffp_ ## _fn)
+
+extern void ffp_set_target(const struct ffp *m, void *new_fn);
+extern void ffp_reset_target(const struct ffp *m);
+
+#endif
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 2b3413549734..a2ed547fd171 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -30,6 +30,7 @@
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
 #include <asm/fixmap.h>
+#include <asm/ffp.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
 
@@ -1603,3 +1604,24 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
+
+void ffp_set_target(const struct ffp *m, void *new_fn)
+{
+	u32 branch = aarch64_insn_gen_branch_imm((u64)m, (u64)new_fn,
+						 AARCH64_INSN_BRANCH_NOLINK);
+
+	if (branch == AARCH64_BREAK_FAULT) {
+		/* TODO out of range - use a PLT sequence instead */
+	} else {
+		aarch64_insn_patch_text((void *[]){ (void *)m }, &branch, 1);
+	}
+}
+EXPORT_SYMBOL(ffp_set_target);
+
+void ffp_reset_target(const struct ffp *m)
+{
+	u32 branch = le32_to_cpu(m->def_branch);
+
+	aarch64_insn_patch_text((void *[]){ (void *)m }, &branch, 1);
+}
+EXPORT_SYMBOL(ffp_reset_target);
-- 
2.11.0

