Return-Path: <linuxppc-dev+bounces-21734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41EECD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmml0z9Mz3byh;
	Sat, 30 May 2026 01:02:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066951;
	cv=none; b=El3t/ncXCV/FM70NrszO35V3wSapyvtvKC9TSzl5N/J4ItwEMdnnnUV+DCYJ1zSBxLrJ/ABrhZZCkgI/l3/4FWXCYndLXNt3kFoqg3gjbEG2dTGD6nbQ1qDGSAYunEOn0DPqfytHYnwdcq+pLdsFOhAbZ5VdGTk9tWYFdBqg+IKFeIBND8lKyrOjqcwFfl5nFJNIONYfmfzo8Z1+OOYL9fHBby62FkbgVkNyW8PpFk5fxhBvNQ0NxhScT67qsbMEj5CP9dZixV2v/4bqGzhOncvAGktD8Si+iCxr/VFipjq1al6+ipOXxbMqu2mq6NHjzw4U0nSq9zC22ndW16PM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066951; c=relaxed/relaxed;
	bh=i9tlxHwsxA6eqo2SKmJcmasVfNUkIRzlQyYjktT989Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htZrf0eh/hbeilmk1EW/7RNgmbWmyuCynB0feqjK8LLd9jWpVNqJ9u6sg/9q/azADyVr/eRXmqPcQK5+EVdJa0DQ+am2Jhf+Ehmc4EwrFOKwDezBuimv0tIQCfrAQeZQKzwt1G+XBilCX6U+IVeVWqI8PWEmftS4MhiKX6/ZjbVG30uyKAt+MGG709+21OByVZ/o83gvWxIVTH8zXP1JTbnoWXhW1ndNEhvgbb+fdcGp/gZgtnq+pFNT1b+oSEgKxMxcCvpIMKuEi+NmbbfA15yomQVqbErM/VTHpuQ65J5Odq+DILBUFyB8PJ6RRnXAt3Y2YR+lvTzthDfUtznKXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ctbb1uRW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3gqozaggkdjuzg20+57i5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ctbb1uRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3gqozaggkdjuzg20+57i5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmk1BHmz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:30 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-49058295985so41886125e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066947; x=1780671747; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tlxHwsxA6eqo2SKmJcmasVfNUkIRzlQyYjktT989Y=;
        b=Ctbb1uRWuWJ++ohlwdBllh4lGLdmmSjIrGXBnHVDXmYs2Ve/apFrKwj9qYOfSTJ5p1
         tx9L3I3Ldh+QkxN0EC9tQYa+DLpgAsEca+BUTI28Go2kTSWJdLEyhRU7HmQF5Rxc6K6A
         AE1PRtFRPsIo+RmmrAU67BaQUoe8u++MWeNR9lrqXbcKseUpU3ZJgwe5uG2HXNmyLU2R
         BD4KRPj/R2awjJ7PVP7YD6667kHvpTUMmggAklitOTQNX2O73V/txc1X4B3Ro5fIpXXC
         DO8IifwFbEbI3BRWMSdqm9CjoTpo/pOZvGexKedNQA4knpM7UkbMYwGKOFMSAclSeaFV
         h90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066947; x=1780671747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tlxHwsxA6eqo2SKmJcmasVfNUkIRzlQyYjktT989Y=;
        b=q0aDbFFDe2cP98XEGKTxw/x7mGIoZ2L/Cq6p1A2+AR2sXTYCyuqGJmMyJIvQwVehTe
         ifo4Wh+n5/3o1dqiuLJ+swdZ8wIPpRvSz/Q0gkMCPN1pBDA3cng16Frwe2mnfaikIfE9
         IRh9W9AlfgFWWiUHPcPu3JlToZGhIVX86RBwUG4rxfoupIxP+Dp2c2Ffd+Y/01oWtheU
         ze6JjaN+p02/5Rmg4aLLev3DzQ+ATiDhuFx2824xIK5AtVa7nv9F5k4Qa7XOppvgFS6K
         3o+MyPyNOnPcOkXPq7KlT2QrqsGspJhIy9+BqPlgkUcho9zXS+P990aa5n4woQdqb4g3
         6IwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j2wbEar2V8JcWYVni251mJO4/Ht3qKMiyZsEm4eMydlS/gCRPh40Vv1vUXk/R6xZE1pTivLfY8wYWdSQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yygx26ykq4gZ7B60BHsttCsAoo0ojKv3yyYVr8+ylssqCu45qjt
	JgBVxwv9IZPhBCf7l4i92IiajmaSQO5sXDMo7CCiwS6PLba+CjggqGleA0gLrcCzKUBJaZ+GYA=
	=
X-Received: from wmaq22.prod.google.com ([2002:a05:600c:6c96:b0:48f:dc9f:6f14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b14:b0:490:4b89:5361
 with SMTP id 5b1f17b1804b1-490a2904d7fmr303015e9.7.1780066946805; Fri, 29 May
 2026 08:02:26 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:59 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=ardb@kernel.org;
 h=from:subject; bh=TyyULer9eaKHyQ1BOINcFoCv1vvnMukGL48REtJhPzs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVUboiS16Xkfr8iLbWErOKcytU4vuVJk0+76BcO5Hz
 rb1+sUdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKqGxgZNjU07DG6GaTpezdh
 zbZrEwzidjxa865atLfK9/GeO2emyzH8d7MLuK/p3ZH8ib3z+D7vti6R81b7wgsSZrk1v7x+zKK WEQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-25-ardb+git@google.com>
Subject: [PATCH v7 08/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

There are a few cases where we omit the contiguous hint for mappings
that start out as read-write and are remapped read-only later, on the
basis that manipulating live descriptors with the PTE_CONT attribute set
is unsafe. When support for the contiguous hint was added to the code,
the ARM ARM was ambiguous about this, and so we erred on the side of
caution.

In the meantime, this has been clarified [0], and regions that will be
remapped in their entirety, retaining the contiguous bit on all entries,
can use the contiguous hint both in the initial mapping as well as the
one that replaces it. Note that this requires that the logic that may be
called to remap overlapping regions respects existing valid descriptors
that have the contiguous bit cleared.

So omit the NO_CONT_MAPPINGS flag in places where it is unneeded.

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cdf8b3510229..971996e46fd1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1016,8 +1016,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -1044,8 +1043,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-				 NO_CONT_MAPPINGS);
+	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
 
 	/* flush the TLBs after updating live kernel mappings */
 	flush_tlb_kernel_range(virt, virt + size);
@@ -1191,10 +1189,8 @@ static void __init map_mem(void)
 	 * alternative patching has completed). This makes the contents
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
-	 * Note that contiguous mappings cannot be remapped in this way,
-	 * so we should avoid them here.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


