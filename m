Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zX7V31MM3zDqj2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 16:10:19 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel v2] powerpc/mm: Flush radix process translations when
 setting MMU type
Date: Thu,  1 Feb 2018 16:09:44 +1100
Message-Id: <20180201050944.30332-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix guests do normally invalidate process-scoped translations when
a new pid is allocated but migrated guests do not invalidate these so
migrated guests crash sometime, especially easy to reproduce with
migration happening within first 10 seconds after the guest boot start on
the same machine.

This adds the "Invalidate process-scoped translations" flush to fix
radix guests migration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* removed PPC_TLBIE_5() from the !(old&PATH_HR) case as it is pointless
on hash

---


Not so sure that "process-scoped translations" only require flushing
at pid allocation and migration.

---
 arch/powerpc/mm/pgtable_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c9a623c..d75dd52 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -471,6 +471,8 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 	if (old & PATB_HR) {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
 			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
 	} else {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
-- 
2.11.0
