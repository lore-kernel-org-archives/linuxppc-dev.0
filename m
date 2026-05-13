Return-Path: <linuxppc-dev+bounces-20887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3435CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3Y2Bx6z2yfs;
	Wed, 13 May 2026 23:11:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677865;
	cv=none; b=LPJgCNYx/aJujwM8JI45R1dHhbRiBLiphwJ4Dgj7LIIMPECSlGgtbp/zD1BnXBqAbBsqZjgKeF5/FtgBxMGaV0xb2rHJ5rjPHy6oG95d2oX+oyGDTeg9os0duOZaNUyQ36tIqDMiE8KY1Y6As/H27P3h7cbBgmy1iwxMyRbO2+kMla5SwG/L2KwlVi/VLItPkz/nSF7F6u31AN48XipnwNwW4+CVaOq5GA3O7ckHF4ThoU3FcR8DAJYKXwAT1avzkdpnpXgK52H1VtHXdEDFB6A1dmKlpcZJ4on/v/jA4xLfN1MMio8pFHFB6XiyHh+O3StPdzkn+AP6YhuLMKl08g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677865; c=relaxed/relaxed;
	bh=LpwPxpfie30YAMOHUn6jeAG+IgoJLqSekICSQMqQJSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM248VcF/OQazsW8wMbQchrjfvjSL3Mwc7o6OnrTs56Ori2Ayd2fDlQrwYzuOOETylrA8xo3BKn8x4cEqLpy0NZLJIzCzpeicxJwqbAsvIk8gZvTqvAZ3XdesYN/hGEWz/1tSmVjdPJeymuZb4E+rgTgxD5AhdHnIld50ERvLhJoJD0qstjKkSJVYWxEqya3JakEKLPNFYQd2CWoiiwleiJHfIqbSeJy24jZMQj/GRCMLW6tcTHamnCRKPwoiAzIMHap9U4FuEHM7G3uJ1+HB7XL9BhUIx5xuc4+w8Qf+azDV2DVnqMrCaoh05yh8f25y4oIrpBZIF+IZttFQiwgcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CK6vPSLf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CK6vPSLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3W6kS0z2yfN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:03 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso4627557a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677862; x=1779282662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpwPxpfie30YAMOHUn6jeAG+IgoJLqSekICSQMqQJSE=;
        b=CK6vPSLf3v0D+lCKQkq1gkRRTIWvQG+z+c0CDAyGeeM2Cv16JINR1zyNe81sxJ4Frk
         aXoFs+pEbEIzwCkjHn45whnS7AbCxf2YoUc62FivDU0O3rY776Yd89lfeUVNh1ZWuY3u
         LzKTnG1vn5bnfVe8Mq3aub1mTydv3uRhs1HVjVGWtyZ4RTVA8Ro+nGBzKHhH0WtUFMq8
         m0TpWNKXelk289cSw/8cg5uJ0noSps7Yt/FILV6MEUDUmQl9YEhr9JgfPW0kLYvtz7S3
         GbHcRhw1epRSawpKRjQ8Hp7Hl3O3eaXvdp9FAdGpez+BvcsBQkWT5K3egHHHRUUPMF1f
         BbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677862; x=1779282662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpwPxpfie30YAMOHUn6jeAG+IgoJLqSekICSQMqQJSE=;
        b=LVmx2ex95DQYnRjVPb75coXYKzSQyYNdWt6oMyDLu9dgeKVZFntIRTCWxP+9HTOcNa
         G8WFPr1YYh4U8piWmtz7HKy5vYRcfuDOemZGzgIlZ2gv3M4LGPJF/caxuT0GweuQBLBd
         mc6rPGdD8smKfOyLpMgoMjC6WOObMz/P3l7X4Nx76WIvpgwPMzd1iVe3R/P5pS/kDnkF
         aUQdVq4OkVQL2AwbYaXSf4E09vj4esAZ9d0Fs526rL6YuYKD0b0xsuBWJ7HT/u6p+eqq
         mZjkJNSBhcSzBC7p6Za4716RRljXXXUUIfiKADQUpLRIvCNvVZqbJMHq1c4ZLKNqKmB9
         ksAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nd7KAvZ3bk0SDaLP4LWFToPG+rCKVIwwMVVEvE5MrXS2GbAxuqIAJR1nuWXq0jamjyDiztivqbUhIyf4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGO929UOlIrgQM0Cb1zrckxSaQVnVcCOM7B0aK795Z8m09K+ik
	H/edRMVlh8V1Ym9lgqOmXZxt6WbLa9FHz8TYOr9TZfB/PqXk4hKB+Ybhj798ekWQLXc=
X-Gm-Gg: Acq92OEzvKQEFM1vPeK+kAsPpz6mpxXwMjzVONrxr5VnJODVB/WaMWeWPNI+us2FGKh
	QVQlf6Fp/bHYfHyxm21y3ZS57MGJBfiBJygNmLTBl2j/hY5XenG7k5Tepb+kplbrUIlp9r35oNZ
	pkRj9pqQ1pXNtB3bo++Vrf22a0Eg6sf72ikWo560JpUUV44gV3Up6WMAnkdLE1zMshNS9Xc2XWj
	WWZ6mUC3EYi45BSOsCdI2wGGX3qhnvno6mLRZi78SHgf6nxwA3zyQietr3PYmp1aUrLwDgs4f+g
	pcw3oG0vXdSLdZ86dWPzru/6x5Z2WSghBoJmHaEyDrpSNAcGVYfq+q+bTibgrW2lhoSneJU/z2W
	hxoyTbfSYesWIrSY1RBKhnM1IUTKI7FYDn8SwPH8s99XkahnI3ffHuj7/lfGtSpJM+3Aynb9hj9
	4EssjDQC5EJjGAfMtd9l/DdwuGnCJIOQSq2V0SKnBUbcxCRiof1NYkZY5zqqw=
X-Received: by 2002:a17:903:22d0:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2bd2716ecabmr35771225ad.9.1778677861863;
        Wed, 13 May 2026 06:11:01 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:01 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 38/69] mm/sparse-vmemmap: Introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
Date: Wed, 13 May 2026 21:05:06 +0800
Message-ID: <20260513130542.35604-39-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

The generic sparse-vmemmap optimization code is still guarded by
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, even though it is no longer
HugeTLB-specific.

Introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION to represent the common
vmemmap optimization infrastructure.  Have HugeTLB and DAX select it,
and use it to guard generic optimization code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |  2 +-
 drivers/dax/Kconfig                           |  1 +
 fs/Kconfig                                    |  1 +
 include/linux/mmzone.h                        | 33 ++++++++++---------
 include/linux/page-flags.h                    |  5 +--
 mm/Kconfig                                    |  4 +++
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
index bc3e549795c3..5f8424eade2b 100644
--- a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
+++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
@@ -11,7 +11,7 @@
 #undef CONFIG_PGTABLE_LEVELS
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
-#undef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#undef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
 #undef CONFIG_NR_CPUS
 #undef CONFIG_PARAVIRT_XXL
 
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 602f9a0839a9..60cb05dce53d 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -8,6 +8,7 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
+	select SPARSEMEM_VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP && SPARSEMEM_VMEMMAP
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/fs/Kconfig b/fs/Kconfig
index ccb9dd480523..f6cee1bbb1fc 100644
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
index 9b87d798a365..5285d53b0c53 100644
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
 
 #define __NR_OPTIMIZABLE_FOLIO_ORDERS		(MAX_FOLIO_ORDER - OPTIMIZABLE_FOLIO_MIN_ORDER + 1)
 #define NR_OPTIMIZABLE_FOLIO_ORDERS		\
-	(__NR_OPTIMIZABLE_FOLIO_ORDERS > 0 ? __NR_OPTIMIZABLE_FOLIO_ORDERS : 0)
+	((__NR_OPTIMIZABLE_FOLIO_ORDERS > 0 &&	\
+	  IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION)) ? __NR_OPTIMIZABLE_FOLIO_ORDERS : 0)
 
 static inline bool order_vmemmap_optimizable(unsigned int order)
 {
@@ -2033,7 +2034,7 @@ struct mem_section {
 	 */
 	struct page_ext *page_ext;
 #endif
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
 	/*
 	 * The order of compound pages in this section. Typically, the section
 	 * holds compound pages of this order; a larger compound page will span
@@ -2213,7 +2214,19 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
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
 	VM_WARN_ON(section->order && order && section->order != order);
@@ -2225,16 +2238,6 @@ static inline unsigned int section_order(const struct mem_section *section)
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
index c26d2d2050d5..ddd10cb4d0a3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -410,6 +410,10 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
+config SPARSEMEM_VMEMMAP_OPTIMIZATION
+	bool
+	depends on SPARSEMEM_VMEMMAP
+
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
-- 
2.54.0


