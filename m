Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE3DC43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD3C2084F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="U8/Hg020"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD3C2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qgKj4yW3zDqJH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="U8/Hg020"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhj0DKQzDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhZ5kgLz9v07L;
 Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=U8/Hg020; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ovHELJZ2eFk3; Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhZ4k9Nz9v06V;
 Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202574; bh=TwaIS2P81oPcrASBsdsj/1AWlg/8riE96JLh5A3sUas=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=U8/Hg020NC+94+eCvjW4y2f2bWclR29QvzVVZWmL1VB7vXxIInZp9JFsRBpKhp6oU
 MtYbQs6L1dNQSjz4L76lNupPPvkUaGioufV5/BOTT4olHoe0KRgMyrSq1ItVlSFb70
 lskvBxMb9XL05b1QAEgVOOXUz7ybMNPhcYBjQbPI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 33ADB8B931;
 Thu, 25 Apr 2019 16:29:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VPpSKOszOp44; Thu, 25 Apr 2019 16:29:36 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C4108B923;
 Thu, 25 Apr 2019 16:29:36 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C9F1866276; Thu, 25 Apr 2019 14:29:35 +0000 (UTC)
Message-Id: <306daa20cb5b7c361b28831a190e45b16245779d.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/11] powerpc/mm: define get_slice_psize() all the time
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:35 +0000 (UTC)
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

get_slice_psize() can be defined regardless of CONFIG_PPC_MM_SLICES
to avoid ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/slice.h | 5 +++++
 arch/powerpc/mm/hugetlbpage.c    | 4 +---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index be8af667098f..c6f466f4c241 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -36,6 +36,11 @@ void slice_setup_new_exec(void);
 
 static inline void slice_init_new_context_exec(struct mm_struct *mm) {}
 
+static inline unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..5f67e7a4d1cc 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -578,14 +578,12 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
-#ifdef CONFIG_PPC_MM_SLICES
 	/* With radix we don't use slice, so derive it from vma*/
-	if (!radix_enabled()) {
+	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled()) {
 		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
 
 		return 1UL << mmu_psize_to_shift(psize);
 	}
-#endif
 	return vma_kernel_pagesize(vma);
 }
 
-- 
2.13.3

