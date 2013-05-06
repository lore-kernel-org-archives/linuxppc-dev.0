Return-Path: <aik@ozlabs.ru>
Received: from mail-ye0-f179.google.com (mail-ye0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F8CF2C053F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:16 +1000 (EST)
Received: by mail-ye0-f179.google.com with SMTP id l14so648576yen.24
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:13 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] KVM: PPC: Make lookup_linux_pte public
Date: Mon,  6 May 2013 17:25:52 +1000
Message-Id: <1367825157-27231-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lookup_linux_pte() function returns a linux PTE which is needed in
the process of converting KVM guest physical address into host real
address in real mode.

This conversion will be used by upcoming support of H_PUT_TCE_INDIRECT,
as the TCE list address comes from the guest and is a guest physical
address.  This makes lookup_linux_pte() public so that code can call
it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_ppc.h  |    3 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |    5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 41426c9..99da298 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -379,4 +379,7 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 	return ea;
 }
 
+pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+		int writing, unsigned long *pte_sizep);
+
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6dcbb49..18fc382 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -134,8 +134,8 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
-static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
+pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+		       int writing, unsigned long *pte_sizep)
 {
 	pte_t *ptep;
 	unsigned long ps = *pte_sizep;
@@ -154,6 +154,7 @@ static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
 		return __pte(0);
 	return kvmppc_read_update_linux_pte(ptep, writing);
 }
+EXPORT_SYMBOL_GPL(lookup_linux_pte);
 
 static inline void unlock_hpte(unsigned long *hpte, unsigned long hpte_v)
 {
-- 
1.7.10.4
