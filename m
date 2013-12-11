Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com
 [IPv6:2607:f8b0:4003:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DDAE2C034E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:47:08 +1100 (EST)
Received: by mail-ob0-f180.google.com with SMTP id wo20so6514815obc.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:47:05 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 2/4] powernv: kvm: make _PAGE_NUMA take effect
Date: Wed, 11 Dec 2013 16:47:52 +0800
Message-Id: <1386751674-14136-3-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To make _PAGE_NUMA take effect, we should force the checking when
guest uses hypercall to setup hpte.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
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
