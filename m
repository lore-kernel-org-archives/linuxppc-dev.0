Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79153C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:43:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E929C2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bPP/HrAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E929C2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRMm57cjzDq8D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:43:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="bPP/HrAa"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZC6XSvzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZ70WFrz9vC05;
 Wed, 20 Mar 2019 11:06:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=bPP/HrAa; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hJJEyGeQ88To; Wed, 20 Mar 2019 11:06:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ66FZKz9vByx;
 Wed, 20 Mar 2019 11:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076414; bh=44lMvXfn9OTNczxHNDZIfIWxgTrbUf9YNLiYscWPdVw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=bPP/HrAaZFkbkHDqN1fRLB1VMb4pdWvLuBQPCS8NYE788JR1OwTR2VGzragVFdkxu
 gAJiKo641ef9UMTdl/1hwaAuvxv94ci6n7E4n4by9cWtTaOcxBl5QpjpndqO8Yx10I
 4+HCVVW/63ex9ATyOPT0UD4pTQwxvSIha7zalMAM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E18428B918;
 Wed, 20 Mar 2019 11:06:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QGjqgYjdM4md; Wed, 20 Mar 2019 11:06:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BDE4F8B911;
 Wed, 20 Mar 2019 11:06:55 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8529F63AEF; Wed, 20 Mar 2019 10:06:55 +0000 (UTC)
Message-Id: <dd5ce2a3cc162164051d5d1450e538a91b1f3580.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 19/27] powerpc/mm: drop slice DEBUG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:55 +0000 (UTC)
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

slice is now an improved functionnality. Drop the DEBUG stuff.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 62 ++++---------------------------------------------
 1 file changed, 4 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 011d470ea340..99983dc4e484 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -41,28 +41,6 @@
 
 static DEFINE_SPINLOCK(slice_convert_lock);
 
-#ifdef DEBUG
-int _slice_debug = 1;
-
-static void slice_print_mask(const char *label, const struct slice_mask *mask)
-{
-	if (!_slice_debug)
-		return;
-	pr_devel("%s low_slice: %*pbl\n", label,
-			(int)SLICE_NUM_LOW, &mask->low_slices);
-	pr_devel("%s high_slice: %*pbl\n", label,
-			(int)SLICE_NUM_HIGH, mask->high_slices);
-}
-
-#define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
-
-#else
-
-static void slice_print_mask(const char *label, const struct slice_mask *mask) {}
-#define slice_dbg(fmt...)
-
-#endif
-
 static inline bool slice_addr_is_low(unsigned long addr)
 {
 	u64 tmp = (u64)addr;
@@ -245,9 +223,6 @@ static void slice_convert(struct mm_struct *mm,
 	unsigned long i, flags;
 	int old_psize;
 
-	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
-	slice_print_mask(" mask", mask);
-
 	psize_mask = slice_mask_for_size(mm, psize);
 
 	/* We need to use a spinlock here to protect against
@@ -293,10 +268,6 @@ static void slice_convert(struct mm_struct *mm,
 				(((unsigned long)psize) << (mask_index * 4));
 	}
 
-	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  (unsigned long)mm->context.low_slices_psize,
-		  (unsigned long)mm->context.high_slices_psize);
-
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
@@ -523,14 +494,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	BUG_ON(mm->context.slb_addr_limit == 0);
 	VM_BUG_ON(radix_enabled());
 
-	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
-	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
-		  addr, len, flags, topdown);
-
 	/* If hint, make sure it matches our alignment restrictions */
 	if (!fixed && addr) {
 		addr = _ALIGN_UP(addr, page_size);
-		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
 		if (addr > high_limit - len || addr < mmap_min_addr ||
 		    !slice_area_is_free(mm, addr, len))
@@ -576,17 +542,12 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		slice_copy_mask(&good_mask, maskp);
 	}
 
-	slice_print_mask(" good_mask", &good_mask);
-	if (compat_maskp)
-		slice_print_mask(" compat_mask", compat_maskp);
-
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr != 0 || fixed) {
 		/* Check if we fit in the good mask. If we do, we just return,
 		 * nothing else to do
 		 */
 		if (slice_check_range_fits(mm, &good_mask, addr, len)) {
-			slice_dbg(" fits good !\n");
 			newaddr = addr;
 			goto return_addr;
 		}
@@ -596,13 +557,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 */
 		newaddr = slice_find_area(mm, len, &good_mask,
 					  psize, topdown, high_limit);
-		if (newaddr != -ENOMEM) {
-			/* Found within the good mask, we don't have to setup,
-			 * we thus return directly
-			 */
-			slice_dbg(" found area at 0x%lx\n", newaddr);
+
+		/* Found within good mask, don't have to setup, thus return directly */
+		if (newaddr != -ENOMEM)
 			goto return_addr;
-		}
 	}
 	/*
 	 * We don't fit in the good mask, check what other slices are
@@ -610,11 +568,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 */
 	slice_mask_for_free(mm, &potential_mask, high_limit);
 	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
-	slice_print_mask(" potential", &potential_mask);
 
 	if (addr != 0 || fixed) {
 		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
-			slice_dbg(" fits potential !\n");
 			newaddr = addr;
 			goto convert;
 		}
@@ -624,18 +580,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (fixed)
 		return -EBUSY;
 
-	slice_dbg(" search...\n");
-
 	/* If we had a hint that didn't work out, see if we can fit
 	 * anywhere in the good area.
 	 */
 	if (addr) {
 		newaddr = slice_find_area(mm, len, &good_mask,
 					  psize, topdown, high_limit);
-		if (newaddr != -ENOMEM) {
-			slice_dbg(" found area at 0x%lx\n", newaddr);
+		if (newaddr != -ENOMEM)
 			goto return_addr;
-		}
 	}
 
 	/* Now let's see if we can find something in the existing slices
@@ -657,8 +609,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		return -ENOMEM;
 
 	slice_range_to_mask(newaddr, len, &potential_mask);
-	slice_dbg(" found potential area at 0x%lx\n", newaddr);
-	slice_print_mask(" mask", &potential_mask);
 
  convert:
 	/*
@@ -736,8 +686,6 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	struct slice_mask *mask;
 	unsigned int psize = mmu_virtual_psize;
 
-	slice_dbg("slice_init_new_context_exec(mm=%p)\n", mm);
-
 	/*
 	 * In the case of exec, use the default limit. In the
 	 * case of fork it is just inherited from the mm being
@@ -774,8 +722,6 @@ void slice_setup_new_exec(void)
 {
 	struct mm_struct *mm = current->mm;
 
-	slice_dbg("slice_setup_new_exec(mm=%p)\n", mm);
-
 	if (!is_32bit_task())
 		return;
 
-- 
2.13.3

