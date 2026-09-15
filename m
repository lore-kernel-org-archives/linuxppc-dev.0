Return-Path: <linuxppc-dev+bounces-27301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E9CC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:05:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkbhN5zm4z2yqq;
	Tue, 15 Sep 2026 19:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789463124;
	cv=none; b=fEfJPeQvyw+2nPett+d/yFQxxX+KgwBMamd5yAXnY1EmV4vi59UXlxtCjYyvnYQ0YTVCGyT9vg33zZCWOakdfEzCpI19ooSLClHnoshDr/WSLyvwCEOJxjXTIYHJCRbbP4lkHyrhUrSikmVJyC7BSohXnNEH9PmalqtvBo3t4y7wwmASIB9oyzne7P/S5r4EtFIj/C34I/8f43opJjA7FHRSdmQ7JG25/djNsyfbQ/zUwkfjKBBb0vgt2qvkYncuTwVfH97ekdFhDziiUi//90QdM9G5IiGumewZbQIXbYNi4jF+uBezf4/Hu2iIWbYZq5Ohw8GbqQNnRGOTd29JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789463124; c=relaxed/relaxed;
	bh=dRlgQjCaKIy4dVemjk8uAj0nWBn95cwji7bMZ4jS6zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe0GcGAT/awbpR2mqM+stGNmP7ta6jD2cnIlB/NeP0EbfUApQRYz7MxzAOl5Hu/MN/TSobJTvUxwNi35HIg5qhTP18jPz3dYxRRSj6wJBOZ5fxk4nmSbYZd+13t6P4KJTtfB00lQdNghd3pW5r1gv00//NG8OcyfdSoH2Ke1Y7yhm9BvR1DHOmwdirRshdlIXhL4P14iUOnvnhNAk485ZeHap7iS+061wxUTVdEMSaqBfNThYAtnFgRhfwAQYskuH+q1INyV6gNvsH4EM3AgN+waJUBHbQtXFDv8jDqs2myYx2+qlgEopeJyxUU8iPQNGPAkskWDhZuBuuRuP66B+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvfowciY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvfowciY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbhM6tw0z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:05:23 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469b35611so1700926b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463121; x=1790067921; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRlgQjCaKIy4dVemjk8uAj0nWBn95cwji7bMZ4jS6zE=;
        b=LvfowciYgPs/HNQbo5wXoZTtMzdHqnT+28YPRqq9HNCTBCqu0OzE33lLxAndyni1UW
         Ihmz10YlGB4oO0BqqY5gXTb7mMgxJRZlQErZXjvTYdJeEsx2+zU7e4ZEPfVUCh9IVtoZ
         LNP/wnKcsM6F5z0T21B322J6joubcRvqdd4Z0/PSFy5a9AVU9sqK5FIHrNryZC9ige2c
         j46hwHQ/uQ1FdCLF/hzZtOFJdhr2DlSvdxqWuVTclwgg2tzcUN3pcdR1cKr5eLEJyD38
         o21fuDAntSoQR4DWSgYDmRlakkTd6jr8kFLCMe58bylG8s7Rssa1D4ATd4fNCS7Wqiqm
         BxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463121; x=1790067921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dRlgQjCaKIy4dVemjk8uAj0nWBn95cwji7bMZ4jS6zE=;
        b=iEPZN35OGqIC2L+Ilf8EcHKy9BilT9tNzaFHYle7UHLtENJXaIcCRiEBqkbxevjho/
         tmMS78q2t1s6DljUNY7+4iZgYLPc3RA9RUqyqyKU5SFTBafX8FFWj7RgLaUrKTJZ4Q+j
         ft76ggbkRS5WPb3lYqXsx5YMgoM4PlUZZBVXy97+AZ9U0Z+KDns6mWsEaDvlmS01BmnT
         0aCVjFt3ffR0Jr0+F3xZog6e02u9Hezd31vvpWkb60lfeKxZmgR+k9LUdhxG9r8YEZY2
         RFLvdm1tuh57k/TPO3ew5sEyHbScJLadkC82hfymx/zXYaBO/r+AE5VbdETmpbzsK/xQ
         UQdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpXgfDlgAzZFlMJq+OxAMWBPinlZ4sBby7xW3fBUyzV5rM8g79+qpI+FQzog/moZxKeREGCH3NAEXYogE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mBQ5gmqs6ESjTMdlgblg49q02puhvwP4LvHhObIYIMFRb9Zsqn
	66rgDDTN5wBTsROziClMycqWSa3EoBrgpv5Lbb10b4Hu1n8ckT9A/9aa
X-Gm-Gg: AYBFou0OzD4zr8UMxX62jcLRc5RXTUZhGdROE1p7ZCiPEHk7E/2Vak43hmiWeJOX6AW
	f0a9NmBbbSfSKYUYw7AF3qFEc7oP20lhZZ5woqrAqo9cFjV/vM1xATfc4HJu1Reitmkcc9bATn1
	M78f256YW5ezz8p/CvPWfWj6VZpP52g/qWC/Fu1gSY9i1PSAvXHpTh4SsKezHjT5Yqy9+HTaMNK
	/kb539VwY8ePopD+v002rI7+y+HFKJXeDeWwc3VGfx0uFY851lmqyrQU+12F+eWmuWNPpbqJxy6
	SoDdZkCax1evENPL99JRIuJDelR+Jxz6FEQgFWtRP/DBQrHWfqhK7alyFsvffJehb/aht50TMxN
	3GVQS6ko/k75KQVskxnBaPk3dF30+NEtvN1oAJrahh94QjpNluAz3vgyJUs5IBBaukQnFgw9BgP
	pLLTTok2P52zbpl9nh35NIKXNYk2AthgFVGkklTQPVoOtGxGCR9n7PI0/ZSHY14kMyQXFLHNmyg
	icDnvfunwpuYMx2AGkbgzepd4V7F2yJpFW5B/KoanCoVZOMDL0jIA==
X-Received: by 2002:a05:6a20:430e:b0:3d3:ad3c:49a6 with SMTP id adf61e73a8af0-3db4061f449mr14643678637.20.1789463121439;
        Tue, 15 Sep 2026 02:05:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65a8120sm6495512a12.30.2026.09.15.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:05:21 -0700 (PDT)
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
	david@davidgow.net,
	joelagnelf@nvidia.com,
	fujita.tomonori@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Cc: FUJITA Tomonori <tomo@flapping.org>
Subject: [PATCH V5 1/2] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Tue, 15 Sep 2026 14:34:52 +0530
Message-ID: <20260915090453.1227034-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915090453.1227034-1-mkchauras@gmail.com>
References: <20260915090453.1227034-1-mkchauras@gmail.com>
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

Refactor _EMIT_BUG_ENTRY to take explicit (bug_entry, trap, file, line, flags)
string arguments via string concatenation. This removes the dependency
on asm operand numbering and makes the labels an explicit argument,
so the caller's intent is visible at the call site and a future caller
using a different label cannot silently produce a wrong bug table entry.

Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
as an asm operand while ARCH_WARN_ASM can supply its own size string
independently.

Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
convention, indicating that no additional reachability annotation is
needed after a WARN on powerpc.

Reported-by: FUJITA Tomonori <tomo@flapping.org>
Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
Fixes: 73b741adb264 ("rust: Add PowerPC support")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/bug.h | 46 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 0db48977c70c..bf31ee1e902a 100644
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
+#define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
+	".section __bug_table,\"aw\"\n"				\
+	#bug_entry ":	.4byte " #trap " - .\n"			\
+	"		.4byte " file " - .\n"			\
+	"		.short " line ", " flags "\n"
 #else
-#define _EMIT_BUG_ENTRY				\
-	".section __bug_table,\"aw\"\n"		\
-	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
-	".previous\n"
+#define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
+	".section __bug_table,\"aw\"\n"				\
+	#bug_entry ":	.4byte " #trap " - .\n"			\
+	"		.short " flags "\n"
 #endif
 
-#define BUG_ENTRY(cond_str, insn, flags, ...)		\
-	__asm__ __volatile__(				\
-		"1:	" insn "\n"			\
-		_EMIT_BUG_ENTRY				\
+#define BUG_ENTRY(cond_str, insn, flags, ...)			\
+	__asm__ __volatile__(					\
+		"1:	" insn "\n"				\
+		_EMIT_BUG_ENTRY(2, 1b, "%0", "%1", "%2")	\
+		".org 2b+%3\n"					\
+		".previous\n"					\
 		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
-		  "i" (flags),				\
-		  "i" (sizeof(struct bug_entry)),	\
+		  "i" (flags),					\
+		  "i" (sizeof(struct bug_entry)),		\
 		  ##__VA_ARGS__)
 
+#define ARCH_WARN_ASM(file, line, flags, size)			\
+		"1:	twi 31, 0, 0\n"				\
+		_EMIT_BUG_ENTRY(2, 1b, file, line, flags)	\
+		".org 2b+" size "\n"				\
+		".previous\n"
+
+#define ARCH_WARN_REACHABLE
+
 /*
  * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
  * optimisations. However depending on the complexity of the condition
-- 
2.55.0


