Return-Path: <linuxppc-dev+bounces-28727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D819CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:10:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3035327z2yPG;
	Fri, 02 Oct 2026 19:10:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932211;
	cv=none; b=iueIz4ayABJvSHQcxczjCfZiwktGX47va2qKQDQW8dhtPOwrxERJJpTL1G2Fph1CvkoKj2YRGVMEfUUwlNYZgRGT9+TpBgOota+OzMWOienduAZUcx4en0saOLIr5PA1IdE/vDwcjBrY8iioytmfy8TgPtUX9JHsazS3bFoPva1spucIosGVI6ErsIb04+/w0ptLa6yKR+VCt8F/Gwh1iudPEre2Aw8QYYCbU1p1cRUycVC1+4Igp+fY/sSKjFkxDVF6hHZs526Lwk8iib8QNF0rnpZ2dOKFPCbXmBSLFY7YEE0F5j63vDCnfiorTx5vCbE1vhHJkScL3g6tMz87Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932211; c=relaxed/relaxed;
	bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kekJcSSsrUrFC6IZCW4fS3BLH36pyCflziSaG18dcUO8SVYH+adr759Zu70pOP2jtPfkUKYTob/NFYfQameSyyhALd+NC478nc+qkMqSai0irG6s498EO9qHMpUQV10u/BIAH5hP/8wB7oH97P0eVDTNdMagXMvqfNBjjzOhToyFhtCsyeUtw1Wpu5aylTkqhZeqwkgqrdtBMb5XyznsG/WspVk5Zqt7Gj11hrcujDbadUUuEZmvpuUPVPRJITFjv4jgoLcTRv3HiLdDcBRJ8XIuEkji/gTE5eITBU93NGQX6UCCVlLs627gDFqIP2APi3AaaZTgZharfYuGJLWjEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0BKjdZz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0BKjdZz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3026l0Bz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:10:10 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747f0b25dso48340845ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932208; x=1791537008; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
        b=g0BKjdZzexpZ+lycVmhChCsQMzXXrZTxCJyCTEcN7fbfpIbKy8IDnQQiBkQCru6T03
         pf/0hqG2beqJ72aAdgu5RqGzLG5Gg8+Lt5DT69EFmxsIYTruscyyhq6JLT/CK+NmIltP
         G/fbI+IgyC9hsjWpRt4VzDF38/r6XeQhnUMxt3CFwcm75OPZzkdxgiOeDWCamPxa0ci3
         HcA4KTbM5NWCoX9f6M9x/pNFDqNonu8h+Eemm3qPGZjBswmMZvbd1pe1YYqXX0nODpm9
         cxZtDPVUhdXKrYbgYZHpD+ZWYBECLda0WK7vRfOJ1lvvnGXs+lhPJBecJmOYs9qf2gtG
         Vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932208; x=1791537008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
        b=LbLEA8ToXwew7b0N1L1qXstr0EFp34y+Rk0P2xguHCwjY5UqQXFk8xfDPA3haHaypB
         tj601G31ze2wiHJxz6cqD+c1rc57qpwR9Lru5nXL3qZV6NxGNUHx9I/NnTbaYt+TQXc/
         R86SFWNEEaoyLz2Dz8ocW71/6KT5i1czLf6g410GWy+0kNy3mvXXy/ae2ujK5+3EAfUB
         QjnYu9blr6DIY9xxr2yNsNRAtK8UOPeB6lOQHgz5+nDVdf2uZFKT7BgAXwn4Jf5R6ic+
         MqKjyjTd9z9D/jvLZl2k3DGqGPTPelnco7m4BWaD6vSeB/2SVGyyEvshtiUDsSV3sePk
         zRow==
X-Forwarded-Encrypted: i=1; AKwUvBy98fhnzAViqpXnR+lZCCB/HTxO5/gxRMk33dWy9cBpVYbn3d6m2PAiYjDK4FJ+zZnBTm9gfQjWdUFBxoE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIs8hi36+rEWp7uQNjifn12PD6CePGV4khovMNIoQLXToZuJaRR
	NlHQGcfZWimS9aayI4ArjqP2bHhaQuQRBHSPENhV7uXTKc2CH88qVA58
X-Gm-Gg: AYBFou27Wg01jL+0GmYi5fsx9M5tAgfc76kwV4Fm7RsWTwm1/DpVQue0FPThTA4F3w6
	rIcnDUO0hVbWeepGR+8nyfXHu/qbgK0JWvCwtophd94sfypJYcuaXrooSZcZHJ8GRwVL7TRbBDM
	LOyBS2ocBCKM8EustoPzQ1zIbc7jx7xDtfomTIB+RKpk5ewGTpoyaiJssur+NIQUCRML0RMNLFG
	4hT77J9q3aOu5aIb2jlnfXrxBig/gMJqUN5MpQAhvh/J83R971U97u19ytAJCQwV7JzxXxr2FkG
	jI3QQ6yVoplUxjuYwnLRWvkU2dk4+0Do3t4gQ7jfPg7b7/4OUqYwi5gODufkyoH6yP5feIoO7mm
	zQCn0JHzoKrsaBmCDputvjzkk4sxCwXcwXi0J+cQO299VEUsUx4+nO0wCv2l32CItjDVsz2XJJP
	FstS8IWJ2q+j4COcCTS837qqBRDP8Y5syU46Zmj+wuyKr5A4krseyu+WFfwFGiP9KToUn7buAtq
	J8XY4Vtz+9tjcxW9QgLjQ==
X-Received: by 2002:a17:902:dac2:b0:2dd:68a4:170c with SMTP id d9443c01a7336-2e49b612e9emr18357635ad.11.1790932208496;
        Fri, 02 Oct 2026 02:10:08 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6ab2b9sm5480555ad.36.2026.10.02.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:10:06 -0700 (PDT)
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
Subject: [PATCH v10 02/10] powerpc/8xx: add pte_set_huge()
Date: Fri,  2 Oct 2026 17:09:39 +0800
Message-Id: <20261002090947.869220-3-jiangwen6@xiaomi.com>
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
PTE-clearing branch.

In practice PPC_8xx selects HUGETLBFS unconditionally, so
CONFIG_HUGETLB_PAGE=n does not occur there today; this is a decoupling
cleanup rather than a new configuration.

There is no caller yet: mm/vmalloc.c is converted later in this series,
once the generic fallbacks are in place.

Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
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


