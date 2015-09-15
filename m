Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D33301A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:50:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E0AAC2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoLHc64028924
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAo6hB026334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:06 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 2/9] KVM: PPC: Make real_vmalloc_addr() public
Date: Tue, 15 Sep 2015 20:49:32 +1000
Message-Id: <1442314179-9706-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This helper translates vmalloc'd addresses to linear addresses.
It is only used by the KVM MMU code now and resides in the HV KVM code.
We will need it further in the TCE code and the DMA memory preregistration
code called in real mode.

This makes real_vmalloc_addr() public and moves it to the powerpc code as
it does not do anything special for KVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu-hash64.h |  3 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 17 -----------------
 arch/powerpc/mm/hash_utils_64.c       | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index a82f534..fd06b73 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -606,6 +606,9 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 	context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
 	return get_vsid(context, ea, ssize);
 }
+
+void *real_vmalloc_addr(void *x);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index c1df9bb..987b7d1 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -22,23 +22,6 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-/* Translate address of a vmalloc'd thing to a linear map address */
-static void *real_vmalloc_addr(void *x)
-{
-	unsigned long addr = (unsigned long) x;
-	pte_t *p;
-	/*
-	 * assume we don't have huge pages in vmalloc space...
-	 * So don't worry about THP collapse/split. Called
-	 * Only in realmode, hence won't need irq_save/restore.
-	 */
-	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
-	if (!p || !pte_present(*p))
-		return NULL;
-	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
-	return __va(addr);
-}
-
 /* Return 1 if we need to do a global tlbie, 0 if we can use tlbiel */
 static int global_invalidates(struct kvm *kvm, unsigned long flags)
 {
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5ec987f..9737d6a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1556,3 +1556,20 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(ppc64_rma_size);
 }
+
+/* Translate address of a vmalloc'd thing to a linear map address */
+void *real_vmalloc_addr(void *x)
+{
+	unsigned long addr = (unsigned long) x;
+	pte_t *p;
+	/*
+	 * assume we don't have huge pages in vmalloc space...
+	 * So don't worry about THP collapse/split. Called
+	 * Only in realmode, hence won't need irq_save/restore.
+	 */
+	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
+	if (!p || !pte_present(*p))
+		return NULL;
+	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
+	return __va(addr);
+}
-- 
2.4.0.rc3.8.gfb3e7d5
