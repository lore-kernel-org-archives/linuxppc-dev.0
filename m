Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A85D62C02EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 21:37:16 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>, <agraf@suse.de>,
 <paulus@samba.org>, <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/6 v3] kvm: powerpc: keep only pte search logic in
 lookup_linux_pte
Date: Tue, 6 Aug 2013 17:01:13 +0530
Message-ID: <1375788674-13140-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lookup_linux_pte() was searching for a pte and also sets access
flags is writable. This function now searches only pte while
access flag setting is done explicitly.

This pte lookup is not kvm specific, so moved to common code (asm/pgtable.h)
My Followup patch will use this on booke.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2->v3
 - New change

 arch/powerpc/include/asm/pgtable.h  |   23 +++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   38 +++++++++++-----------------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 690c8c2..d4d16ab 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -254,6 +254,29 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 }
 #endif /* !CONFIG_HUGETLB_PAGE */
 
+static inline pte_t *lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+				     unsigned long *pte_sizep)
+{
+	pte_t *ptep;
+	unsigned long ps = *pte_sizep;
+	unsigned int shift;
+
+	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
+	if (!ptep)
+		return __pte(0);
+	if (shift)
+		*pte_sizep = 1ul << shift;
+	else
+		*pte_sizep = PAGE_SIZE;
+
+	if (ps > *pte_sizep)
+		return __pte(0);
+
+	if (!pte_present(*ptep))
+		return __pte(0);
+
+	return ptep;
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 105b00f..7e6200c 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -134,27 +134,6 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
-static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
-{
-	pte_t *ptep;
-	unsigned long ps = *pte_sizep;
-	unsigned int shift;
-
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
-	if (!ptep)
-		return __pte(0);
-	if (shift)
-		*pte_sizep = 1ul << shift;
-	else
-		*pte_sizep = PAGE_SIZE;
-	if (ps > *pte_sizep)
-		return __pte(0);
-	if (!pte_present(*ptep))
-		return __pte(0);
-	return kvmppc_read_update_linux_pte(ptep, writing);
-}
-
 static inline void unlock_hpte(unsigned long *hpte, unsigned long hpte_v)
 {
 	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
@@ -174,6 +153,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned long *physp, pte_size;
 	unsigned long is_io;
 	unsigned long *rmap;
+	pte_t *ptep;
 	pte_t pte;
 	unsigned int writing;
 	unsigned long mmu_seq;
@@ -233,8 +213,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 		/* Look up the Linux PTE for the backing page */
 		pte_size = psize;
-		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size);
-		if (pte_present(pte)) {
+		ptep = lookup_linux_pte(pgdir, hva, &pte_size);
+		if (pte_present(pte_val(*ptep))) {
+			pte = kvmppc_read_update_linux_pte(ptep, writing);
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
@@ -662,6 +643,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			unsigned long psize, gfn, hva;
 			struct kvm_memory_slot *memslot;
 			pgd_t *pgdir = vcpu->arch.pgdir;
+			pte_t *ptep;
 			pte_t pte;
 
 			psize = hpte_page_size(v, r);
@@ -669,9 +651,13 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			memslot = __gfn_to_memslot(kvm_memslots(kvm), gfn);
 			if (memslot) {
 				hva = __gfn_to_hva_memslot(memslot, gfn);
-				pte = lookup_linux_pte(pgdir, hva, 1, &psize);
-				if (pte_present(pte) && !pte_write(pte))
-					r = hpte_make_readonly(r);
+				ptep = lookup_linux_pte(pgdir, hva, &psize);
+				if (pte_present(pte_val(*ptep))) {
+					pte = kvmppc_read_update_linux_pte(ptep,
+									   1);
+					if (pte_present(pte) && !pte_write(pte))
+						r = hpte_make_readonly(r);
+				}
 			}
 		}
 	}
-- 
1.7.0.4
