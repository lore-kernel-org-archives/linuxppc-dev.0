Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30ABB2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 19:14:02 +1100 (EST)
Received: by mail-yh0-f49.google.com with SMTP id b6so2672761yha.36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 00:13:58 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
Date: Tue, 21 Jan 2014 16:15:29 +0800
Message-Id: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
when guest access them, we should force the checking when guest uses hypercall
to setup hpte.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
v2:
  It should be the reply to "[PATCH 2/4] powernv: kvm: make _PAGE_NUMA take effect"
  And I imporve the changelog according to Aneesh's suggestion.
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 9c51544..af8602d 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -232,7 +232,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		/* Look up the Linux PTE for the backing page */
 		pte_size = psize;
 		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size);
-		if (pte_present(pte)) {
+		if (pte_present(pte) && !pte_numa(pte)) {
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
-- 
1.8.1.4
