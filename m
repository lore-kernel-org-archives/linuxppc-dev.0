Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zX7RN3lvLzDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 16:08:00 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH kernel] powerpc/mm: Fix typo in comments
Date: Thu,  1 Feb 2018 16:07:25 +1100
Message-Id: <20180201050725.30247-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes: 912cc87a6 "powerpc/mm/radix: Add LPID based tlb flush helpers"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/tlb-radix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 71d1b19..001c1f6 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -98,7 +98,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	rb |= set << PPC_BITLSHIFT(51);
 	rs = ((unsigned long)pid) << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
@@ -112,7 +112,7 @@ static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	rb = PPC_BIT(53); /* IS = 1 */
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
@@ -164,7 +164,7 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 	rb |= ap << PPC_BITLSHIFT(58);
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
@@ -212,7 +212,7 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 	rb |= ap << PPC_BITLSHIFT(58);
 	rs = pid << PPC_BITLSHIFT(31);
 	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
@@ -615,7 +615,7 @@ void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
 	rb |= ap << PPC_BITLSHIFT(58);
 	rs = lpid & ((1UL << 32) - 1);
 	prs = 0; /* process scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
@@ -633,7 +633,7 @@ void radix__flush_tlb_lpid(unsigned long lpid)
 	rb = 0x2 << PPC_BITLSHIFT(53); /* IS = 2 */
 	rs = lpid & ((1UL << 32) - 1);
 	prs = 0; /* partition scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
@@ -657,7 +657,7 @@ void radix__flush_tlb_all(void)
 
 	rb = 0x3 << PPC_BITLSHIFT(53); /* IS = 3 */
 	prs = 0; /* partition scoped */
-	r = 1;   /* raidx format */
+	r = 1;   /* radix format */
 	rs = 1 & ((1UL << 32) - 1); /* any LPID value to flush guest mappings */
 
 	asm volatile("ptesync": : :"memory");
-- 
2.11.0
