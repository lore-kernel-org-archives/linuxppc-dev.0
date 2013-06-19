Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3398C2C02C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:44:17 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 16:30:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6AFD33578045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:44:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6TWUL64684078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:29:32 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6iDkR028399
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:44:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/kvm: Handle transparent hugepage in KVM
Date: Wed, 19 Jun 2013 12:14:05 +0530
Message-Id: <1371624245-17247-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We can find pte that are splitting while walking page tables. Return
None pte in that case.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 51 ++++++++++++++++++--------------
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  7 +++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  4 +--
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 9c1ff33..ce20f7e 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -162,33 +162,40 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
  * Lock and read a linux PTE.  If it's present and writable, atomically
  * set dirty and referenced bits and return the PTE, otherwise return 0.
  */
-static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int writing)
+static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
+						 unsigned int hugepage)
 {
-	pte_t pte, tmp;
-
-	/* wait until _PAGE_BUSY is clear then set it atomically */
-	__asm__ __volatile__ (
-		"1:	ldarx	%0,0,%3\n"
-		"	andi.	%1,%0,%4\n"
-		"	bne-	1b\n"
-		"	ori	%1,%0,%4\n"
-		"	stdcx.	%1,0,%3\n"
-		"	bne-	1b"
-		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
-		: "r" (p), "i" (_PAGE_BUSY)
-		: "cc");
-
-	if (pte_present(pte)) {
-		pte = pte_mkyoung(pte);
-		if (writing && pte_write(pte))
-			pte = pte_mkdirty(pte);
-	}
+	pte_t old_pte, new_pte = __pte(0);
+repeat:
+	do {
+		old_pte = pte_val(*ptep);
+		/*
+		 * wait until _PAGE_BUSY is clear then set it atomically
+		 */
+		if (unlikely(old_pte & _PAGE_BUSY))
+			goto repeat;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		/* If hugepage and is trans splitting return None */
+		if (unlikely(hugepage &&
+			     pmd_trans_splitting(pte_pmd(old_pte))))
+			return __pte(0);
+#endif
 
-	*p = pte;	/* clears _PAGE_BUSY */
+		/* If pte is not present return None */
+		if (unlikely(!(old_pte & _PAGE_PRESENT)))
+			return __pte(0);
 
-	return pte;
+		new_pte = pte_mkyoung(old_pte);
+		if (writing && pte_write(old_pte))
+			new_pte = pte_mkdirty(new_pte);
+
+	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
+					  old_pte, new_pte));
+	return new_pte;
 }
 
+
 /* Return HPTE cache control bits corresponding to Linux pte bits */
 static inline unsigned long hpte_cache_bits(unsigned long pte_val)
 {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 5880dfb..e1a9415 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -675,6 +675,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		}
 		/* if the guest wants write access, see if that is OK */
 		if (!writing && hpte_is_writable(r)) {
+			unsigned int shift;
 			pte_t *ptep, pte;
 
 			/*
@@ -683,9 +684,9 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 */
 			rcu_read_lock_sched();
 			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
-							 hva, NULL);
-			if (ptep && pte_present(*ptep)) {
-				pte = kvmppc_read_update_linux_pte(ptep, 1);
+							 hva, &shift);
+			if (ptep) {
+				pte = kvmppc_read_update_linux_pte(ptep, 1, shift);
 				if (pte_write(pte))
 					write_ok = 1;
 			}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index dcf892d..39ae723 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -150,9 +150,7 @@ static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
 		*pte_sizep = PAGE_SIZE;
 	if (ps > *pte_sizep)
 		return __pte(0);
-	if (!pte_present(*ptep))
-		return __pte(0);
-	return kvmppc_read_update_linux_pte(ptep, writing);
+	return kvmppc_read_update_linux_pte(ptep, writing, shift);
 }
 
 static inline void unlock_hpte(unsigned long *hpte, unsigned long hpte_v)
-- 
1.8.1.2
