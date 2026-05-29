Return-Path: <linuxppc-dev+bounces-21726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B745CD6E52
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmc30tsz2ykX;
	Sat, 30 May 2026 01:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066944;
	cv=none; b=PdRUFMaZLRCfWLRV5QhXB6ar02EOkvCIqd2iMtK5cSN4eVewpE5TkoIRrmTah0/yjMO6eW592x6obbfLBIzH8qgboeARoxxd31w62I/fvpx64gZP87VbkX8OYjV9Acw66Nwh48PJUPJTIt3RMhR+Xxwpzw+hLdXP6BPXf9GZXa7J8N1lmZpNwFVdizOIXMPQLjbt4NN9dhGB8kCwp+1kMel/Z9BkVN/tWiljNp43taVapZ5X/u6Qw129SI1wabWbUjyj7vMT1YKg7wRsYocMqbbNMm812Q1E3mYNO/dnmkrX09oXgMQqCAwEMfLS3F/YXNoDozked5b6Vu+BGzJJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066944; c=relaxed/relaxed;
	bh=RHwZV4K/OQyLo87ubxB2N7tui2RqyNeWqpTDKGM1mWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkhLajvyWsj0mG6ApxuRTr4LjTRm1HheI76QuRk40jDPjvOnt7i9zv4llPwtDm1T2DDkuyPvHtSSxY5b90mxpuUbqUbIkOMFkHQlviLJS9qI+dC7EERfTI4IoyXbhmAN4ZIliWIPrpBD0vg0kt7X3G0g/MxQvvrswuCp2j133HJqP78Y8v/3G9rJIgZTT4oBEbog0tjrAL/GTXMmouoZrHr6Tj+D1uaTJOBFbYsGOW587AM3W+GgmaZkk1y0L0iXSUfiJXZkYlwFlWtdxMctwCAifIMLenGVwEizcB5+sfry/BBrpRQqXP//aZWV5Cr7mIogNq3nCM4Ri4AoKH672w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmxa+GzO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3e6ozaggkdi4s9vt+y0by66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmxa+GzO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3e6ozaggkdi4s9vt+y0by66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmZ5C9nz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:22 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-49058295985so41885485e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066940; x=1780671740; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwZV4K/OQyLo87ubxB2N7tui2RqyNeWqpTDKGM1mWQ=;
        b=rmxa+GzOtWXtUvUqjGXua3/eJNrDzgDtr6ZUs9g/s5M+1E9uc54mUfCPUZHzKboFY4
         g8iiVoxGyJ94eJTvYD+mmhpRLugpG7qA7Sol9x1wbfILpkjaYiBpFfI4VMiIKgSxUBgG
         K4PHtVbb/tz5ECqNz/xnRc8Kpvx86CNwaWtUYaF7BsOTyNms2jHvrYG3oyD6lvw5wHGc
         zMfwby4ifH3pePFkhq5LGyzqYOP2IFjtmjbwlYBZzJuXO7UzIgHDkHiBgSF0wvWhk3cc
         X1UbFFbm2ulwT/gNZo0R5pF2t9qv3eo6RrLnEg9EOm5U6JFLYvkwia15afKNduuXw9e0
         uT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066940; x=1780671740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwZV4K/OQyLo87ubxB2N7tui2RqyNeWqpTDKGM1mWQ=;
        b=B/x9sFHi17YO8XQrxOorUof9xTeVcOko4VZoDaX3QJ5cRi8OlHX01H3pWy/NwU/s/P
         qpgEU2cj2N6U5Uv/iJuoX4Jiwp20O91EravCZXQf31OBDP1R3zIYUZLXyaiSwG5e8Hbc
         /BIdTBCsUkyre8QIbC9yKlJp5yzV+wPzKdeMQeSRP4Ws2rpdd+W/rFJDI06NvH9YoJcN
         DP//bS1DpkZh3VFfBvPS9rLz1VIOJ/ffIezOYTKRPuRwP6W7Mw0J8NK1LWopFIBe/ZEh
         WpimjeS3enIs0+j6uuXu9KPeFO89mXvbo1hn3HTgZhvQ1a74Dd0zIp+XFkcYHs/a+djS
         zXVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KnmoaBfgAeoB1sxT5bi8rwIzUls3QKjLvUgvrFyWzm0XNcdN8HIcq1Zkt3ZFYs7ThhEEwWsxrSVTCKV0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXsUwDA9HVCmgDt9kwoQKX0EtrhmsUzkrikWJlwHIWb/dyDExu
	Tz02MEQhpOYcKj6aYyQS8FPi64APsBH7y1J6KamOWw2Q/g/4KTSCzcsC0sXuJfraxThlFDqZ3Q=
	=
X-Received: from wmbz2.prod.google.com ([2002:a05:600c:c082:b0:490:3d2f:edc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:828d:b0:490:507c:bdb1
 with SMTP id 5b1f17b1804b1-490a291cbbemr329805e9.15.1780066939649; Fri, 29
 May 2026 08:02:19 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:53 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=ardb@kernel.org;
 h=from:subject; bh=RVK4+kwUNBzT2vP63qv/oNPK4oNSEDZX2ULcXiZameE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVeK1gth6p/IV1dd2mU+oVf+4YqKnwbIQxumu9bquP
 Yfu1HZ2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIncvMPIcGzv+x2vrDJc2eUk
 LtltCDno/Lq1Z7LA5Ge9k44qbfyXuZqR4dqGMNajx9vSleJns73yeprz3enQ4h9HLk24LK1xMO+ dISMA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-19-ardb+git@google.com>
Subject: [PATCH v7 02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
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

__map_memblock() and map_mem() always operate on swapper_pg_dir, so
there is no need to pass around a pgd_t pointer between them.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 112fa4a3b0eb..aa0e2c6435f7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1035,11 +1035,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 	flush_tlb_kernel_range(virt, virt + size);
 }
 
-static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
-				  phys_addr_t end, pgprot_t prot, int flags)
+static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
+				  pgprot_t prot, int flags)
 {
-	early_create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
-				 prot, early_pgtable_alloc, flags);
+	early_create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
+				 end - start, prot, early_pgtable_alloc, flags);
 }
 
 void __init mark_linear_text_alias_ro(void)
@@ -1087,13 +1087,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
 	return kfence_pool;
 }
 
-static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
+static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
 {
 	if (!kfence_pool)
 		return;
 
 	/* KFENCE pool needs page-level mapping. */
-	__map_memblock(pgdp, kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
+	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
 			pgprot_tagged(PAGE_KERNEL),
 			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
@@ -1129,11 +1129,11 @@ bool arch_kfence_init_pool(void)
 #else /* CONFIG_KFENCE */
 
 static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
-static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) { }
+static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
 
 #endif /* CONFIG_KFENCE */
 
-static void __init map_mem(pgd_t *pgdp)
+static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
@@ -1178,7 +1178,7 @@ static void __init map_mem(pgd_t *pgdp)
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
-		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
+		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
 
@@ -1192,10 +1192,9 @@ static void __init map_mem(pgd_t *pgdp)
 	 * Note that contiguous mappings cannot be remapped in this way,
 	 * so we should avoid them here.
 	 */
-	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-	arm64_kfence_map_pool(early_kfence_pool, pgdp);
+	arm64_kfence_map_pool(early_kfence_pool);
 }
 
 void mark_rodata_ro(void)
@@ -1417,7 +1416,7 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	map_mem(swapper_pg_dir);
+	map_mem();
 
 	memblock_allow_resize();
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


