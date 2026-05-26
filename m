Return-Path: <linuxppc-dev+bounces-21543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768B2CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78w5GSMz2yRl;
	Wed, 27 May 2026 08:44:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818378;
	cv=none; b=Hz1o9UYf5LYf9NniEQwcWTlE5lkr1t40vaN/nYuS09CCRExH0A4Xy6GyxQy/V9Xgd+8MhwsIdJnytY7wPt+4Su0iYDnqnhlA1eG4Uu0ZF8cxsKAmdZN+4H7FQfb4G9b81zGgHlsFM5eMZ6Pl4lw/tQQkFn/mMnjQaL0nb+x9L49NdREb/tSU61Bk61sFTXCE12fw6i8R5m9eLrb+ZwhUjpzf9cUyCidZdihMPF0V9dafxBjZMvq58jbLn/Q6CzgZzk98u2jXpUatBTi9giTQO9uVeejjxKTsjj0X9SfyJ4/fRqC/I71EXmad3fVDvrkPAwhsqcrmmW7z3VGZ4airqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818378; c=relaxed/relaxed;
	bh=hN7dKQgvYd9nbZsuBceB/G3FfRSci9s4lIdLcy6NsRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9jFoygA/NZrA303X9KjNeDsrf/+wNv9ZKObA4yblaZH3HBYLVSVo4gGwxb7zykO3BKJpgtAyO8sXsZhyujDz+sIbasL5XRJZZknHyvi2PJm+PR5EQaWXRmslnvkFhlHjfdZeUKk+ang76f6ykHKsBj+aLM3VpstCafBGbXxWBMUVqEX1T70/c/7etV8Gma0ZsUkwmsJsqlMAfGNyykIhDvOrQmuwXk7smgbDQaIzsBT2JZuBhRBHwGvPFc5FIk90tmmZF6qp7aLKN6GU8XHl780stw8wrCcvTyxl97EnAyzS5JUBsSfuNbFhTaNt47qamG6MFYcgvG7MGjgC0gQTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BMd1DutY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3h98vaggkdpqwnzx+cepckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BMd1DutY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3h98vaggkdpqwnzx+cepckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rV11cwz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:38 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so30960055e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818375; x=1780423175; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hN7dKQgvYd9nbZsuBceB/G3FfRSci9s4lIdLcy6NsRQ=;
        b=BMd1DutYHxdpMj7elHExtcIjiIbXpw99JWz+DAyJ3f/mQzlaDBy87J7Kdyj5TZas7g
         f/i3qZn8BFIdI4gVQSUXna20aZrrXMDKBwlGb0xNmrQGr/rGDQYEYwaRlc0sE+3ewexO
         I0is7ZbQhVQYSJRMtx50CeOlzfaBPIKZANSvrXF10y8UG+3Vi6uihRiC1Y9xt6fn3YjD
         Lu7LFLq23F24H9cqcJL50XPMEaXLREMPPIiw2wMusmr9YrhU1UOZod7/evxObolSaFa0
         vdUkw4OBCTSYS3O9JaVcLKdrI431QiM9ShwfqRgeDFHcENCpb3jQ4Mh53oHHDBAPIbhK
         ARcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818375; x=1780423175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN7dKQgvYd9nbZsuBceB/G3FfRSci9s4lIdLcy6NsRQ=;
        b=BhuUdLLrhWRt2lwtPeUIg0P4Zh1mEMK3BNQ9X1Zi0JsocJnKmLTwcIy3+kTBuH7LpJ
         9iTwVUbehh5Ak8XfT+be/0RD2xr1c7zEh+9NvmOE1MoievkAwNM5KWoynw8lJ28HbvaT
         C4XvL/ODYCt1CeKQ9F7UmacRNzg7FN0kFpVJy3BEmeCCwWlUopNdNPrmSEwSJGfGe47B
         w5t071a7VR0Ec/xffhMu7wicIIMy7ZOmJnYiqWSz8oDA+hW9dxStoenjhDRWvbiux2vJ
         L8tcV+WigesrTmXiB7RPdw/l9rlGyQAZd76vVEUXzwXGGWcAfqUxoGYpjvNEV2jm2BAf
         q+lQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nu6q84D7FIUCWdFu4yZwDJgRrdFiomGw3+Yf1gIuFSMdiq4DfPZattk5l/iL8zqP5Yn0V8lEFVTqExqE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxnf8XP8D3fa9AqHQBEIQICyK0ZCQkFXSVL7OOTFfpi+mL8fn+h
	mvzhPvw9hZ2ZqzvVVGTpTEeH2zoh562DbYdJR4kYImJTqIaJOK/WIPq2PAFQXp/QsB/Ccum1xQ=
	=
X-Received: from wmrk9.prod.google.com ([2002:a05:600c:b49:b0:490:7e29:9cea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a402:b0:490:3f7a:108b
 with SMTP id 5b1f17b1804b1-490426c5be8mr278139655e9.16.1779818375139; Tue, 26
 May 2026 10:59:35 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:58 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=ardb@kernel.org;
 h=from:subject; bh=bcrl0Dq8YQBZ2y6oSLTxv/uZS/MgfYTkD9gOirfShVU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fppn5XvTONsranx8M7mVQs+XJQdo2RuuSWq7JaMf9
 7fh7PqOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJEXcowMtw6WZR/exrN7YplZ
 UMhusfI9n1W/fnxWF5Br8bb/o5j6XUaG9kh5ycXzfXi7yhR03u2bYfF33raUQN5POWLfbh9Jdln ECgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-28-ardb+git@google.com>
Subject: [PATCH v6 11/15] arm64: mm: Map the kernel data/bss read-only in the
 linear map
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

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region. This is not needed, so map them read-only as well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b20c76b8381d..e7ca53d20b87 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1138,7 +1138,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
 	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
@@ -1171,7 +1173,11 @@ static void __init map_mem(void)
 	 * of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
+	__map_memblock(kernel_start, init_begin, PAGE_KERNEL, flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1183,6 +1189,11 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog


