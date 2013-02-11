Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-x22b.google.com (mail-ia0-x22b.google.com
 [IPv6:2607:f8b0:4001:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62FFB2C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 23:13:23 +1100 (EST)
Received: by mail-ia0-f171.google.com with SMTP id z13so6337094iaz.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 04:13:19 -0800 (PST)
From: aik@ozlabs.ru
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: lookup_linux_pte has been made public
Date: Mon, 11 Feb 2013 23:12:40 +1100
Message-Id: <5118e055.22ca320a.1f08.ffffe2e5@mx.google.com>
In-Reply-To: <1360584763-21988-1-git-send-email-a>
References: <1360584763-21988-1-git-send-email-a>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The lookup_linux_pte() function returns a linux PTE which
is required to convert KVM guest physical address into host real
address in real mode.

This convertion will be used by upcoming support of H_PUT_TCE_INDIRECT
as TCE list address comes from the guest directly so it is a guest
physical.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    3 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 0182c20..ddcc898 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -377,6 +377,9 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 }
 #endif /* !CONFIG_HUGETLB_PAGE */
 
+pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+		int writing, unsigned long *pte_sizep);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 19c93ba..6a042d0 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -145,8 +145,8 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
-static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
+pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+		       int writing, unsigned long *pte_sizep)
 {
 	pte_t *ptep;
 	unsigned long ps = *pte_sizep;
-- 
1.7.10.4
