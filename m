Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKjd969Q3zDrBt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 14:09:01 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: [PATCH v3] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9 DD1
Date: Fri, 18 Nov 2016 14:08:56 +1100
Message-Id: <20161118030856.12445-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 DD1, when we do a local TLB invalidate we also need to explicitly
invalidate the ERAT.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v3:
  - Now with added bike shedding
v2:
  - Remove unnecessary isyncs
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 +
 arch/powerpc/mm/tlb-radix.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 0132831b30..c56ea8c84a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -460,5 +460,6 @@
 
 #define PPC_SLBIA(IH)	stringify_in_c(.long PPC_INST_SLBIA | \
 				       ((IH & 0x7) << 21))
+#define PPC_INVALIDATE_ERAT	PPC_SLBIA(7)
 
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index bda8c43be7..3493cf4e04 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -50,6 +50,8 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
 		__tlbiel_pid(pid, set, ric);
 	}
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 	return;
 }
 
@@ -83,6 +85,8 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 }
 
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
-- 
2.9.3
