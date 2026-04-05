Return-Path: <linuxppc-dev+bounces-19363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D5F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:57:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXs1N5Hz2ynW;
	Sun, 05 Apr 2026 22:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393821;
	cv=none; b=FuLY39of4cvDlPy7CSBlZGNJTFmn3IbiwBspshm5BlGxSvOC2wAZBwFULnogIJDY2CEjUHY8qqqcWRi9UaJDXHpox5FvRwRg7P8n0TOwhsBoA42Q7mfaQ0tUfINPBjgDHHYFN9gHja6LOjKBmDLvxj8clfWWSlFM+HvvXp0JtCCZSBb6UW+dCFwhjTBjKML1dR4QetEedbTf2hyk3uhWfZx+ly7N58NH9R9TxJ3AlhVdPzZKt7PJ1+w3MWnY2uWhOlOwbkjzggs1xy1YmtNAAOAIDh93ldMfvFA4UrSdJ2qnVxhGFyHOCmeev0RU/KF5uHJxZLFf/H7A4Z5ZFBjBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393821; c=relaxed/relaxed;
	bh=6htym6+MXjsCESpIggFByDAobBonwD3F5r0quJbwaas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K80PMzhukExQWAKG3rKAgdWxNY+EAsB1clTFeRJN3MTS+qjBk0+YUHeJS3Ci1EeXuOLb8yGA1ch2EOh+f1t7lP9L/EUfB1PVFS2IXjMyvkGj/UnEK+HcbBZNxZQRDfoT/GeXagyYhOkok1SosCbZNaIZ6m4EnMsisqBdRJ99CONdJaoxr0ViD7S5ANIuxrfTibZtpyCjTDmxlTNgQJFaWmklJnvFpwIFVxUDinip5+fLciFqugKbjJUPr4Su/fMnwn13xXdxC3eIsO9ts4W4J+kh3bsxY99gADXTUgDG/Lcly0b7r6TJvKC1cWwZ+/q700/b51uC0bNRO0gtQuggcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=f3I2oSYh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=f3I2oSYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXr3f9Cz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:57:00 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1813599a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393818; x=1775998618; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6htym6+MXjsCESpIggFByDAobBonwD3F5r0quJbwaas=;
        b=f3I2oSYh6YlYVoPt6PqKBii6QNvlHfe2qUPRKdvxOQvuhN/o0gTYN6zR4lcUmw31DC
         VhLswxNFx8/PW8i0+rVShL/2Ub+XX5Bllahbor8+T1TzJOvM5jFwNDfazhBiyfo2M2hH
         LOP5keCvuys+GaJ/VnBTPfQb0fRII9U5vM5C1kjxgHwlyjhGw2Xd2VHY9OVDK1F09Si1
         aaNgp2mbHJA/T9iSSx21qVh2Ol+r7IhgF1Nfdv/M+EQmAmt34eQFxuBfPJ0U/ez2XMu2
         TiwBFVZm7jKGVhha2Hx/NyGxR3e/T5AkApzNGsUyvMtW0dbXBXMn3IeiNgIv0SaCEKC9
         J4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393818; x=1775998618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6htym6+MXjsCESpIggFByDAobBonwD3F5r0quJbwaas=;
        b=CgVH9ZNoy9wu3wFzgVrcLnn3HJ3GOur5EzyQyEMU6qRXcxmCWdneSI6fObr904Ifwp
         xi1EMLVyi+taumyHWWIP5YKBpzzX6RCMYKfdtX7ZfDsili4bNRiVDaknjJwZaoeaqLhh
         xRfUzwbrPRonbFv9vSB+nJZ3oFqjOba59IChUfSaGmTO2bPIEc3lFV9xjpf6lwdQlE7p
         kyNQ4y6gqdZdWfyFsTZYjeP0DUpszJflIIbOlT3ysfpDBc4c8oR5iAghCCXUF6oUFlh8
         H9m/f0e35pkMpFYxnS7SPxWQ9kpiEBUtm87y8nz9ca4+BANZlo7B1oRIIKGRrh6ax6Rd
         JwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZOv3jSQsGLwOtrj7z7Ob9P+pgMezzphDMlhnhKPGDfYXLpw8VpiqF4gtEHmgQIJoTnG9JydJCvsu570=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwceS039XZ0kA0oafSHq7+IoYFrHOKkr0k1O8pSlnm4y4REjg0D
	oNaLmXbZvLrnY91lE1PRllUhW3YcunUeRErvHdMtOXvL/9PdlYW6sKS66WZ+oRwbc0o=
X-Gm-Gg: AeBDieuq6vZl982t1s30FCozZCjmYAvGVFgOs28NsP/RTnZknOixkU6nPgvQe0BiFml
	1xx+zG7CLmST8ALBwSCnlS01Sm2OStI0+bYXrAuj3JlVxWnpQGbQEMLRoCu/9oBvZSexKKpn0aI
	bblDfsJJ/NKzNHqYvPojpRQbMuhg0c1bouQyllvaTeEbLkhaXeoDuzftIfLPF2dLQy5rEi+i5SY
	sriPT8ldDx2EiRP4GmqUzKwMM7Z51E3SQMMs3cur1dyzn70qq62pMavOkJyRLle4N9Gp/TfoTKq
	7uAiOzC61rjbTRWeh2HioHOof07FuNUVomctjslCEuDkBTH/F3B1cxP9k/woMLTtxjlU+94Uc7H
	CbNkoVj8hvUDn5lcPyHVT1uS1InU30esL4EGd2WV/k1W5JP4kLjBwWZgf1VoLRSs1q8CiYL5xRi
	cfnEluAwTWqwNev06M8XazEGwy/4Behk51JwneRwMTCwk=
X-Received: by 2002:a17:90b:3809:b0:35d:9560:3efc with SMTP id 98e67ed59e1d1-35de68ce84bmr7967133a91.14.1775393818406;
        Sun, 05 Apr 2026 05:56:58 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:58 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 33/49] mm: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
Date: Sun,  5 Apr 2026 20:52:24 +0800
Message-Id: <20260405125240.2558577-34-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the vmemmap optimization logic in mm/sparse-vmemmap.c was
closely tied to HugeTLB via CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP.
With recent refactoring (e.g., introducing compound page order to struct
mem_section), the core vmemmap optimization machinery has become more
generic and can be utilized by other subsystems like DAX.

To reflect this generalization and decouple the core optimization logic
from HugeTLB-specific configurations, this patch introduces a new common
Kconfig option: CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION.

Both HugeTLB and DAX now select this generic option, ensuring that the
shared optimization infrastructure is enabled whenever either subsystem
requires it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/Kconfig                 |  1 +
 include/linux/mmzone.h     | 33 ++++++++++++++++++---------------
 include/linux/page-flags.h |  5 +----
 mm/Kconfig                 |  5 +++++
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index e70aa5f0429a..9b56a90e13db 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -278,6 +278,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
+	select SPARSEMEM_VMEMMAP_OPTIMIZATION
 
 config HUGETLB_PMD_PAGE_TABLE_SHARING
 	def_bool HUGETLB_PAGE
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75425407e0c4..6edcb0cc46c4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -102,9 +102,9 @@
  *
  * HVO which is only active if the size of struct page is a power of 2.
  */
-#define MAX_FOLIO_VMEMMAP_ALIGN \
-	(IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && \
-	 is_power_of_2(sizeof(struct page)) ? \
+#define MAX_FOLIO_VMEMMAP_ALIGN					\
+	(IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION) &&	\
+	 is_power_of_2(sizeof(struct page)) ?			\
 	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
 
 /* The number of vmemmap pages required by a vmemmap-optimized folio. */
@@ -115,7 +115,8 @@
 
 #define __NR_OPTIMIZABLE_FOLIO_SIZES		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
 #define NR_OPTIMIZABLE_FOLIO_SIZES		\
-	(__NR_OPTIMIZABLE_FOLIO_SIZES > 0 ? __NR_OPTIMIZABLE_FOLIO_SIZES : 0)
+	((__NR_OPTIMIZABLE_FOLIO_SIZES > 0 &&	\
+	  IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION)) ? __NR_OPTIMIZABLE_FOLIO_SIZES : 0)
 
 enum migratetype {
 	MIGRATE_UNMOVABLE,
@@ -2014,7 +2015,7 @@ struct mem_section {
 	 */
 	struct page_ext *page_ext;
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
 	/*
 	 * The order of compound pages in this section. Typically, the section
 	 * holds compound pages of this order; a larger compound page will span
@@ -2194,7 +2195,19 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 	*pfn = (*pfn & PAGE_SECTION_MASK) + (bit * PAGES_PER_SUBSECTION);
 	return true;
 }
+#else
+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
+{
+	return 1;
+}
+
+static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long *pfn)
+{
+	return true;
+}
+#endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
 static inline void section_set_order(struct mem_section *section, unsigned int order)
 {
 	VM_BUG_ON(section->order && order && section->order != order);
@@ -2206,16 +2219,6 @@ static inline unsigned int section_order(const struct mem_section *section)
 	return section->order;
 }
 #else
-static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
-{
-	return 1;
-}
-
-static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long *pfn)
-{
-	return true;
-}
-
 static inline void section_set_order(struct mem_section *section, unsigned int order)
 {
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0e03d816e8b9..12665b34586c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,14 +208,11 @@ enum pageflags {
 static __always_inline bool compound_info_has_mask(void)
 {
 	/*
-	 * Limit mask usage to HugeTLB vmemmap optimization (HVO) where it
-	 * makes a difference.
-	 *
 	 * The approach with mask would work in the wider set of conditions,
 	 * but it requires validating that struct pages are naturally aligned
 	 * for all orders up to the MAX_FOLIO_ORDER, which can be tricky.
 	 */
-	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
+	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
 		return false;
 
 	return is_power_of_2(sizeof(struct page));
diff --git a/mm/Kconfig b/mm/Kconfig
index 3cce862088f1..e81aa77182b2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -410,12 +410,17 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
+config SPARSEMEM_VMEMMAP_OPTIMIZATION
+	bool
+	depends on SPARSEMEM_VMEMMAP
+
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
 #
 config ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	bool
+	select SPARSEMEM_VMEMMAP_OPTIMIZATION if SPARSEMEM_VMEMMAP
 
 config ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	bool
-- 
2.20.1


