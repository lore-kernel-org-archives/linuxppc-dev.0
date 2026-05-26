Return-Path: <linuxppc-dev+bounces-21524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40496CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:39:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ73R15cHz2xPb;
	Wed, 27 May 2026 08:39:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779807384;
	cv=none; b=J/rOhY7CMHVZPa8OfL8PYgCqDheQmmK+NkOWKzi8rh9Etq+PyYTdE1Nvj3WLA1B9FdNgoj6Vtd0x8vrcAgD1iQNXnxJkM5E3rFvOS09cIs7OOsRR9YmKfubDFvJ2msf/uvUGEVrC+MeaKQ1OJRBkrlMvVGLYlN8VJojnTZVZ4CzQ4or/e/8eD6zaHea6TvZ9NGkdyNZByp3wtR56dYHvJp9VgAjeABZ1TLY7ruTYHdRosjv0yWgh7pyh7vDkuTU8RnA23OXFysINi3ws1NxNXYdP72XiItpiDS842wQlkR39Dy0BkTjzm3Jw1MEbolp/XSUN/YJ4yE155sb0jJzwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779807384; c=relaxed/relaxed;
	bh=l+aFKJrjVwtzzo3eLUyF5+IW/uSU3+87cCQnsOJ4oeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdN7niayLbnUmYCrz6WQwQowGnwafPwskL+3P/eCX6e+Ez7133PM0ujzNUERkLHfKTgVvzfBHS15T72ZA/dyE1bL+DNFMGguV2HpmbDHxLNmILo29UqgUBN8Sn1e2KKHmw2dEz6Gcg0vlF5MF3KUcFBEC5lfXYysF/wD/6oUNAsClsqU7IDMfw1OAa6oNAirVh6qK/Q5gRL2vyoQoEfM4yiBzuet4exGvea6Gc4O4F49t0VHvzj1tyZdtCX5qU6jWXe4VJd0CT1jW3iH3p4FW+QY9QvKG9YJBM+4XGq42mzpKEWv06TBMW7rsU9TDQ4Gwx0yP1i8IB47lHCQH5+dCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0iMEW0ts; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0iMEW0ts; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0iMEW0ts;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0iMEW0ts;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPwn20NTbz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:56:21 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l+aFKJrjVwtzzo3eLUyF5+IW/uSU3+87cCQnsOJ4oeg=;
	b=0iMEW0tsF/BBgk4ze5nZcHMmdemvVB1xjaYbneUnB2p3zX6RYNWiFoVmHYi0xEF5s2CCLn5Oa
	A/qAQxOhoQKr4PXdSbSP16hYOVmOosHS57dE7hnJY/IV4AfhzMAuDqs4A7vCLbtKI+1pZ9V6gfL
	dPaibFsUNvw+EGtOP7+W/Jg=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPwlz2GDNz1BGWP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:55:27 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l+aFKJrjVwtzzo3eLUyF5+IW/uSU3+87cCQnsOJ4oeg=;
	b=0iMEW0tsF/BBgk4ze5nZcHMmdemvVB1xjaYbneUnB2p3zX6RYNWiFoVmHYi0xEF5s2CCLn5Oa
	A/qAQxOhoQKr4PXdSbSP16hYOVmOosHS57dE7hnJY/IV4AfhzMAuDqs4A7vCLbtKI+1pZ9V6gfL
	dPaibFsUNvw+EGtOP7+W/Jg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gPwbg0PqJznTVR;
	Tue, 26 May 2026 22:48:15 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 985234056C;
	Tue, 26 May 2026 22:56:12 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 22:56:11 +0800
From: Yin Tirui <yintirui@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
	<ljs@kernel.org>, Juergen Gross <jgross@suse.com>, Jonathan Cameron
	<jic23@kernel.org>, Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>,
	Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Coiby Xu <coxu@redhat.com>, Dan Williams
	<djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, Rik
 van Riel <riel@surriel.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <yintirui@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH mm-unstable RFC v4 2/7] arm64/mm: use PTE-level pgprot for huge PFN helpers
Date: Tue, 26 May 2026 22:49:58 +0800
Message-ID: <20260526145003.88445-3-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>
References: <20260526145003.88445-1-yintirui@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.87.63]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)

Make the arm64 PMD/PUD PFN helpers use PTE-level pgprot_t as the basic
format.

pfn_pmd() and pfn_pud() now translate PTE-level attributes into block
entries. pmd_pgprot() and pud_pgprot() translate block descriptor
attributes back into PTE-level attributes.

Remove mk_pmd_sect_prot() and mk_pud_sect_prot().

Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 48 ++++++++++++++++++++++----------
 arch/arm64/mm/mmu.c              |  4 +--
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d053..c3ee12e14f86 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -511,16 +511,6 @@ static inline pmd_t pte_pmd(pte_t pte)
 	return __pmd(pte_val(pte));
 }
 
-static inline pgprot_t mk_pud_sect_prot(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~PUD_TYPE_MASK) | PUD_TYPE_SECT);
-}
-
-static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
-}
-
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
 {
 	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
@@ -628,7 +618,13 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
 #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
-#define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = __pmd(__phys_to_pmd_val((phys_addr_t)pfn << PAGE_SHIFT) |
+			  pgprot_val(prot));
+
+	return pmd_mkhuge(pmd);
+}
 
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
@@ -652,22 +648,46 @@ static inline pud_t pud_mkhuge(pud_t pud)
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
 #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
-#define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+{
+	pud_t pud = __pud(__phys_to_pud_val((phys_addr_t)pfn << PAGE_SHIFT) |
+			  pgprot_val(prot));
+
+	return pud_mkhuge(pud);
+}
 
 #define pmd_pgprot pmd_pgprot
 static inline pgprot_t pmd_pgprot(pmd_t pmd)
 {
 	unsigned long pfn = pmd_pfn(pmd);
+	pmdval_t protval = pmd_val(pmd) ^
+		__phys_to_pmd_val((phys_addr_t)pfn << PAGE_SHIFT);
+
+	/*
+	 * pgprot_t represents PTE-level attributes. Convert the PMD
+	 * block descriptor type into a PTE page descriptor type.
+	 */
+	pmdval_t mask = PMD_TYPE_MASK & ~PTE_VALID;
+	pmdval_t val = PTE_TYPE_PAGE & ~PTE_VALID;
 
-	return __pgprot(pmd_val(pfn_pmd(pfn, __pgprot(0))) ^ pmd_val(pmd));
+	return __pgprot((protval & ~mask) | val);
 }
 
 #define pud_pgprot pud_pgprot
 static inline pgprot_t pud_pgprot(pud_t pud)
 {
 	unsigned long pfn = pud_pfn(pud);
+	pudval_t protval = pud_val(pud) ^
+		__phys_to_pud_val((phys_addr_t)pfn << PAGE_SHIFT);
+
+	/*
+	 * pgprot_t represents PTE-level attributes. Convert the PUD
+	 * block descriptor type into a PTE page descriptor type.
+	 */
+	pudval_t mask = PUD_TYPE_MASK & ~PTE_VALID;
+	pudval_t val = PTE_TYPE_PAGE & ~PTE_VALID;
 
-	return __pgprot(pud_val(pfn_pud(pfn, __pgprot(0))) ^ pud_val(pud));
+	return __pgprot((protval & ~mask) | val);
 }
 
 static inline void __set_ptes_anysz(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e5a42b7a0160..2dd99d595f19 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1816,7 +1816,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
-	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), prot);
 
 	/* Only allow permission changes for now */
 	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
@@ -1830,7 +1830,7 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 
 int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
-	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), prot);
 
 	/* Only allow permission changes for now */
 	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
-- 
2.43.0


