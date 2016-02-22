Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B050D1A040B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 13:41:30 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 6/9] powerpc/mm/book3s-64: Move HPTE-related bits in PTE to
 upper end
Date: Mon, 22 Feb 2016 13:41:17 +1100
Message-Id: <1456108880-27464-7-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
References: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

This moves the _PAGE_HASHPTE, _PAGE_F_GIX and _PAGE_F_SECOND fields in
the Linux PTE on 64-bit Book 3S systems to the most significant byte.
Of the 5 bits, one is a software-use bit and the other four are
reserved bit positions in the PowerISA v3.0 radix PTE format.
Using these bits is OK because these bits are all to do with tracking
the HPTE(s) associated with the Linux PTE, and therefore won't be
needed in radix mode.  This frees up bit positions in the lower two
bytes.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 8 ++++----
 arch/powerpc/mm/hugetlbpage-hash64.c      | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 14cfd49..a59cfae 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -24,11 +24,7 @@
 #define _PAGE_DIRTY		0x00080 /* C: page changed */
 #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
 #define _PAGE_RW		0x00200 /* software: user write access allowed */
-#define _PAGE_HASHPTE		0x00400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
-#define _PAGE_F_GIX		0x07000 /* full page: hidx bits */
-#define _PAGE_F_GIX_SHIFT	12
-#define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
 #define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
@@ -37,6 +33,10 @@
 #define _PAGE_SOFT_DIRTY	0x00000
 #endif
 
+#define _PAGE_F_GIX_SHIFT	57
+#define _PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
+#define _PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
+#define _PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index e2138c7..8555fce 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -76,7 +76,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (old_pte & _PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & _PAGE_F_GIX) >> 12;
+		slot += (old_pte & _PAGE_F_GIX) >> _PAGE_F_GIX_SHIFT;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
 					 mmu_psize, ssize, flags) == -1)
@@ -105,7 +105,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 
-		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
+		new_pte |= (slot << _PAGE_F_GIX_SHIFT) &
+			(_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
 
 	/*
-- 
2.6.4
