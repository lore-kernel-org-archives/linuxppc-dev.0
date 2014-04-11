Return-Path: <pingfank@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66BD514008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 21:43:02 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pingfank@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 21:42:45 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5E7752CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 21:42:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BBM3ZA10027116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 21:22:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BBgfpI002437
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 21:42:41 +1000
From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v3] powerpc: kvm: make _PAGE_NUMA take effect
Date: Fri, 11 Apr 2014 19:45:07 +0800
Message-Id: <1397216707-12795-1-git-send-email-pingfank@linux.vnet.ibm.com>
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

When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start
and mmu_notifier_invalidate_range_end, which will mark existing guest hpte
entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
guest hpte entries.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
v3:
  rebased onto Alex's tree, branch kvm-ppc-next
  substitue commit log with the more clear description in Aneesh's reply (thanks, Aneesh)
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1d6c56a..1117525 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -234,7 +234,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		pte_size = psize;
 		pte = lookup_linux_pte_and_update(pgdir, hva, writing,
 						  &pte_size);
-		if (pte_present(pte)) {
+		if (pte_present(pte)&&!pte_numa(pte)) {
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
-- 
1.8.1.4
