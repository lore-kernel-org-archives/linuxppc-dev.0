Return-Path: <linuxppc-dev+bounces-27542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B61C982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hll3W51yYz30Lw;
	Thu, 17 Sep 2026 15:40:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789622995;
	cv=none; b=EO2tlirhLlT6lO4bHdk7gx7gjrETN5ugvxDtG/HX2ym0a5m1qyGldDY1KPNXuCCPiZSnNKWlGf7nWV4Ak85v5K4W1s1/PsULpV15cixODZhsQOUlTY32mWU9pust3JHbQ5YZHkR7vZ/hKO26Tbv6IsY71TtDCwztagM5IVaQgZaSNIFI1MrsBCH2vT9hhAUKqUQ47IB6WvrmpqPDnAmakuh1526+8jyxHcNr2a/qV4Mc3Ls+sIBcGyybmoyv/PG1E7w9N7zJnZ93/PBCGum6y6MIokYBckYaVIFqed2VUMerVPqu1d9aXKS04/XBRkGZJfpZdmLeRCR1xLNAzCcZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789622995; c=relaxed/relaxed;
	bh=aMxiXZ3VjT6yairvAxeBbjdHvNVDdfswnxYz1hMIZxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1q9xKIxe3lhDHbINhO9MHu1/lX+TjVXTK8PDLTeMauetVB/U3rsP18P5ccoIBCVCNzfw7GQsMSMmAldoPw4HZ3Ox9aEXiYCH4tC3yKzyK6jyJXPPN4bQftE/3pycZYGE7Kdc0vq5IZ1WxkzGs8d+0pScyjVYeLjI1lPVCCgR6x1dILLxNJtzQ4De3+R4p3sMnAawcGJpivUGzgIGHVn54/HF+YPNOYeJBIdnH1C2Lo6jvAwbpn/GnXfoD9t8b5cKl99YlzF0scMg7bsJ55QmFupMLiOJ+d95uNpbYfXEy9pmF3EpJt2+Mpbo1N8fZ69n6Ss6vKRmrpnAwXzYaEuOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YUkzok7X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YUkzok7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com [IPv6:2607:f8b0:4864:3b::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkpp56bKz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:29:54 +1000 (AEST)
Received: by mail-pz2-x0d.google.com with SMTP id 41be03b00d2f7-cc4c3304833so302654a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789622992; x=1790227792; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMxiXZ3VjT6yairvAxeBbjdHvNVDdfswnxYz1hMIZxE=;
        b=YUkzok7XkzNsr+/k4kwymnQHELrDH7vKvN+vvXXGqZsyUmZH52q7WYoyzeFC1G6Rhh
         SnI2JG5+PuYKg5ZmEWflsh88QSRsoMcBRWEPAwNoKlaYIkRDfg7d8Tg46Np/Q1ftFLDg
         4A/XLLH6FsHPctFCze4Fh1KotHmm+7ugOQ8vgnKe+8z+X73o3kwHBV1pES1KTiEGpY4l
         KBx5cBMm0j0MMTxoPvQ9ACIjZ7B5Qwym5AOBHvh5XjCMEKfhHWEjjsQyRtKYWLRthVuU
         cQc3N+Z7K/TBCE7ZKRZ6FsL0IMBorVuh0xTEsWecCGdGTXRPldjbKdpZ/8kT5yumIGhf
         sixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789622992; x=1790227792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMxiXZ3VjT6yairvAxeBbjdHvNVDdfswnxYz1hMIZxE=;
        b=wb4hUhPtPRHkEOMwoGZb+e30jsD1/PhVdA+NqRp9s2nejJ8cQVbWiNhlzkH39i1Lgm
         pKqZ1uSBMlBOitGV/O7bUNf3cD1jXs0zqny3D+RAXy96zCNlU8QJETDA4OwQdOIXMPsA
         0fWMHSkbyspn0Bx/nzxQWVL8qhnziwGliwJrOpVCGN+6DmX2b/lGYJLuF5rDWCHf2v28
         y4IaqQO0oEtBoUdHHr9tx+S8h5UQRtYAjBh6HN9rRIPhuE+FkHp+O1sgg3OwMZ7gGcET
         1Ws6ZcpiHfDFhVg0KTRrJi2ZMTYjyoy/C0MmaEhxEzpcc+6H8sjxbgbmr+FLQQmoaVlQ
         1swQ==
X-Forwarded-Encrypted: i=1; AKwUvBzD8VDk48nYmEpaPNaSxPaUrOSluM24c1FMPNPTC/NL5GoBUF8ZxvuQHtwmWEzyifMawK/LwKlVP6OLe5M=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k/MemFhJ3B2FGqRs7Ovzo6IQiLtAPX8L9a0AgG2cLLpJ6WGZc4
	ZOsDHzP8PIuZjmQEdYi/hCFvyrCwXve78l6dhhvo3YhEx5R+p2Dw+WTp
X-Gm-Gg: AYBFou1gxyV9fDQjR0h4FQwnpEskcE7IlpbeVSBqLZT9ZkmdS4Xrzx4UnRu1Cz0RzEe
	yG/5iFiRxuU/+dUgt6dc2pe/Tr9yo2L4hTq9c3pNdIeUDBRRvZnExAFUCamROoVZ9ChqFTJQmO/
	HFTQaaKdqO1X1bAhVB+43K2m/XrWGat8c7DEgJtu5iAEKJGsUrne+h8ZLtrn2UNm8EPmdO7QGmu
	/eu81yJ7cyP/954ArD53DIThSYcURiRzA79cmYTsmqavxS3zOvEpV1aAzFFps5WUrCtpTb7tY+M
	jJgp4k2e70LUAAzk1Gt+R3Fg5ZyL1yMeHFCXtLvCap+qK1hE6YSJvlh3LyYqKsb3dDYT+dy3y/k
	tmxslNUseksClr/QrEohEEsKxBvCMMrIj/LkJbFhmIfEz6V6Fbsvk4Xa3hwOolh6oxOWCOyvmL3
	y7C+LOod+XSH53STdjXomgJ5DsMvXKuW+JG1M9s4ep5nZbYa7p0mGA9+JYU1415Z8drNuofSZg5
	OSAktXnSGwqXYITMUcxzwRKtQk=
X-Received: by 2002:a17:90b:3b91:b0:39d:ec43:3cc3 with SMTP id 98e67ed59e1d1-39e1e2f3e9fmr11172449a91.10.1789622992190;
        Wed, 16 Sep 2026 22:29:52 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1955836a91.14.2026.09.16.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:29:51 -0700 (PDT)
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
Subject: [PATCH v8 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
Date: Thu, 17 Sep 2026 13:29:24 +0800
Message-Id: <20260917052933.188679-2-jiangwenxiaomi@gmail.com>
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

vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
unavailable on CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to
HugeTLB internals it does not otherwise need.

Add pte_set_huge()/pte_clear_huge() to arm64, joining the existing
pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
__set_ptes() and __get_and_clear_full_ptes() directly, so they do not
depend on CONFIG_HUGETLB_PAGE.

There is no caller yet: mm/vmalloc.c is converted later in this series,
once the generic fallbacks are in place.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
---
 arch/arm64/include/asm/pgtable.h |  6 ++++++
 arch/arm64/mm/mmu.c              | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d0535..6ee1522fac78f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1949,6 +1949,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+#define __HAVE_ARCH_PTE_SET_HUGE
+void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size);
+#define __HAVE_ARCH_PTE_CLEAR_HUGE
+pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 92fedf4db9278..93b602a6c68a6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1872,6 +1872,25 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size)
+{
+	unsigned long pfn = __phys_to_pfn(phys);
+	pte_t new_pte = pte_mkcont(pfn_pte(pfn, prot));
+	unsigned int nr = size >> PAGE_SHIFT;
+
+	VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
+	VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
+
+	__set_ptes(&init_mm, addr, ptep, new_pte, nr);
+}
+
+pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
+{
+	return __get_and_clear_full_ptes(&init_mm, addr, ptep,
+					 size >> PAGE_SHIFT, 0);
+}
+
 static int __pmd_free_pte_page(pmd_t *pmdp, unsigned long addr,
 			       bool acquire_mmap_lock)
 {
-- 
2.34.1


