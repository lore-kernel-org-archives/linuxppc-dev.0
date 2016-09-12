Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXlYF6qbMzDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:13:37 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8CBDUEg125837
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 07:13:35 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25cbsydd8q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 07:13:33 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 12 Sep 2016 21:13:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0E9FF3578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:13:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8CBDJ5u58130514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:13:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8CBDJRG007394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:13:19 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in allocation
 ioctl
Date: Mon, 12 Sep 2016 16:43:17 +0530
Message-Id: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the HPT size is explicitly passed on from the userspace, currently
the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
from reserved CMA area and if that is not possible, the allocation just
fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
back to smaller HPT size in allocation ioctl"), it does not even try to
allocate the same order pages from the page allocator before failing for
good. Same order allocation should be attempted from the page allocator
as a fallback option when the CMA allocation attempt fails.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
- This change saves guests from failing to start after migration

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 05f09ae..0a30eb4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -78,6 +78,14 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 			--order;
 	}
 
+	/*
+	 * Fallback in case the userspace has provided a size via ioctl.
+	 * Try allocating the same order pages from the page allocator.
+	 */
+	if (!hpt && order > PPC_MIN_HPT_ORDER && htab_orderp)
+		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
+			__GFP_NOWARN, order - PAGE_SHIFT);
+
 	if (!hpt)
 		return -ENOMEM;
 
-- 
1.8.5.2
