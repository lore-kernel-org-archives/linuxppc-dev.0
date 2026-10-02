Return-Path: <linuxppc-dev+bounces-28726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBCCA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx2zw6w3Yz30Tf;
	Fri, 02 Oct 2026 19:10:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932204;
	cv=none; b=axJI8LY7QiF6drEnMaQddCIsCfHV07bFhrPPdj3Zbi3AKW8Lb3foy90QIDBb3Vi6hxDkOJnKeRaNZfKQoZFJbPpG2/BQdeaMoCtsqvw4VkwUne6StnSWOPR4mpJovsDTwfPZQmfVmrdlklFzgMOmKp9ggvSGNkLYC4HTKexutbjNXrNWpVdn75y8oy0kMmAzWL4WuGgADpb7ZBH4Em5RE/7nrQqq9b9Ycf4uEdHaSA4Qd4ZGoLGfiPqOtJPTWc4eEqcZ1J8bpeCP+yvaLxpmO35Epbx+gFPxgUHGCZbamcuIsm+0myS9JKqq6Ef2Hh3c/X08l7l0xZDGS241Ki34Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932204; c=relaxed/relaxed;
	bh=ZrNUgiHK76eibcbmJczjwEumW62nZKL7vmCqyjldhkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDR1ou3vQ7t3iieHUAt7KNBotlbt6/CHX8SEsL/uPWBqdJVrdm2zSGxhcUXAPOkwxdvDspqXpFx8KhTbVgsE/bp0m++0Nb/DGveKagIGi+mWt5QsEanILrl/PZJZUpjQ0hVzWQUQNmorxkff5K4CBxgxI62p+jPy2KuP66HfpInd/Iqljyt8IpkdTKWpF/Zfo/eWfhxVAqkdaUgdYzcIjycX7dlURAfxmnOS6DpFq5xHhSGAY5w1YL6rSQjgpQv9yTb0uziv2MuQ/jeyehl7Qb87ZCnh1r6/Hd1W/3QPP8MJyzRvZrcYkxqhc7zqtprQdR4K7G/MM+YpHr1tIzN0Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eEpaBQ3R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eEpaBQ3R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx2zw2d4Jz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:04 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so6577385ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932202; x=1791537002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrNUgiHK76eibcbmJczjwEumW62nZKL7vmCqyjldhkU=;
        b=eEpaBQ3RDrJcMfTVA27SJ7qPxupw0WLB21wS7sxZFbpZBXGPAx7LhnSFT4U62ddkad
         dplSCBUtabyqCKnRh2xEa80EindltyZmKYANSXEBgeZuc+4Hy+L4VQ9OkBAMWgujI3s4
         2H4H5tgHPvv43Xfd51bGV7fWWUlGyqSHX3P8ywH7Y9zeH7Zb507+dkRRXOZn4WxlWKOi
         +cGlFUO37V2ane8l+2cmzKdHi6oW9VX3CUeUtobZdh19rKwa2osuNGEEfJRGeLWnzZ4f
         bYLGY24gsDSKtetlRAV+JrhX6VM+GedYAFzcb3uQS0EnxamXFOoLNdf7ekz1w2kNtcn6
         nj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932202; x=1791537002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrNUgiHK76eibcbmJczjwEumW62nZKL7vmCqyjldhkU=;
        b=RS0ICoX3tv/+KR1KsRX2qR3hLrnIe9COhhjQNRwx7p8CPXL5jzAmv6dy/QBcovcwmK
         DIxhuhu6Dd6MueOQs3yI4hGyNWrzz5OkEeoNuHui0zSAv8DJ3kY3yJlIT+hNIASauuZx
         dNIMOUiaz+4Xv/hUcc3/yDYJ5zo5SAEBu2fOsCQeDBT0I75Pz3mZh8ZpObtt6ALFN/6x
         X/+6u7luXFdmXOZauxAiKwosRlundIDA+TIc5CR2S6l3WrKTUprnxFo5U/ooKMOSDTdz
         HqlQw+zibC3jXPdC4d3FX8+PGdl9OqPfczgqMwNiwuG7KTRbzpwN0uCAvFqiNkF7PTrC
         WNEw==
X-Forwarded-Encrypted: i=1; AKwUvBz9htzV9NI40GlMIrBsr3QUHnLT2nbc5sUDYoYOXj5W1D53It+lfzGgz2nDvZHg7P43p32+NxOviMMpM3Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIDvNA8ItfRVXeRgJvqnjtqGchG8K6/sDBLKD2xaIB+UBf7oUKf
	1EEX0LaiGWCDwGtW1Y8ilABX9RejBdYQmMKVhgqLTvD8QQ1ZZOwzppZr
X-Gm-Gg: AYBFou3u2ZFwLb3/Al+HxUK3oYOJxfN6BmpYjPBj4sDl8WDAoV0zaEgfHZgT1O46I7k
	MxmG5AlVTbqA6gKognYMvh1OFNYtu+mZZo+WSLYSUc9dcYNGW4Pqrx/Xo98EEhYf812S98zLBNg
	YbuemNY9EIq6F4DJV1VmXqncEEE1IIELe+BfNSvNsKBqWDCSetc8YAkQNbl9JuJp+VmUMyr20eE
	VeM15NUkhSFiV77mgsHuJUUV8lKhitDz1Hjf5as4fqwuizCwVXsyndcNnn2Ytozd6/NHRIkzaT8
	UuesejD5NngIDmywHRuhc8GaifhXBdQdeAS8bTJUuMUih5nCzdC4J+xfOXxk64+yM0+V/mVh8CS
	//mtI4yi2w84u+MmSLdIYhlKbVyWMck2mJusgs76HE8YxBghvxVVjowpGacC7hsoiE9bgSojdXA
	noFVW/cm4/L1F2dJ97Xwvycsecaucg6QksXrzovrXOGfwoZw0ROtYM+K9OkViWWhXLYb8VvBG+O
	6tBjRUZYUlAimZvzelwzksu9aVWLls7AA==
X-Received: by 2002:a17:902:f686:b0:2e1:35ec:e03d with SMTP id d9443c01a7336-2e30029e1cdmr33883955ad.31.1790932201968;
        Fri, 02 Oct 2026 02:10:01 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:00 -0700 (PDT)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
X-Google-Original-From: Wen Jiang <jiangwen6@xiaomi.com>
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
Subject: [PATCH v10 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
Date: Fri,  2 Oct 2026 17:09:38 +0800
Message-Id: <20261002090947.869220-2-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002090947.869220-1-jiangwen6@xiaomi.com>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
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
Reviewed-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  6 ++++++
 arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6000905a2e865..9b762eb68cff0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1978,6 +1978,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
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
index 79d90226fd5dc..ae2f15618c97d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1912,6 +1912,29 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size)
+{
+	unsigned long pfn = __phys_to_pfn(phys);
+	pte_t pte = pte_mkcont(pfn_pte(pfn, prot));
+	unsigned int nr = size >> PAGE_SHIFT;
+
+	VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
+	VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
+	VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
+
+	/* For vmap, there is no valid -> valid transition */
+	VM_WARN_ON(pte_valid(__ptep_get(ptep)));
+
+	__set_ptes(&init_mm, addr, ptep, pte, nr);
+}
+
+pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
+{
+	return __get_and_clear_full_ptes(&init_mm, addr, ptep,
+					 size >> PAGE_SHIFT, 0);
+}
+
 int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
 	pte_t *table;
-- 
2.34.1


