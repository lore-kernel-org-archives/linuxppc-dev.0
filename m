Return-Path: <linuxppc-dev+bounces-25972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FDBC5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 08:48:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ0bc09Lfz2yCL;
	Wed, 19 Aug 2026 18:48:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787129323;
	cv=none; b=MSLO7oT5DIKI1Jhipmw6aLffraaY9oLtB1bIRbxR6gE7j7B00Hw/sS3466gSgnqLMiGD8iR72MBc7aAWHuTI/aA9vl/9G+Sd1ZAio78WkoHEe7EkH7Mi3eIwMDXsuo385Cejo6aolIAvAEXKauIudWlFLWNSEEnFvRGvuCq/n/PZYEYEPH80Q/mEXpTS/5Y+9UAAxBcFa4FCbBEoMZk38w9rA5pxnD1ibr0TRRjMlFahc3JCUv3z8B7khPEGiJVd668/806JBse18CXKtNse2H4AnzhvKKJQImvF3BJPQGE3wtRJrwirvZiGHsbYr/TL4YdL1YzyHf/XHL/DBfUeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787129323; c=relaxed/relaxed;
	bh=KQ7keLJ8medHWvNAYhKdIsoM73FCKMrfDS9RRH+9RkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAYzOx2CjGyi/jGHA9dmyKFFJZ+28BsOeB6gW0bA+/hN+NFj/MF4ZQeQK+TXuot8CML7UbLVfAJ34cH7dia0GswCooQN2KtrzSsQ0uaQcW8Arfl+i8WZ2rErD4vJQZtQH9+b+ngRLbHIkiFyiWwIolcZ49WJH6PZzva3BRLO0fFOkey3fv0a0Qc6idLfLryH4KhRzcN1xNTfF8XHANU7WMYVkPh4N4R6YKICGhWONr1lJ907UvKk9eUITCeusqMZOW2AZN84cNMtfVzTbK1k6hhs3Rqhrmkghgbg+heGgIzZdktwXBnQJ4oWCJBE12EMAlcsc5TFqCGPILMkkL9rpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J5ySgru8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J5ySgru8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ0bb2T8tz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 18:48:43 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso967971a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787129321; x=1787734121; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KQ7keLJ8medHWvNAYhKdIsoM73FCKMrfDS9RRH+9RkI=;
        b=J5ySgru8/WLdFmCT9HRA8rNfmviaX0Lnq28xFHm6RoIgNYSIV1RYdcfojQpVWDdMp6
         q3nY6aF6TtPucsyWzYVe9+Z579yH4bvMki6Gza2haVfnLFQyls1J/N9UqBY6nvAhmeKR
         tWIxsx79OhC1i7KUrLPaDPYBsjKjIw0j68bpGfX5szJ2nMLAB4WtjV2tiUL0OtlzwCuy
         40yYdDuvXhhtB044Cf8rydq1TN7GrIlfPq7AlfUePbJqE+KO52HInH0nRvb4rE8n036k
         6an0UqxPh8SK4HvftkZBE6gkwoZHeVzu0jSNlX1FdyAejxMeN5amnbHzo3cZjNxgIS00
         mZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129321; x=1787734121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQ7keLJ8medHWvNAYhKdIsoM73FCKMrfDS9RRH+9RkI=;
        b=ibuF+o8LvgyXodDV0XHFL7wpPB1PBo/98M4XH3F7VfQh1IEVlNLQHBWk6UB+LdT42p
         IR6n6kVC3toaFfbZ0WtU5MrmqE9rZlhnScwUCCa8pjsiD7fT+78djSGqcKfBwJNZ8T21
         lSol7EEa6FoOIZugIBWIkGDWIe4IFjR8t0MqSYDpXjiVVKL2ur84bTasxox9cZP89ukN
         C2ow+3yR54L2nDMd6fBJd83jehIDkdE3r7hhqOaVMk+AU9un81yh4fCuBrqKtMsh4wab
         ST1aqt7RV+kr37WcZgvywWxaWNo93k4bCK9Mzhgm++oUjTg0Ci3Ha16vOzJdpCWaLA5t
         BNww==
X-Forwarded-Encrypted: i=1; AHgh+RqjQG8q9EYQGAO5cQhZbWWNx273cEMDkzjXajTgwtJLJ0gy6zP85oBwBPvCAjN8LVOtDW2IyCYZdJu/El0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++knnSe4m+/Mhiz/Tx/F+a3U4AF8GsmEEjsIfqAviLTwXN933TYB
	o4/XxeClz7SMlFI5dKnDwv5kJ4AEUzjk3aUC7DwhdXCrvnmiZxfG5UYi
X-Gm-Gg: AR+sD10h3p3MOGCZIQSsbEkDihJV8bDyqNgtj++45sKAh2zVgUdlgL84MLM5Sdu4KW5
	Z2OCnBNreR0Slm6NK12T7JfaAxYEnYvLzxUdMRp7N2JwPFCL0/seHPMZZE3rkIetoSH2gaaxsD8
	s3L4mipD6Zq+Btc7P1rFEzPmNhZiffHfZaeYtJELkmaPBqdOEqwT+3dOUpD9c0sExgJBuIFB8EY
	gJjlchhMj4CWmjeFlxGo5o73Ai52Y4SMtJNLlY5JdRtxZ5DqKTsn3zgFZoagMSMZO6v3OHIshVV
	nb/yvxT4OW7xDTBqbuz29SXHtuVBuIO+XjUmU1LpwPNTtHgAF4wWOdGmD0GA3eSjVcZilOK95VF
	Xt3lbnu1V2EBVUmeAInAujzo+V1qqnwYbehHclyWYw6+fjQV7InWBevSuwA2q8nM1Cc6JOed9PW
	T7be4uJGAxwMy8t+gis99Xh8UkiM/SgR4aWVqki0wuEMLitOFlNkAJIaKLdKa8hSmzAbZ0ht7pk
	O3c6AzS7UAwj2Kn8u56oecY9P49KrTvM1nNNAPqmw==
X-Received: by 2002:a17:90b:4cc5:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-39580ed0a57mr6214530a91.8.1787129320646;
        Wed, 19 Aug 2026 01:48:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf13f4bdsm5154174eec.20.2026.08.19.01.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:48:40 -0700 (PDT)
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
	thuth@redhat.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
Subject: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor _EMIT_BUG_ENTRY for Rust support
Date: Wed, 19 Aug 2026 14:18:25 +0530
Message-ID: <20260819084825.969116-1-mkchauras@gmail.com>
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
Rust builds to fail on powerpc.

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

Suggested-by: FUJITA Tomonori <tomo@flapping.org>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
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


