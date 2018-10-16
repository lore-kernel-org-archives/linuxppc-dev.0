Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A13C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 09:14:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D851205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP19pbzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D851205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z8l62ZYvzF3W1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:14:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EP19pbzl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=ypgj=m4=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="EP19pbzl"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z8hH3dPBzF3Vy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 20:11:55 +1100 (AEDT)
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net
 [213.127.77.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36A2920881;
 Tue, 16 Oct 2018 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539681113;
 bh=CNGF2Nqi/qgeLhGkTFSMF//mdZP2DNHYWOiSD4PM4zs=;
 h=Subject:To:Cc:From:Date:From;
 b=EP19pbzlZjg/InMpCJ7y12XZxID2KEM7xSR8WH6xLmqX/sYs2wXPR7BwnpnjqTUMC
 dRD/HiXme11t3SKYWwfIxmovtMKX0zfNy+W6CtBwxY1N/m3w6kwbhQHf4H3un+QGZ1
 wUUkOwKPtnERifmGeiXoqjiisGP+PtByJFeYLyIE=
Subject: Patch "KVM: PPC: Book3S HV: Don't use compound_order to determine
 host mapping size" has been added to the 4.18-stable tree
To: alexander.levin@microsoft.com, aneesh.kumar@linux.ibm.com,
 david@gibson.dropbear.id.au, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, paulus@ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Oct 2018 11:10:57 +0200
Message-ID: <153968105748115@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
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
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    KVM: PPC: Book3S HV: Don't use compound_order to determine host mapping size

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-ppc-book3s-hv-don-t-use-compound_order-to-determine-host-mapping-size.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Oct 16 11:10:21 CEST 2018
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 11 Sep 2018 20:48:34 +1000
Subject: KVM: PPC: Book3S HV: Don't use compound_order to determine host mapping size

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
 


Patches currently in stable-queue which might be from npiggin@gmail.com are

queue-4.18/kvm-ppc-book3s-hv-don-t-use-compound_order-to-determine-host-mapping-size.patch
