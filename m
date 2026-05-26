Return-Path: <linuxppc-dev+bounces-21544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEE5CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ7924P41z2ybR;
	Wed, 27 May 2026 08:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818380;
	cv=none; b=hLezXGVk24kB3E5m3Iq/U7jAeRs63dpSPJJsbnCzaS+YdAbn+y+N9z4BSBK/3oGNhrXpj/BJ3gBgdONSj1HBjWl8Wqng0OClEuEoaiVmAQapE3T2y9cHOxHZP7ZBSzC0cMb0LqMcE7lXxIHHIyBzv7YqFQ7VD5kq0h41gMA60Cf+veoPgU9nitYW7xDWBemWHiAYLJviqWbsP2A6XpyxAsuXE4mFenirER5Boj2ajyfZnvQSBG66re/bS9kaqqzjpZTeSvyw9zhIUP4hV7QqSaruyprHw5xC2UMMaGG0iXqjfeyZIqyIWUJw59RhAcYFgb6BqHKccemXPf7gbgZHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818380; c=relaxed/relaxed;
	bh=ZqWf3aIh9jwoRDW7ej6OaYtUXPKSIApXmlGfcanpMS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otftca3gJlsLkqskR4yx5vIjClulDdT8TaeYDDX5tUSHa3RFzvIg0y8rY3QqsupYF5Sij10J0ZDlTt/FMdoChQMcUP4/T0lAsIkl8o0Q6odFsdd5m8BBd/dtqGfV4jNEVb0F+T2glwtz4w6YWaVeMZaIZ0dFlrV7HowT9oVKOKlJjk4ll/sAco5L8vQyOTjmy/Sc+Dlj+Jji3IdPLQ2T85ZiCTMd15vB8IiptBphOQoWJqNw9u6bwZQqXdT6vad3LK494XM3R0uQ5c/THDbRW4brmZ6R8HPVVIS9WhaBQ0Pa3AR406QENzY9iy/Hq2MBffkPBfl59sLVIaAslp9bxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DwnVCqYz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3in8vaggkdpuxoay+dfqdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DwnVCqYz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3in8vaggkdpuxoay+dfqdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rW1XhXz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:39 +1000 (AEST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-67c2ce99bc4so10895128a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818376; x=1780423176; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqWf3aIh9jwoRDW7ej6OaYtUXPKSIApXmlGfcanpMS4=;
        b=DwnVCqYzH4NGHEIfeF80qiqsTNXowT6wwzjavHTzHXR6JTmbWluYpfKuS7NYj6nhUr
         wHqeHQSiAxHwdDNBsPxl8Eiqo36kTzO34L5wfsb/CWtZG2AMwEzT4qThD7HlITY2o5vk
         lfmZhkEyWR7Ww/SbDMAii6IkKwtcq5T4iAveGGfNI8UXaWj/ByccixqLcAdcG5m1WfLE
         JB6fAiKMRnkhup6gtd5KOv306IC4vT418gOyaJuoUw1PfAYxoQ+BYQvu2PaoF4bRvc1B
         zvxd27awKcUkRVsjquhFftFHtbPLmVNJ8eaAk9dfktUSQr5zlNDrMlfn8tRE3iQPb7/J
         GuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818376; x=1780423176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqWf3aIh9jwoRDW7ej6OaYtUXPKSIApXmlGfcanpMS4=;
        b=S0mSi3TfAn1ZZ71JdOg9+BdrFBFYsEFwUyoo491NtLzkBlwq9XKJlH/mUZt97reLZg
         W6y6HyvHhqSlnGEjdRMCe186uW7GfNtXxKcABztsgnhLZO64jJCTL6uglyS1307PwmYC
         gbBESBv1t2tpiR+XUQLlr8TqNOLmLHWF1MY39rN8lE1T2/iWvDp6aAd1vfCm1DgNnbfD
         zmIe7QsLHrwo9z1C2CMwttZ7eCef72Rle520XbB8KQgpOQsTKvgeEBvqmFN4QAVcL0Xj
         RzNzC+s92YxgM5OjzeQa5FTCDRCoNjntmZkmhxwDBSZhUKFQRTSMbmmRGnTKJizbUVCP
         BevQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5TBpcjWFBdIgxX8CBUJIVg6CL19SmaXSJVq+wBuJTYsntDnWVDYrcQKa529KeCKbQ21OIx3RzysWdeqY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzxExRV9yTyGqa8F19Mooa0nNVbCaA+5tG5+qutdr1Ex4kDEXWI
	PbZgZIwfPDVMjLwpIrT2DAMyKUuY6xW755avMARpvDw9qmP6qiYpTvjtW3H+aycGfRbLoG22zQ=
	=
X-Received: from edqv21.prod.google.com ([2002:aa7:d815:0:b0:67b:7c67:1fa3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4348:b0:674:5b2c:d42c
 with SMTP id 4fb4d7f45d1cf-6889c406b3cmr9914567a12.3.1779818376178; Tue, 26
 May 2026 10:59:36 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:59 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ardb@kernel.org;
 h=from:subject; bh=UEzDYeArIhcNSC2frPncytSQGHg972cpOAqaWBBxbIk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnq9X+pUBo2wreeSOJ9dXiQeemVxk13k2m0KUYbfu
 fQXzIvuKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRzGRkWNkdW18r/eqia85v
 tUMNMXXf3V+K+oQl+nh/av96UvTZBEaGFv6biY3/V70q4frOvkbMYcPfR2skZm6tkJiyR9TynUs ZOwA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-29-ardb+git@google.com>
Subject: [PATCH v6 12/15] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining use of map_patch_area() is mapping the zero page, and
immediately unmapping it again so that the intermediate page table
levels are all guaranteed to be populated.

The use of the zero page here is completely arbitrary, and not harmful
per se, but currently, it creates a writable mapping, and does so in a
manner that requires that the empty_zero_page[] symbol is not
const-qualified.

Given that this is about to change, and that map_patch_area() now never
maps anything other than the zero page, let's simplify the code and
- remove the helpers and call [un]map_kernel_page() directly
- take the PA of empty_zero_page directly
- create a read-only temporary mapping.

This allows empty_zero_page[] to be repainted as const u8[] in a
subsequent patch, without making substantial changes to this code
patching logic.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/powerpc/lib/code-patching.c | 52 +-------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f84e0337cc02..44ff9f684bef 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -60,9 +60,6 @@ struct patch_context {
 
 static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
 
-static int map_patch_area(void *addr, unsigned long text_poke_addr);
-static void unmap_patch_area(unsigned long addr);
-
 static bool mm_patch_enabled(void)
 {
 	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
@@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
 
 	// Map/unmap the area to ensure all page tables are pre-allocated
 	addr = (unsigned long)area->addr;
-	err = map_patch_area(empty_zero_page, addr);
+	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
 	if (err)
 		return err;
 
-	unmap_patch_area(addr);
+	unmap_kernel_page(addr);
 
 	this_cpu_write(cpu_patching_context.area, area);
 	this_cpu_write(cpu_patching_context.addr, addr);
@@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
 		return __pa_symbol(addr) >> PAGE_SHIFT;
 }
 
-/*
- * This can be called for kernel text or a module.
- */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
-{
-	unsigned long pfn = get_patch_pfn(addr);
-
-	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
-}
-
-static void unmap_patch_area(unsigned long addr)
-{
-	pte_t *ptep;
-	pmd_t *pmdp;
-	pud_t *pudp;
-	p4d_t *p4dp;
-	pgd_t *pgdp;
-
-	pgdp = pgd_offset_k(addr);
-	if (WARN_ON(pgd_none(*pgdp)))
-		return;
-
-	p4dp = p4d_offset(pgdp, addr);
-	if (WARN_ON(p4d_none(*p4dp)))
-		return;
-
-	pudp = pud_offset(p4dp, addr);
-	if (WARN_ON(pud_none(*pudp)))
-		return;
-
-	pmdp = pmd_offset(pudp, addr);
-	if (WARN_ON(pmd_none(*pmdp)))
-		return;
-
-	ptep = pte_offset_kernel(pmdp, addr);
-	if (WARN_ON(pte_none(*ptep)))
-		return;
-
-	/*
-	 * In hash, pte_clear flushes the tlb, in radix, we have to
-	 */
-	pte_clear(&init_mm, addr, ptep);
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-}
-
 static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
 {
 	int err;
-- 
2.54.0.794.g4f17f83d09-goog


