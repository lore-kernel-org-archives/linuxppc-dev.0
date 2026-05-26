Return-Path: <linuxppc-dev+bounces-21539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC8CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78N5qJBz2ynr;
	Wed, 27 May 2026 08:43:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818373;
	cv=none; b=kQFlbAX2WHMmscycNRNxIoktIcvZoGVqPvFax1x1acR7UDK9oPVxUDxWO7b4ptkB/JLEyQvIix9WEmy6LejFeDYdAu47bYbEgz/tZm/TAXDjmQxfRZbLOUrrKK0ob3QCH/agas1AKFzap889hlRqJSC9TTKIFgZmQUSK6p9kA+J8i85SA7w4p4ht5utpC8FCuzyzVZDHsv+oe3TIYqlmnoDrbKN9IcDDpqjFkvxVC0ZKw2ejYuOGRvLPcszXAFiq758NV46rET7XVq5zMNtX6u34xsMp532iUc5gpsbN2O4kx1ytJrLe7Anh3KfJGPEuX4UojpT7awD3sNVDLHVVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818373; c=relaxed/relaxed;
	bh=uVwVNe3cqI0RCHG1xJv3LRo5BwxDkOUdlieXkffr7Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VzZRlaWGUPur6IdaCRnumv0VxqdkYm3PFIKR7hsw1f0RWMiiQ7iZ8Wvtl9Y7eoCE1NfANsCs9/4cbghVm8Cx6xUAjMnq47GjgmIPvFauJBKsKillpEe+cKWRbDAV6r0Rr2pGlPKSEoYNIXfENClb9UfewV52jHxwni5jWXCgFjnJgdrMaaWjQcIuIl1Jwt8fjr9GU4L6sKIIKOCHKB+lOiJRuEGkMOnA3LiIag/IZ9FPCiaW1T0Y5tY58YW3e6ZbTb4gtlQ82RZ+NlqKN/hz77sdr/URnwYNd9Sud8r/rAwnbker+22QrypEczPP6ZWM+SkJTSqTroGOj2iybwoKaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d7Q4x75X; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3gd8vaggkdo4qhtr+wyjweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d7Q4x75X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3gd8vaggkdo4qhtr+wyjweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rN6nYSz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:32 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-45e2f74da10so10467236f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818370; x=1780423170; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVwVNe3cqI0RCHG1xJv3LRo5BwxDkOUdlieXkffr7Nw=;
        b=d7Q4x75XdYlEw2F5hGksg80/oW7eWV+LO6u/EHNegYkVQmzRRta/RZyF8Dy1c5WBeW
         CWc8k09KKYpXWa1rgLeG/7M44ToIVj+cm2z6O4e2Gi8ojvX2fwrHMBRLESI65b05u/KV
         yXAUHMeaWdUaejqlprkSI30Ea5/1KB+vk6bIgqGYjDfk/hKs/TddsCSm+n5NbFXC3t4q
         7SgMIuyPK9JsI1xeTX99Zh6uPz5IcGh2Mso2Z+9ZnfHHm/vq1EmA4acqBIj8c0S2sETL
         ntm8H52TtPSjLhh2lI3FnO6SGwKaVxnNAlKoOJvsTM/t/GJOoABm+IDjR7IydyGHmZ7d
         TatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818370; x=1780423170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVwVNe3cqI0RCHG1xJv3LRo5BwxDkOUdlieXkffr7Nw=;
        b=RymWe5yFhuBN28D7jsWkPRZV4EqK97rPEm0+Pj9MAXxuPuDdWxPcmkqylXxStbid6L
         GKGzRkeQuoY7mK/IHfQrTu/8wKKdJqwA07oFBHE762sjvPG77FhDO0gbOf0unO3j83Wq
         qaEYfaDj6SH2HgeuHk0y59W/UgF6XAbTbOL6DFydNx9bwXaRa8NZ2Hkf225Z+31JLcr+
         EdzEHBkoD3qxb9Uo1pVCXJhhpwtt061cJ9DeuD/XB9N9Kqske/e0QA+x73oBiYddK8Ax
         rQ4UarFwpuZDPZOBoxU/EJx/5frzR697yW4NVHbmzzgXJQLpzU21mP/5q3vh70pquf5Q
         +X2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ZQDylMc2z6BUpmlwtUvDp2PZWzplidLW0/BRLIe0JcJ3dmMrLeYSz28mF1p0IuxkfK/NCVVEY8nwNccM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyccUad/bTiBwYGfz4cVJCOKaeX4Kqqhwr9S29uMjoWzdB/8TKJ
	O5I+VBoFbMef7yZ1z7oVc02Q/IqjwiVW/CygcYGKAzo0gaH2mgPw/nEpoMQwEIoJZDLW7zeNQg=
	=
X-Received: from wmxb15-n2.prod.google.com ([2002:a05:600d:844f:20b0:48f:d328:60c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e14:b0:490:5cb3:e936
 with SMTP id 5b1f17b1804b1-4905cb3eb00mr223400195e9.4.1779818369475; Tue, 26
 May 2026 10:59:29 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:54 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
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
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=ardb@kernel.org;
 h=from:subject; bh=p/GjcIFRscd8SARDtYvyFpPt1lS/DKkRLXn2dxWNXF4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsKpx8vWnXp9PDbK7d7pQ5f7tV6IZt198fXxgbl3+
 RdMT7Zr6ShlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQAT0bvEyHDiTj+j5qWAr0Y/
 aoUNp/5XU7S1WV4v/ue8Dkfu9tf7llszMqzS+fykyFm2qtwylU02r291afDEKR3P9d4q/j84eW/ EbjYA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-24-ardb+git@google.com>
Subject: [PATCH v6 07/15] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the map_mem() routines respect existing page mappings and
contiguous granule sized blocks with the contiguous bit cleared, there
is no longer a reason to play tricks with the memblock NOMAP attribute.

Instead, the kfence pool can be allocated and mapped with page
granularity first, and this granularity will be respected when the rest
of DRAM is mapped later, even if block and contiguous mappings are
allowed for the remainder of those mappings.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d7a6991e1844..55bb40348a47 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1083,36 +1083,24 @@ static int __init parse_kfence_early_init(char *arg)
 }
 early_param("kfence.sample_interval", parse_kfence_early_init);
 
-static phys_addr_t __init arm64_kfence_alloc_pool(void)
+static void __init arm64_kfence_map_pool(void)
 {
 	phys_addr_t kfence_pool;
 
 	if (!kfence_early_init)
-		return 0;
+		return;
 
 	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
 	if (!kfence_pool) {
 		pr_err("failed to allocate kfence pool\n");
 		kfence_early_init = false;
-		return 0;
-	}
-
-	/* Temporarily mark as NOMAP. */
-	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
-
-	return kfence_pool;
-}
-
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
-{
-	if (!kfence_pool)
 		return;
+	}
 
 	/* KFENCE pool needs page-level mapping. */
 	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 	__kfence_pool = phys_to_virt(kfence_pool);
 }
 
@@ -1144,8 +1132,7 @@ bool arch_kfence_init_pool(void)
 }
 #else /* CONFIG_KFENCE */
 
-static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
+static inline void arm64_kfence_map_pool(void) { }
 
 #endif /* CONFIG_KFENCE */
 
@@ -1155,7 +1142,6 @@ static void __init map_mem(void)
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	phys_addr_t early_kfence_pool;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
@@ -1172,7 +1158,7 @@ static void __init map_mem(void)
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
 		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
-	early_kfence_pool = arm64_kfence_alloc_pool();
+	arm64_kfence_map_pool();
 
 	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
 
@@ -1210,7 +1196,6 @@ static void __init map_mem(void)
 	 */
 	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog


