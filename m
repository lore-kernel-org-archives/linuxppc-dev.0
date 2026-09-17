Return-Path: <linuxppc-dev+bounces-27543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0084AC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:41:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll3f6qC4z2yFj;
	Thu, 17 Sep 2026 15:41:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623001;
	cv=none; b=ffJ7OsOZ8hWXf6NiC8yb/Z/BCbbCA62yD+7E4vl5t3MqBvMo2gXiPJaR91umgHRwqWgeg7uO9yryv7bk4Egc+AYS1vVn6tmTIO5U3aAwrcGmr3yZ7jP7Us3dyJFtylekDBQ8rq3LFdIRaJj/Ere6gOI4yF442C27TnW39ykt2ox7y/v+BbgxHJIVK4kAJTg1SdRSIxw92qvWo1jP3sm6C11BIf90Z1lJHqJ8ljJ0yvp67DlVy+YmqogksEs4gzaHOLUvEpsSA5W23BwYf0kmGKMPmChrmdiUBaP67OaJmGg19GAy7SFuDGP1jBJP2Otc4AeSMlcJbchx4m2hyaQMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623001; c=relaxed/relaxed;
	bh=Qf2/Psgvj1EaockCLCoqTAU5YfPvsk9Hzwk+BcXGZSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+7EG23RpOMKrQm12tCzr/3Yi2IjvU/dMmgcwvC1YH+Y/d7nvTIzAPxwR57d7kwMNt6XZiM+FtIgVTy1C8YnQrbbiurebGE0L00WS4rrzkla4K/VA5OJCtoKCbhpNISS/Lc7HcC05LbKMwdhxQc4psrxGvMX/nczJdp+lXryjlBTDqB+nNdE6V8uvogv+aefus70nxK3L5dZ5Z/iOAr6uT7ooa5oePQQlAME/9uqzK6ZQPcWbP4h6p1CNN9AQYAGM+3x9Yy/jCc4AoOJotRebSZo1ruCYLSq6Ot7oGLzUSxYetxebr1xkXwDY7io0YpdIHd4SHolA+o/B2ooaBd4wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BhprJ1vX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BhprJ1vX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkpw4lSkz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:30:00 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so378424a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789622998; x=1790227798; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qf2/Psgvj1EaockCLCoqTAU5YfPvsk9Hzwk+BcXGZSE=;
        b=BhprJ1vXatdMopMPOP9l2lQi15ZHz6mrFYntnC+bTZ+ap+GaMvEFLRDkE49dszDmMl
         XaLtucfy+HEcRXaZ1Giftjm+9qhI/aMLgZLvzmYd8ElnDGZ67u6nz2iuj3TydFwzlLGC
         qhOeeNvcUlg1+YM8w3QjZog4M1i4rzylEwApzOJqQOJGXvvo50C6rpFe4dAwmbaTYO1O
         TovscSbVo5rsdAUj4JLukpWcdv1kUraN8rb/SrJC63ux2dlkHe9wGKaZ6Q1rFFwAJZ8F
         UHZ5xatpV0SaSilszeiCDBR1iMdEMWqNuru+COCT0x+3wNFDg69JuQTDndj9a5lyVN4I
         Ogaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789622998; x=1790227798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qf2/Psgvj1EaockCLCoqTAU5YfPvsk9Hzwk+BcXGZSE=;
        b=w6pRSPIGxElJnW6UlEAUo0CUY4sFacb3XFbCIUxltjeMJjPBSSgIp0TGdBHqG3sWuc
         fQ3Sl3OJDoMdyKjoAd6aWWIXc3C9OE8HwbzhPY6BQ7JunweygNLR4SkY4CHOgFEHDjbw
         VSnCmcbC98bmWvkzVsTu2fqwP9c83QuL1cvFX9awn39ASQhZl6u6S3NQpHHGiwRhGHsf
         NnwoBaUwOmY0b9pWsq3tooO08KpE7YpuMj1KjycudVqSkdd+cSdHNhfO1lxKRGplF1ok
         perzuQ2e6iAfULmyjgoMUb5z1/u87m3KA/eCkaUS6r2QMADphHbhNG2tYTMTNhkZOmCd
         uNJA==
X-Forwarded-Encrypted: i=1; AKwUvBzt6hkvpvVwJZnj2/fa1otbKeG3TdIwRECVsLbpuqo0TmEaEhv8PkkEavE0bg8xQjIpcNyFOX2kQT+2RXs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nHZFjxC6n0SS8dMtjApn8+Re5KspTrojTSVceDZLVsD9DJGSPB
	36g+MHq8zQvTEp7VhduG4vcZrXUVgStL2Jnpl5A8l9xTm2ibIjA2zX1p
X-Gm-Gg: AYBFou0IsB+3oFexS+FTOPiAkpwhHiEOe7B26vjYXUQTS2mmpWUnwJSUoonYkbLzGJ3
	2v2/NDX8EsV4ka88aaQ18EMle1VsYs0yWVCkrzuaRolySzt593yXPCSnchcTJtjlmu7BlzLu7jR
	AnKvvQ59eQXkl/NjTBkhwil7U7WQNBHBJRhE7yWoyaNjHzqQR8fmCcNP/Am07rPWv/N+PaXMsbg
	xbAZ8WkjOfj4TtdJWYZdRYptWqdAQdmmH2BbP0pB/nqpmPYrTJNau925i+2KqysjMSA+C4I3FLm
	yG6vTbB0U4utIAyZHv1Qru08IIfGVY8EJxJj2mNd4BXCAQN8iGe9wHFuCiD7HsTy9A3QJJJLspW
	1FZ9Ck18fNibq0z5pTPxc3OHfy67ABEIGq88Ks5pKAQwsemU42dAFBewBSIHyg4wMUPK0n5lSsC
	M6rAR+aXTFKvkMtEHJ3pU8L1eBlXvaenbCXfVIcylsCVUKKiZKMBG6LYSLgLP615RdOSt1btjAn
	xF4y4kh/j2Xeviq5iHXfvnzqZ8=
X-Received: by 2002:a17:90b:53c3:b0:398:c0ad:711c with SMTP id 98e67ed59e1d1-39e1e48a517mr11683515a91.15.1789622998238;
        Wed, 16 Sep 2026 22:29:58 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:29:57 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	linux-mm@kvack.org,
	urezki@gmail.com,
	will@kernel.org
Cc: Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	chleroy@kernel.org,
	david@kernel.org,
	dev.jain@arm.com,
	jiangwen6@xiaomi.com,
	leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
Date: Thu, 17 Sep 2026 13:29:25 +0800
Message-Id: <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
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

From: Wen Jiang <jiangwen6@xiaomi.com>

vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
by reusing set_huge_pte_at(), a HugeTLB helper gated by
CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to HugeTLB
internals it does not otherwise need.

Add pte_set_huge() to powerpc/8xx, next to the existing
pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
PTE and writes it into the backing cells directly, without going through
set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.

No pte_clear_huge() is needed: 8xx does not implement
arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes the
block-mapping branch.

In practice PPC_8xx selects HUGETLBFS unconditionally, so
CONFIG_HUGETLB_PAGE=n does not occur there today; this is a decoupling
cleanup rather than a new configuration.

There is no caller yet: mm/vmalloc.c is converted later in this series,
once the generic fallbacks are in place.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 +++
 arch/powerpc/mm/nohash/8xx.c                 | 29 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index e2ea8ba9f8cae..1ee3f8f0de974 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -235,6 +235,10 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif /* CONFIG_PPC_16K_PAGES */
 
+#define __HAVE_ARCH_PTE_SET_HUGE
+void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size);
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index a9d3f4729eada..2518d2a6bdb41 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -220,3 +220,32 @@ int pmd_clear_huge(pmd_t *pmd)
 {
 	 return 0;
 }
+
+/*
+ * vmap PTE-level block mapping. Sets a present kernel mapping directly,
+ * so unlike set_huge_pte_at() it needs neither CONFIG_HUGETLB_PAGE nor
+ * set_pte_filter() (a no-op for non-exec kernel mappings).
+ */
+void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size)
+{
+	pmd_t *pmdp = pmd_off(&init_mm, addr);
+	pte_t pte = pfn_pte(PHYS_PFN(phys), prot);
+	pte_basic_t val;
+	pte_basic_t *entry = (pte_basic_t *)ptep;
+	int num, i;
+
+	pte = arch_make_huge_pte(pte, ilog2(size), 0);
+	val = pte_val(pte);
+
+	/*
+	 * Make sure hardware valid bit is not set. We don't do
+	 * tlb flush for this update.
+	 */
+	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
+
+	num = number_of_cells_per_pte(pmdp, val, 1);
+
+	for (i = 0; i < num; i++, entry++, val += SZ_4K)
+		*entry = val;
+}
-- 
2.34.1


