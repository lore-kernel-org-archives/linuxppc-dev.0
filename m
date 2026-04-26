Return-Path: <linuxppc-dev+bounces-20124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A1FF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:00:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Nyl5yXyz2yng;
	Sun, 26 Apr 2026 21:00:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201231;
	cv=none; b=SifW4b0OX180ozfx24yYMrEE/mjv4CAFwXfXskiOBMwVkyUKqmORQu35cEwSeYGOhPcVazviP3hh0/bG3gTEq1wHjbkSh2PzIdpADVRkMnGOkVwhzKl81f6ILWWfrVQJ5NQH61t9nRN25rIF4doYXvNOH/pOi7FAf6EbSSl0RiTKWghmOJjELw+ParSZu6uGakD8IJoBCh3Yndl5TiywnVJ3L4T1poxkVDXc5TxqmeIcoet6z4REB/iwZ8Uxj6bLdkz1ED8X+8cd8TfeO9IVpH8Vmgskmz0gwnkgIUTfPmFDIitwyMjXuD3ay3hqnXpUxEmq2sfo+blwdkeUWL0fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201231; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg2ofBUltJcJrvBjY6Qs4ppf5/2GTmPdwEomhdXpTrgD7RzR5IouQl/Gbrg5OImP7lX0G+ldR31gzpx5mDj09wWwNzfS4e6y61+608x4AcYNfmUvtzGXah4EdGnlbHsAIFdpZGiL7pDADFqeXYGzhm8kECGNE+HZGy+8GlIEp/zPJgQCDVk9urRI1xEQD0gwHcuPLwsi8/ml5TDnVQ5n/oRDyTiImvvPxf8NS9L/lUQzzuWKx3s6F7qpgn+4aOl6idrMf6S2E2gXGrKp7aVl+rEGNGym8Fp4PwZN1Saw9+jvHBP+g9GlhMhNA2qGpkL/PbsNYS6FXyDHQRms1z8fUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F/4UTiNM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F/4UTiNM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Nyl1LhJz2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:00:31 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b788a98557so41958225ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201229; x=1777806029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=F/4UTiNMgP0L8RvZzKohFWWtYGvaOgJXtvoutEvfPU0fJHutoezhhnTuPz3Fl0E2eY
         v73XuRjv7gkYtOrvWc1wiDyFNt8i7XiTvR4HnVw4DyWUQF2xvvwORtjuSiq5sInyNv5i
         lnvZ69zIDWEoIVPSN8zlmgwTpNg4hc07szny0kC9nnmOnDZFBi9OyZvymsjSo5EEgzw9
         apcqkcq6+mzxQfogskPM+Z4170Im/dqaSBwjKEmqFiAEV/fbP3QyDaZWQcpJVo2hn0kG
         ge0koUOSkFbLOczlL2+bl4VLy82/FcFuMp6oqKsVtGa5RAOaf3p+lOmDPBqB5sPCQvC8
         /pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201229; x=1777806029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=Bh5JF3ZMZFlEhevEaznGMdydXp/C13iXfqXr0eRQv1oZTTvZGK/KZFqmFlnhHQuWi7
         R/cJ2jVuiEYD5AHbqDacvhNW/RmC1MZb54qaYxyLOSoLxLqLqjihYlSFYPvUJ0z9OCt6
         BcZbJpQ4B5TDSqt0P0CSr5w7hxnM9t87JzEFINlAGH+jQnGzepbJ/6Q6RP/FhULCcht9
         KNCG0Mm2bIQpNW3lvddCsHhgwBJR09Gnpr3QGYXMFJxYviKh5C/oqTpLBh63MGJbag3s
         LJ6VdnN2ndBxREe5+7zpvh8bOrgMG8DgjZxmd4YupNLjUA496k6p9Q64cXIrw6ZQF4B4
         MyZw==
X-Forwarded-Encrypted: i=1; AFNElJ8/sMj+0SRjiq4ht9IYAzbzJ+U9OXV4YzqPgYUrtJJAlcE+6rQb5B/oVwE1FquxxJyRZRhGeuLFNBG/tGQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqMyJj404Md2zjdN4C8uSInqFkJE3pl3FDZhFieXwotTJ23yKz
	LZ2l9izQtL6bdVfU8QjJ+yuMjV50/km2IaPI/GSihlh71D1ZIL04Em0p
X-Gm-Gg: AeBDietTyyo3HA6XewXAfpj4CVQLXpyqE11lR+AIuZzrDE8PBg1O+ZEsymw0lQeHtf4
	F8FtVrZvd20iEsgitzcZ0i65inG09ha4RULGTpODymkDUdCqRVXS0glXI0tfWR/9/eSVbP1ngLE
	euMB8aRDi/TC5E8VKsLfnf5qU9a4mV+BmNHjQAuI/WJ66X8QGtQ7x/frfJpnwIQvyg0QSnutc7z
	Rl3kb90w6b59956CJWCu2SFxqFTRSXmeeZsmMuOIZihjsia9AZUk59gOWML6SB/zM5JQISux60y
	/Pr542X1I3Hupad98otca/B/WjWPxEklXJ/2lG00KzJ9qGpSZ///UulaKScnPGZH6dAvfG5iHiM
	T4wyMGtwDXXwZNlTRx4wPTZByOb0DkS/6qqKU0M4ei8H/Tj81nvVzUNKs7LbIc6thhoukd8oT+c
	CHz/au0/gEVq9LDc9K3Vd1VVvgH2g8Z6GJYAHTZJP1Nq7i3qTtXBAl4OmMdRu5kIin1wUXzA4NB
	aMsvahn5asTKThJCpWUDUwofA==
X-Received: by 2002:a17:902:8649:b0:2b4:65ab:57cd with SMTP id d9443c01a7336-2b5f9fbdd39mr296814685ad.36.1777201228981;
        Sun, 26 Apr 2026 04:00:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:00:26 -0700 (PDT)
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
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V15 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Sun, 26 Apr 2026 16:29:28 +0530
Message-ID: <20260426105932.2270364-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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
2.53.0


