Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CF606EEAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bElxlIl7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkyp1tCHz2xlY;
	Tue, 03 Nov 2026 21:17:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793701042;
	cv=none; b=oyJDzibTFaw+eMFpjJWWtnyFfn30Bj25FMBwbZIRGUo5BYY/J3O/evXkjzxgGeoFNLcqPMaqUxZAJqI6EQhFuJ9tvBhjjhnrg6NSawmTGwruxhcEt1qyf6BFDgSDwojaYSwIx7JBSchoS+DFYlqKW/zmqGGyxMVyf2CXAOzilhTEm8hNwcX1+aPMrYIBAZujmUItCuiaqcNc1XQmmADtlU13Evoc5AOcNyfX/kG4sNqBFzI+tANPEKh+1yy9K3e4NbMDOiXjqqZKj4BRIin3v4rIiiZ/ao54oroiA3uhuXV/YMQ3M+5I6/10IRrgerPeRBbdVJq5tEOulzNAeuvVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793701042; c=relaxed/relaxed;
	bh=iIqgn31oqWqTiWXF2IW0vHwpw1vMj9WhwN7adf+gUg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEWx01PKI+Z4Z5X8aFHxYLJn/fXWJU/Ug9v5glL7NnX2AxY+jbr5C/P3MYWiyFJsgpMt+9S7LScf2leqDT2VR+XR/E6ApVx1yEQ45E/ajuU3ntP25eJbFqBFPQ83esw3EEAqDJHGtbKGPcQo7mmo0Z9zUDxwdFE5e7s83cu275Fg+O1B/moy+C4aIa58UIMOIiEH1S/mqUOgrkpNiyMUfaJ1ZXbvRC65wMRsl9jjrBz4m+Wn6xAdUV8Qxur5F1xP8rUSRav6kynfg1KmeNmzLW8gMef/tm1/Hjc9f0a9wWeW139VyJ/QBQdnRaBfrpOMMCmj1GhKNRaKllRQph5CHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bElxlIl7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bElxlIl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkyn3tdgz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:17:21 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-36a1947498bso3892728eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701039; x=1794305839; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iIqgn31oqWqTiWXF2IW0vHwpw1vMj9WhwN7adf+gUg0=;
        b=bElxlIl7dJ1t3ZLMHjVLq27/KcFTPIdF+9zfR75wu+SC1ZqpQ+8KOUCTA40r+CAhxy
         mbggWa8gNN+yW4lIq0a1X6eaTWRBdlKETIi+lJhj0M+MxKSwN1Uq8Wdb/wBnw3COx+23
         gcoHOds/TSTA8yRYBFsvJjVISck4ihe+Yn7JmKnSFmDShGcIUa4lF+jjuKk6CjaedvvQ
         DWCcWjzXLmMZObma3d/4q3U/4W8NYiRSYQLEQZXvM4KMQ27jk0VcEe7UbGEThkqLi1et
         V8ULYbjIyopZM446aJJtV15W1eUmHSh8x1sXW7j7Et17/sqFh7CPwj4mO9CV/XW6iTon
         le9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701039; x=1794305839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iIqgn31oqWqTiWXF2IW0vHwpw1vMj9WhwN7adf+gUg0=;
        b=PZOcwjPRQBQa9LE+47XJ0AXhdEsdt9dN1Q9oAAxGP0E7nLCW0JA2azfmZWmjO3zKQO
         ogOEFe8369vQdSLlZ0H/4dhp4Reh0BHLQnLJTeT3IwbFSYU3N1xxEnEEbQXa81nL2O0e
         MuX0OzNw4/ZSngJIgmEYpkmWM+rvbuTNt3TgRUs8BKv2vUp8YjLO3F3873zBRA+OMOb3
         aIAg08usHf9L952aTl1PUTZmYEg9QSpGVYqnOtklSxTu3TkbILWIwxIzp/lT5+jjPnUN
         G/8MzRN+L2g6KUoe1HXOC6DNzzwYfJaYtIKe7F+wfkEGdkAwwRdJSSkipCV2IPZfbPSK
         UwUA==
X-Forwarded-Encrypted: i=1; AKwUvByVjxytwVw7i62d7ONFeSiOu8umhiviGwiP4cgbb25s3TtmHqNFNIbW0fTGxWReV4FFMWzO5x/TUF/lKvw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z81pVLFNdEN5KgEq3Sbwr/mQQWu5U8sXyy9LTPYOYDPkLYzu3YG
	leKHP48mOHs21nF/hA5SkEZA0JccG4ScIYYOhaa/Y5FjvaFIfpa10dPpvZ3Fl6xu
X-Gm-Gg: AYBFou1F2Mo7jelzmSXOmqGPOsAXT2F5U2/hY5H4eMRPIUtVV4wcux070kUG9EADPvd
	9ll5a3UKYBTFM4zyVH7myUzy7PW6AcS09l/2Cri8molKdF7VMQu4/ccmGMYC+FEyouALoQ3Zitt
	tYi/GgILsWyPBHnbRsLmTUQRhnYMNgI/Qe9Ni4tZSlhnH3NtnwaeN/JTUb6aCE5fVQtd3YKC9Ny
	A+J93sxTS+xqebo0FwhMu2BteXksT+RRC/cEl9BFnReF5HuiPiW766bvL38D0qj+ID2GNXkXtb/
	VTFkfU8ygHvGTb5rSS/kyHIoIa5atJ4o9gIaeF1OBqLd7LlPdYfDexr55/PkcZjbJZBSvRKOVYc
	e3wAu5PdDMi+tXBFJ+Q4rtR6HK6RPAwpsWfxzByuLy1DuUrjDzeApO1zgrlKOAAf1Zi5btd7Zxy
	rMDfVqC3SXwY9IxaCOjumbbT3BQu8jVCAjcnPG1ASGMkE0QuXLwkmy/nYI8L0Bv/tysQ25MhIOF
	odTyv+BULXnM81vlH6zuKq+9WhEAxMh+oyGFlvE5qSw9kC0R/GT8fOmNYTiTOAoxCHMQucZFh9L
	uct/6kIfFRSexOFkfkkv9J/vRfhzFQ==
X-Received: by 2002:a05:7300:471a:b0:36a:2382:7dab with SMTP id 5a478bee46e88-36a4232cda7mr18277051eec.6.1793701038947;
        Tue, 03 Nov 2026 02:17:18 -0800 (PST)
Received: from 027.. ([2409:8a20:4a5:7150:84fc:ce3c:7b09:dbca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm53145387eec.15.2026.11.03.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:17:18 -0800 (PST)
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
Subject: [PATCH v11 01/10] arm64/mm: add vmap_pte_set_huge() and vmap_pte_clear_huge()
Date: Tue,  3 Nov 2026 18:16:49 +0800
Message-Id: <20261103101658.766905-2-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
References: <20261103101658.766905-1-jiangwenxiaomi@gmail.com>
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
 arch/arm64/mm/mmu.c              | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a474c9fb485a..fe138590972a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1927,6 +1927,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+#define __HAVE_ARCH_VMAP_PTE_SET_HUGE
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
+		  pgprot_t prot, unsigned long size);
+#define __HAVE_ARCH_VMAP_PTE_CLEAR_HUGE
+pte_t vmap_pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 140520b351e2..2929bec8821c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1912,6 +1912,34 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+void vmap_pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
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
+pte_t vmap_pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
+{
+	/* Kernel mappings only */
+
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


