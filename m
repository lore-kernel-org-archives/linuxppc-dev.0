Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmKM1tQ7zDq7V
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:15:35 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:15:33 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EA05C3E4001C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:15:20 -0600 (MDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396FJvd36044932
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:15:20 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396FJIv009779
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:15:19 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 20/68] powerpc/mm: Handle _PTE_NONE_MASK
Date: Sat,  9 Apr 2016 11:43:16 +0530
Message-Id: <1460182444-2468-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am splitting this as a separate patch to get better review. If ok
we should merge this with previous patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d547c6b44749..9d1f986bc60a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -36,8 +36,7 @@
 #endif
 #define _PAGE_SPECIAL		0x00400 /* software: special page */
 #define H_PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
-
-
+#define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
 #define H_PAGE_F_GIX_SHIFT	57
 #define H_PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
 #define H_PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
@@ -136,7 +135,6 @@
 
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
-#define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 /*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
@@ -381,7 +379,7 @@ static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
-static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-- 
2.5.0
