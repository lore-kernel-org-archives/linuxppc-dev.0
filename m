Return-Path: <linuxppc-dev+bounces-20161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A9FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42sk1GQ0z2yLG;
	Mon, 27 Apr 2026 22:28:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292906;
	cv=none; b=B7onFnRh0MRjNEL7jjttL3NMkqU7CGBAtAO1CeIS4CLc1Z+2WjTFA1cxDoI9lk0ieII3Cvqeerkx/4/WAx44cnz6XVudOQO+w3bRHpXhxnJgYwNT3kJnj763W0CEdCckbEaJmOZ8ODgyG5ZdNwXDYLCNKjnlfflGNBPZvPAvs6GE2qEOCXE4QaQS9WWIeCTJvsNMzACgY4EnlkfL9edL9GdE7lfKJg2ZgtEkaOKlKMuTT+ZJK97hhEAqMZDOR6tiGroYEgTdLnXA9gumSynEL4CxvbItMsQtYUr+0hdHvhV7gPl8+swm5ffP0mQ0Qw6sFnwVL6SKMlZDSDbhcyWhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292906; c=relaxed/relaxed;
	bh=F7kNDm/BPqOqbkHNlgIl8EcDdI8YLcc/3k2ekG2vBcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tkavg5oYZ2wpW7zYkC9tFbiZrlpFs8rV+cBWlaB/bi6q9HIG1FXaAQK3Xgdf831Pd2G7d9Gdy34n4nnlaNVO/6wd/3713dq2D0qnzr8yJ7eD8epc5Rn7XDo4XOfPcUXRdHnAPMQ8jyCgz8Z33LFpyGOcbTAkL1Mp5LWCDFex5O9g7mD8wMlV5dkvyllq9arjuOf6SDx5A7eKaOPAsyeU1FDNXx+BWOsXif7XcjaFB677EwiTbrWDZu1LksT0XrcUzOe+WWUM/YhbvrFEqyznv3k68K/Zzjj3oxrnv6VxCzMgpPm6/LDymWrzLTG1lHTUx/Wm5d/qo3UuUpCd6shDXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXzewFYi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXzewFYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42sj2cqSz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:28:25 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4205120b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292903; x=1777897703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7kNDm/BPqOqbkHNlgIl8EcDdI8YLcc/3k2ekG2vBcE=;
        b=BXzewFYiWWlV8TJf83NkV31MYVwa7muha6BHJ9ujtP3d/a7iFSO+NebrfXA5LoiYsi
         6NoGSYVEuEazrxpLbw1jYpyKeNHtBENAekfzaz3fcOMehuW1nC1v06rGxGUvl8NXg9LD
         /zPE0meSgV7o2csG9gNM/J9LaOnen8jCNsJZopKUsPoAw1jje8S5Iw+HiEzavueP9jjs
         WDh8NuY5Ft/CdfwtuO/jOA/var7Ic1Pp85U6bMTlvQc8L88KV3XMi3we0IkzBv9PQrUw
         ntgbEkP8ftdJuIuKGvla1WOdIuPPEKWr+AfxHLpolftFnCyl6Sit4aMkrk/cUFZbFEDh
         3kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292903; x=1777897703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7kNDm/BPqOqbkHNlgIl8EcDdI8YLcc/3k2ekG2vBcE=;
        b=Gl0jWF3UnViolJNNxpR/ar5Jc9XoQDRFvGdU0U76/uNmjlECl6V8Kc/VEMd2Yll+dc
         S/2aljGCsG/EJTCVdLOLgkvEb3wBw8SBu2aHAuNbuHtiIu2TIZE+mZQtetSGc4rTljRw
         sT+q7lYqvIsjsiXUci0cvi0JI2fvkb3WYWdxscGnxeTBdztNDmhhO2AR6/kW0csTb+CI
         nCmBxB2EDJ9zAve1vD9VIWlP6jb+yeXLfJSWvfTnGf/Vn4zBFoiOyeBnJwteheZ5hYac
         oVvJm72g1jyziTb/GorVAt02O6phi0AKBU2EcGfQNgNbb1/2eMPtgK5glklHebxUVMxd
         yR3A==
X-Forwarded-Encrypted: i=1; AFNElJ91YIU1QBYkRPPO6fmcB8InG8ogBNzyLkZqjmN6g+VW1Ag4bbgES4kGL3zhNp5oJq8IYbvXlJpTtTcQUBI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzWqGCTt8pXua7rBmh0IoAuiBjVE+X8HSAPtJ9cldrgfh0yoqA
	18FSegcQ7U+Nk5BzYGeXW6Eq7vN6L7mFlAvEDTKYqmjm5qnlyYxXmSn7
X-Gm-Gg: AeBDiet+lDb0EfjWFFFfQ/S4eMNtTCeI+zdGn6HVcLzYII50F1bcR0d8QFuVjLyoQXu
	6N1fv5sFCdQNoyev0/A3TRH2mge1ztLovSAw1Yi0Exis1s90KF9Wk/XFPRu3bgKlrxxgE2FAk6i
	cMnh5T86EXv7YJx9q3Ttkqm6smoPZFAhnGqND5bTEZMHXINzDyrWQT6Z7/LRqSeKgH+MRs2HGGa
	AsAWHcohuPWYdqtHAjWJeGr2DV4PHKPujacJufNVJb2pJoObMa+ejc3PTpDkQQcB6zBXm1/kOOj
	1Glc0s475NJv1VgyVSMe4rEJj5g48aRLWKABgEET9QOZ14R3mQP9SBnPZ3LLNJamJWwYuhP5McF
	LM9ovj1dan135OjZRY/UNKOdiVqZf2cuLCjpv0uDaNWwSTu58noEqWDtPOBwFirEn2whaKlW0nK
	F9McF5uQvXO8s3m9NuowpKQQKFY5Rzu1cqMy2uOgSROraKslBt21WANMpPNw/HNs5qEW23FSj9G
	KPDWQ==
X-Received: by 2002:a05:6a00:c8f:b0:82c:26a4:df02 with SMTP id d2e1a72fcca58-82f8c9bad60mr45450220b3a.42.1777292903159;
        Mon, 27 Apr 2026 05:28:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:28:22 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Samir M <samir@linux.ibm.com>,
	David Gow <davidgow@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5 2/8] powerpc: Prepare to build with generic entry/exit framework
Date: Mon, 27 Apr 2026 17:57:36 +0530
Message-ID: <20260427122742.210074-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

This patch introduces preparatory changes needed to support building
PowerPC with the generic entry/exit (irqentry) framework.

The following infrastructure updates are added:
 - Add a syscall_work field to struct thread_info to hold SYSCALL_WORK_* flags.
 - Provide a stub implementation of arch_syscall_is_vdso_sigreturn(),
   returning false for now.
 - Introduce on_thread_stack() helper to detect if the current stack pointer
   lies within the task’s kernel stack.

These additions enable later integration with the generic entry/exit
infrastructure while keeping existing PowerPC behavior unchanged.

No functional change is intended in this patch.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/entry-common.h | 8 ++++++++
 arch/powerpc/include/asm/stacktrace.h   | 6 ++++++
 arch/powerpc/include/asm/syscall.h      | 5 +++++
 arch/powerpc/include/asm/thread_info.h  | 1 +
 4 files changed, 20 insertions(+)
 create mode 100644 arch/powerpc/include/asm/entry-common.h

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
new file mode 100644
index 000000000000..05ce0583b600
--- /dev/null
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_PPC_ENTRY_COMMON_H
+#define _ASM_PPC_ENTRY_COMMON_H
+
+#include <asm/stacktrace.h>
+
+#endif /* _ASM_PPC_ENTRY_COMMON_H */
diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
index 6149b53b3bc8..987f2e996262 100644
--- a/arch/powerpc/include/asm/stacktrace.h
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -10,4 +10,10 @@
 
 void show_user_instructions(struct pt_regs *regs);
 
+static __always_inline bool on_thread_stack(void)
+{
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer)
+			& ~(THREAD_SIZE - 1));
+}
+
 #endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 4b3c52ed6e9d..834fcc4f7b54 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -139,4 +139,9 @@ static inline int syscall_get_arch(struct task_struct *task)
 	else
 		return AUDIT_ARCH_PPC64;
 }
+
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
 #endif	/* _ASM_SYSCALL_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 97f35f9b1a96..ee3b9adb5b67 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -57,6 +57,7 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
+	unsigned long	syscall_work;		/* SYSCALL_WORK_ flags */
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH_64
 	unsigned long *livepatch_sp;
-- 
2.53.0


