Return-Path: <linuxppc-dev+bounces-27889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76893C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 05:43:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hppt96KsNz2ygW;
	Tue, 22 Sep 2026 15:43:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790055809;
	cv=none; b=n4j2TzagghnNFga2kWP5jMhwPptk0FUMAGtZdQ4U+DnsPZy1fMiYYNfAEBrWsftPqKl/117qywiNLOx+r99ywkgn3rnbcVliQ2Q7gZzRck06r6QLZ42ryGPVEv3b8+07IdXazNhXm8UUPpfGN0GxiZrEP1LMyhx/g+1wHMHQOO/8DLRfW9mO1yOwkRFNWcTjd1j+vMuqrQLjVptMSxgl4jkAf14iiy5XMIQ4MNr7VSVymRarMEe+HVcuYvy21bvcdbAdCaiYa5sm7NBVRypPyUJLZAxWh9ZRsqwNwFAumVslzqFGTxCYP4dI6hilfVXiWgiOw6j7UpbCCig1CAf3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790055809; c=relaxed/relaxed;
	bh=aI8dvVPU2tEhTtS2QxSNBjEg+bGkrZOYEQeAhVqGoaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWZ9yEZAAB47e2eB3YNMeYJ4iTEyUpi3xcERVljHektQqEGIUP2oZMcrAUguleXeov9Njt/kCYkvvCRUSASWb3r3qae9T1aWopTgAia+PxFgrhqUgl1fbF5nc7kIHObdv+nbxJpdiL47WiHHOHEnFRWQyQwOLolIKAwiek8Ucve/Jl0TjWGsL0h0602+wy0edPrE2zbpZrV66gfjItaj4vr+eElGqjbpDVpRjPxAQHpzv+RtUbX51Npyk/44AzNG2wg56iInQBbcFhwA7JJDjRjsCx5VJXbH7ZUxpVlKOZrze3AyN/nbBMbdRXbuCN8O5nxjJ9Er7HSERzGcxCyPnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qj0590B7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qj0590B7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hppt80Lztz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 15:43:27 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-398a147688bso3857893a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055805; x=1790660605; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aI8dvVPU2tEhTtS2QxSNBjEg+bGkrZOYEQeAhVqGoaM=;
        b=Qj0590B7PTc1bNEvhuDZ+e1GR8tyNGbgMk09/UUR5KlYHszW4l1z1mtSn3nXVI2yRB
         V7gaULUDLJ0n1fBtaOIBD4GJyfoYvgrzQlbbisA2ej+hfJMDprq4LRNddlvI4CltJ+0M
         Rr13ogJepLmxr77GI9vlrpe4qLIjtkp0nbABzkIyrPjYz4RQv4O0oFQkHorAuCPNi+iQ
         JKI2qrc1Ha1HdmJuj5fY8ITG38r+dencXjClxmDvgXsjaASCagO8cjPltOu3THKU2Nys
         CgJUvp+6KH21wdAe3QadYLjUCbG+liIzJtfb9l/EeH2Ygid2DPs4MQh1h41hZ7ZfrcEC
         x9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055805; x=1790660605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aI8dvVPU2tEhTtS2QxSNBjEg+bGkrZOYEQeAhVqGoaM=;
        b=BjyjTPbak1kG3TdpZXqvPEFD77fFQShZg8WgrBxHv6UhjoN+I8x0NUItKT776qkjr1
         Lbp65rWHxC1vrzN7HayE1Git0+1nbiVYmOCxkWM78SL22PLZ22WVLSRl2y3kU45qKgUw
         7oNQ/kojs92PvLD+ugSuF8d4KF9BAANRnb1KnfHbT1nABPt9k5BBtmsaRCyVuLCNzPSR
         3OXHzkGMkTfUlLKmluzqTxT1NcxIdcui5Udk2UINMqWx0ZHwte6Ho8NhFAd13iG9Y3uZ
         9uq4Z9t07aYAKE4V57ZRU754wHXSmduIHw6rPJOpWika4fijalNt0ODsjFxHtZm9lR64
         G9jQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+aBsFKZg9w7uqyfc0qzTr2O2FTiYAS6bWzB/VuzY46+OCgmuQFBdxbrd2p48fdNNH04mywc2EnKfbs6E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nk2xCE6TwV+D4q1A33lLbJfXmJ/EwkFL8KrnX8oNS/JHkZLY0R
	kZ2nRl9cBuR9q+Va9pAI8ZIOGvHxs8CyM6o2cUnx86TCuBUO4Tvcortv
X-Gm-Gg: AYBFou0vYlzFyp7AmZ5U5z7ZZSa+l5eK1ExguW8pofIC2TLsCyiJUFsv0OoQH7aatc5
	Z1mwotKBbjeBWFidcXBjSeEorW8Xvw4VIc6lLSpD1ViXmLJQpERcCxI+3aB2BJrF+T5wFaIRwGk
	Kx5ml63jQqbXZxdC92RCsHLZPkAStL6UasonrU6d1y5B3S+O2X3nFlZnujg3kevhLnrju0xI9X5
	IljbJ4IXomrseY2i24EMKoucuaqpWkc3uyQbcBRyTU8RnyOc6zjN9Kt+lvdwHHJzr8xRqnoj4sX
	UzeEFw3cqMJd3IGEAlvS4B74rP2ukyDbsh2d3ZqZpF4lKrKQ/qHaIC/PTsO1tmcchcyJu8miW5r
	NvTy/iY7W4CcK8jSnS3GU9Eg5zLn4PxUcT3hB0oOSpPiT0gfOd+mEiMM/fq4naaqTszf14z8j4x
	kH7G4PubylgvOokSixNfzgsSPmOTt1yhnSvC8RY92pK1wg4NShoxQvjXe2xw8qYpGlt4Rctbz+h
	CnJxutvaLEEULvBfMv2mtB2FKCcYqpxAyt2bLl1b0wyKCveei+a
X-Received: by 2002:a17:90b:35c3:b0:39e:6c69:9b8c with SMTP id 98e67ed59e1d1-3a073226d79mr77215a91.49.1790055804607;
        Mon, 21 Sep 2026 22:43:24 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129a33esm2426272eec.14.2026.09.21.22.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:43:24 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
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
	rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
Subject: [PATCH V6] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Tue, 22 Sep 2026 11:13:11 +0530
Message-ID: <20260922054311.906816-1-mkchauras@gmail.com>
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
Changelog:
V5 -> V6:
 - Dropped KUit tests from this series. It will be sent separately.
V5: https://lore.kernel.org/all/20260915090453.1227034-1-mkchauras@gmail.com/

V4 -> V5:
 - Fixed a build error with DEBUG_BUGVERBOSE=n
 - Added a label for bug entry
V4: https://lore.kernel.org/all/20260912065902.24017-1-mkchauras@gmail.com/

V3 -> V4:
 - Fix Label with appending b at end
 - Add KUnit test patch
 - Tested on ppc64le pseries: pass:5 fail:0 skip:0
 - Tested on ppc32 QEMU mac99 G4: pass:5 fail:0 skip:0
 - Tested on ppc64le QEMU pseries: pass:5 fail:0 skip:0
V3: https://lore.kernel.org/all/20260910100801.2159785-2-mkchauras@gmail.com

V2 -> V3:
 - Add label argument in _EMIT_BUG_ENTRY
V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com

V1 -> V2:
 - commit message now has error, fixes tag and closes tag
V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com

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


