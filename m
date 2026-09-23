Return-Path: <linuxppc-dev+bounces-27967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48FCC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:28:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRr63x8gz2yvy;
	Wed, 23 Sep 2026 16:28:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::1b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144934;
	cv=none; b=ZTfIuCklrFpGPRakaQbMROrLmApVsIUpPA6A4sJLI+7Godkhn+lSt6sFX/WDXkwiL+Nn/Lc2hCGHeHiX9UtqtuUGUnJEbGcNMwPwS9+oCjZjQvqbkH1swm4TCYRPSMi+jadAbrydQt4fgfsuwPc/fuqvmltcUvRb9X8pY7Vg/XR4OhZr9N1OtOcWHygxYQbljylYZCP9WPqYcw1gPimqKbUE0H1yHo422ly1wunif5Y8/0oazsmDnvFxflRawzkpdzdT0vkNFn9oAbKfBV9Ew3PPEt+NiPFU9OSI3CBKrKvEkfn4E4mzwaZMYf0vYL4EJCoDsH9AiSFNKCpeMQZf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144934; c=relaxed/relaxed;
	bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aV98bQ7ZQ6tz29z86V015E9bABN1lpB9c3yYm40m5eKTBV60UrOlDydAdhZVN2zc13WccZpOcHaykn6yRTDcr01q3MmpvyGdFpkCIp7uTspAGcVMftW6mybzbKaxsZKxFts/LgXUw+6zk79GQFLs5bdDPQhn5RAIZvcxt2vpfx2/O/cutFLsQ/ov1jcc7cFLQoJTO5l///2KLw8ecZ1+fRUIYLOal33ArjMKcM/Bn9k3Ek/gfAF31RyMxs+BXjbZBbswdYikUsUINEH1n9gpBiLRge7fwO1GKjXOXNlnm/01jSCZRgxMft6cUNXeQjKov7nM6f9GLlmMmxPSKdsAPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VRWxq0ZK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::1b; helo=mail-pj2-x1b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VRWxq0ZK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::1b; helo=mail-pj2-x1b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x1b.google.com (mail-pj2-x1b.google.com [IPv6:2607:f8b0:4864:39::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRr55WbRz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:28:53 +1000 (AEST)
Received: by mail-pj2-x1b.google.com with SMTP id d9443c01a7336-2d747f066d8so1916755ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144931; x=1790749731; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
        b=VRWxq0ZKqPaR8KJLh08v8b0V5KQI+lHmb/vKyuxrsZj5lMxm+Zhk2sDwGjLZDYhWDD
         ot9ONtlFrJvHfsKh+wnEuk8vz9fsut4CK3M8zIYu5S4a/qLxaFnxtdrmtcXYorUaM4qI
         rqq6RYnGf+W6/ktPjo1wMEv17D22n5PnOwx6jhZFh//Wt+0JdZ18MjAuLnQlsh70y7d9
         gIV80+JB59KvpsC2vNHza9O/LxT4DLrGyaDESmRhqnzUcyuTckZ+ga+b1Hc0zNSRpWoI
         1Nuns1hOG5uXzZyFHaqv94ZDmBNxvdVKbnSEtrLMj4xMGBBzqeYsp4yIjSX+AwMzVTB3
         VxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144931; x=1790749731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qd05crYEDf1zOBsfrx9KiTFMAUGQioHKS/Nf5VbEp9U=;
        b=XRZI+SNH2P+QAbaToJKEAH9QZ+//UFpSogh+c4Cdz/FGIUq/Xq1ynaGf6tdBZtbH5Y
         S5Htg0lFvsWkjAJMVO7swihruqmyTHC0GYrz1U/8FT5pi0j+7B7yPQSO6G+++5P+0YgQ
         8iKBCloW3/emEjr7tt8PgEpTfjuEu8rsH5m2TgBbn51maS4hsDXWlN3iEpahjfR3BGF4
         /Mh0lwwPu6ihm3oUYCaEJliwMr8g85WMon+IG88z3FLZ/UXXZjGEr5yujsN3CRZ5IUWA
         QSWHEGR3ICUEUJNobXiG2A7K6YxoPIVmGxPRmx3J4h5CavcVe+T+BASuGK2cgzx5SSuS
         lZbA==
X-Forwarded-Encrypted: i=1; AKwUvBw8WR7U49ODbxsn3ac2Fhr03onMnmhFH/KfYxMM/hyU3YwWHRNRldRRJxpZr23rwlkkbZJKmcMh+lufB8A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++liZtPlsMMOmlWYnW2kL7SxNd8oLVr1fo1aR+uAEXTnD/MyoCX/
	SgXrb4rCUVXASDWMQXtzmrNQ6TbEDcVUZCrACwQKehQWaGuu9r5PXti8
X-Gm-Gg: AYBFou2zn8QgjhRDtFnLdvyagtz9egMnmtm4m5wnN/5ioThBdp217vzHnWez71RcugB
	pzNlFJfD5B2l4VI7gc0Ika4cH46J3T1CnGOHs0CvePD2yMt25Wgc8LNPN3jGU6pVHRJlNJE4VAJ
	mLFGSPgEwEDjhFtSbYjwI7EaBfsU+P+doQjpvFkOIV3+wEpROLmie8H7csuEg99gfzIbloAaJJm
	GXb1QJOYEy/5GCcFphrNyN8xeqfTuVTb8vao0tuwVaN/hAnuegvOfqFAkXiCTXhKS/KR9rC6/uO
	YvvRgyr1orE87cIAujaBkww7nvfT58awKEvYWGfdmmTdfTt/z/Yh/qsyrBOgYnCRAwXiFVZbCZA
	sQPU2wGKOoXCcJzVpHWZyfRnwauQXNG+QpMjGj0SNljW6HsGHXquRhQjHM6OXb2vMQNIg2RdKr2
	Ei2NCkEjC9fzudSPcp0YVAoEfT3cy556xX3sdtGOfsC7+3e+GW8k0PXm/SFUjJiBbUzHPGJNzol
	Hq4OogA4YyV3gg5BlLEmQ==
X-Received: by 2002:a17:902:d4cf:b0:2cf:b9f9:18bb with SMTP id d9443c01a7336-2df6987811fmr11433845ad.4.1790144931608;
        Tue, 22 Sep 2026 23:28:51 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:28:51 -0700 (PDT)
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
Subject: [PATCH v9 02/10] powerpc/8xx: add pte_set_huge()
Date: Wed, 23 Sep 2026 14:28:24 +0800
Message-Id: <20260923062832.479455-3-jiangwen6@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923062832.479455-1-jiangwen6@xiaomi.com>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
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


