Return-Path: <linuxppc-dev+bounces-27010-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F3C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 07:13:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgTRL3QqQz2y2L;
	Thu, 10 Sep 2026 17:13:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789024398;
	cv=none; b=GLCQeB8daVTICufnMscMEQEx5NbWRFPMPqludiyyG3Li23EIz9YIX6Xj6pzHY1bACCgsgmseC8NTzSD17uDkVz6dfwfpTgDpey/Jfqi9+ZxMaegq180hAcwfwnqEa0QX49EnwLW8XFMu6cJWfxTHpZn4yK38s8UOzgO2e8wsNzywupWMmLV+fw1fTf446VepE+tlpSCqxZTMnIbzA6n3oGnJ466KVyc678UxCUDiCujsxLLslyyG/1Ef0ywzSmiNFBqN3L1fe9yMm1zQWJJ6U5OgMvnF/wKOrJ6dQGW530aANN1SReUOAFFPJ8/I8PP9bs5h7/QYzMcR4WbJ2sLxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789024398; c=relaxed/relaxed;
	bh=2oXTxVfBODKLGSc/9HbMzKqtFz+JtlQq+nSqeCi24+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/yWTrdFh58FQqd99odMNlta6cqXEPJgZ5f2QEkcUN7KX5p7uub7cZDJtKjtJBgKZULzto1m3b9RGvgFugLU80LqUpHn+2FHQGrBUWGnIdSrbVMAvdZMr0MeDkywWeHO+HtEyWpy1lGvv+/v6jrBweixSlHamJ+psDjB0vFNzI+P1MJ10d8FXrFHg2olwq+0c7SwqSASRPsx1ssKUTK9CAOwAvDbnYlnkAw10t1PjPahAWj1Nei9KDg9C9AOe7Qoa9LGP6egEw0YUYObu7lCe5/hUhyArZE7oJAyadwCPFo7ZQYaxnTSHWUyykJLxBpabFHg2q8gVRwLkxdOLdXSow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kz00vXth; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kz00vXth;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgTRK4hnXz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 17:13:17 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d90ba1d807so13872225ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024395; x=1789629195; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oXTxVfBODKLGSc/9HbMzKqtFz+JtlQq+nSqeCi24+U=;
        b=Kz00vXthLdullpofWHkLvopqnZvjYUfA/ivnCJ1s8dBAttebnyTEL5pXLRwCbqKzkH
         +9fGdmjzUdIvRA5bEyXhpsmZSQAgsYuZh2T/HJGuatociam9nC/QprSqpKrIyhj30uMX
         QDA9a50iFWDKAxykWbXfCPZFraog6J6Dt8rVHHawvR4KwXu0osxpH8R70DylKzFjf3lx
         XZcNf7wQcq8/0cp+leuKyax4RqYzdGVYiU8JS9aYOFjhHMrMbPbpqLeN9qIUEsyLIiHo
         xpJNf38NfBJqdb04K9yDvilKEsy0F6rO1Fn81keIUfkYz5uHe4GFn1TyTTtQuuuv9dfR
         vWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024395; x=1789629195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oXTxVfBODKLGSc/9HbMzKqtFz+JtlQq+nSqeCi24+U=;
        b=TnVUD2hZnU8+zUx5lW1YNc1bsIgVs8HUh63r3bHFJACv6EB+JD5s1y2rG4Bb4aGOxg
         SD/VDCJPcnYoFKsyofG8iQ+W7Ro5kehwp83nI8alIRHLuq7PfgvMn7Bey3V4dIQk8FdB
         37JfCCs0go8PM7E4WsEBmvuT21fIQjTL2qIqybe5Se8gUNxx0YI4znnW7kfti1cSVhUM
         HQ3I8BfHq4nnUQSATCTE0cevnXtFrfUgoMP9gb+1+Zy3FV3iCWCnrR+x+t59pZHEHnVE
         87qxKMkOAa5pTzn79pIR69ex9thi3RbL8wLbNkvtNZwxuQR831lTPog6S8WU1SfhnO7/
         ZC7A==
X-Forwarded-Encrypted: i=1; AKwUvByE3HAjEYmfrS1XPcbp9Ngh0LCJybXt82WaXpv35ekCOAwW++pATkdRloscsyBxFMIMgnRYDEO6oylfAr8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nj/xk4uwz+aT9ek8M8qvGBWSIdAJy8AIUDRSEAS76H/CPynvdU
	H49uw563oIBaM/QQfhL2adTEEppPLbw2NeS39Znx5xXY9HMaW9SI7RmT
X-Gm-Gg: AYBFou2k/FIWw7R5c18U6VTFkO1HaMxQySu4xNpbOwlSNNjCb4ZkcxYGmsFMRp12J24
	zyBJP+FTEEa7WSBf5868+cVQtZDSp3RpsVjoPm7pfqZTsrFjbPtGe8ZVoiL6aPg7ZFsz0jI2XsG
	nndfYsmP2sWGFsZ2Jz+yWUQs7ZY2QOC5jtckwc7huzSDn5huLCILRkugDBlmkBBnheFp9rYm/5r
	xkDNBzuitJpT13jj8v5roV1DfXWAnwwFn8ALx94B2laE3LMyv+cjTLeY030zCnnAdSjYU4K6n/a
	qSp9KyQbXm1L7x+xYk4DjCOgg3sAWiSW8XEMdWM7EDaBOF/ahcKaUq1gbPeKG/Qw6EHF9PV85Li
	uA14PAmP3Io6PM7xLiqP67wBJVu5Gaj2GoDgKBh0vsdrzyA84Be1OII0OrKymODKHdD446PweQW
	ARGfHHsT72B938jAiISjYIv6JQBQgMBcn7reJRi8MDdYXcBEgp2WAMEvm95x6k91G1QaOIECcsK
	xIoS/RC0rSTKOa+NdU4dru+RZa801WjGWNMpuobn2v2Ypv/xnzTfw==
X-Received: by 2002:a17:903:17cc:b0:2d9:4871:393d with SMTP id d9443c01a7336-2dd07cb17dbmr88797695ad.21.1789024394747;
        Thu, 10 Sep 2026 00:13:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae8af3sm82366995ad.80.2026.09.10.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:13:14 -0700 (PDT)
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
Subject: [PATCH V2] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Thu, 10 Sep 2026 12:42:53 +0530
Message-ID: <20260910071252.1950488-2-mkchauras@gmail.com>
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

Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
arguments rather than relying on positional asm operand references
(%0, %1, %2, %3). This allows the macro to be composed as a plain
string concatenation, which is required for ARCH_WARN_ASM where no asm
operand context exists.

Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
the BUG_ENTRY() call site to preserve existing behaviour while enabling
ARCH_WARN_ASM to supply its own size operand independently.

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
V1 -> V2:
- commit message now has error, fixes tag and closes tag

 arch/powerpc/include/asm/bug.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 0db48977c70c..8aba39e0cf26 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -32,34 +32,38 @@
 #endif /* verbose */
 
 #else /* !__ASSEMBLER__ */
-/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
-   sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _EMIT_BUG_ENTRY				\
+#define _EMIT_BUG_ENTRY(file, line, flags)	\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
-	"	.4byte %0 - .\n"		\
-	"	.short %1, %2\n"		\
-	".org 2b+%3\n"				\
-	".previous\n"
+	"	.4byte " file " - .\n"		\
+	"	.short " line ", " flags "\n"
 #else
-#define _EMIT_BUG_ENTRY				\
+#define _EMIT_BUG_ENTRY(file, line, flags)	\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
-	".previous\n"
+	"	.short " flags "\n"
 #endif
 
 #define BUG_ENTRY(cond_str, insn, flags, ...)		\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
-		_EMIT_BUG_ENTRY				\
+		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
+		".org 2b+%3\n"				\
+		".previous\n"				\
 		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
 
+#define ARCH_WARN_ASM(file, line, flags, size)		\
+		"1:	twi 31, 0, 0\n"			\
+		_EMIT_BUG_ENTRY(file, line, flags)	\
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


