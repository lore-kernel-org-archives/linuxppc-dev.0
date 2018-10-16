Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918D2C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9E821477
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaTbhOSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9E821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZMXL5Q40zF3W7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 04:20:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GaTbhOSm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=ypgj=m4=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="GaTbhOSm"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZMQq3bwLzF3Vk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 04:16:03 +1100 (AEDT)
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net
 [213.127.77.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B30AE20866;
 Tue, 16 Oct 2018 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539710161;
 bh=FFqP+vq2j5Wue3Z1M4J5ODbAPHEs3FDYIrfUxxCx7og=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GaTbhOSm1Tk0YehK8kCpaGyDN4mWAF52Aw7mKkU83BKEtYmvvGzuhUgJQStEJtamz
 IxGiv+6jyP9PtaMQVtSZr658Cojtth6P245/ODDU808MJY2Dcw0bHPXfrmTDNW6UgT
 7ek2451Z5q3w2/1TfhcTWPkXBRXdnf3s1I2gNMM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.18 086/135] KVM: PPC: Book3S HV: Dont use compound_order to
 determine host mapping size
Date: Tue, 16 Oct 2018 19:05:16 +0200
Message-Id: <20181016170521.241312038@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <alexander.levin@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 stable@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 71d29f43b6332badc5598c656616a62575e83342 ]

THP paths can defer splitting compound pages until after the actual
remap and TLB flushes to split a huge PMD/PUD. This causes radix
partition scope page table mappings to get out of synch with the host
qemu page table mappings.

This results in random memory corruption in the guest when running
with THP. The easiest way to reproduce is use KVM balloon to free up
a lot of memory in the guest and then shrink the balloon to give the
memory back, while some work is being done in the guest.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c |   91 +++++++++++++--------------------
 1 file changed, 37 insertions(+), 54 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -538,8 +538,8 @@ int kvmppc_book3s_radix_page_fault(struc
 				   unsigned long ea, unsigned long dsisr)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long mmu_seq, pte_size;
-	unsigned long gpa, gfn, hva, pfn;
+	unsigned long mmu_seq;
+	unsigned long gpa, gfn, hva;
 	struct kvm_memory_slot *memslot;
 	struct page *page = NULL;
 	long ret;
@@ -636,9 +636,10 @@ int kvmppc_book3s_radix_page_fault(struc
 	 */
 	hva = gfn_to_hva_memslot(memslot, gfn);
 	if (upgrade_p && __get_user_pages_fast(hva, 1, 1, &page) == 1) {
-		pfn = page_to_pfn(page);
 		upgrade_write = true;
 	} else {
+		unsigned long pfn;
+
 		/* Call KVM generic code to do the slow-path check */
 		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
 					   writing, upgrade_p);
@@ -652,63 +653,45 @@ int kvmppc_book3s_radix_page_fault(struc
 		}
 	}
 
-	/* See if we can insert a 1GB or 2MB large PTE here */
-	level = 0;
-	if (page && PageCompound(page)) {
-		pte_size = PAGE_SIZE << compound_order(compound_head(page));
-		if (pte_size >= PUD_SIZE &&
-		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
-		    (hva & (PUD_SIZE - PAGE_SIZE))) {
-			level = 2;
-			pfn &= ~((PUD_SIZE >> PAGE_SHIFT) - 1);
-		} else if (pte_size >= PMD_SIZE &&
-			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
-			   (hva & (PMD_SIZE - PAGE_SIZE))) {
-			level = 1;
-			pfn &= ~((PMD_SIZE >> PAGE_SHIFT) - 1);
-		}
-	}
-
 	/*
-	 * Compute the PTE value that we need to insert.
+	 * Read the PTE from the process' radix tree and use that
+	 * so we get the shift and attribute bits.
 	 */
-	if (page) {
-		pgflags = _PAGE_READ | _PAGE_EXEC | _PAGE_PRESENT | _PAGE_PTE |
-			_PAGE_ACCESSED;
-		if (writing || upgrade_write)
-			pgflags |= _PAGE_WRITE | _PAGE_DIRTY;
-		pte = pfn_pte(pfn, __pgprot(pgflags));
+	local_irq_disable();
+	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
+	pte = *ptep;
+	local_irq_enable();
+
+	/* Get pte level from shift/size */
+	if (shift == PUD_SHIFT &&
+	    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
+	    (hva & (PUD_SIZE - PAGE_SIZE))) {
+		level = 2;
+	} else if (shift == PMD_SHIFT &&
+		   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
+		   (hva & (PMD_SIZE - PAGE_SIZE))) {
+		level = 1;
 	} else {
-		/*
-		 * Read the PTE from the process' radix tree and use that
-		 * so we get the attribute bits.
-		 */
-		local_irq_disable();
-		ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
-		pte = *ptep;
-		local_irq_enable();
-		if (shift == PUD_SHIFT &&
-		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
-		    (hva & (PUD_SIZE - PAGE_SIZE))) {
-			level = 2;
-		} else if (shift == PMD_SHIFT &&
-			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
-			   (hva & (PMD_SIZE - PAGE_SIZE))) {
-			level = 1;
-		} else if (shift && shift != PAGE_SHIFT) {
-			/* Adjust PFN */
-			unsigned long mask = (1ul << shift) - PAGE_SIZE;
-			pte = __pte(pte_val(pte) | (hva & mask));
-		}
-		pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
-		if (writing || upgrade_write) {
-			if (pte_val(pte) & _PAGE_WRITE)
-				pte = __pte(pte_val(pte) | _PAGE_DIRTY);
-		} else {
-			pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
+		level = 0;
+		if (shift > PAGE_SHIFT) {
+			/*
+			 * If the pte maps more than one page, bring over
+			 * bits from the virtual address to get the real
+			 * address of the specific single page we want.
+			 */
+			unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
+			pte = __pte(pte_val(pte) | (hva & rpnmask));
 		}
 	}
 
+	pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
+	if (writing || upgrade_write) {
+		if (pte_val(pte) & _PAGE_WRITE)
+			pte = __pte(pte_val(pte) | _PAGE_DIRTY);
+	} else {
+		pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
+	}
+
 	/* Allocate space in the tree and write the PTE */
 	ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
 


