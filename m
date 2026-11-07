Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22560606A32F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBaM3xXo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHVf0d98z2yTK;
	Sun, 08 Nov 2026 00:50:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059418;
	cv=none; b=eX7kT1BuRIinQZnFWeznTOIfNLA8ExEd15G35SfNLNHJ8ikwa/msATNHPmZAAqTLyiX5qZODKtrftURpOenLaxvYnjI5XpydRiNLqWTwsMg7CP+shIGsqwswx0axunNLaBwNBY0HlXf2wa8Tp245UWxlEHyOvUDkIscEHer/xG0OGmVXhobyKarl2V0NwFw6glSqJqxKfT1icn4t6XQwYp+TmZkPnNWXoGz0KHQGoCmj6iWCa3M/kPZJlwb79YNf0ZqFgMLjElU+5KthmexiOQsxFFduSnWrx7a/1YgG8R/1SoydzTI7Rm8kaM9TcbuDGsCuRcmk5iQOq+7+bSj1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059418; c=relaxed/relaxed;
	bh=aqN7aZ8iVALpTxJjSlPOIKNge5VZrwlYvXTmPXr+N8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmMGyRKBJnw/xUleTjRIuV4fUTH1FQK26kccmbNxbZvp+ukSC7TN4RNirxKBsYXijGXWZTVDsT5HjM00MTsVtsQbDq/UXxVmxcTygNsbi15JyH3rHvUsz2fp5CgvUCzJT1R1AEP0+FAmIY0ZULX2UcfZ4vvv2ae2Vlw7zcNHU6Z3l6/r1xtJ025ly4Iu09ZkSJkcwlp8wDTkD1nZpvpiHCWxRLc2EdZvqmo78kaWJ04q63xxV6zibV8oOPs5zkPvXKMQlVEQFDB/951ZLZeU2VMRWM6I1bwv55igEHRwIOJmoC7HbyxyuslP4AI4ikSpRM7uztp9V2I7E9gjwUWqXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBaM3xXo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBaM3xXo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHVd2fgrz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:17 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-37071c0f42aso2118611eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059415; x=1794664215; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aqN7aZ8iVALpTxJjSlPOIKNge5VZrwlYvXTmPXr+N8o=;
        b=RBaM3xXo3CWoxjMlBFE++kD7AAGXj8g2Z2v/CgMEV4YV/onT1DSKw8tDo4oBl1X5II
         tKjxFu8rYHH5ebzBNV2gVfroJ3r+KqOiy//TSSxNh8vxRVqsFfwLOzE+nPbOOxP0wDkP
         j0eYo78Mm9Yq2kb7acHukUzToHcJewO7aUhBCyWaSKWAP2l3EFT2+KEClHCiolWnmRyX
         lnElJKoIRl7D/gndO1oEOTJvNOe+v0A+JNgBuFiOkBRtOk9O5oLIz4Und1XchmGuDQjg
         su0glN4cIF9A2aAJQQcX3qErfg2O160UqH58BiTvXXLDHmppc3Zn0L1XrxgPPZlFyRKS
         Wjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059415; x=1794664215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aqN7aZ8iVALpTxJjSlPOIKNge5VZrwlYvXTmPXr+N8o=;
        b=PYfXsBhWJpVbTsRoyZH0CjuenzvO7ewglRhlkvWKARFWi6fhsfozOdx9RW4OOoSHwq
         OH9XD+ExIy+bYUPB/xLG+5q+tviL4tFk4QitR4vXQEAjEDmky8ZFroim5piXinV85oi2
         HpQ0Jk3hKKcDitDwZPIAb4Aq4HnapLiC3VHRnw9fhCB4CNhaJtGKRZbe5TKGZlEYzysP
         28WAV4azzvR+Wf3/LkPXtvLy6te1Hd16kXVT/T9CuzIJY/n1ksva0CGM/T0jkn22MGLh
         7UUPJQsvh8kzkIU9xWA4PbIq2HiKAz1DG6NrS+d8WnwtC8p2dY7FZEmjIcRzmBhrZLWr
         Wxgg==
X-Forwarded-Encrypted: i=1; AL+hErEERcwJQnBaKRnyLWaS7wrB9ZdrCHNUCsAsS4s2fQeuAwQnrfTnkWAcIzUwaAbCcl6N0ORDd3gc9ofgxOU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+LM8SjWGw6QIc+BjkABW1n9t46eodE8+ZzKj3MBUhd0813OL8J
	Aju93p7CU/T5656+AzFmuOHf8k7q2cdkQ0jXjBGX6aezfDGh6emsw1Pl
X-Gm-Gg: AYBFou1Tf6hVO0qNVhFLbFLxR/SYi0gozWQ9Kz8dGHhH0rbegfJ21HJvgwt2YbfwhJa
	HJBgCAHVNnS+cceXqLGMsZTRNOa4Fq8EhZqmdiMpLKoS4Ku0QYHS7Yth3etcR1ZPs9op3xZMOVB
	S6cE/o8TsM543Mup2AlsdFEt1KNv8HNjpIUhP4YsXLgfyO521C+VMlwYfXhKqaBEHgw2BGFzvna
	cdxGeriJoChRz9IVIdEsDOjO0rikMsHe2Fd20Embg/rbHVM60GS0aIQGCGha8vCWk2rghb1Zin6
	6nJHoxRXjRGXW+BnjL8VG6dhxppIpkqq4qVEIgTVhl+vUV1B06Iv9KCMzLxmGidz/gqiaLILtkZ
	2W7OjxAfhWLUa28i8pNQr+P9vSZ9QVYBmwj8CiwfSjfR+jWv6lChbpFe9oLyJmVBot+CelvSTFK
	HfTfmbvDnyFjQbq+URC1z2qXCRt3LGmt1Q3uTvhqcf7Ykhf/lxX8Fs+2rqO55FQMPnbprZZcJhJ
	YpfEB/B+KdD/LeV2rtT00+cOYC22bcpwj4YZ1LJVzJvdKNyT95Z3OEwC4stYEZR8yI3m63Oe20k
	CO7njmQnrUoo5RTaX2LquhGGiOxs8BfBhZKqEmAqEDIohoCVJ2CjdOHjqQ==
X-Received: by 2002:a05:693c:20c8:10b0:36a:30b:5dc0 with SMTP id 5a478bee46e88-36f75838341mr7149731eec.24.1794059415250;
        Sat, 07 Nov 2026 05:50:15 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:14 -0800 (PST)
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
Subject: [PATCH v12 02/10] powerpc/8xx: add vmap_pte_set_huge()
Date: Sat,  7 Nov 2026 21:49:45 +0800
Message-Id: <20261107134953.748622-3-jiangwenxiaomi@gmail.com>
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

vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
by reusing set_huge_pte_at(), a HugeTLB helper gated by
CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to HugeTLB
internals it does not otherwise need.

Add vmap_pte_set_huge() to powerpc/8xx, next to the existing
pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
PTE and writes it into the backing cells directly, without going through
set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.

No vmap_pte_clear_huge() is needed: 8xx does not implement
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
index e2ea8ba9f8cae..141336d30cc76 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -235,6 +235,10 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif /* CONFIG_PPC_16K_PAGES */
 
+#define __HAVE_ARCH_VMAP_PTE_SET_HUGE
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		       pgprot_t prot, unsigned long size);
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index a9d3f4729eada..b12e2829c08ed 100644
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
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		       pgprot_t prot, unsigned long size)
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


