Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A84F2C013F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:10:43 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <paulus@samba.org>,
 <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 4/6 v5] kvm: powerpc: keep only pte search logic in
 lookup_linux_pte
Date: Thu, 19 Sep 2013 11:32:44 +0530
Message-ID: <1379570566-3715-5-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
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
v4->v5
 - No change

 arch/powerpc/include/asm/pgtable.h  |   24 +++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   36 +++++++++++-----------------------
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 7d6eacf..3a5de5c 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -223,6 +223,30 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #endif
 pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 				 unsigned *shift);
+
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
index 45e30d6..74fa7f8 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -134,25 +134,6 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
-static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
-{
-	pte_t *ptep;
-	unsigned long ps = *pte_sizep;
-	unsigned int hugepage_shift;
-
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
-	if (!ptep)
-		return __pte(0);
-	if (hugepage_shift)
-		*pte_sizep = 1ul << hugepage_shift;
-	else
-		*pte_sizep = PAGE_SIZE;
-	if (ps > *pte_sizep)
-		return __pte(0);
-	return kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
-}
-
 static inline void unlock_hpte(unsigned long *hpte, unsigned long hpte_v)
 {
 	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
@@ -173,6 +154,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned long is_io;
 	unsigned long *rmap;
 	pte_t pte;
+	pte_t *ptep;
 	unsigned int writing;
 	unsigned long mmu_seq;
 	unsigned long rcbits;
@@ -231,8 +213,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
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
@@ -661,15 +644,20 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			struct kvm_memory_slot *memslot;
 			pgd_t *pgdir = vcpu->arch.pgdir;
 			pte_t pte;
+			pte_t *ptep;
 
 			psize = hpte_page_size(v, r);
 			gfn = ((r & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
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
