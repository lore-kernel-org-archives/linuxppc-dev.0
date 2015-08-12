Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 813A31A1D25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:22 +1000 (AEST)
Message-Id: <766c0a5d33d5fc501652e81900e442f27dfa03a4.1439382636.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 13/20] powerpc/8xx: Handle CPU6 ERRATA directly in mtspr()
 macro
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:19 +0200 (CEST)
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
 arch/powerpc/include/asm/reg.h     |  2 +
 arch/powerpc/include/asm/reg_8xx.h | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bb27588..336895d 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1203,9 +1203,11 @@
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
+#ifndef mtspr
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
+#endif
 
 static inline unsigned long mfvtb (void)
 {
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 150323c..59f9b72 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -63,4 +63,86 @@
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
