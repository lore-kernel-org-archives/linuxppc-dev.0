Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD1BC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:29:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C6A206D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 14:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="My66LnNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C6A206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491nt72S3GzDqkp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 00:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+4a22011dcb1da0b09bf4+6078+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=My66LnNv; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491mF75Nd1zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 23:15:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Kl69HLWQOnE04wC+uxhqbtds0xCIlpZipVtGnO7U4c0=; b=My66LnNvAAIlKiTBNDHFh9YpkC
 z7lHK2mjnFfvdbpsnhzIplc0igKBHlccUmet+rWTnvHlHq/9jq22ujoAVkc1POdRaH8nAnI1fIf2D
 iJyGHO+afJtdahjeo02n82UU9FZkVAIG06owOap0CGyAZyLRsI+ffP4OAob2AaVSIv5f9QETNgA+d
 K0e+2WRQCZGCLar8kb3mgM70BVYScJ+P3YRBXFWyAGGZLEAGHUId6KaJ/FK2SkT4C1OKWx6UN6vlF
 DZCyomhhIG5he2qHvfEI4S6kujIjTND1odx3bgNjkRIvmtofxAGY9CpJyFJJavsvWxyvTPznzFkjI
 PnarSU2w==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOLOy-0007Ax-40; Tue, 14 Apr 2020 13:14:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 19/29] mm: enforce that vmap can't map pages executable
Date: Tue, 14 Apr 2020 15:13:38 +0200
Message-Id: <20200414131348.444715-20-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

To help enforcing the W^X protection don't allow remapping existing
pages as executable.

x86 bits from Peter Zijlstra <peterz@infradead.org>,
arm64 bits from Mark Rutland <mark.rutland@arm.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/pgtable.h     | 3 +++
 arch/x86/include/asm/pgtable_types.h | 6 ++++++
 include/asm-generic/pgtable.h        | 4 ++++
 mm/vmalloc.c                         | 2 +-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 538c85e62f86..47095216d6a8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -407,6 +407,9 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define __pgprot_modify(prot,mask,bits) \
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
 
+#define pgprot_nx(prot) \
+	__pgprot_modify(prot, 0, PTE_PXN)
+
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 947867f112ea..2e7c442cc618 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -282,6 +282,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+static inline pgprot_t pgprot_nx(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) | _PAGE_NX);
+}
+#define pgprot_nx pgprot_nx
+
 #ifdef CONFIG_X86_PAE
 
 /*
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 329b8c8ca703..8c5f9c29698b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -491,6 +491,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
 #endif
 
+#ifndef pgprot_nx
+#define pgprot_nx(prot)	(prot)
+#endif
+
 #ifndef pgprot_noncached
 #define pgprot_noncached(prot)	(prot)
 #endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7356b3f07bd8..334c75251ddb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2390,7 +2390,7 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_kernel_range((unsigned long)area->addr, size, prot,
+	if (map_kernel_range((unsigned long)area->addr, size, pgprot_nx(prot),
 			pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
-- 
2.25.1

