Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8398C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:28:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368982146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EN0Qv39N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368982146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PR2X0YYMzDqD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="EN0Qv39N"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ34vdGzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQYz3P3qz9vC02;
 Wed, 20 Mar 2019 11:06:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=EN0Qv39N; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CIAH3mzzheRG; Wed, 20 Mar 2019 11:06:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYz2Cfrz9vByx;
 Wed, 20 Mar 2019 11:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076407; bh=vudUPerMLQi3dd/zw5E0qPtrcqQHJnlkft2XxIn5fdE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=EN0Qv39NEobTKZbM7BSI5/z2axMW5Tkn7YmmKz+6/wz0RcICQGysDUiUW4r8elKDB
 iW+kY8b/Iad+E/g7BUZLY7h9H6Yc8JJOVCflulXmwlvz9pWAz7G6Rrj9pDjvWG4zf1
 PKz3oyWqp4kSwkUVetOEJKUT/15h0CoXC7wiirtQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 692CB8B918;
 Wed, 20 Mar 2019 11:06:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JIEmtOOUOzOU; Wed, 20 Mar 2019 11:06:48 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 464CF8B911;
 Wed, 20 Mar 2019 11:06:48 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 289B063AEF; Wed, 20 Mar 2019 10:06:48 +0000 (UTC)
Message-Id: <abcfa513ee7e9df2184b7c94441fe0a615b80ed6.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 12/27] powerpc/mm: add a helper to populate hugepd
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:48 +0000 (UTC)
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

This patchs adds a subarch helper to populate hugepd.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h     |  5 +++++
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  8 ++++++++
 arch/powerpc/include/asm/nohash/hugetlb-book3e.h |  6 ++++++
 arch/powerpc/mm/hugetlbpage.c                    | 20 +-------------------
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 2f9cf2bc601c..177c81079209 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -101,6 +101,11 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 	return hugepd_page(hpd) + idx;
 }
 
+static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
+{
+	*hpdp = __hugepd(__pa(new) | HUGEPD_VAL_BITS | (shift_to_mmu_psize(pshift) << 2));
+}
+
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
 #endif
diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 209e6a219835..eb90c2db7601 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
 #define _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
 
+#define PAGE_SHIFT_8M		23
+
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	if (WARN_ON(!hugepd_ok(hpd)))
@@ -29,4 +31,10 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 	flush_tlb_page(vma, vmaddr);
 }
 
+static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
+{
+	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT |
+			 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M : _PMD_PAGE_512K));
+}
+
 #endif /* _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H */
diff --git a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
index e94f1cd048ee..51439bcfe313 100644
--- a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
+++ b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
@@ -28,4 +28,10 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
+static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
+{
+	/* We use the old format for PPC_FSL_BOOK3E */
+	*hpdp = __hugepd(((unsigned long)new & ~PD_HUGE) | pshift);
+}
+
 #endif /* _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 29d1568c7775..26a57ebaf5cf 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -26,12 +26,6 @@
 #include <asm/hugetlb.h>
 #include <asm/pte-walk.h>
 
-#define PAGE_SHIFT_64K	16
-#define PAGE_SHIFT_512K	19
-#define PAGE_SHIFT_8M	23
-#define PAGE_SHIFT_16M	24
-#define PAGE_SHIFT_16G	34
-
 bool hugetlb_disabled = false;
 
 unsigned int HPAGE_SHIFT;
@@ -95,19 +89,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	for (i = 0; i < num_hugepd; i++, hpdp++) {
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
-		else {
-#ifdef CONFIG_PPC_BOOK3S_64
-			*hpdp = __hugepd(__pa(new) | HUGEPD_VAL_BITS |
-					 (shift_to_mmu_psize(pshift) << 2));
-#elif defined(CONFIG_PPC_8xx)
-			*hpdp = __hugepd(__pa(new) | _PMD_USER |
-					 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
-					  _PMD_PAGE_512K) | _PMD_PRESENT);
-#else
-			/* We use the old format for PPC_FSL_BOOK3E */
-			*hpdp = __hugepd(((unsigned long)new & ~PD_HUGE) | pshift);
-#endif
-		}
+		hugepd_populate(hpdp, new, pshift);
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
 	if (i < num_hugepd) {
-- 
2.13.3

