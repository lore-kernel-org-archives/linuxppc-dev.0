Return-Path: <linuxppc-dev+bounces-19373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED6CF3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZJ50yXz2ypY;
	Sun, 05 Apr 2026 22:58:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393896;
	cv=none; b=NftQomTXUIKlNVRKKzs3vgZDscYy4Eg5khtMhjNmTkt70cfQxM0Zh4o42A76ZI75WL+NI1u0dunBR6EvwFIBF0RW6Y/CuyAIgMRTRJi8VPSEIurHouCdPY93Aw/ilUrvX8Gt3r/sOSe5SJdLJ0VMVHc63g6qoMFC2iKZZyPpqcfDiCceZAJMsvYADt2ge7tXbwSIGh+/x7qH2KcFxY+QuRM9klTmE39I4S5JBRD7dPttaoMVDya2dcIbBexbKz4oYB5nccZVrN/beuqFvVzvmMxTGqHve4b1zSims6yLrmcbCM3cLYIFpNYAAjdLicvb/9i8aTHKrO1qJ5PEWOn50w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393896; c=relaxed/relaxed;
	bh=QwisMsoot6phm5Bl4goqnbBJk52l8dQLV+Q/Y11L1i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lay1gdbY8H3a3s3/H3yqckY74kMApQ8Vcxx7LXC/m2dIQ/4+GohM1kXcT5/AK8Mrq7SP6WkN21rBL/xYHIG1Lk39ezvmddiyOt/raYFt+jM/Co3B0exT5GDHj5i/+I3SUl2PEXCnyuvPjWkw49ZZqBhMWEWI/RizaNvKKTGMBFhtEvxML17pcHGsBRqPW0XhtqkR5XePVUA/6YnG3ILrfdrkZi0r+1lqgH7ex4Xdxhv2Un3mSia9G+6sgu42cU52f5Mgz46iqVIQz3OsOt3xEfYpdiairoNmbLWVU/G4TfTrSGJS1u5DMdVsskfGVmoTZYu9f6Z0EewW26AsuBFPIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=H18cIio+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=H18cIio+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZJ0709z2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:15 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2819867a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393894; x=1775998694; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwisMsoot6phm5Bl4goqnbBJk52l8dQLV+Q/Y11L1i8=;
        b=H18cIio+GOZuyIvFX7P2NzXwrX47LAYZ++nOxjrqMIROeRnusCUIkzV1Dc7dNHXaf2
         adRPY9S0lO3/vjSDTIi/mlrwG5u7Kseewn3dH4vqXK3XzZCFqhKGzrp7iPy3T02g/58V
         BUn8sMfrQ9rj/2KxqRel+Myvw6YPWfJtK2ZpKC8/Yf4LNKmq9g8AS4LbDE7XFXVrMq8Y
         i9GogGm6hlKJgg8ZG/Hu6+s1XBo9kYgNmVpqM40orchbFzhvIxuYogwKk/NKoWTQ/U1Y
         v6ZegDJhI4zkYRaxnZWJ2LJfv3fwNnasGLtneAeG611EXkvBaY+YtbQ2GVziXIhK6VzA
         aWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393894; x=1775998694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwisMsoot6phm5Bl4goqnbBJk52l8dQLV+Q/Y11L1i8=;
        b=JszU6UqRiTjRpKf2/XsNZnx9zDtIfxTfc26A88v9rW5Km8jyz8piykVcZswmKPe3XS
         k1SxncLgw9AhqtLrfzCewHJvl2G8sH5QcIKZWQlnREnCeHmmskKQ0IF8FExvkTNapbFL
         S75/kt1c6rd9Uvx7OLEWCIOkIJ5ZZR2SkTukOWgB3G7A/JMrW4U6wAd7qXwn7LXZxk0z
         t90Sel/yf8/3vlUzHfdDTCqK2bfUUzYcn08Sd90YGRgd8+CFiCScqwZIipkl5tKjJK5D
         PQXMT7pK35+4tRgAyIAokWXJuNPG9hEJk9JA2GDjYXmz6EVhDk7F2Qw/XUVHfVqZuCeI
         djmA==
X-Forwarded-Encrypted: i=1; AJvYcCUge3d10qR4uYjM98+0PsxpgQ0j4UjEsimQtnBdJjEFH2SxZHQ2Pg7Bif3l0sDLmz8pAkFgqc2N7N9dlz8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZr8YQDi91Gyv4/ZWyxnAopEpL6fN+SrxD4jJunswRmCbv5f1B
	I+hRaqxajvqAzjIkusjS/SnOoMqUvYE8+hBSgxsnrsLSPzcb17+4N4tGnDwq198wS3U=
X-Gm-Gg: AeBDiev1FUTQKNeCXHYCfBFLcjqVV+EBt74ntK2AxHXEWfBmtGHBYsxR+CPAqYniXqh
	0FEyy9/8b5E5BTqvdk8bXiSBn1avfo91vRzRR4L+1XvPM8mLm2X6W7cQxN7rAEUZU4yhuabymP/
	Hzg+K2JabaJw02SoPxq1VcN8GyuWElzcznK+l+sitGixe7/jKSwj6GJHTx/6U3IAidaLi7b6irK
	Xlf8itiolvaVvmaXd+o0vqvkzk8IX/gg/WnK7eEdBUKrbhXKPWTOPb9kcqsVYVkITy45DplhNZj
	B8MfcN0kwwAw6IHhWNSbiuVFT+GK8REKmMV1SsrcfLJi1A+8qRD0B2N/21niq3AygUk8pTeMJ6B
	YpCgU/6Gsse8HR+WvSiFol19Z10rZJoJmnIsSwylKp2aTbdK7xZGA634F/3G56xCeRe1D6vdsLt
	IridHC9qMA4Qm2XjF1+cWhfkVnyBbL3E1JINoQCYsz0pvxR0xF6K87rA==
X-Received: by 2002:a17:90b:1dcc:b0:35b:929f:7e92 with SMTP id 98e67ed59e1d1-35de68ce5d0mr8629035a91.18.1775393894073;
        Sun, 05 Apr 2026 05:58:14 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:13 -0700 (PDT)
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
Subject: [PATCH 43/49] powerpc/mm: rely on generic vmemmap_can_optimize() to simplify code
Date: Sun,  5 Apr 2026 20:52:34 +0800
Message-Id: <20260405125240.2558577-44-songmuchun@bytedance.com>
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

The goal of this patch is to simplify the code by removing unnecessary
architecture-specific overrides.

After unifying DAX and HugeTLB vmemmap optimizations, we can rely on
the generic rule of vmemmap_can_optimize() instead of having architecture
specific overrides.

In radix__vmemmap_populate(), we can directly depend on
section_vmemmap_optimizable(__pfn_to_section(pfn)) because the upper
layer (sparse_add_section()) has already set the section order correctly
if the optimization condition was met.

In the fallback case for Hash MMU (!radix_enabled) inside vmemmap_populate(),
we reset the section order to 0. This is necessary because sparse_add_section()
may have optimistically set the section order assuming optimization could
be enabled, but Hash MMU does not support it. This ensures that
section_vmemmap_pages() calculates the unoptimized page count accurately.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 12 +-----------
 arch/powerpc/mm/init_64.c                  |  1 +
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 2600defa2dc2..18e28deba255 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -352,10 +352,5 @@ int radix__create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-#define vmemmap_can_optimize vmemmap_can_optimize
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-#endif
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 714d5cdc10ec..36a69589fae4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -977,16 +977,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	if (radix_enabled())
-		return __vmemmap_can_optimize(altmap, pgmap);
-
-	return false;
-}
-#endif
-
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
@@ -1126,7 +1116,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pte_t *pte;
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
-	if (vmemmap_can_optimize(altmap, pgmap) && section_vmemmap_optimizable(__pfn_to_section(pfn)))
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		return vmemmap_populate_compound_pages(pfn, start, end, node, pgmap);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 8f4aa5b32186..56cbea89d304 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -283,6 +283,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap, pgmap);
 #endif
 
+	section_set_order(__pfn_to_section(page_to_pfn((struct page *)start)), 0);
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
-- 
2.20.1


