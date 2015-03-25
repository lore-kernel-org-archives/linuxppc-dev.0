Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D10A61A025F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/6] powerpc/mm: Change setbat() to take a pgprot_t rather
 than flags
Date: Wed, 25 Mar 2015 20:11:55 +1100
Message-Id: <1427274719-25890-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aneesh.kumar@in.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The callers of setbat() are actually passing a pgprot_t for the flags
parameter. This doesn't matter unless STRICT_MM_TYPECHECKS is enabled.
So we can turn that on without breaking the build, change setbat() to
take a pgprot_t and have it convert it to an unsigned long internally.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/mmu_decl.h   | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 78c45f392f5b..085b66b10891 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -96,7 +96,7 @@ extern void _tlbia(void);
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
-		   unsigned int size, int flags);
+		   unsigned int size, pgprot_t prot);
 
 extern int __map_without_bats;
 extern int __allow_ioremap_reserved;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 5029dc19b517..94f33721d382 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -113,11 +113,12 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
  * of 2 between 128k and 256M.
  */
 void __init setbat(int index, unsigned long virt, phys_addr_t phys,
-		   unsigned int size, int flags)
+		   unsigned int size, pgprot_t prot)
 {
 	unsigned int bl;
 	int wimgxpp;
 	struct ppc_bat *bat = BATS[index];
+	unsigned long flags = pgprot_val(prot);
 
 	if ((flags & _PAGE_NO_CACHE) ||
 	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
-- 
2.1.0
