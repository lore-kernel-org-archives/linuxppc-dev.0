Return-Path: <pingfank@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E45281400EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 18:31:18 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pingfank@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 14:01:15 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4F6EA1258055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 14:03:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3F8VDku4325826
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 14:01:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3F8V6LN018837
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 14:01:06 +0530
From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v4] powerpc: kvm: make _PAGE_NUMA take effect
Date: Tue, 15 Apr 2014 16:33:40 +0800
Message-Id: <1397550820-29993-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>,
 kvm@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Numa fault is a method which help to achieve auto numa balancing.
When such a page fault takes place, the page fault handler will check
whether the page is placed correctly. If not, migration should be
involved to cut down the distance between the cpu and pages.

A pte with _PAGE_NUMA help to implement numa fault. It means not to
allow the MMU to access the page directly. So a page fault is triggered
and numa fault handler gets the opportunity to run checker.

As for the access of MMU, we need special handling for the powernv's guest.
When we mark a pte with _PAGE_NUMA, we already call mmu_notifier to
invalidate it in guest's htab, but when we tried to re-insert them,
we firstly try to map it in real-mode. Only after this fails, we fallback
to virt mode, and most of important, we run numa fault handler in virt
mode.  This patch guards the way of real-mode to ensure that if a pte is
marked with _PAGE_NUMA, it will NOT be mapped in real mode, instead, it will
be mapped in virt mode and have the opportunity to be checked with placement.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
v4:
  more detail description 
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1d6c56a..8fcc363 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -234,7 +234,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		pte_size = psize;
 		pte = lookup_linux_pte_and_update(pgdir, hva, writing,
 						  &pte_size);
-		if (pte_present(pte)) {
+		if (pte_present(pte) && !pte_numa(pte)) {
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
-- 
1.8.1.4
