Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6BD218C3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oktkWmv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6BD218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gygH73ZVzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 12:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oktkWmv4"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gydB31ByzDqVK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 11:59:56 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id y3so5980896pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wwveNRNxujw5waPLRivwuo1nprTPlYwvMTguQVXk7fA=;
 b=oktkWmv4YfVwBVoI9Nz99QeU2IuUbZ1MMTF6yQNkl93cW6DvKYiqe+efwbqvjl5HjQ
 qLdxPGKFT5jXFN3GKp2y6ie6k8vBIywIGSRkHYc+3txkY2SHU4VeUoDCjCKhhPBohE2s
 J+V3tki9CJ28hKhgljNHmpDmIOdPzXe5PSDljWfHYCsnHl3hv2apoX/Rwm0CvoUM6Mp2
 IHtunfJ/c6d7SiMfZfdFnXIkFlYogmRHGGz7iCk+8FMzkwCDCWcHDVJhhJxayGlZthoB
 y47iTtOOqKOH81PHuSWUZGCRoQJmnbM8jgyhmwhRa850+SHjg6I4MjS53RYQO6FPR3ps
 /WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wwveNRNxujw5waPLRivwuo1nprTPlYwvMTguQVXk7fA=;
 b=beW5h7JgwVk4BddI8oZmkoiDIjg3uNBDEs4HQ1f0xufCeRUYGWdgkCXTSJNtW6WY/I
 FFIdfnwxCUUfnDfkoHIqaCArR/HB2+9rERs23XDPQDaJ272WQSWZYrs06dIY3M/Y4L1t
 91Q5JIXEacAXgZtnHJe1ohMJTPAAGzbhueIC0NR7sD6eI1Tt0D22X1n50EfTYRj+F64O
 UPQuCJvE4nS4DnSsspVlwrsDWC7Flf1MlzvuCN8Qvp4qQdqMxIsSebDcxNhQmZBT0n0m
 PpwS/Ddyzz+GpG/UjlC0Ti45p3OKbIQV2Vs9pz+ZIohyhBFsSoEaq1wVBMagKnnBaIy3
 TiZQ==
X-Gm-Message-State: APjAAAU0JXjFFuZDv3NZwap4xF0nNBH8tzLWpdONSaX7b2Fd2lIDlBlM
 aPtvfWrmgfIKHDvGGlMMmOm1SzBP
X-Google-Smtp-Source: APXvYqzSY30gH97hqiahZJm5JhJ2bXKBbgtUNINquAdJv5IjkcSKOLQubUDH4RF2+YQTrJyW3VZoHQ==
X-Received: by 2002:a62:e518:: with SMTP id n24mr60658208pff.174.1555120792409; 
 Fri, 12 Apr 2019 18:59:52 -0700 (PDT)
Received: from bobo.local0.net (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id
 r76sm48350528pfa.39.2019.04.12.18.59.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Apr 2019 18:59:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/64/ftrace: mprofile-kernel patch out mflr
Date: Sat, 13 Apr 2019 11:59:40 +1000
Message-Id: <20190413015940.31170-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The new mprofile-kernel mcount sequence is

  mflr	r0
  bl	_mcount

Dynamic ftrace patches the branch instruction with a noop, but leaves
the mflr. mflr is executed by the branch unit that can only execute one
per cycle on POWER9 and shared with branches, so it would be nice to
avoid it where possible.

This patch is a hacky proof of concept to nop out the mflr. Can we do
this or are there races or other issues with it?
---
 arch/powerpc/kernel/trace/ftrace.c | 77 +++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 52ee24fd353f..ecc75baef23e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -172,6 +172,19 @@ __ftrace_make_nop(struct module *mod,
 		pr_err("Unexpected instruction %08x around bl _mcount\n", op);
 		return -EINVAL;
 	}
+
+	if (patch_instruction((unsigned int *)ip, pop)) {
+		pr_err("Patching NOP failed.\n");
+		return -EPERM;
+	}
+
+	if (op == PPC_INST_MFLR) {
+		if (patch_instruction((unsigned int *)(ip - 4), pop)) {
+			pr_err("Patching NOP failed.\n");
+			return -EPERM;
+		}
+	}
+
 #else
 	/*
 	 * Our original call site looks like:
@@ -202,13 +215,14 @@ __ftrace_make_nop(struct module *mod,
 		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
 		return -EINVAL;
 	}
-#endif /* CONFIG_MPROFILE_KERNEL */
 
 	if (patch_instruction((unsigned int *)ip, pop)) {
 		pr_err("Patching NOP failed.\n");
 		return -EPERM;
 	}
 
+#endif /* CONFIG_MPROFILE_KERNEL */
+
 	return 0;
 }
 
@@ -421,6 +435,20 @@ static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
 		return -EPERM;
 	}
 
+#ifdef CONFIG_MPROFILE_KERNEL
+	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
+		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
+		return -EFAULT;
+	}
+
+	if (op == PPC_INST_MFLR) {
+		if (patch_instruction((unsigned int *)(ip - 4), PPC_INST_NOP)) {
+			pr_err("Patching NOP failed.\n");
+			return -EPERM;
+		}
+	}
+#endif
+
 	return 0;
 }
 
@@ -437,9 +465,20 @@ int ftrace_make_nop(struct module *mod,
 	 */
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
+		int rc;
+
 		old = ftrace_call_replace(ip, addr, 1);
 		new = PPC_INST_NOP;
-		return ftrace_modify_code(ip, old, new);
+		rc = ftrace_modify_code(ip, old, new);
+		if (rc)
+			return rc;
+#ifdef CONFIG_MPROFILE_KERNEL
+		old = PPC_INST_MFLR;
+		new = PPC_INST_NOP;
+		ftrace_modify_code(ip - 4, old, new);
+		/* old mprofile kernel will error because no mflr */
+#endif
+		return rc;
 	} else if (core_kernel_text(ip))
 		return __ftrace_make_nop_kernel(rec, addr);
 
@@ -562,6 +601,20 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_MPROFILE_KERNEL
+	if (probe_kernel_read(op, (ip - 4), 4)) {
+		pr_err("Fetching instruction at %lx failed.\n", (unsigned long)(ip - 4));
+		return -EFAULT;
+	}
+
+	if (op[0] == PPC_INST_NOP) {
+		if (patch_instruction((ip - 4), PPC_INST_MFLR)) {
+			pr_err("Patching mflr failed.\n");
+			return -EINVAL;
+		}
+	}
+#endif
+
 	if (patch_branch(ip, tramp, BRANCH_SET_LINK)) {
 		pr_err("REL24 out of range!\n");
 		return -EINVAL;
@@ -650,6 +703,20 @@ static int __ftrace_make_call_kernel(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_MPROFILE_KERNEL
+	if (probe_kernel_read(&op, (ip - 4), 4)) {
+		pr_err("Fetching instruction at %lx failed.\n", (unsigned long)(ip - 4));
+		return -EFAULT;
+	}
+
+	if (op == PPC_INST_NOP) {
+		if (patch_instruction((ip - 4), PPC_INST_MFLR)) {
+			pr_err("Patching mflr failed.\n");
+			return -EINVAL;
+		}
+	}
+#endif
+
 	if (patch_branch(ip, tramp, BRANCH_SET_LINK)) {
 		pr_err("Error patching branch to ftrace tramp!\n");
 		return -EINVAL;
@@ -670,6 +737,12 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 */
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
+#ifdef CONFIG_MPROFILE_KERNEL
+		old = PPC_INST_NOP;
+		new = PPC_INST_MFLR;
+		ftrace_modify_code(ip - 4, old, new);
+		/* old mprofile-kernel sequence will error because no nop */
+#endif
 		old = PPC_INST_NOP;
 		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
-- 
2.20.1

