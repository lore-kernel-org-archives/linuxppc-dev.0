Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6EDDC1A0226
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:33:32 +1100 (AEDT)
Message-Id: <60880dd52214e8e8df10aafce66adc1eaf8310de.1454581227.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454581226.git.christophe.leroy@c-s.fr>
References: <cover.1454581226.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 14/23] powerpc/8xx: Handle CPU6 ERRATA directly in mtspr()
 macro
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  4 Feb 2016 11:33:29 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8xx has an ERRATA on the use of mtspr() for some registers
This patch includes the ERRATA handling directly into mtspr() macro
so that mtspr() users don't need to bother about that errata

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change
v4: no change
v5: no change
v6: no change

 arch/powerpc/include/asm/reg.h     |  2 +
 arch/powerpc/include/asm/reg_8xx.h | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c4cb2ff..7b5d97f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1211,9 +1211,11 @@ static inline void mtmsr_isync(unsigned long val)
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
+#ifndef mtspr
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
+#endif
 
 extern void msr_check_and_set(unsigned long bits);
 extern bool strict_msr_control;
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 0f71c81..d41412c 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -50,4 +50,86 @@
 #define DC_DFWT		0x40000000	/* Data cache is forced write through */
 #define DC_LES		0x20000000	/* Caches are little endian mode */
 
+#ifdef CONFIG_8xx_CPU6
+#define do_mtspr_cpu6(rn, rn_addr, v)	\
+	do {								\
+		int _reg_cpu6 = rn_addr, _tmp_cpu6[1];		\
+		asm volatile("stw %0, %1;"				\
+			     "lwz %0, %1;"				\
+			     "mtspr " __stringify(rn) ",%2" :		\
+			     : "r" (_reg_cpu6), "m"(_tmp_cpu6),		\
+			       "r" ((unsigned long)(v))			\
+			     : "memory");				\
+	} while (0)
+
+#define do_mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" :	\
+				     : "r" ((unsigned long)(v))		\
+				     : "memory")
+#define mtspr(rn, v) \
+	do {								\
+		if (rn == SPRN_IMMR)					\
+			do_mtspr_cpu6(rn, 0x3d30, v);			\
+		else if (rn == SPRN_IC_CST)				\
+			do_mtspr_cpu6(rn, 0x2110, v);			\
+		else if (rn == SPRN_IC_ADR)				\
+			do_mtspr_cpu6(rn, 0x2310, v);			\
+		else if (rn == SPRN_IC_DAT)				\
+			do_mtspr_cpu6(rn, 0x2510, v);			\
+		else if (rn == SPRN_DC_CST)				\
+			do_mtspr_cpu6(rn, 0x3110, v);			\
+		else if (rn == SPRN_DC_ADR)				\
+			do_mtspr_cpu6(rn, 0x3310, v);			\
+		else if (rn == SPRN_DC_DAT)				\
+			do_mtspr_cpu6(rn, 0x3510, v);			\
+		else if (rn == SPRN_MI_CTR)				\
+			do_mtspr_cpu6(rn, 0x2180, v);			\
+		else if (rn == SPRN_MI_AP)				\
+			do_mtspr_cpu6(rn, 0x2580, v);			\
+		else if (rn == SPRN_MI_EPN)				\
+			do_mtspr_cpu6(rn, 0x2780, v);			\
+		else if (rn == SPRN_MI_TWC)				\
+			do_mtspr_cpu6(rn, 0x2b80, v);			\
+		else if (rn == SPRN_MI_RPN)				\
+			do_mtspr_cpu6(rn, 0x2d80, v);			\
+		else if (rn == SPRN_MI_CAM)				\
+			do_mtspr_cpu6(rn, 0x2190, v);			\
+		else if (rn == SPRN_MI_RAM0)				\
+			do_mtspr_cpu6(rn, 0x2390, v);			\
+		else if (rn == SPRN_MI_RAM1)				\
+			do_mtspr_cpu6(rn, 0x2590, v);			\
+		else if (rn == SPRN_MD_CTR)				\
+			do_mtspr_cpu6(rn, 0x3180, v);			\
+		else if (rn == SPRN_M_CASID)				\
+			do_mtspr_cpu6(rn, 0x3380, v);			\
+		else if (rn == SPRN_MD_AP)				\
+			do_mtspr_cpu6(rn, 0x3580, v);			\
+		else if (rn == SPRN_MD_EPN)				\
+			do_mtspr_cpu6(rn, 0x3780, v);			\
+		else if (rn == SPRN_M_TWB)				\
+			do_mtspr_cpu6(rn, 0x3980, v);			\
+		else if (rn == SPRN_MD_TWC)				\
+			do_mtspr_cpu6(rn, 0x3b80, v);			\
+		else if (rn == SPRN_MD_RPN)				\
+			do_mtspr_cpu6(rn, 0x3d80, v);			\
+		else if (rn == SPRN_M_TW)				\
+			do_mtspr_cpu6(rn, 0x3f80, v);			\
+		else if (rn == SPRN_MD_CAM)				\
+			do_mtspr_cpu6(rn, 0x3190, v);			\
+		else if (rn == SPRN_MD_RAM0)				\
+			do_mtspr_cpu6(rn, 0x3390, v);			\
+		else if (rn == SPRN_MD_RAM1)				\
+			do_mtspr_cpu6(rn, 0x3590, v);			\
+		else if (rn == SPRN_DEC)				\
+			do_mtspr_cpu6(rn, 0x2c00, v);			\
+		else if (rn == SPRN_TBWL)				\
+			do_mtspr_cpu6(rn, 0x3880, v);			\
+		else if (rn == SPRN_TBWU)				\
+			do_mtspr_cpu6(rn, 0x3a80, v);			\
+		else if (rn == SPRN_DPDR)				\
+			do_mtspr_cpu6(rn, 0x2d30, v);			\
+		else							\
+			do_mtspr(rn, v);				\
+	} while (0)
+#endif
+
 #endif /* _ASM_POWERPC_REG_8xx_H */
-- 
2.1.0
