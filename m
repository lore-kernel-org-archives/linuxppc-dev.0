Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59804C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD77214C1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHqrx8We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD77214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439frc6sbYzDr1g
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:38:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHqrx8We";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHqrx8We"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNr0yC7zDrMc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:47 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id y4so274078pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MmZLMYHzDBi6DX3d5Y6WCAGlPGFs0F2Tp7nIc90Y7E4=;
 b=kHqrx8Weluru4rL0F6yjtRQYvh0amwpgIHmpQmLJJSX66CQhJkORQjZq3LjCpTHffE
 FSuvYy2m32xQcLnxTWFCXAjVluhO8EInmP+SjEVFmihgnXzjcNhewkEWgOVCO+ndRUCa
 qF/8R+F7K+LHwNGtjIz610OjH8yhPK9s8M9r0DFOc/Lz9ffsVllTOCql3HqO6A5wo7SO
 YGdFHl1XEgqPDkzLxg0TKtIchqluwmlSM/8xD9tP+edmOuyGwUr0beZtuaHSM6O/MCdS
 JxfZobEwjMn9arSfYRc5EWvDw2xMkzR0Tt6kfX/V63ZzBBNfWYRROA8Ha3d0lWyNCl8W
 rMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MmZLMYHzDBi6DX3d5Y6WCAGlPGFs0F2Tp7nIc90Y7E4=;
 b=DYRvIoWjf9kPhD4z+BzfcOFnV8AZ1jb/Jc0x9+bwo+r/y9REM27s2WGO/PJrMioOu1
 ge+v3+rz9xAtNZeazviOcqfgogu/08qd5gteGVfAQDjzy+WLthfjgpS7jkAxBf4kNZ+w
 4PdWOZ1dol0qU3H/cmqxzmQME/3t6L0db3oFzuCCSY6VZSebScBwkMmoMJqyZPMdws3z
 pAHRBmf+VYAIi2AdbML9i+NeC5mlzXas8mqZuk43L03yt6LycyaC1XnBYu9BZNVnegWF
 6iO6+Os+HjP8T9pr6VB+RQLMjDzRqjlP3gs4sHddfIXJudUnGZA1JTUQ1dFTxUDEWQTV
 fs7A==
X-Gm-Message-State: AA+aEWZt3O6mLoLg7OjQETs1RBje/eUKVbCfOtD+crseLqSKC9RxhFWV
 qLxeBXBTttHi9ltCU7E9n0oO4D4e
X-Google-Smtp-Source: AFSGD/Va0PcC1e17JyQ22YLDWsBZK/oL2ehsxEliESIhfSxfZ5V9g031C6Oh+X3Pse3UoeLnVygQZA==
X-Received: by 2002:a63:2406:: with SMTP id k6mr23598684pgk.229.1544109465955; 
 Thu, 06 Dec 2018 07:17:45 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:45 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/7] powerpc/mm: Fallback to RAM if the altmap is unusable
Date: Fri,  7 Dec 2018 02:17:14 +1100
Message-Id: <20181206151714.28494-8-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206151714.28494-1-oohall@gmail.com>
References: <20181206151714.28494-1-oohall@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The "altmap" is used to provide a pool of memory that is reserved for
the vmemmap backing of hot-plugged memory. This is useful when adding
large amount of ZONE_DEVICE memory to a system with a limited amount of
normal memory.

On ppc64 we use huge pages to map the vmemmap which requires the backing
storage to be contigious and aligned to the hugepage size. The altmap
implementation allows for the altmap provider to reserve a few PFNs at
the start of the range for it's own uses and when this occurs the
first chunk of the altmap is not usage for hugepage mappings. On hash
there is no sane way to fall back to a normal sized page mapping so we
fail the allocation. This results in memory hotplug failing with
ENOMEM when the new range doesn't fall into an existing vmemmap block.

This patch handles this case by falling back to using system memory
rather than failing if we cannot allocate from the altmap. This
fallback should only ever be used for the first vmemmap block so it
should not cause excess memory consumption.

Fixes: 7b73d978a5d0 ("mm: pass the vmem_altmap to vmemmap_populate")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
The Fixes here is a little dubious since the bug was present when altmap
support for powerpc was first added in b584c2544041 ("powerpc/vmemmap:
Add altmap support"). However, the rework in 7b73d978a5d0 ("mm: pass the
vmem_altmap to vmemmap_populate") moved the altmap allocation out of
generic code and into arch code so a fix for b584c2544041 would
be a completely different patch.
---
 arch/powerpc/mm/init_64.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index be6e964625da..960f2a44c525 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -173,15 +173,20 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
 
 	for (; start < end; start += page_size) {
-		void *p;
+		void *p = NULL;
 		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
 
+		/*
+		 * Allocate from the altmap first if we have one. This may
+		 * fail due to alignment issues when using 16MB hugepages, so
+		 * fall back to system memory if the altmap allocation fail.
+		 */
 		if (altmap)
 			p = altmap_alloc_block_buf(page_size, altmap);
-		else
+		if (!p)
 			p = vmemmap_alloc_block_buf(page_size, node);
 		if (!p)
 			return -ENOMEM;
@@ -241,8 +246,15 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 	unsigned long page_order = get_order(page_size);
+	unsigned long alt_start = ~0, alt_end = ~0;
+	unsigned long base_pfn;
 
 	start = _ALIGN_DOWN(start, page_size);
+	if (altmap) {
+		alt_start = altmap->base_pfn;
+		alt_end = altmap->base_pfn + altmap->reserve +
+			  altmap->free + altmap->alloc + altmap->align;
+	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
@@ -266,8 +278,9 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 		page = pfn_to_page(addr >> PAGE_SHIFT);
 		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
+		base_pfn = PHYS_PFN(addr);
 
-		if (altmap) {
+		if (base_pfn >= alt_start && base_pfn < alt_end) {
 			vmem_altmap_free(altmap, nr_pages);
 		} else if (PageReserved(page)) {
 			/* allocated from bootmem */
-- 
2.17.2

