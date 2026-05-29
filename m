Return-Path: <linuxppc-dev+bounces-21737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B8CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmq5W7zz3c4P;
	Sat, 30 May 2026 01:02:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066955;
	cv=none; b=BJlF+OxOJDjPaXdVf+WRC5g2gJErwRebPleJKiTbvopw140RD+DITYc1jqXaLaiTb/hwLX+HZGsdU2zmfiRsuEWbZGTg3d+8y4OVZ9mG3gI7tmMCij7IMtzCtd7tha1/RiM7ZiF68XvCKlv6DfiUMQFBhH1uY39C9JERGckyJuNNyLpZOHdn50MAXZ8ylI91agsOGzXW8OnCfsZ4g62exzIeb3Wz0yc3YqCGsb3NphDVqfd8PRpU8VtJgh/oXCoFXQs3e29+JHYMGcXXciD4GlMdaNKVg7NDbkNmqUMiXcsHrRjlHjPK6JA+zkDKBrtyi4VV2I+uYFENajuJ9NVVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066955; c=relaxed/relaxed;
	bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rr1bJsxUhnRKofVcBQ8kmG06r+ICE1M6n3OB6i8sQyHv8bnr9QbzNW3F6BmTGVdKyAqcdGwdWCb9lnXT9oNbKBlt6czrSszTHNRTNKdAWmxqC5uMEiEWWThgPRjTb/v5jZB5/OcFPBcTKk4Pc9GqIShborcUL/cTR4UKgXVlTnbBPTkfCqoF3EfLM6n+94EYUzSLdcz8+8cLm2wPqJjn9jwAkb3FjFKMtG6Jk0GFlWpsRFDx6HjHPwQg51+kde8WSXJf8qlkyuMMJVEDqPlkyzQFxNAIW5L+mCJxgo8vygrzBsD5rs0sf0h8zreAQNfIKOQS9VrW+s3clV5wwrMNSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jj+sQEGI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=3hqozaggkdjk3k64+9bm9hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jj+sQEGI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=3hqozaggkdjk3k64+9bm9hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmp6GPLz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:34 +1000 (AEST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bd2a8eb9281so218495166b.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066952; x=1780671752; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=Jj+sQEGI+0diyY7O3t/o8y5+qH/D+n6V0Hbcg8tHxe+ML0hpdbcgtMqqqTI8dxSedp
         dH2cfyNtlYQxJLSY9H6Hk6BwLsl7274gM7CVr4YsTOzOev0J6ZYILksCfFdrzAMzmbPn
         2dzR+KCVGGHMuFsjXHkyIeLk5v6/r3O29CLGpgDXponpGYbuTBDI7pJi/wcXexoEobXC
         dvpY3lYY2y2lXzQXaDjEE/4kKZVHB+nmjswKpvxNv0vvIkZmHXBeIcL1Csr8h3mZcC1D
         YA4C49NFT/+H/H+3d9bHvIrusq61M5BZ90YBmJWJeZi6PaGxZUQ2rVJ9F26Ix+dsWYrw
         HoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066952; x=1780671752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic2DGsrtEHhUHaDXXEd0q4Y8zWmRk/iCag+la1hIg4=;
        b=e+RxKdPCB9bHJNCfjqQfXxtXcRQwf6qbdr25RKR1z7TFjuDSxtaXaMd/cTl/+yv66z
         dtW2f4AOFZdE1HqcIwyqsqN5PDN3riVHA6/okyKrs35Svezdc/BRoM77Y0PN6IZf/oQv
         47Sz158OLDdzFVl5UlAXz/k+TyNCKAzCiQ6zy68X6jeN69BFdnsNF1SY57W20bNAl+Ip
         P0BU0F6JUAemq9tY6Uc9gZiAS4CD4n/TBS4dVXe7P6cAAgS93NXbjpHUGskF5RUffL1s
         WQoac1JGmNPha5j6tVMXhhkYZPH2/3K/C/zN8+3TZlYBrla6YDSP+f9nN/K0fi2Bg+u5
         u9sw==
X-Forwarded-Encrypted: i=1; AFNElJ/z4QzMryvbgo2l3sCCr5clNX+CKh0Q8Di1Ce/az+3v16639scc/3pax838luZamn823h5dGL4QgCiG4Tw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzzJnWiprBKkyDsQ1+V8WylqygQv9XXUYf3OHA//AiX8DJmWrL6
	HMl5bzsk+g7L8lAkOQyPF81U/FEdtmZfH6oDQiAvuiF+HZpWkk9Ezubcul4bDnds7Sh5uiGBSA=
	=
X-Received: from ejcdp16.prod.google.com ([2002:a17:906:c150:b0:bcc:71b:965d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:846:b0:bd5:7c2:7622
 with SMTP id a640c23a62f3a-be9cce79583mr206170566b.49.1780066950536; Fri, 29
 May 2026 08:02:30 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:02 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=ardb@kernel.org;
 h=from:subject; bh=ubRBWkWn2UVZmjj/MlvsEvyHLMfMbEt4k4F760d5eRs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVY4k535dO+nZFlbOfzzdd/L8Kc16wKgvUGy0L8C+M
 NAkc31HKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMji6YwM9xVOLdQXVDy63md1
 QcOOcqYQ72WntJ6eyrZNi+loev33MsP/3BPHG8Off7zik3rM8U/Y17jQr64tKe5X7+RwlEXo3Rb gAwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-28-ardb+git@google.com>
Subject: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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
2.54.0.823.g6e5bcc1fc9-goog


