Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zFvqD3m04zF0bs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 12:35:51 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Oliver O'Halloran <oohall@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH kernel] powerpc/mm: Flush "process-scoped translations"
 when setting MMU type
Date: Tue,  9 Jan 2018 12:35:41 +1100
Message-Id: <20180109013541.6229-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes migration on POWER9 machines, especially when migration
starts within first 10 seconds after the guest start.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is a reminder that the problem exists, a proper patch and
commit log are still needed. The "(old & PATB_HR)" was tested but
not the other one, something is wrong with hpt guest on radix host.
---
 arch/powerpc/mm/pgtable_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 813ea22..f690f6d 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -483,10 +483,14 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 	if (old & PATB_HR) {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
 			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
+				"r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
 	} else {
 		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
 			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		asm volatile(PPC_TLBIE_5(%0,%1,2,1,0) : :
+				"r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 0);
 	}
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-- 
2.11.0
