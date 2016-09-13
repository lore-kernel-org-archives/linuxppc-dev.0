Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYBrB53jszDsQd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 14:43:06 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 128so9045251pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:43:06 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v1] Fix __tlbiel in hash_native_64
Date: Tue, 13 Sep 2016 14:42:41 +1000
Message-Id: <1473741761-2795-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__tlbie and __tlbiel are out of sync. __tlbie does the right thing
it calls tlbie with "tlbie rb, L" if CPU_FTR_ARCH_206 (cpu feature) is clear
and with "tlbie rb" otherwise. During the cleanup of __tlbiel I noticed
that __tlbiel was setting bit 11 PPC_BIT(21) independent of the ISA
version for non-4k (L) pages. This patch fixes that issue. It also changes
the current PPC_TLBIEL to PPC_TLBIEL_5 and introduces a new PPC_TLBIEL similar
to PPC_TLBIE.

The arguments to PPC_TLBIE have also been changed/switched in order
to be consistent with the actual assembly usage for clearer reading
of code.

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  9 ++++++---
 arch/powerpc/mm/hash_native_64.c      | 14 ++++++++------
 arch/powerpc/mm/tlb-radix.c           |  4 ++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 127ebf5..308004a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -354,14 +354,17 @@
 #define PPC_TLBILX_VA(a, b)	PPC_TLBILX(3, a, b)
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
-#define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
-					       ___PPC_RB(a) | ___PPC_RS(lp))
+#define PPC_TLBIE(rb,lp) 	stringify_in_c(.long PPC_INST_TLBIE | \
+					       ___PPC_RB(rb) | ___PPC_RS(lp))
 #define	PPC_TLBIE_5(rb,rs,ric,prs,r) \
 				stringify_in_c(.long PPC_INST_TLBIE | \
 					___PPC_RB(rb) | ___PPC_RS(rs) | \
 					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
 					___PPC_R(r))
-#define	PPC_TLBIEL(rb,rs,ric,prs,r) \
+#define	PPC_TLBIEL(rb,lp) \
+				stringify_in_c(.long PPC_INST_TLBIEL | \
+					___PPC_RB(rb) | ___PPC_RS(lp))
+#define	PPC_TLBIEL_5(rb,rs,ric,prs,r) \
 				stringify_in_c(.long PPC_INST_TLBIEL | \
 					___PPC_RB(rb) | ___PPC_RS(rs) | \
 					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 0e4e965..ae17d4c 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -74,7 +74,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		va |= ssize << 8;
 		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
-		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
+		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%0,%1), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
@@ -93,7 +93,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		 */
 		va |= (vpn & 0xfe); /* AVAL */
 		va |= 1; /* L */
-		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
+		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%0,%1), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
@@ -123,8 +123,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		va |= ssize << 8;
 		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFCLR("tlbiel %0,0", PPC_TLBIEL(%0,%1), %2)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
@@ -141,8 +142,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		 */
 		va |= (vpn & 0xfe);
 		va |= 1; /* L */
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFCLR("tlbiel %0,1", PPC_TLBIEL(%0,%1), %2)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	}
 
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 48df05e..7d31440 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -35,7 +35,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	r = 1;   /* raidx format */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+	asm volatile(PPC_TLBIEL_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
 }
@@ -80,7 +80,7 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	r = 1;   /* raidx format */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+	asm volatile(PPC_TLBIEL_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
 }
-- 
2.5.5
