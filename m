Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 48BB71A0282
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:33:13 +1100 (AEDT)
Message-Id: <e35a7387604db5982b05bb21ffd2c034392caa99.1454581227.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454581226.git.christophe.leroy@c-s.fr>
References: <cover.1454581226.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 05/23] powerpc32: Fix pte_offset_kernel() to return NULL
 for bad pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  4 Feb 2016 11:33:11 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fixmap related functions try to map kernel pages that are
already mapped through Large TLBs. pte_offset_kernel() has to
return NULL for LTLBs, otherwise the caller will try to access
level 2 table which doesn't exist

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v3: new
v4: no change
v5: no change
v6: no change

 arch/powerpc/include/asm/nohash/32/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index c82cbf5..e201600 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -309,7 +309,8 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pte_index(address)		\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, addr)	\
-	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
+	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
+				  pte_index(addr))
 #define pte_offset_map(dir, addr)		\
 	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
 #define pte_unmap(pte)		kunmap_atomic(pte)
-- 
2.1.0
