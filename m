Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD88C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:15:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51AC206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ny54hz+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51AC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3hK0GzzzDqcg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:15:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ny54hz+n"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3Kw2MVLzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:48 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kr1mklz9v1vL;
 Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ny54hz+n; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CqRKAlW6QgSj; Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kr0lSLz9v1tj;
 Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258384; bh=7QQJoVXeezfa6QCvF6I8JYRSBlQYlqT81BrZCfuDxsA=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ny54hz+n1O9MHftGA8MPT1S60u9/jYHQGJayXo6TDauSwwtuGiJz+OBzKZCFAowow
 yj0LoGL2PIi6IoEKf6GcL2vY9h+Hti2ZbZJZ5nhc+BE4EN+4USzjgtjmVg3xdY9snM
 d9c40hfKBLaC36ZcAciGUXXrmgUM3e5s4xL8llxU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F2B0C8B807;
 Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JJ8t2-oWIVWG; Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CDF408B74C;
 Fri, 26 Apr 2019 07:59:44 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B6AA466276; Fri, 26 Apr 2019 05:59:44 +0000 (UTC)
Message-Id: <7d12cb9983b9ad32ca053b107b7ad8fd606a9da2.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/17] powerpc/mm: split asm/hugetlb.h into dedicated
 subarch files
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:44 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Three subarches support hugepages:
- fsl book3e
- book3s/64
- 8xx

This patch splits asm/hugetlb.h to reduce the #ifdef mess.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h     | 40 +++++++++++
 arch/powerpc/include/asm/hugetlb.h               | 87 ++----------------------
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 31 +++++++++
 arch/powerpc/include/asm/nohash/hugetlb-book3e.h | 31 +++++++++
 4 files changed, 106 insertions(+), 83 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
 create mode 100644 arch/powerpc/include/asm/nohash/hugetlb-book3e.h

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index ec2a55a553c7..7c99f018f7b5 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -62,4 +62,44 @@ extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep,
 					 pte_t old_pte, pte_t new_pte);
+/*
+ * This should work for other subarchs too. But right now we use the
+ * new format only for 64bit book3s
+ */
+static inline pte_t *hugepd_page(hugepd_t hpd)
+{
+	VM_BUG_ON(!hugepd_ok(hpd));
+	/*
+	 * We have only four bits to encode, MMU page size
+	 */
+	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
+	return __va(hpd_val(hpd) & HUGEPD_ADDR_MASK);
+}
+
+static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
+{
+	return (hpd_val(hpd) & HUGEPD_SHIFT_MASK) >> 2;
+}
+
+static inline unsigned int hugepd_shift(hugepd_t hpd)
+{
+	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
+}
+static inline void flush_hugetlb_page(struct vm_area_struct *vma,
+				      unsigned long vmaddr)
+{
+	if (radix_enabled())
+		return radix__flush_hugetlb_page(vma, vmaddr);
+}
+
+static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
+				    unsigned int pdshift)
+{
+	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
+
+	return hugepd_page(hpd) + idx;
+}
+
+void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+
 #endif
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 7f1867e428c0..fd5c0873a57d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -6,83 +6,13 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_PPC_BOOK3S_64
-
 #include <asm/book3s/64/hugetlb.h>
-/*
- * This should work for other subarchs too. But right now we use the
- * new format only for 64bit book3s
- */
-static inline pte_t *hugepd_page(hugepd_t hpd)
-{
-	VM_BUG_ON(!hugepd_ok(hpd));
-	/*
-	 * We have only four bits to encode, MMU page size
-	 */
-	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
-	return __va(hpd_val(hpd) & HUGEPD_ADDR_MASK);
-}
-
-static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
-{
-	return (hpd_val(hpd) & HUGEPD_SHIFT_MASK) >> 2;
-}
-
-static inline unsigned int hugepd_shift(hugepd_t hpd)
-{
-	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
-}
-static inline void flush_hugetlb_page(struct vm_area_struct *vma,
-				      unsigned long vmaddr)
-{
-	if (radix_enabled())
-		return radix__flush_hugetlb_page(vma, vmaddr);
-}
-
-#else
-
-static inline pte_t *hugepd_page(hugepd_t hpd)
-{
-	VM_BUG_ON(!hugepd_ok(hpd));
-#ifdef CONFIG_PPC_8xx
-	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
-#else
-	return (pte_t *)((hpd_val(hpd) &
-			  ~HUGEPD_SHIFT_MASK) | PD_HUGE);
-#endif
-}
-
-static inline unsigned int hugepd_shift(hugepd_t hpd)
-{
-#ifdef CONFIG_PPC_8xx
-	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
-#else
-	return hpd_val(hpd) & HUGEPD_SHIFT_MASK;
-#endif
-}
-
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#include <asm/nohash/hugetlb-book3e.h>
+#elif defined(CONFIG_PPC_8xx)
+#include <asm/nohash/32/hugetlb-8xx.h>
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-
-static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
-				    unsigned pdshift)
-{
-	/*
-	 * On FSL BookE, we have multiple higher-level table entries that
-	 * point to the same hugepte.  Just use the first one since they're all
-	 * identical.  So for that case, idx=0.
-	 */
-	unsigned long idx = 0;
-
-	pte_t *dir = hugepd_page(hpd);
-#ifdef CONFIG_PPC_8xx
-	idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
-#elif !defined(CONFIG_PPC_FSL_BOOK3E)
-	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
-#endif
-
-	return dir + idx;
-}
-
 void flush_dcache_icache_hugepage(struct page *page);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
@@ -99,15 +29,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 
 void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 			    pte_t pte);
-#ifdef CONFIG_PPC_8xx
-static inline void flush_hugetlb_page(struct vm_area_struct *vma,
-				      unsigned long vmaddr)
-{
-	flush_tlb_page(vma, vmaddr);
-}
-#else
-void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-#endif
 
 #define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
new file mode 100644
index 000000000000..27acd2ad2176
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
+#define _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
+
+static inline pte_t *hugepd_page(hugepd_t hpd)
+{
+	VM_BUG_ON(!hugepd_ok(hpd));
+
+	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
+}
+
+static inline unsigned int hugepd_shift(hugepd_t hpd)
+{
+	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
+}
+
+static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
+				    unsigned int pdshift)
+{
+	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+
+	return hugepd_page(hpd) + idx;
+}
+
+static inline void flush_hugetlb_page(struct vm_area_struct *vma,
+				      unsigned long vmaddr)
+{
+	flush_tlb_page(vma, vmaddr);
+}
+
+#endif /* _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H */
diff --git a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
new file mode 100644
index 000000000000..e94f1cd048ee
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H
+#define _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H
+
+static inline pte_t *hugepd_page(hugepd_t hpd)
+{
+	if (WARN_ON(!hugepd_ok(hpd)))
+		return NULL;
+
+	return (pte_t *)((hpd_val(hpd) & ~HUGEPD_SHIFT_MASK) | PD_HUGE);
+}
+
+static inline unsigned int hugepd_shift(hugepd_t hpd)
+{
+	return hpd_val(hpd) & HUGEPD_SHIFT_MASK;
+}
+
+static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
+				    unsigned int pdshift)
+{
+	/*
+	 * On FSL BookE, we have multiple higher-level table entries that
+	 * point to the same hugepte.  Just use the first one since they're all
+	 * identical.  So for that case, idx=0.
+	 */
+	return hugepd_page(hpd);
+}
+
+void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+
+#endif /* _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H */
-- 
2.13.3

