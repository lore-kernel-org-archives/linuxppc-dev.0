Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrml4k3vzDwt3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:23 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed3DO046220
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9mf2sjw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:22 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:21 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 14/16] powerpc/mm: Cleanup LPCR defines
Date: Wed,  8 Jun 2016 20:13:21 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes it easy to verify we are not overloading the bits.
No functionality change by this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h | 54 +++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 466816ede138..5c4b6f4f8903 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -314,41 +314,41 @@
 #define   HFSCR_FP	__MASK(FSCR_FP_LG)
 #define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
-#define   LPCR_VPM0	(1ul << (63-0))
-#define   LPCR_VPM1	(1ul << (63-1))
-#define   LPCR_ISL	(1ul << (63-2))
+#define   LPCR_VPM0		ASM_CONST(0x8000000000000000)
+#define   LPCR_VPM1		ASM_CONST(0x4000000000000000)
+#define   LPCR_ISL		ASM_CONST(0x2000000000000000)
 #define   LPCR_VC_SH	(63-2)
 #define   LPCR_DPFD_SH	(63-11)
 #define   LPCR_DPFD	(7ul << LPCR_DPFD_SH)
 #define   LPCR_VRMASD	(0x1ful << (63-16))
-#define   LPCR_VRMA_L	(1ul << (63-12))
-#define   LPCR_VRMA_LP0	(1ul << (63-15))
-#define   LPCR_VRMA_LP1	(1ul << (63-16))
+#define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
+#define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
+#define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
 #define   LPCR_VRMASD_SH (63-16)
-#define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
+#define   LPCR_RMLS     0x1C000000      /* impl dependent rmo limit sel */
 #define	  LPCR_RMLS_SH	(63-37)
-#define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
-#define   LPCR_AIL	0x01800000	/* Alternate interrupt location */
-#define   LPCR_AIL_0	0x00000000	/* MMU off exception offset 0x0 */
-#define   LPCR_AIL_3	0x01800000	/* MMU on exception offset 0xc00...4xxx */
-#define   LPCR_ONL	0x00040000	/* online - PURR/SPURR count */
-#define   LPCR_PECE	0x0001f000	/* powersave exit cause enable */
-#define     LPCR_PECEDP	0x00010000	/* directed priv dbells cause exit */
-#define     LPCR_PECEDH	0x00008000	/* directed hyp dbells cause exit */
-#define     LPCR_PECE0	0x00004000	/* ext. exceptions can cause exit */
-#define     LPCR_PECE1	0x00002000	/* decrementer can cause exit */
-#define     LPCR_PECE2	0x00001000	/* machine check etc can cause exit */
-#define   LPCR_MER	0x00000800	/* Mediated External Exception */
+#define   LPCR_ILE     		ASM_CONST(0x0000000002000000)   /* !HV irqs set MSR:LE */
+#define   LPCR_AIL		ASM_CONST(0x0000000001800000)	/* Alternate interrupt location */
+#define   LPCR_AIL_0		ASM_CONST(0x0000000000000000)	/* MMU off exception offset 0x0 */
+#define   LPCR_AIL_3		ASM_CONST(0x0000000001800000)   /* MMU on exception offset 0xc00...4xxx */
+#define   LPCR_ONL		ASM_CONST(0x0000000000040000)	/* online - PURR/SPURR count */
+#define   LPCR_PECE		ASM_CONST(0x000000000001f000)	/* powersave exit cause enable */
+#define      LPCR_PECEDP	ASM_CONST(0x0000000000010000)	/* directed priv dbells cause exit */
+#define       LPCR_PECEDH	ASM_CONST(0x0000000000008000)	/* directed hyp dbells cause exit */
+#define       LPCR_PECE0	ASM_CONST(0x0000000000004000)	/* ext. exceptions can cause exit */
+#define       LPCR_PECE1	ASM_CONST(0x0000000000002000)	/* decrementer can cause exit */
+#define       LPCR_PECE2	ASM_CONST(0x0000000000001000)	/* machine check etc can cause exit */
+#define   LPCR_MER		ASM_CONST(0x0000000000000800)	/* Mediated External Exception */
 #define   LPCR_MER_SH	11
-#define   LPCR_TC      0x00000200	/* Translation control */
-#define   LPCR_LPES    0x0000000c
-#define   LPCR_LPES0   0x00000008      /* LPAR Env selector 0 */
-#define   LPCR_LPES1   0x00000004      /* LPAR Env selector 1 */
+#define   LPCR_TC       	ASM_CONST(0x0000000000000200)	/* Translation control */
+#define   LPCR_LPES     	0x0000000c
+#define   LPCR_LPES0    	ASM_CONST(0x0000000000000008)      /* LPAR Env selector 0 */
+#define   LPCR_LPES1    	ASM_CONST(0x0000000000000004)      /* LPAR Env selector 1 */
 #define   LPCR_LPES_SH	2
-#define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
-#define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
-#define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
-#define	  LPCR_HR      0x00100000
+#define   LPCR_RMI      	ASM_CONST(0x0000000000000002)      /* real mode is cache inhibit */
+#define   LPCR_HDICE    	ASM_CONST(0x0000000000000001)      /* Hyp Decr enable (HV,PR,EE) */
+#define   LPCR_UPRT     	ASM_CONST(0x0000000000400000)      /* Use Process Table (ISA 3) */
+#define	  LPCR_HR       	ASM_CONST(0x0000000000100000)
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
-- 
2.7.4
