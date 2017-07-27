Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJGKN4DcbzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 01:36:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id k72so15046254pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 08:36:08 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, sjitindarsingh@gmail.com, joserz@linux.vnet.ibm.com,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2] powerpc/mm: Check for _PAGE_PTE in *_devmap()
Date: Fri, 28 Jul 2017 01:35:53 +1000
Message-Id: <20170727153553.9160-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ISA radix translation tree contains two different types of entry,
directories and leaves. The formats of the two entries are different
with the directory entries containing no spare bits for use by software.
As a result we need to ensure that the *_devmap() family of functions
check fail for everything except leaf (PTE) entries.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
"i'll just tweak the mbox before i sent it, what's the worst that can happen"
*completely breaks KVM*
"..."
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1da415..6bc6248 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -610,7 +610,9 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 
 static inline int pte_devmap(pte_t pte)
 {
-	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
+	uint64_t mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
+
+	return (pte_raw(pte) & mask) == mask;
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-- 
2.7.4
