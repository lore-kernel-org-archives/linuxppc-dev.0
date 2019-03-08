Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 21:16:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4E22081B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 21:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4E22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44GL035GDLzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 08:16:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leonardo@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44GCrp4p15zDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2019 03:39:35 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28GZTu7122126
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2019 11:39:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r3u0y3gcm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Mar 2019 11:39:33 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leonardo@linux.ibm.com>;
 Fri, 8 Mar 2019 16:39:31 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Mar 2019 16:39:27 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x28GdQsE22282374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2019 16:39:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5771AE060;
 Fri,  8 Mar 2019 16:39:26 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04C1AAE05C;
 Fri,  8 Mar 2019 16:39:18 +0000 (GMT)
Received: from LeoBras.ibmmodules.com (unknown [9.85.169.115])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2019 16:39:16 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: kernel-team@lists.ubuntu.com
Subject: [PATCH 19/20] KVM: PPC: Book3S HV: Don't use compound_order to
 determine host mapping size
Date: Fri,  8 Mar 2019 13:35:05 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308163505.13021-1-leonardo@linux.ibm.com>
References: <20190308163505.13021-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030816-0040-0000-0000-000004CECED7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010727; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01171458; UDB=6.00606765; IPR=6.00952102; 
 MB=3.00025895; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-08 16:39:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030816-0041-0000-0000-000008D9DE3B
Message-Id: <20190308163505.13021-20-leonardo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-08_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=705 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080115
X-Mailman-Approved-At: Sat, 09 Mar 2019 08:14:35 +1100
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

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
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 91 +++++++++++---------------
 1 file changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 7efc42538ccf..ae023d2256ef 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -538,8 +538,8 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
@@ -636,9 +636,10 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
@@ -652,63 +653,45 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
 
-- 
2.20.1

