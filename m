Return-Path: <linuxppc-dev+bounces-21735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4ECCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmn1QFqz3c1w;
	Sat, 30 May 2026 01:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::24a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066953;
	cv=none; b=N6DyJffGsFuBYThm8hHe2XaVp2J/5NHjb+D3nOUXf+8WC4dRKTsgaagR/jBr/F1+Np6uB1iD2bix33aglM8kX2hdmF5DPQasEs9GMSVF9zF5Diui3/ui2dDquIzuO0NNMZS8o3CbObYnyAr7jsdlZcKnkyR02j3y+ke+VzE4k3lf67x8zHF5euLbtzkcha2TpfBC+LeyDaOuAzx9kPASs5WnUpf/fjTGHBzFGnhgi1F8nhsGQNX7gHQH5xI83aURfDpz4e56GFJGuUfLKh3+rPNmrA7FqlFyqP33d3Bk2ffk3S4Odlavl+hT7TBSp0EXOAbtilwL8MCZ0QrxfvQuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066953; c=relaxed/relaxed;
	bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zbi7aUapz/k1GiWt+Sr9sC+XxdIoGyEfL3h8kjSQSAmycvNbgcSp9n5/ckNYv+gKJpRISontz/xSQga9yqVosigtb6JLN1hAGzdXKXYTifPRPpCfq2urzF5ahajXSBmikOKln6QoNCb9zxMNiIdtHkfAGsDzD7n9lRkIeVX4ChlWkYP06d82+XI3SXluOi6lfyUQFLE2r8aIiFX/lKZMRo0F0bNf6y7bLzYnYm5iSz/E/qDoDoXAr69PqIeDPqTLC/VdBewgxdYDUqwqclCT97v1DSMzjmG+PUCpd2omiOk6L6Wxqa7qI/Uk59MHHe6rNcUam+8QFrw/Vzv9Y3XsDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Nd0z6e2B; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::24a; helo=mail-lj1-x24a.google.com; envelope-from=3hkozaggkdjc1i42+79k7ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Nd0z6e2B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::24a; helo=mail-lj1-x24a.google.com; envelope-from=3hkozaggkdjc1i42+79k7ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmm1RDxz3c1g
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:32 +1000 (AEST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-39660440f38so970551fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066949; x=1780671749; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=Nd0z6e2B4vQH9kyHilJZm5lHxct68WECOM+aCTb/hzPBr/PEjTHd9+t+dwonq0P0OC
         NBExEbuMVjQSu0ZlKy2rVGYG5sPbxH4EwcyAN1a8qO8O96XyY0GTmvMgKN/rkJKOy7jC
         fNMTCFCwUAwVll9H8vqMXDC090C2gHV1WzRhKpOcBLhtxWMyuYSa7FmyngxRzfnzZ8E2
         W0FyJmEJ774xkAECH9oyhdoTKY7rz8U1Ypkdz822laVxHU/ku7/m2NeF0t0b4AYrm3jT
         aLKOmgQEB82dObtItgasdFUktcU+GaYuqf8pBqOHC6MwACBnemUDkw44W/3+F79k6d6+
         OvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066949; x=1780671749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs8UZJaaGpDG2dm36q3rutkvNlrSNXe/Bj9mb4oSyno=;
        b=swjRu2WCGCmvbv9RlR+wAWfG4EZuXw21EvJ/ax87/dLlRGES7G1DvDYjOUMhZ+z0mY
         O9VhQScgJCu2+syvb7qGuok1DJwL03XxkT6khQ8BJ0OIRRf6J8qSgbJsBpkArUf2/09j
         WBwLqLbWHsGWrZfkaEn+ZxUz906PJCurBfUiZpnKWwwP1/xASYp8sTGzHsr4iLK1kFPU
         zNLTshY8+m1fNjEeXx9Ph5+0NZKUUE4MxqKlEHhZ4Su2229K9mFRKOaxJYcNg/UTblAP
         xIwQuEDUcDEnwLvf1f+xTn6erE78HJOUbk9OdamBKBqeAuNy9v56eAF9ePy2nOvH1nL5
         uRuA==
X-Forwarded-Encrypted: i=1; AFNElJ92qgrpdLWjkeP6wAbEUjeqYZHynUlCNXPlDr/+68EQ+CiD3RQxkBAM/ic63rZq/CsYmidsBM9Kp7hHMp8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0no+34ieWmJfasTrFD/Q4eHt1NT4+UTeZr9ad1KVSFiGVci8e
	FKiH7r1mD/cl7i1jqp1Dpj+zG80ljEDm+rjyc7Zu9svDsND/ncqlFjM7qm/8tsnuORNmNUwT4Q=
	=
X-Received: from wrjb2.prod.google.com ([2002:adf:e302:0:b0:45e:f542:3761])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:990d:0:b0:395:ae3b:3375
 with SMTP id 38308e7fff4ca-39664e981c0mr41301fa.2.1780066948187; Fri, 29 May
 2026 08:02:28 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:00 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=ardb@kernel.org;
 h=from:subject; bh=QwDzTM46GdUE+NivIT38dC1HutxUWa2GWKTenTtP7nY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVWb2gvjDypnblG6ZO3Wv1Bft/jrhexd79oV7t577u
 RU+EnfqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZI8zw36neUKL4j/F/nsar
 u7+2BlcevsMd8uPEywc1ppJzt9RzHGb4K8J9S++osuTMJf0rlUt33Z06V/Xzwox9+yqmH1l/Qee ZAysA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-26-ardb+git@google.com>
Subject: [PATCH v7 09/15] arm64: Move fixmap and kasan page tables to end of
 kernel image
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

Move the fixmap and kasan page tables out of the BSS section, and place
them at the end of the image, right before the init_pg_dir section where
some of the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h    | 2 ++
 arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
 arch/arm64/mm/fixmap.c          | 6 +++---
 arch/arm64/mm/kasan_init.c      | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..fb95754f2876 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -13,6 +13,8 @@
 
 #ifndef __ASSEMBLER__
 
+#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
+
 #include <linux/refcount.h>
 #include <asm/cpufeature.h>
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..2b0ebfb30c63 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,9 +349,15 @@ SECTIONS
 	_edata = .;
 
 	/* start of zero-init region */
-	BSS_SECTION(SBSS_ALIGN, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
 	__pi___bss_start = __bss_start;
 
+	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
+	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
+		*(.pgdir.bss)
+	}
+	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
+
 	. = ALIGN(PAGE_SIZE);
 	__pi_init_pg_dir = .;
 	. += INIT_DIR_SIZE;
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..1a3bbd67dd76 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index abeb81bf6ebd..dbf22cae82ee 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
 		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
 		 * when the linear region is mapped.
 		 */
-		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
+		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
 		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
 
 		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
-- 
2.54.0.823.g6e5bcc1fc9-goog


