Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E6606A330
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbHP35xn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHVX1LPkz2yDs;
	Sun, 08 Nov 2026 00:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059412;
	cv=none; b=DRb3hJpUQfewTmFcwGuHal0kM45q38UD73eErg5JXfe5Tn26GHFcG3w8vA5ADt6UHR5Zvfftkb6q0vl34Q3Sv+Z1/hn7tEXlVDFYEJBEp0p2homr9zyKYYZzy233nljQE+7Lcbjwe3B3ilDS1cRoB0W855OuxBovDMF7y1yFZSwaHY+ocPAaTATF7V7IA9L95TwI6NNVBnLMMonrHNUTSo37xB+F/+8l0dm9QydRH4GV+BOAlWYFZgMym6DuytFOoQuMD37Uu4oWGINONg3ymHNmrg2njj9hTh23KURHR07RMoVDBbUfeg09MKXNrBJNxqdV7cL68BRSLTZoXGjnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059412; c=relaxed/relaxed;
	bh=1yTgtDF6jEtnEd1/HsYlbR7LkWEKWDRmQNU783tsnwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5cqfM9rx+lfsEj8u+x8ZTkDXjXCkHocfXdZyG8/Tb482jO3dnq8N9CJzD5mafL+105gIyvxKrpKHvUqW/3Z/SGr2uo6zXWBAnzDq/3m3yaZGLJPJb9gEKFgUKcs5qArbtYarfw26gJORKYn13JBaNIXRrEyfnUCqDGlFptQeM8hvvW7is6jakbRY3qIPmOGj3xvhc495JhYmUMoPQHBlvrZTtdNlgcA/G/OrmqjSE+K4RWTTeHAHPwLuo2tDHpI9bIKj9UvSuFKQMHYIBIIYngaLvvvhsmZfhVJ7IOmm5jfYgf1vpS9UIBnI883dWwjP6D+o7ApF1a53J/0lKdxuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbHP35xn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbHP35xn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHVW1twHz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:10 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-37071c0f42aso2118519eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059409; x=1794664209; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yTgtDF6jEtnEd1/HsYlbR7LkWEKWDRmQNU783tsnwk=;
        b=vbHP35xnRn3txWhVjQnyPCkZmaBC+IMVzD6bpgaVLLXMkcAY46P1cPwkwVPnFmfKRF
         297YAA6Ms5yrbKT767va0NaqszjyQB44qP7bEvuJsoAuGMo9HGk7mnO17YxetCs09WAK
         M9GNK275CmLFLwriSH1yUPd4TU0BvxTN5prRD3tZvhP0gu2ueHJimFQDn9qC/5xxMuQP
         sq4SLiNzZZWtc+wMuTvEAG3d6pw7N8jNCy7YTqawnNvxfj6S52NKqdlvAJMw1ELCjTpW
         o1b2J151kNsXQ1clUSEE9yDa8lhAZcb/kg8K1Qiot3zYw3TrX6shozVOYvCvZHwbdg3D
         NdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059409; x=1794664209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yTgtDF6jEtnEd1/HsYlbR7LkWEKWDRmQNU783tsnwk=;
        b=apl/ta5lNksutJuA9Un35AjlcpPF9yDwhgyHAeqsKwkW7S33A3JBBBpN1OG+l8DIHf
         4LGDrID4oG554XN+ipqH3yJJ25hQOy4A9GPXiRFVH4Z2Rh3ErPqIbwCyyTUxvvij6MGw
         d7IFARqikew1rkStuoG4RY6WrN6DtvEudgM7ibgdMUx33Vqepiw56GX+5WmuHGC/uCpN
         WJtP9m3HNBibtZRqZnNtKHgQA9dhEJBvLwp8kIk+FZG75bpx7F2PoH581pcW2aXu6WFY
         BCzdTJLEjIuucA39zQ1nplNeVNSGbBOOyBevspgKNxAi1IZpmN5UtmZtI0Wl+9Cv7CTg
         IXIg==
X-Forwarded-Encrypted: i=1; AL+hErF0n9yy2XyxH0zzKc8Bksq/CHB+dFLXLgEAseIGYUWIVET+RCfY60rjwiphCene0aMcMZO0qKlGWAyEGoQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8wIPbjbKrAuBRovM82ehZ+C7SEODcx5ApxXCEskIHQni1jwTY9
	csVK3zBMTF7N2qiKiDTuBjC/X5SgE+A4cBcxOHrP86bn2+MrHLBAO8ZbuVpcVpzdues=
X-Gm-Gg: AYBFou0n/JTzzWcz0xH3Q44bvZMXuTxTK7jKS7iX4w2o1SFpqDTjC8IVZ6Afc81sRyk
	ivxlxW9pWAf4KP7Q+0ca/7Dak06jeEWd71t5M6TzttTgwwXiOgF8tOnlBAq/GOhCcVJiSVT74Uo
	9ESR4IexQA41NAeN4KUUUgoI2ZuEWDmjYJDwjnWK8gj4f1BFAXHXh757YbB7/iW7P3mM+/NRZFZ
	Zu6ukmMA8KvJcRF9WtR52+4qLGAa+qyL8+v0UOFw2Mqm7+Rz/VmrUYsz4krAU1qQlUcVIDWE5zY
	Z05rz4nPt71peRyBBdPwc/WTBV+rDTt6qzEwHYH6qCuQ+lQwsUbrYSEo2XbervZe3yB0PjfIvww
	tw3feI62f3bLQG97UJzwwXOkBns4YQnoPj25axBfVsB7UzcUbQ3AbfrC/iPjTSXZFiNnPS/jxKd
	FPwvru/G2r+O/9yMjuioHz58pBxTgCO112AdUgLlHIMvcPUmq1ImaWVTAHyOJz9Bwn4gs1AyRUm
	m2TdR/4n1S6cuSzArULMS2bDqgFxLfLB6f4U+F+PJP+upnJapmrCN9a0b0XZ6HSy52EkePy4Tgn
	KvoVoBd0+XZNQNBd7Hsu/B79GafAcppfneDGqTOI2DVdhJkQX0IikQvHTw==
X-Received: by 2002:a05:7301:70b:b0:36d:4560:dd38 with SMTP id 5a478bee46e88-36f765216bbmr6889124eec.37.1794059408773;
        Sat, 07 Nov 2026 05:50:08 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:08 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 01/10] arm64/mm: add vmap_pte_set_huge() and vmap_pte_clear_huge()
Date: Sat,  7 Nov 2026 21:49:44 +0800
Message-Id: <20261107134953.748622-2-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
unavailable on CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to
HugeTLB internals it does not otherwise need.

Add vmap_pte_set_huge()/vmap_pte_clear_huge() to arm64, joining the
existing pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
__set_ptes() and __get_and_clear_full_ptes() directly, so they do not
depend on CONFIG_HUGETLB_PAGE.

There is no caller yet: mm/vmalloc.c is converted later in this series,
once the generic fallbacks are in place.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  6 ++++++
 arch/arm64/mm/mmu.c              | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a474c9fb485ad..ce51c1b9be222 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1927,6 +1927,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+#define __HAVE_ARCH_VMAP_PTE_SET_HUGE
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		       pgprot_t prot, unsigned long size);
+#define __HAVE_ARCH_VMAP_PTE_CLEAR_HUGE
+pte_t vmap_pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 140520b351e28..66b23c78f0951 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1912,6 +1912,33 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		       pgprot_t prot, unsigned long size)
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
+pte_t vmap_pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
+{
+	/* Kernel mappings only */
+	VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
+	VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
+
+	return __get_and_clear_full_ptes(&init_mm, addr, ptep,
+					 size >> PAGE_SHIFT, 0);
+}
+
 int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
 	pte_t *table;
-- 
2.34.1


