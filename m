Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CBB02C0150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:53:41 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 08:19:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3D29E3940023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:23:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G2rWaG43581510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:23:32 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G2rZhh029020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:53:35 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 2/3] powerpc: Split the code trying to insert hpte
 repeatedly as an helper function
Date: Tue, 16 Apr 2013 10:53:19 +0800
Message-Id: <1366080800-27885-2-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1366080800-27885-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1366080800-27885-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the logic trying to insert hpte in __hash_page_huge() to an helper
function, so it could also be used by others.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c      |   35 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage-hash64.c |   31 ++++++------------------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f410c3e..ead9fa8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1230,6 +1230,41 @@ void low_hash_fault(struct pt_regs *regs, unsigned long address, int rc)
 		bad_page_fault(regs, address, SIGBUS);
 }
 
+long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
+			   unsigned long pa, unsigned long rflags,
+			   unsigned long vflags, int psize, int ssize)
+{
+	unsigned long hpte_group;
+	long slot;
+
+repeat:
+	hpte_group = ((hash & htab_hash_mask) *
+		       HPTES_PER_GROUP) & ~0x7UL;
+
+	/* Insert into the hash table, primary slot */
+	slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, vflags,
+				  psize, ssize);
+
+	/* Primary is full, try the secondary */
+	if (unlikely(slot == -1)) {
+		hpte_group = ((~hash & htab_hash_mask) *
+			      HPTES_PER_GROUP) & ~0x7UL;
+		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags,
+					  vflags | HPTE_V_SECONDARY,
+					  psize, ssize);
+		if (slot == -1) {
+			if (mftb() & 0x1)
+				hpte_group = ((hash & htab_hash_mask) *
+					      HPTES_PER_GROUP)&~0x7UL;
+
+			ppc_md.hpte_remove(hpte_group);
+			goto repeat;
+		}
+	}
+
+	return slot;
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index edb4129..b913f41 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -14,6 +14,10 @@
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 
+extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
+				  unsigned long pa, unsigned long rlags,
+				  unsigned long vflags, int psize, int ssize);
+
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize)
@@ -83,7 +87,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	if (likely(!(old_pte & _PAGE_HASHPTE))) {
 		unsigned long hash = hpt_hash(vpn, shift, ssize);
-		unsigned long hpte_group;
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 
@@ -97,30 +100,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
 
-repeat:
-		hpte_group = ((hash & htab_hash_mask) *
-			      HPTES_PER_GROUP) & ~0x7UL;
-
-		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-					  mmu_psize, ssize);
-
-		/* Primary is full, try the secondary */
-		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) *
-				      HPTES_PER_GROUP) & ~0x7UL;
-			slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags,
-						  HPTE_V_SECONDARY,
-						  mmu_psize, ssize);
-			if (slot == -1) {
-				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_hash_mask) *
-						      HPTES_PER_GROUP)&~0x7UL;
-
-				ppc_md.hpte_remove(hpte_group);
-				goto repeat;
-                        }
-		}
+		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
+					     mmu_psize, ssize);
 
 		/*
 		 * Hypervisor failure. Restore old pte and return -1
-- 
1.7.9.5
