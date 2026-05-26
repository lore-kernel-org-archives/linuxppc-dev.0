Return-Path: <linuxppc-dev+bounces-21532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB3CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:42:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ7764XVGz2xR4;
	Wed, 27 May 2026 08:42:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818368;
	cv=none; b=XSxJNF+s3OhejB5HA7S1HgEPMGie5F6p30ne8NRpHZitRCsrZkgRgTgq5cXbSvibdOzJN7vfbizWci6QEKEBaVDl2mRRPTl2OlLqVvHHbx/1Cc9vlnxL6TXlL5YH43EthxeGeRx1/FBjg1m18uCvSlebjeNdjVy4zr8WCmbjkvP30/4YRu4u8wS64q6AXGIo+D7tGg3qxKKvyLHS7ECkSUsyAZ01hWjKjNWexQK6GgHa/Rx2HjyXH0TjUhcWPut9LMNkFSi1zrsHfBZst3kBr6od1mBFT7HfuUU+DwAT0FdoM71AonvbjGQip0a9dXYbgItJ+JCarP4Qah3SjXu9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818368; c=relaxed/relaxed;
	bh=yyd3IudRVUHVyeM6Sgx7GyCvuriuV9w8zEGgNDuF+gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZX7ecHRoOErryZzGu8Il01qu9pmFofTHQPAP6ZUXTRvDpJm6kGi4b+FOJOI55VmyzjZt2BR1MYas95pTVp6WRXnoqyIBtcreW0DxyLStiPqQkdqnhPZJp7om7wH5GXvVUkupaLN58hIFFTz/M9JK0znkXzgwvVY24hjxvspE1Xf1YPWCZ1hbtKKSiHNW/fEdOT/LJOnIlxlnlNuLRj8BPQ4UDmpRSIvdEgyqyzr1G4AnbcygKeVKGHaTNWHJi7H3/nRigjvxLFP04IJslUNxT++2nbNDuW2T+lfxWISFfWZpahZtiZVhiurpp9oUkxJQfLxm3JKcB3VVWcc+6JLKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s/CoPsyd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::449; helo=mail-wr1-x449.google.com; envelope-from=3et8vaggkdocjamk+prcpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s/CoPsyd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::449; helo=mail-wr1-x449.google.com; envelope-from=3et8vaggkdocjamk+prcpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rG65MPz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:26 +1000 (AEST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-4411a2c034fso9938163f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818363; x=1780423163; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyd3IudRVUHVyeM6Sgx7GyCvuriuV9w8zEGgNDuF+gw=;
        b=s/CoPsydgBNgRAuHhT58cDErRvaGdnP6Sr+GB17PWBNwj3Nq0MIvGOjBMsGwsl+cl9
         d3v2o2557P6eCmA3Eo7MSlpqcgoBWx9OGLuU8ER0tNdeY0ysWt5BwRDzi/P4h2lSMeIr
         abmlGloLe/XatiMosLOpOWAArLqiyeC2H91mROt1ytW0X3VGCDc8tvFBs4LfN2nDUDsF
         oAttzg4pEm8o0UQmb9VybpvCS/zWcA612Kgzg0WErLOT2sBlvJNIGCv8DiHX5Wenu/Tt
         zKrdjFXuUeGun7iWPZ3VfWcggBeMpjzYBUtSMQiso7qmwV+q/IPAz24hbbZChVCic9Hi
         HYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818363; x=1780423163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyd3IudRVUHVyeM6Sgx7GyCvuriuV9w8zEGgNDuF+gw=;
        b=FjcZZ0Tz4a7Qx8py24NToJHzPchKs4LTH1aUJWwwB8kKujlcHDraOM5F+g+y5a6nh0
         YXp0qGCgYdyraH5+VYark/wz90u6oWGhtcrP/oIs+8wSNatpFFeAZMUBaUgDIRtkHUAm
         l0dJawFgxHzng1efWvAthr2LfXamCzzxhUIZCEAo4jRgOUMLSEI5KMFZnZ81PBkTd860
         tx51oB6QLBjK7554LcSHQFKSxwWACuEAONfcJA5VUIgiFX9aCzFFUf9udRfW4IZFeKkd
         2Ip5JrKLke7KLXMQYil3j05ism3A3ZqEMKwYz2u1zD1Eow8q7EzW42IuYasDtJ9HmgHc
         iMyg==
X-Forwarded-Encrypted: i=1; AFNElJ+l+rOjkaRYrqCelTNy7Fz11dFlP9oPQDlKDnYZCEJ7yn6VmeHWAIR9mE47XSI9TOfJ6gkdbEh3VcVKwgs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxCq0jGNsTrjN8jQ8J/lRsNeG1uwQ94RjXMfCf3ceoH4SHQeHcQ
	Iv75KxVn+9ayX9lVVLRbrHhessbhKfDWTIY3XkM9ctEvdVAHM5M1PtNn4+wVg6BOw8WRmzhahQ=
	=
X-Received: from wrwy1.prod.google.com ([2002:a05:6000:1081:b0:44c:3df5:500e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4917:b0:43d:dd:8ca4
 with SMTP id ffacd0b85a97d-45eb36ab5c9mr33376312f8f.14.1779818362409; Tue, 26
 May 2026 10:59:22 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:49 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=ardb@kernel.org;
 h=from:subject; bh=vIIm6COov+NQzX2nIS8cvw7su4mTKmzskcBcPmulqnI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fpS02zOfRUy3961i3vC1b7n+Evm+/R38NgG/DlrXZ
 Qm+/ezWUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyZREjw8TXaqzPetiWhH24
 cp5p0vNHbzoXsV7Pm+XWwVYqvcHR9SUjw6wVekazft8qKTufNy9Z5jRL5boX02v9d1fyMKbXF/Q c4gAA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-19-ardb+git@google.com>
Subject: [PATCH v6 02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
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
2.54.0.794.g4f17f83d09-goog


