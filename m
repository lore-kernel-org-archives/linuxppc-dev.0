Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrV7z6cMVzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 21:04:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Cleanup LPCR defines
Date: Fri, 15 Jul 2016 21:04:26 +1000
Message-Id: <1468580666-6894-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This makes it easy to verify we are not overloading the bits.
No functionality change by this patch.

mpe: Cleanup more. Completely fixup whitespace, convert all UL values to
ASM_CONST(), and replace all occurrences of 63-x with the actual shift.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h | 74 +++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

v2: Clean it up even more.

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 295a19aec9b9..d7e9ab5e4709 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -330,43 +330,43 @@
 #define   HFSCR_FP	__MASK(FSCR_FP_LG)
 #define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
-#define   LPCR_VPM0	(1ul << (63-0))
-#define   LPCR_VPM1	(1ul << (63-1))
-#define   LPCR_ISL	(1ul << (63-2))
-#define   LPCR_VC_SH	(63-2)
-#define   LPCR_DPFD_SH	(63-11)
-#define   LPCR_DPFD	(7ul << LPCR_DPFD_SH)
-#define   LPCR_VRMASD	(0x1ful << (63-16))
-#define   LPCR_VRMA_L	(1ul << (63-12))
-#define   LPCR_VRMA_LP0	(1ul << (63-15))
-#define   LPCR_VRMA_LP1	(1ul << (63-16))
-#define   LPCR_VRMASD_SH (63-16)
-#define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
-#define	  LPCR_RMLS_SH	(63-37)
-#define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
-#define   LPCR_AIL	0x01800000	/* Alternate interrupt location */
-#define   LPCR_AIL_0	0x00000000	/* MMU off exception offset 0x0 */
-#define   LPCR_AIL_3	0x01800000	/* MMU on exception offset 0xc00...4xxx */
-#define   LPCR_ONL	0x00040000	/* online - PURR/SPURR count */
-#define   LPCR_LD	0x00020000	/* large decremeter */
-#define   LPCR_PECE	0x0001f000	/* powersave exit cause enable */
-#define     LPCR_PECEDP	0x00010000	/* directed priv dbells cause exit */
-#define     LPCR_PECEDH	0x00008000	/* directed hyp dbells cause exit */
-#define     LPCR_PECE0	0x00004000	/* ext. exceptions can cause exit */
-#define     LPCR_PECE1	0x00002000	/* decrementer can cause exit */
-#define     LPCR_PECE2	0x00001000	/* machine check etc can cause exit */
-#define   LPCR_MER	0x00000800	/* Mediated External Exception */
-#define   LPCR_MER_SH	11
-#define   LPCR_TC      0x00000200	/* Translation control */
-#define   LPCR_LPES    0x0000000c
-#define   LPCR_LPES0   0x00000008      /* LPAR Env selector 0 */
-#define   LPCR_LPES1   0x00000004      /* LPAR Env selector 1 */
-#define   LPCR_LPES_SH	2
-#define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
-#define   LPCR_HVICE   0x00000002      /* P9: HV interrupt enable */
-#define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
-#define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
-#define   LPCR_HR      0x00100000
+#define   LPCR_VPM0		ASM_CONST(0x8000000000000000)
+#define   LPCR_VPM1		ASM_CONST(0x4000000000000000)
+#define   LPCR_ISL		ASM_CONST(0x2000000000000000)
+#define   LPCR_VC_SH		61
+#define   LPCR_DPFD_SH		52
+#define   LPCR_DPFD		(ASM_CONST(7) << LPCR_DPFD_SH)
+#define   LPCR_VRMASD_SH	47
+#define   LPCR_VRMASD		(ASM_CONST(1) << LPCR_VRMASD_SH)
+#define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
+#define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
+#define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
+#define   LPCR_RMLS		0x1C000000	/* Implementation dependent RMO limit sel */
+#define   LPCR_RMLS_SH		26
+#define   LPCR_ILE		ASM_CONST(0x0000000002000000)   /* !HV irqs set MSR:LE */
+#define   LPCR_AIL		ASM_CONST(0x0000000001800000)	/* Alternate interrupt location */
+#define   LPCR_AIL_0		ASM_CONST(0x0000000000000000)	/* MMU off exception offset 0x0 */
+#define   LPCR_AIL_3		ASM_CONST(0x0000000001800000)   /* MMU on exception offset 0xc00...4xxx */
+#define   LPCR_ONL		ASM_CONST(0x0000000000040000)	/* online - PURR/SPURR count */
+#define   LPCR_LD		ASM_CONST(0x0000000000020000)	/* large decremeter */
+#define   LPCR_PECE		ASM_CONST(0x000000000001f000)	/* powersave exit cause enable */
+#define     LPCR_PECEDP	ASM_CONST(0x0000000000010000)	/* directed priv dbells cause exit */
+#define     LPCR_PECEDH	ASM_CONST(0x0000000000008000)	/* directed hyp dbells cause exit */
+#define     LPCR_PECE0		ASM_CONST(0x0000000000004000)	/* ext. exceptions can cause exit */
+#define     LPCR_PECE1		ASM_CONST(0x0000000000002000)	/* decrementer can cause exit */
+#define     LPCR_PECE2		ASM_CONST(0x0000000000001000)	/* machine check etc can cause exit */
+#define   LPCR_MER		ASM_CONST(0x0000000000000800)	/* Mediated External Exception */
+#define   LPCR_MER_SH		11
+#define   LPCR_TC		ASM_CONST(0x0000000000000200)	/* Translation control */
+#define   LPCR_LPES		0x0000000c
+#define   LPCR_LPES0		ASM_CONST(0x0000000000000008)      /* LPAR Env selector 0 */
+#define   LPCR_LPES1		ASM_CONST(0x0000000000000004)      /* LPAR Env selector 1 */
+#define   LPCR_LPES_SH		2
+#define   LPCR_RMI		ASM_CONST(0x0000000000000002)      /* real mode is cache inhibit */
+#define   LPCR_HVICE		ASM_CONST(0x0000000000000002)      /* P9: HV interrupt enable */
+#define   LPCR_HDICE		ASM_CONST(0x0000000000000001)      /* Hyp Decr enable (HV,PR,EE) */
+#define   LPCR_UPRT		ASM_CONST(0x0000000000400000)      /* Use Process Table (ISA 3) */
+#define   LPCR_HR		ASM_CONST(0x0000000000100000)
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
-- 
2.7.4
