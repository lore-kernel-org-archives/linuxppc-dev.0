Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B59C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:34:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227B02075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="GJlgJvUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227B02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PR9P11srzDq8B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:34:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GJlgJvUn"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ65ZJCzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZ24l3jz9vC04;
 Wed, 20 Mar 2019 11:06:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=GJlgJvUn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id AJQbp7OS1rAz; Wed, 20 Mar 2019 11:06:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ23bWVz9vByx;
 Wed, 20 Mar 2019 11:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076410; bh=3Qt6UQ3ffffO/L8sunyHgvgpbRibyr/ois3WcgDAd5g=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=GJlgJvUnLRdqDLK0qxzNY2px6Q87Wq+D3ptunkddYDVp+dc1a0LpVVBKyRgjaJZ2G
 Uhtws7C3jwrF4w+GLQRrwj/fAfgZ28R+JCEpTcWF0REs5+0ebg1eG0CzS0w9HxDlvc
 HxSLdNkfw2tNy/fbKycSQtuYAi6x3+uLYMhh1fZ4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B7BE8B918;
 Wed, 20 Mar 2019 11:06:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LpscSlKqI4Ug; Wed, 20 Mar 2019 11:06:51 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7330F8B911;
 Wed, 20 Mar 2019 11:06:51 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 51CC363AEF; Wed, 20 Mar 2019 10:06:51 +0000 (UTC)
Message-Id: <54f43a41968cf6db1369f98247618c58ed2ff94d.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 15/27] powerpc/mm: cleanup ifdef mess in
 add_huge_page_size()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:51 +0000 (UTC)
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

Introduce a subarch specific helper check_and_get_huge_psize()
to check the huge page sizes and cleanup the ifdef mess in
add_huge_page_size()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h     | 27 +++++++++++++++++
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  5 ++++
 arch/powerpc/include/asm/nohash/hugetlb-book3e.h |  8 +++++
 arch/powerpc/mm/hugetlbpage.c                    | 37 ++----------------------
 4 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 177c81079209..4522a56a6269 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -108,4 +108,31 @@ static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshi
 
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
+static inline int check_and_get_huge_psize(int shift)
+{
+	int mmu_psize;
+
+	if (shift > SLICE_HIGH_SHIFT)
+		return -EINVAL;
+
+	mmu_psize = shift_to_mmu_psize(shift);
+
+	/*
+	 * We need to make sure that for different page sizes reported by
+	 * firmware we only add hugetlb support for page sizes that can be
+	 * supported by linux page table layout.
+	 * For now we have
+	 * Radix: 2M and 1G
+	 * Hash: 16M and 16G
+	 */
+	if (radix_enabled()) {
+		if (mmu_psize != MMU_PAGE_2M && mmu_psize != MMU_PAGE_1G)
+			return -EINVAL;
+	} else {
+		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+			return -EINVAL;
+	}
+	return mmu_psize;
+}
+
 #endif
diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index eb90c2db7601..a442b499d5c8 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -37,4 +37,9 @@ static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshi
 			 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M : _PMD_PAGE_512K));
 }
 
+static inline int check_and_get_huge_psize(int shift)
+{
+	return shift_to_mmu_psize(shift);
+}
+
 #endif /* _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H */
diff --git a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
index 51439bcfe313..ecd8694cb229 100644
--- a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
+++ b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
@@ -34,4 +34,12 @@ static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshi
 	*hpdp = __hugepd(((unsigned long)new & ~PD_HUGE) | pshift);
 }
 
+static inline int check_and_get_huge_psize(int shift)
+{
+	if (shift & 1)	/* Not a power of 4 */
+		return -EINVAL;
+
+	return shift_to_mmu_psize(shift);
+}
+
 #endif /* _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 87358b89513e..3b449c9d4e47 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -549,13 +549,6 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 	return vma_kernel_pagesize(vma);
 }
 
-static inline bool is_power_of_4(unsigned long x)
-{
-	if (is_power_of_2(x))
-		return (__ilog2(x) % 2) ? false : true;
-	return false;
-}
-
 static int __init add_huge_page_size(unsigned long long size)
 {
 	int shift = __ffs(size);
@@ -563,37 +556,13 @@ static int __init add_huge_page_size(unsigned long long size)
 
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable and slice limits. */
-	if (size <= PAGE_SIZE)
-		return -EINVAL;
-#if defined(CONFIG_PPC_FSL_BOOK3E)
-	if (!is_power_of_4(size))
+	if (size <= PAGE_SIZE || !is_power_of_2(size))
 		return -EINVAL;
-#elif !defined(CONFIG_PPC_8xx)
-	if (!is_power_of_2(size) || (shift > SLICE_HIGH_SHIFT))
-		return -EINVAL;
-#endif
 
-	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
+	mmu_psize = check_and_get_huge_psize(size);
+	if (mmu_psize < 0)
 		return -EINVAL;
 
-#ifdef CONFIG_PPC_BOOK3S_64
-	/*
-	 * We need to make sure that for different page sizes reported by
-	 * firmware we only add hugetlb support for page sizes that can be
-	 * supported by linux page table layout.
-	 * For now we have
-	 * Radix: 2M and 1G
-	 * Hash: 16M and 16G
-	 */
-	if (radix_enabled()) {
-		if (mmu_psize != MMU_PAGE_2M && mmu_psize != MMU_PAGE_1G)
-			return -EINVAL;
-	} else {
-		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
-			return -EINVAL;
-	}
-#endif
-
 	if (WARN_ON(mmu_psize_defs[mmu_psize].shift != shift))
 		return -EINVAL;
 
-- 
2.13.3

