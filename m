Return-Path: <linuxppc-dev+bounces-27966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91819C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:28:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRr06fwzz30V1;
	Wed, 23 Sep 2026 16:28:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144928;
	cv=none; b=S1VPVGaXsbnLvWUjlJoK6NMHfO5IJ0MuPvKxb0exrfhNfKG3KL1ZG3PaGdkxyw+0UCDUz/ifQNykc/urQHQpM/lB/GUuvZxqo/98huPbIyGDm95SRTlAIdZEOa8bp9WWpSqonRomJTBeKw/IVv1UxlxEX6ic3uOMJ4fwcnls2rAdzfZCBFw609QSI7ukoMZaNGLXTkM+DNKCq9QetOEYw55uFS1KPLxqyyx6u/VSrapuIN65P+0P6FihZZVPA4YW8NYWyxzbS6y3zOSZI6fGou7sE3zbLb8kghsUq/6KHx8BM4bgjDJanS6Vcw91HLfMYobxKLTvY4nF3K9by0s0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144928; c=relaxed/relaxed;
	bh=7/fcB7RWsYoduiGVrXMcsoy9SKXwqPZ/B+Usu82ABAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyzSiksggN9BiAUQLhi069grGUr4G8jhpPUU4udT8yh9jhq/H6Ckl9L3dfKi5uMmoJwUvuRUxWkndxGo9QscDzlTvMAuh34cXOalALuPobYTUMiHRF+h5t/4zExwPsT/a/Kg0bGmyUVNdv3x9kJXcmWWWYi+smQYrrNOO2AfhWcHS3Z7LZkE5B6RPnHtM1x09iCKPHEC1/SVpkLkvovy6sa6DvZ+tTwrFn6H9q41BLQ5QqmkTObiVF4gFkXUpeJjEgpqm28sPTxui8Vc86IhH9alaoUDoC1DC3KOJjyQMJZNDwQJBkoquw5mHIoDjNWUxEbiYAfKjInBMrNYts3V4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GiO6W+2Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GiO6W+2Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRr00m7gz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:28:48 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id d9443c01a7336-2df4aa80a73so3558505ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144926; x=1790749726; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/fcB7RWsYoduiGVrXMcsoy9SKXwqPZ/B+Usu82ABAo=;
        b=GiO6W+2ZgXLH/xDS/j6vS9hbYQRAVmurd845SAjUrmgLrO95zpwAuAaDEvl+A5vKEN
         TFWVpvynoO4HxA2/ZXQlgzDtniQeSIKbxeQsTg6ESTOKvoAmP7J0qddP4nK+CKWN8ABs
         aAqodenAcawoSLtT3DqtQTXj6sq/cwUTeBM7X9/pK3Fj3W1ZGFeSxINkyAX7B1VHruCE
         6ulr8a1tRacErrSaHcv34jAKC0if+T8I5e6EV8A5rgT/aW6GiUzgRf+eyi+YHp/6qz+k
         DbceubUWtx6j6g2V0dvC/mf2pUFTJlRVi31nBMifJdSa0XtFNqBbtoGDT6i6jsI+7Y36
         mSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144926; x=1790749726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/fcB7RWsYoduiGVrXMcsoy9SKXwqPZ/B+Usu82ABAo=;
        b=n+8RVYcn+A+dI+C8KduBoDMVpJJssTOS/NRpbcgACOTpH+z5CNBouhajpeYPuCOOLJ
         kbIBn+JxJUzk2kstpxJ7aOGQerc6gY4F+rVLVDJ62TsCIpHqsZ0VqHt9ol+FTD0w1tNn
         3SZOBb05PwIEVVu1+THDopeRKkeArip015q7uIuITstrueQpJHfvE1o68G+b6VCpS7dC
         F4WW/wjXG450ASncRCmoIepUyd/9/nMk5ZFPxauTlKnEFkf3T1I7x9ru/AIVO2UzN8oC
         RFlpgiaNKoUx+8D0zbaPIC4Y2FAb50WqBg03t/3kirX/vTh8ssmM+cAJAPL8I+hsT0J+
         v5Xg==
X-Forwarded-Encrypted: i=1; AKwUvBz+ZkFXqKA9lKemptyqGM8QHSalAhjnchPYQ5bwlDfoOuXxSfCq2WTrBGbqIBvBPIYealkIEk6nstqAD+E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lsgf5gyExRkQcoIK+BYe+Kdiw0T0RA2gbrl2hEiweatu+qyi/E
	2g/Iaa7UWGvcwcNJH2C203E8r15oknQrNhaYV0fbPYe5BzIP1yDO1O0z
X-Gm-Gg: AYBFou2emAZlJ3/aYCM5K+vI1Z637PB0YT2VJi14y94rRQE/A312PEw3iM+JRuPpbF1
	mXX3RqwSvWx2SNKwtvB+BgT+an3QKB2LJH0b8e8U8IebwKaFaGo/WOG3gA+OEpXIhVb/Tap9ht9
	MrmRJOhtDz8WrUlFiqqqiSQd8XSts9rmYEwnO9kQ9IbdaxjY2hLtSrpUS0y9uxhNB1IX0yzb31K
	pBDc8UOhrABhUWD8YlkkVvwsG/TcUpdB0KVYeBacVUBrn3e5o4fwPBEgTFsFfu36jSxE5DlpWOp
	Mu19vwbEeynxuM3KtAsMxZuWdG/IufuPDgeAYpBw3wktBpXbINj0BKbURAHCCcIYgs5XCYZkxKm
	cK2l9KGdo0ZegBP1CP4ZYoWICMqc3+Mwvyq9YYgxnOtUNh2Hb3ie4XhFrDof/qKdv+CQBDY5kJR
	oR6YwJgfEBmhFEMNf4jsdhUu6mSzdroW0Xziqqeb5LZ0M4A3moIzO2uPeSxiPbHXEuk5rf8UTAD
	MbXYM8Zag0HFPRlhIWGGw==
X-Received: by 2002:a17:902:d2c2:b0:2dd:c0ff:e724 with SMTP id d9443c01a7336-2df69de446amr13040735ad.54.1790144926198;
        Tue, 22 Sep 2026 23:28:46 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516bfdsm5620465ad.5.2026.09.22.23.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:28:45 -0700 (PDT)
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
Subject: [PATCH v9 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
Date: Wed, 23 Sep 2026 14:28:23 +0800
Message-Id: <20260923062832.479455-2-jiangwen6@xiaomi.com>
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
 arch/arm64/mm/mmu.c              | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 79d90226fd5dc..4a3d084bb7556 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1912,6 +1912,26 @@ int pmd_clear_huge(pmd_t *pmdp)
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


