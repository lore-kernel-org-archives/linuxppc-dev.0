Return-Path: <linuxppc-dev+bounces-21733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2170CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmj6NV6z3bwf;
	Sat, 30 May 2026 01:02:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066949;
	cv=none; b=kX987DYRfu6BFpR/RFKUK4XpEUBPBZZZ7A54nmL7bTeIozF2dUaD3hj4HHnVUf6g40mC8fByDg/8GZDSTIeiKIsAHBc7o8IfD58JDwAN2hN92fUZwXTxfk30lFHHm3Jd5ASnCTh8pvX9+4G3YhLfXy+C4JdSp+NQ9+FKsMNS6u1hyuCIMi3xauJfQ3KGjOUxY6qokKls2Mec2QpQTHwm9bd/ntkvPaG7SgofDnpnVjOEzcQT1zFza2Lol6kFQrxxqMHq1Avssp4UtgGn4kCmLG7ho4BwkI2qwRfyPQnso/OcUSqqVg43BtVJ2yLW0QHVaa0w2X/21upctZ9VcixJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066949; c=relaxed/relaxed;
	bh=uCoU+OqdPKjZv36ACGpsB/y/JO/SUTxBEuaSym4ONwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJSUpbuwCHrkNPpZe5oZ/G3ci2+Upxv74zd+hExu64ZjxfVo9O9q+hi9MIgQrmHAbFGxSY8cWC65Vjy6+6z4v5siBj9qI1n6VCrGuaSfkHmwWw78MZO5HzJm2agJCwqe/xbg1EharcMnqjosa0OTIF9nulnHx4Xqt+Q5m9JsgR4dP4S9ImmzGrM/JSirTYp/PdnxK19vr3d0pk0Aw18G7R9RvXqoHIYykI3G2CzzQEppxP7aOa+nc59Tss52CEs/UDv+QopmD5uuRyVcQHMnHQaHfGkI5KeRW9zxmnwsT2LPfagUsqhhIAAG2Vh0hAAjbFkNYE/2CkV7T9ecvgWSAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AlKdb/rh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3gaozaggkdjqyf1z+46h4cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AlKdb/rh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3gaozaggkdjqyf1z+46h4cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmh5YJdz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:28 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4909deb82d0so5763825e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066946; x=1780671746; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCoU+OqdPKjZv36ACGpsB/y/JO/SUTxBEuaSym4ONwQ=;
        b=AlKdb/rhAgmf4pJFBet81LdGJLVlgFiQsUhN6pY6WK0kwmLLn7omjO7CyMTto/70xo
         HCKj2Q9pLkZDf9u/JBcmDaYN4D3XTjDLHAfG1M6xiq+hF/M0OmviU/O7Gkal2q2iPvhO
         dyI/OdHRwwT9pcnaTuGgpKEnzieUUVqX7iwvEG5PAegieHGXBrqc3g5rdbBE+//2EIoe
         tdZfZD7I0I6qkrps9a+8qxnqBgjU8Lk9iazMztLFNO4lL6TKChMN2lJ6qQD0GzyBIMlX
         StRy14Ar9zuYJB8Z71yQXOIgD7EAexRsHNx+xAx93FmdaA9ojGfW67wBvpZehCL4xldv
         dvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066946; x=1780671746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCoU+OqdPKjZv36ACGpsB/y/JO/SUTxBEuaSym4ONwQ=;
        b=fXqNVD7lg0XLTUXHzF2+BCRvSQM8m1yhgXAY3YYNC9nKrmSOkl6ZqQCho4sxT6CFXF
         Zgb3UaSpq6+uWACTU+7lAAdRhnW5ncldKmMiBLsVQ0khiVa2lpNhoCa2jioZaezXIUZT
         KN95259ocul91Gib4sU7Z0VTAKh6d68f2fF312HTMfBovYhJ+rfclrUT+tZ0vjO22Vh4
         IZEDkO3tcvc5lalCdw1yQzgMRO0nkAaaVKrfp99XOMTEq8yiYu55EypL9037Emms9roM
         vWFKQ0gToQqLAP5F96Q6Lsu2BOq35SrM1Eq560+lKo1Hbu5dCyouEsGz4JwZLg1LxV1d
         /e8g==
X-Forwarded-Encrypted: i=1; AFNElJ/ZNztk6bYjsfipAHdoVIJokktGWIOWwH9xXuoCL8pRk0uWjS6ITHyeoXonHJ0PsbhrYs7QPEgc/xfRdts=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZvEzWtzJgl/5AmlWH+bZAhoZwJlXkKk27Xipanx6FQUU8O2Bo
	AlO0juUv+lwe5g9QfJAXTAciLmy899eJWf1/th8x3ZaXEfC3I9HiC1giLHhLjvD59iGNVUcPHQ=
	=
X-Received: from wrmj18.prod.google.com ([2002:adf:e512:0:b0:45e:e492:5442])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c3cc:20b0:48f:d5b2:7c42
 with SMTP id 5b1f17b1804b1-4909c0b3407mr46324775e9.17.1780066945605; Fri, 29
 May 2026 08:02:25 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:58 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=ardb@kernel.org;
 h=from:subject; bh=rMwJ7nJEkWuFVb2g2PkvQNTUrTu6Td3Xh3QWQo7SqgA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVXqXnoyd+bugGevMve7XfXSUYDy66PR9M/aLkzVbX
 p2pPhPVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyMoGR4ftyuXTZZXPnLH8h
 GixVcqWVUTT36gvPhyW+7FMbBCYlHmdkmHBv/+orSg1td3qYcmOUt24wv3i7fwlXUYFT1dq0heu t2AE=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-24-ardb+git@google.com>
Subject: [PATCH v7 07/15] arm64: kfence: Avoid NOMAP tricks when mapping the
 early pool
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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

Add the NO_EXEC_MAPPINGS flag to ensure that hierarchical XN attributes
are set on the intermediate page tables that are allocated when mapping
the pool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 27 +++++---------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d7a6991e1844..cdf8b3510229 100644
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
-			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
+			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS | NO_EXEC_MAPPINGS);
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
2.54.0.823.g6e5bcc1fc9-goog


