Return-Path: <linuxppc-dev+bounces-21540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2CACD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78W70SYz2ypm;
	Wed, 27 May 2026 08:43:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818375;
	cv=none; b=DeiVU7RTQ9P+mfWhnHWGQgKpPVpqFqHYPDg6Xdyr3rx1rKWubV2wBe/NK0Tdky+2Wha8s1i7Rn/lAsMoKq2wzhsaAM0qg8XFGUoPpK9RyKHsVM8ydN4kpVROLleZZ0mWP2STrKleXG36UotHd0gNEFgNCfdv+LqCIp5AO1fkEsQWJ7eu9ZHn1Wx4WZXzclRt4VGlyLaUp/yx5QbSMSZ/1/PFOmvgGrCZuA97GuzEUV0axG/jL3KK8O3HxGQTndBJ1xQJJjblIDIfA0OhO3mHDJxcmEdnY4Zbuwsceqg+j+8vTshIivVnWZNXsbijgvVymdyn8itjW9MhnPDV8BhFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818375; c=relaxed/relaxed;
	bh=8QGcTo9f84jQQ3RURqBOJp1vLQa/oONqz3vOx7niDYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jf/haIx44Bz7iEGa8uJL3gvhgfv9MOoQilIhWl/H7ohI5sACAXR+iO42MldxaKMdhQb4edjrAZlNbOMw2Y0dJN4k2vyquNHTj2PmDRJR10egaXU03dgEc5rte6paxcndA3T1K/QmoGRr4Bk+a/J3otTrXjUAKwQlLNUpCtV5uMVWlFCLljjLoZDqMJRNzBkwsJomoSYFuK6FU0KjsRe5RHqql8LDEG6vqRRIR+LjFiZiy7W35jKZ8Y/ypvIvLV9f1SEgMxNOA6m4RHMx+36KmViVxhijgIDou8DxkGiP8G407dAm0rIxvYGGeUOZDoS18XrDYrHhQmkVijXRVWe1Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nj/DF5SZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=3gt8vaggkdo8rius+xzkxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nj/DF5SZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=3gt8vaggkdo8rius+xzkxffxcv.tfdczeloggt-uvmczjkj.fqcrsj.fix@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rQ0mLHz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:34 +1000 (AEST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bdad545342aso138902266b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818371; x=1780423171; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QGcTo9f84jQQ3RURqBOJp1vLQa/oONqz3vOx7niDYc=;
        b=nj/DF5SZunWjTPJbgTJSjV2fLIYumB9QmO2wUPc40wYzft6Gstt6t9NsfjOYDlHqNp
         eZRUvDxsH+fzArXYb3oZgDDMpxhWZP/UTn9mVJa1sCha0kKOgxuLc/S4Q+WqgH+kbLrt
         47l8yjhbrcemDFbpM2hyZjOOQtmpzvZwkr/+6opW/sY1pyE3ePgYJqxCpI4b6VOtpw8Q
         BikdC8YIm2tadY/aO675rMAPH90P7YaK3RfcDH+/3Mkjb9XeND5hS8ornOGF1Dgq4J01
         IrAcWD+47Ebw2D+3luyz/dgiE9EwDFU6lK/UKLemlUDSBlMk1NAO4gssiqH/fBo5C/ak
         ew3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818371; x=1780423171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QGcTo9f84jQQ3RURqBOJp1vLQa/oONqz3vOx7niDYc=;
        b=WvbcubdeekUyKNYdbaMLwRQcsybBVpBn2VIo1IEKWJ2Ki/onvXfHFMxNYAAfdTUBO4
         VI8Oofxx3ul4QLp1RiCdxuipQbk9ZeuUA2/zc9bHE+Wpn8p4aevSBw8dSDmKuxBdTrOO
         x7xAmxcxDJTnhjQMjW8dtyz7jQnn1LppDbmurWxrbltxfRkesu+icbEQ9VkI4USrYD/U
         QrWhAIJo9LUlJwiBsuRtnEwGWRF5dIGmc2hzvFa5YA8tcgERvXd59RjqzrGap5Ismh6+
         Kx8kE9DGMQmF3bJDk2v6v1s/jyKK+XLopjcCj34BLRqcPrx7jwA8ELpu6XKykBOFYv5/
         0jag==
X-Forwarded-Encrypted: i=1; AFNElJ/KByzJtHGBxiM4WW+DaEe+2Kf2D00unGr9IGZNyiPCltL6FCtzKK5vAKs4tZ4isCUilFNETM/W1wU19Qo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfJyKfgqdEFdxegSVpbAg6teBxZU1pmHAamjuseTKi1J0BaSPU
	bwlMgAvKmnWU+f6GYlukdHyyc82qLkymE2DmjzK++4zaaVPwuHppilCcoMYivEDFhBoI6jXYJA=
	=
X-Received: from edyn13.prod.google.com ([2002:a05:6402:6cd:b0:687:e30e:62a9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:ca84:b0:bd2:e940:db25
 with SMTP id a640c23a62f3a-bdd22e30cc2mr1206557666b.13.1779818370675; Tue, 26
 May 2026 10:59:30 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:55 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=ardb@kernel.org;
 h=from:subject; bh=xB9oKBi8uLt+1POTvwyFN4ig92BBqhDsXz5+cc7USWw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fhKj4MmKF6L9vM+ex9Rs9b0+/d9Nq+XeXuXTJwrky
 3esF1nfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby6AzD/9Dd3yeIi89KKpkZ
 tS7DjyPAYY6GxZyveRIHIpY9rS1/zc3wV6BhbVqFXb6I0JNF9ifsanP6XEOzznS/b/x27JQXe9l 0VgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-25-ardb+git@google.com>
Subject: [PATCH v6 08/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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

Thanks to Ryan for the reference.

[0] RJQQTC

For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 55bb40348a47..04cc579c7a15 100644
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
2.54.0.794.g4f17f83d09-goog


