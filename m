Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJXLf2YbBzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 12:08:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: david@gibson.dropbear.id.au, sjitindarsingh@gmail.com, oohall@gmail.com,
 joserz@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/mm: Fix pmd/pte_devmap() on non-leaf entries
Date: Fri, 28 Jul 2017 12:08:01 +1000
Message-Id: <1501207681-2576-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oliver O'Halloran <oohall@gmail.com>

The Radix MMU translation tree as defined in ISA v3.0 contains two
different types of entry, directories and leaves. Leaves are
identified by _PAGE_PTE being set.

The formats of the two entries are different, with the directory
entries containing no spare bits for use by software. In particular
the bit we use for _PAGE_DEVMAP is not reserved for software, and is
part of the NLB (Next Level Base) field, essentially the address of
the next level in the tree.

Note that the Linux pte_t is not == _PAGE_PTE. A huge page pmd
entry (or devmap!) is also a leaf and so has _PAGE_PTE set, even
though we use a pmd_t for it in Linux.

The fix is to ensure that the pmd/pte_devmap() confirm they are
looking at a leaf entry (_PAGE_PTE) as well as checking _PAGE_DEVMAP.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[mpe: Add a comment in the code and flesh out change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

v2: Add a comment in the code and flesh out change log

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1da415e283c..818a58fc3f4f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -608,9 +608,17 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
 }
 
+/*
+ * This is potentially called with a pmd as the argument, in which case it's not
+ * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
+ * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
+ * use in page directory entries (ie. non-ptes).
+ */
 static inline int pte_devmap(pte_t pte)
 {
-	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
+	u64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
+
+	return (pte_raw(pte) & mask) == mask;
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-- 
2.7.4
