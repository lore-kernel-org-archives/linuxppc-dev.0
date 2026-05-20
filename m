Return-Path: <linuxppc-dev+bounces-21210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF320CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2Ch4GbDz2yQH;
	Wed, 20 May 2026 16:47:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259648;
	cv=none; b=cdBsEVpbjlE7uexbqqk9QQqm2Rw6psvefoWtvbK3Zta4qeyZGVW9o2gUYZ52hUnqsSNBEmYuoN7WqTnsY4OGD1H4w+d5CdZTXmhQjyTBRwZ2npOOL3zgHZdfmQDHzXXDx814EoZaJ3UsW6OE94i8lgxd36Iw6CaeCaJy6oztqtBVOpBz5ek1rd+WQrHAmxTvvg3htXCj2ChdY2uVojPKtqYtDQKBqztpuBwOsxlUwQPDvXq7o/+qgtEb7SPed4haA7BpG4Ciq9xhwQeRKb+n6WPGVbLw2kZ2gHkcWcAOhT3ctpYpiVOW1S1Zd24RXqsS38Cjy3ecWndEvBij0flfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259648; c=relaxed/relaxed;
	bh=1cHgHzHWAoKXE2eMaeg8MSzma23SMwAsMBQx7k/VOAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk5vCHHIjZXR3do5DhRsZyam6b4LyYUSWLiTg0CPNE0YFDAhfR7Py3LEh6y9yDHpm+JFLEyRFZAH6QgrkUIMnr/csfclwehC6pAXqWtfrwkVsJ94NXsoBLUT302vwwNDIWCmJczAqyKUPqE2catdWRlUb8lG7PEz+0H9DiAbfCc5J/aQ+DwTmZFgkCpMxRSGEfmj4V7H6N0ZyfinhOc1S4WZygFrIw10q/gBmTWfBomTjWwjWi4KMM4duAFZU32n+gckspOyjbINe4Zoe9593l/Fn85xBYCQlyS3tCa8VuzCLtTJbG5E7X47yxGcHJm6XfLbdhc8cj24Xlkg041XTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLUJdk1C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLUJdk1C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2Cg6DHWz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:47:27 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso3135499a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259646; x=1779864446; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cHgHzHWAoKXE2eMaeg8MSzma23SMwAsMBQx7k/VOAI=;
        b=rLUJdk1CncX2CabD3ktt957g3FNN5hRQqcllwI6lGXYZ4HFa43POXQdGvrPOZ8Bui4
         NvN10dJmxVStu2DmqHf6E6Zl8oDIKM5jtblTRMO0XqPgxXVd9gRlkjeMn6X2xq2X56de
         4cEYKbsY0WbSg58pgp9D1m9n9U0muI5yoKB0ac8baxb5U8hFheNUo125+aOV8UKa+iYo
         MewiA55W3hptgaSzL3wsLY1MvwlkID7xO+Qya3v4xwCUoyc+aPOMv5o8iRuO8Ncc0u3P
         8k9CTda0xADbih+ih94uYEV2AOiuffbl96DNyxE/nfV1RAt6dVeulEvDgQbGWRgkETsF
         nAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259646; x=1779864446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cHgHzHWAoKXE2eMaeg8MSzma23SMwAsMBQx7k/VOAI=;
        b=JJjZQYvdKuGdM4MskrN7W5jhzzzfUlA+wzvqlUxJYCGIFwEFYxhMKLNYS5cxCAoCI4
         CUHF7uedUW+kBZuXru3X1ym2C2wzrXTSdx7SDESObkXho6t8RuThGhuBy8MOaUSGmkTD
         Jvy5B/aOavfmSRUZrvg3g59VXs1PlJC94U6hOsjvwCpqg8pApgruIpdTLVmMO5pZA8DO
         ZB970Yyw2nbF19bdK3a+DCUajVsxNGoOeUqNL+xas9F/rXZA0d99lql1w/2T8Ol2kpd+
         5oUhQ7dtHzTe54K5dvCsbyne/bpuv3uJzQGMaNPTs/V23ct/lXB5rz0yjKugVJ2HAZxG
         lTgw==
X-Forwarded-Encrypted: i=1; AFNElJ9mu5Ray9xqf1G2pI4K8rsPchXxPU0+GtT93NriHfWY+SADSQmwOAKgNp8LUg4WonArvRefAzqzevSs63I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzrQwOY99a4MTTtpo+da6OETaQFeC0TInFT/8nnR/YzyeIONrL
	JVnOfX4hoF6zwIz1hndYfFSKnbGgaRz65C15kAc6IAYaeAwY4EhmsGuW
X-Gm-Gg: Acq92OG87zd5pSB5BMfdxKRqLGCjfkuEHaslQaU6S2oAWthJRirNXM+Ifk8DgGv59n2
	hDoZsVZJXDkiy8r1Ll3uLsdM2ov88YI89TKv+P90tz9aRhbLDob8Y7eedXbEu+ypRbNvXEtPNQd
	GDPtj0Qej76+ZW6qDSqhReKT5RMCSukHzzxngId5SqXlCcGmqwNTl9Sq9vHNtXJjNPesr+9lw1o
	tpHlG9LkrWBr6YogmVxaMvC6wE/EdpJzdHekrlLk51B1fjzPhxb3fzmb2nD8M5bdC9RwaxrPuRk
	eVX5ThAfftWhnOfh8/ae8PPLT7lpMi89Kormltn0MFYdV2zSxf8PtGUN+NqpiQNNpVAvpCoyPyk
	JCjqwyHw3sAXwvhBdZPS518ZDA5qhEMLuGQ8iV95amZ/Dzqn58z2Pn1eadiE7tLSK0XqRbe5KJ4
	JgN/6ge0Frlglp5ttUd9erYMbMuj++vFnUhw6/VFyZKyCYB6Nfz1SRV1gEgYpSYjCKGz8Q2UQ2E
	uRV
X-Received: by 2002:a17:90a:f10:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-3697944defbmr7347179a91.4.1779259645871;
        Tue, 19 May 2026 23:47:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:47:25 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V16 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Wed, 20 May 2026 12:16:25 +0530
Message-ID: <20260520064630.1785283-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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

Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
to avoid duplication of inline asm between C and Rust. This is
inline with 'commit aecaf181651c ("jump_label: adjust inline asm to be consistent")'

Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index d4eaba459a0e..3016e9c8d6bc 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -15,14 +15,20 @@
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
 
+#define JUMP_TABLE_ENTRY(key, label)			\
+	".pushsection __jump_table,  \"aw\"	\n\t"	\
+	".long 1b - ., " label " - .		\n\t"	\
+	JUMP_ENTRY_TYPE key " - .		\n\t"	\
+	".popsection 				\n\t"
+
+#define ARCH_STATIC_BRANCH_ASM(key, label)		\
+	"1:	nop				\n\t"	\
+	JUMP_TABLE_ENTRY(key, label)
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1:\n\t"
-		 "nop # arch_static_branch\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+	asm goto(
+		 ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
@@ -34,10 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+		 JUMP_TABLE_ENTRY("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
-- 
2.54.0


