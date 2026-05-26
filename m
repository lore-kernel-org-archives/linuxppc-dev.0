Return-Path: <linuxppc-dev+bounces-21541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DECDCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78f0NGQz2xVK;
	Wed, 27 May 2026 08:44:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818376;
	cv=none; b=lTcGCT1ZuGEXhNQf/avWLFSDt9MemLeI6pxkc1rqOoJv+9wOI05hS8bkeH6Uxz3RIJg+pdPYZOtHhZns0Wx4pnwf7h1iBu3GsQR0MgkUc/+9s7fpJYXNacdVpxCOb9kL/ZJEOD2E5tA+B0FUs9QYFzaDeP/54MNCsdgtTfyEwc+V2c/h0d+lEukLXu7axfo9bYPRiW7bi44Jd2lor7Vxj2o7oo6eUcWIeRlEa/9dgUYyrVY/lcTKdVjL1aQDVXAv1fdLJpVkQSmrF+ioWELn72dt0r7JpxeK9N0JCWJ/5xTWv5tfcSO7YlkwIHmV7Z9xUOM0uEBh3didCp83DVtb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818376; c=relaxed/relaxed;
	bh=TJx2KhHmtgY53AkMvOyg5uK/J3luFDMcMijObo9+4vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PtUyFcaNeWrMbH7FY0I4HOlaNxBkvYxOhLawTwLH/+ggtNOhQHAir9VMHdYJgJaZ0O3aimkfatBnLyWTf9qMFZzZZHKz7F52I9Mq4Fjbsei6VCCAv/O4utOk+Yf4Iu0Y5W0hCeMiz0BMf9ev7lJZzWQnU3N+8Et8yBNUBFRTcIK5KSKWRqBD2N6xDs2m1gTc9xqExLEvK7dvnCgi7oizUa6J5yUT5AcjqrTA11QnAhr8e4hWLl+f+flJTAQ0nG2glnE6rBRbXAZhD2fSr//KcOX7im9RlrKK/zXpvNYIhB5VbT5crY1xc1QSjrgZ6yHXBiEsuy772hx0zGFcvy9LTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U+XrXkr0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3hn8vaggkdpetkwu+zbmzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U+XrXkr0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3hn8vaggkdpetkwu+zbmzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rR1gJSz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:35 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so6825642f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818372; x=1780423172; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJx2KhHmtgY53AkMvOyg5uK/J3luFDMcMijObo9+4vo=;
        b=U+XrXkr0oRcAMek8E+pFe/f+MKHcOGRNYd0QSkRnpez2ms5Blufh2iueKsxoGqV23a
         0iRhMvZu3eLfHuCc0BzypGw1nTIgxVUOaBY2UPfy8dhKHFDmrgxu0ZDpnoB634SZYWt/
         TlTfs23La6mWHmj/c1BFXV22q5DmfL5m8lHlz0IGhzHAZo6rHfMILYAWISJzTzS3gmR0
         Rq6UGtvehTX7zy5JS/TdXIXEiyf0OOxU++N9+7gwlCb0beCUSQ3TSQpuD6aXKrwHb4jv
         MG8JKGrapSdl/u0MRWhyrHDCrT/SKWEUCpubpqRHBbjC417qkQD6GbgOwUqcymFNy2Xh
         cyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818372; x=1780423172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJx2KhHmtgY53AkMvOyg5uK/J3luFDMcMijObo9+4vo=;
        b=bUoiT0y3r9Ix5TI6i9ycyTn86IvYBVDV69NWnA/w4JrPPgmRsdlIr+NoaJ9tTBYoMh
         bk3rVJTzEbxmkIkEF/GHJ4KDh48bN2UZRMOG+4GgAsXv+OQdhPaPIDXJf072haHUqeW5
         UV+tGJsYlycgtauNf7Naq61gcNm32+HbjkPWCfemHVHn0Ty8csq2Spq7HOrowmfraHHk
         ZZJR4hASwYP4B85JdjrVwCGX9SxUHl/hhy8SblFpNYjUdn7jWiNhL3Xpx5HaoBHgSV1m
         ZPUXhkwYPdUzFvFSNHAavPf2d5Xn2hVK1kkEvgx5DuKqbMmZAX6OxMvP/5IVVEBWycNB
         BK6w==
X-Forwarded-Encrypted: i=1; AFNElJ8TzxYZf4X+j6ipE0lr19staiGqBOMx+tY0kCeLbfrA7fVRNAYLFrmL1uRnInshiQNGmxBllpBqwJ7mPxQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxe7xXLYn32RACVpD/lj5PN9a9X3rwEMPGfsMIfnNueTbVzI8LB
	B2TP+ptl3QYpXULJW8UO4tKGHPc2ZYNErUcy3d+AicL/HMhTmeRlv86ZlYeeRHTWf9Yxhj0nvg=
	=
X-Received: from wrjn10.prod.google.com ([2002:adf:e34a:0:b0:43d:6f5f:8c52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c8:b0:490:44eb:c1e7
 with SMTP id 5b1f17b1804b1-49044ebc2d5mr360486815e9.30.1779818372100; Tue, 26
 May 2026 10:59:32 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:56 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=ardb@kernel.org;
 h=from:subject; bh=Qta0PMsGcvlQhpXqhjldDBt900x2YBq541ys84w8Z6A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0frL6+VN/jnUf5F5tPjtywfpJk9QUy2MKCjk0NTccj
 r7PUqfVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayl53hf8n7L8U7Dq/XtJM8
 aaNT5xu9zmX9+a6ICfks3cp+rZ7mixj+Z6226zYNmPCvKn7q8tmXSzeumHZtU+IR1bAruyazqkp WMAIA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-26-ardb+git@google.com>
Subject: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of
 kernel image
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
2.54.0.794.g4f17f83d09-goog


