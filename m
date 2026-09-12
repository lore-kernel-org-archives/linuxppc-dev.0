Return-Path: <linuxppc-dev+bounces-27168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB950C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:59:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhj2b170rz2ynZ;
	Sat, 12 Sep 2026 16:59:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::17"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789196375;
	cv=none; b=cT/KQ2gBdopAcP5r86w+Iu51t0W9763DYUpn+NJtSTAcWw/5ObLTfRmiC6/Jlgd1ZKoU9s7xr84jbQ/DxVA9IBLGTYcsvJ1fgkzdrdT18UhJ+eJhVf2rZ4jBrXfkAIoX0ezqvjmXLyVf+LF0uSvDId52jf5hOopMET9Yf/ReauQCkpVSkqhfHgecl1R55hu5M0fVU435LagmqzRaCVHF6L7KJKroAh8/BmDDK7NiK4dDwFRhlg8REqlitExapuXa5nmgvsuImC1L4lYs2Jr9Gy8z/k6Oz8vATeYLb4Pbs6cxiMcC5HBBhBseKXHkC5rfNlhU+iVO4bkpNqQQ3l+TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789196375; c=relaxed/relaxed;
	bh=G3JbySDrX7Qe3HLCVmAQbpZ/Bcq5FNjxxg9MbzFzoSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm9bykUZNuYDKWN1nc+TfzG/QeKpkX0dhG3sRf7DmRu41IVIS6Fg7k5LQ+edZ+LS9Q2g1I6eOaxaNP7kg6BeU6vpufPb8cUBsKFlU4TNV0FPBDjJFjD6X/UxSQjjwHlVl3ArpKNTrs9bCLN/R2kJKL31hI5sthwxZjxFk/xWzbY5mbpCG20/yahPGw+SnekcdUPB9GwNs507xaH9TFhhw1J55ZSg3zOpHMkREzxPDosQ8zW0WgcayUmxnnyiNlw/3YgUTCj1KG9iyVyjTwHTuWvl9kBCWID6tVmgBqHoyO4vFUnBiHlSWZp4StsfUrgTaGYojyloPOZTYJ+R0FbmGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nVTB+iPx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::17; helo=mail-pz2-x17.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nVTB+iPx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::17; helo=mail-pz2-x17.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x17.google.com (mail-pz2-x17.google.com [IPv6:2607:f8b0:4864:3b::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhj2Z3R7Fz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 16:59:34 +1000 (AEST)
Received: by mail-pz2-x17.google.com with SMTP id 41be03b00d2f7-cc1cea48edcso217484a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789196372; x=1789801172; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3JbySDrX7Qe3HLCVmAQbpZ/Bcq5FNjxxg9MbzFzoSM=;
        b=nVTB+iPxWZ2e/fbk2svBS4qNfVMPlVgL+giNqvIAFyQeXPLQuqdso62rUZ94JZClar
         tnPWePIVQe1uinjOYPlzvDLe886WKqDbyCuCRjcXnc5KZ8jPDXBBuE12cqhmN45Qn2Tm
         632ZZMrBbXQDMUD0+1Ov9onnsjdgSvw/f0QC3I3v/N+i0Qsl81tnl6q7rNUYM8FHqiNL
         SqAtiiwttiMjR5lWU8mbh7HhKajUHRTF2r1mxPMvFkTIqnXIeZ591GWF/NVCATi+3U6d
         6gR/av9Oi61WeU9ure0H+odBsS1/nyvJBjgU6bWaAgcA7jiHs4kJWt+AtZvIf/CpTHQ8
         i5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789196372; x=1789801172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3JbySDrX7Qe3HLCVmAQbpZ/Bcq5FNjxxg9MbzFzoSM=;
        b=AE9fN6xeot73sFExD1vF2Cs04MjE82OCQ6EL9JP6qwOeNvZOpGEThkyO9g+M36jdtM
         uVUv5IJQMs1DtF3jUh0OevXufFFr2QMYaU4nNpXTV0knYMFM/F0ZFhlMf8Dni140bKDE
         D3EsNGV8gqcHburBsoL0DraYbwB7O0AV4+gfGK3lF4CsPE/FUl4VBKbd66rbzOm3Qydn
         lWrGAS14Ic7ckHq9jmJ/YE/ujn1VDfQVhQgEKUDO5BB7ALF4kJsFnZdAwYgZZkHeBkSj
         Dd1y1f8KQ4C5lBxmADeW+YYfWjCz+MVuEqGxCrjXIt7Osd/WRnzWi+KRoQm21G4dhGx1
         cU4A==
X-Forwarded-Encrypted: i=1; AKwUvBxOP3EvFaiOLZPMvGnEaZKCPdTxkfAkqj1LiD1hDyIGQdJf+JzK59zo46rgjlJAjM43Qz05VESMJ6Z1wZE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n8xpMi2D4fqwSnTK9v07Bjut/0Mc11KFNSlB/dL5a1yfeDZG8O
	T0ifk47bXLU6AXQCNS1HOKZEzE56sH8ZJ6u8Qs2yfgWc20JHlAlniAD5
X-Gm-Gg: AYBFou0RrIWg7mz/A3zOpA1jhzLo/OkrdhqsMAiN7unLlGnU23S+yjqJJscMzsEtXe+
	as3twsCroBdZtqOiRXqV2it1b/jCTwuDNYPm8W4WO82a5RoIspM6fs6juFt2xj4nMqevvT7CoQ3
	CLAoTLo1EDhGtCV9fF0MflEN0kuV8SL4+m3a+jhSdyg5syJ83XWiwuJurmylUXwu5PLD5dgTcOk
	sW+svouZxv8Kn2blva2JP1lMWhH/hTkmlSapd3gOv+eM186yOPHWM9dCdcaXlk+eKlAKCjxHqXV
	dF5LYnAUgVsLPDgKFbGjYeTczib/ZCAxrfypAqxHKpe4J0sYnL6Xxf5HWkCd77qlBEw4Vq0Iac3
	nG2lS+2ZMnfQ7+cLhSb15EYZBtbDWnEMkJe6b9WfkKoPqncD7glTggv/+QtK63ncE2ScHcrMeYs
	Bzb0vNKE8vr51v9JIyRIeI4C195C8/RKdY45qeU8hCFpELaVXtXWiV917czkDlPJqjR0NzR1IGp
	cUH6cgXRnmnAC+tij3CFS9Axh5+rH2jkICN7NF1XMJ8QQ==
X-Received: by 2002:a05:6a20:cc8e:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3db0e40edbamr3056849637.17.1789196372133;
        Fri, 11 Sep 2026 23:59:32 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm10777777c88.8.2026.09.11.23.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 23:59:31 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	mkchauras@gmail.com,
	ynorov@nvidia.com,
	ecourtney@nvidia.com,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Cc: FUJITA Tomonori <tomo@flapping.org>
Subject: [PATCH v4 1/2] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Sat, 12 Sep 2026 12:29:01 +0530
Message-ID: <20260912065902.24017-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065902.24017-1-mkchauras@gmail.com>
References: <20260912065902.24017-1-mkchauras@gmail.com>
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
Content-Transfer-Encoding: 8bit

The Rust kernel infrastructure generates inline asm for WARN() via
ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
arch-specific asm template string for use in Rust's core::arch macros.

powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
Rust builds to fail on powerpc with
```
error: no rules expected `ARCH_WARN_ASM`
   --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
    |
  1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
    |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
    |
   ::: ../rust/kernel/lib.rs:279:1
    |
279 | macro_rules! concat_literals {
    | ---------------------------- when calling this macro
    |
    = note: while trying to match sequence start

error: no rules expected `ARCH_WARN_REACHABLE`
   --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
    |
  1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
    |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
    |
   ::: ../rust/kernel/lib.rs:279:1
    |
279 | macro_rules! concat_literals {
    | ---------------------------- when calling this macro
    |
    = note: while trying to match sequence start

error: aborting due to 2 previous errors
```

To add ARCH_WARN_ASM, _EMIT_BUG_ENTRY first needs to be refactored.
The old definition was a bare macro with no parameters, relying on
positional asm operand references (%0-%3), hardcoding the backward
reference to local label 1b, and including .org/.previous directives
inline. That made it impossible to compose as a plain string outside of
an asm operand context, and left an invisible contract that callers must
always emit their trap at label 1:.

Refactor _EMIT_BUG_ENTRY to take explicit (label, file, line, flags)
string arguments via string concatenation. This removes the dependency
on asm operand numbering and makes the trap label an explicit argument,
so the caller's intent is visible at the call site and a future caller
using a different label cannot silently produce a wrong bug table entry.

Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
as an asm operand while ARCH_WARN_ASM can supply its own size string
independently.

Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
convention, indicating that no additional reachability annotation is
needed after a WARN on powerpc.

This brings powerpc into line with x86, arm64, s390, and riscv, all of
which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.

Reported-by: FUJITA Tomonori <tomo@flapping.org>
Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
Fixes: 73b741adb264 ("rust: Add PowerPC support")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 0db48977c70c..6f0f652d9348 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -32,34 +32,38 @@
 #endif /* verbose */
 
 #else /* !__ASSEMBLER__ */
-/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
-   sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _EMIT_BUG_ENTRY				\
-	".section __bug_table,\"aw\"\n"		\
-	"2:	.4byte 1b - .\n"		\
-	"	.4byte %0 - .\n"		\
-	"	.short %1, %2\n"		\
-	".org 2b+%3\n"				\
-	".previous\n"
+#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
+	".section __bug_table,\"aw\"\n"			\
+	"2:	.4byte " #label " - .\n"		\
+	"	.4byte " file " - .\n"			\
+	"	.short " line ", " flags "\n"
 #else
-#define _EMIT_BUG_ENTRY				\
-	".section __bug_table,\"aw\"\n"		\
-	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
-	".previous\n"
+#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
+	".section __bug_table,\"aw\"\n"			\
+	"2:	.4byte " #label " - .\n"		\
+	"	.short " flags "\n"
 #endif
 
 #define BUG_ENTRY(cond_str, insn, flags, ...)		\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
-		_EMIT_BUG_ENTRY				\
+		_EMIT_BUG_ENTRY(1b, "%0", "%1", "%2")	\
+		".org 2b+%3\n"				\
+		".previous\n"				\
 		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
 
+#define ARCH_WARN_ASM(file, line, flags, size)		\
+		"1:	twi 31, 0, 0\n"			\
+		_EMIT_BUG_ENTRY(1b, file, line, flags)	\
+		".org 2b+" size "\n"			\
+		".previous\n"
+
+#define ARCH_WARN_REACHABLE
+
 /*
  * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
  * optimisations. However depending on the complexity of the condition
-- 
2.55.0


