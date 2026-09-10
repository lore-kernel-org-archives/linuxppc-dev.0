Return-Path: <linuxppc-dev+bounces-27018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B704C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:09:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgYLl6Zvsz2xGr;
	Thu, 10 Sep 2026 20:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789034975;
	cv=none; b=TLCcCSHmacZiu5tFMLVxLnrRSGskpUjwwLr1p15jtmzygyphitmzBh9qipvHB7hfxp1HNLon3IaQtrHYy8N3J68C6RLvIFj4rexJ8d3fMtk11You7VYuQKUksYwgAmJtMTa/ZZcrCsbs9vfoaLLdgu9Bx0Oa/oL6hJ4y3aYD8o1rnnZheiftbKq3pkfWOJeYE23rpIdqOfuNVMgxfTbFgK/ehLYaYAwlWfuk0kfz/8MTGbiPx+1oDDtkDRCElLu70TYagSKg3AvEovkelh2EMOHg+Aq8sxch5FO/hA2XPWO/Q56C7O9id2yoOs/nb9sDPJm+z1dMZUCyK64CTr9xyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789034975; c=relaxed/relaxed;
	bh=v5leu8y8+SZGo99Bk+YLh7ZmObofNLoxXT8B8pxE/vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO7azlWszqE6p8cOJqUJ8XylROZL8873e1IEU9N9/DaIQk8sI74vIufbjNZEitrK0x/NF9KhDiM14WfCAwxDcGJR4GFPAihsrru6AyQQAB+9YWQhU6D8IaeNFSydVKXhOUV00l9ObjHGWnJefdDzBRLivtkYvCiXJWjofnim/73QmtXoxcX0NxZZSCbG4gaxHlu5liKq3FR3jptyd0hZYYKp+/wpGvdTbTKHTdGzlKZG2v8/ntPWXr83MrV6WgYAIEuJjh0hzm+qod+22ZxfIQmxHm9JTYvXJ1jxAxqkWzq75nj+7ESOaSvFEiQ2U19UqavMh8lkZJJ3ZsTiC/JqTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rhkr4UC1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rhkr4UC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgYLk4STLz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 20:09:33 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so138943a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789034970; x=1789639770; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5leu8y8+SZGo99Bk+YLh7ZmObofNLoxXT8B8pxE/vs=;
        b=Rhkr4UC1LaeJm6M7gZcltBBZdexfmTUfd87QRJUa+R6OG9CpWJB245mpHAIaexRbWQ
         ZZkd9PYVJm8Qsl7bOBFpI9iU/LVC4UAZvm+CTbEvdHMDLUZJfHQjxo2YesF0O0OyrtF7
         D1Yk92Ulej2ETTjKw/aAn1dmVTw4WK17Wo9RmGwEDQwibVuAnT3X23ut7yVrWDvpSelH
         4o2C5mGYqX+6C4EeM2oQVDFHfR+Fy9lin2APLG/WFJDyIITS4C8XPpA5bagBjLw7ikcT
         74xXFrxlzH/apQhT2zilvdKsvKBqo2R3bjQhFLqJmZL3FH2Mkg6yeLhKW2YUrOxdGgGn
         QFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789034970; x=1789639770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5leu8y8+SZGo99Bk+YLh7ZmObofNLoxXT8B8pxE/vs=;
        b=mT39B0y4mDkaLDXGVZ+vbM/j6ENq+nSnPsb5zKXDqyZJ73yS9S3umGTE/I7e5ep40v
         rbole6Ir+7kcwLNDX6mHjZEgbhF+2yl0pUtcK70jTidK1I227oF9DZ8fml9Ozxn1KEeD
         MQdkyZcewSE9MiEJ7IPqYxdgQPwna6faPqXElWpxBZsISzNgzRqdWfjCbQWS074jhEug
         JEgHR9+RgvQIr+qr+c59zm+CibZIBWqOyRxdwSCe8dY1oP+lkMcn+bGmrOUD1MmBihPE
         rcql/heH1AJo1z8TYQHWpsP1BhtZH9v+zUp/gr4q2dos6n+YVd+Ko19ZRNmY6yG8B7mH
         hGPg==
X-Forwarded-Encrypted: i=1; AKwUvBzT1w3GRNRq0C33bhv0MY/D1xf1+VXq6zRYIJ3T02sbeD3KWwXw2QD8hPJotBcDQvOfcz3hRXFCzRloTeg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nM1IA4dUn2VKXZyyP6eP4P07QWWjpzHk4Eaekb1pZEDTKVfGWz
	1BeI4CrPYpgtlnKrCy6Qe5C2n6sBfMHb/5JZrzyrzqaBTSIQX7PBIg3g
X-Gm-Gg: AYBFou2XD70VuR0dAuPch8eq1Ftu9eyUiWOGkbybpaVE/Kor0erB/PANy26BVS1vliM
	V69v+0+/QDpE5B98RORffrsIBqZssKxRQ4iToXWnH7nEsCslbeX3N4MDlPW5KGEN2bUCMe4VSZD
	P5iKgaztpahrXkJDE0csJ5MFURE6gBb66diMVBQabN+394EFB5IJcnfr4AZOHjdn1ZBaMLebsyW
	OlhZsltlmLx1UA9Z69qJ/Gs1NdPuLK+91lWRH1A7I+d88L8F4X7rPjyo52gmqsCNx9WW9OEQikb
	NHSMeZDPbk9kCXqtJgOJf17QgGmyDQkshX2LeZLKrxqpPjXG9qZq1n42G1TIyhzQ1WJ58xO1wgl
	69aXwrd6pfCz767/8XVveWCS+mLgmcspKyIdsXs8Jyqvq6X23FWjmLMIeK6qz5vLNps3scRpyaH
	s1yRLiqPN8z5bPcUk7CoQ4Qq5Y4sy2jNM37qWA+1yRNRoBQbFQD3O4QTx7zNP6hMFjmjUIVymB/
	oyPsbIHrlRi6QdAOTgOeBB4kCHVsOpVkhuLvThogYwyEGOxM0/QhyDLZsgr213R
X-Received: by 2002:a17:90b:33c1:b0:398:9bd1:3214 with SMTP id 98e67ed59e1d1-39b262dfa81mr56515343a91.21.1789034970472;
        Thu, 10 Sep 2026 03:09:30 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae60b23csm3460207a91.0.2026.09.10.03.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:09:29 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	mkchauras@gmail.com,
	linkmauve@linkmauve.fr,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
Subject: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Thu, 10 Sep 2026 15:38:02 +0530
Message-ID: <20260910100801.2159785-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Changelog:
V2 -> V3:
 - Add label argument in _EMIT_BUG_ENTRY
V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com

V1 -> V2:
- commit message now has error, fixes tag and closes tag
V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com

 arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 0db48977c70c..df2183c35945 100644
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
+	"2:	.4byte " label "b - .\n"		\
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
+	"2:	.4byte " label "b - .\n"		\
+	"	.short " flags "\n"
 #endif
 
 #define BUG_ENTRY(cond_str, insn, flags, ...)		\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
-		_EMIT_BUG_ENTRY				\
+		_EMIT_BUG_ENTRY("1", "%0", "%1", "%2")	\
+		".org 2b+%3\n"				\
+		".previous\n"				\
 		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
 
+#define ARCH_WARN_ASM(file, line, flags, size)		\
+		"1:	twi 31, 0, 0\n"			\
+		_EMIT_BUG_ENTRY("1", file, line, flags)	\
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


