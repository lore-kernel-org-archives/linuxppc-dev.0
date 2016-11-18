Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqNz0Pq2zDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:51 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 01/13] powerpc/64: Add some more SPRs and SPR bits for POWER9
Date: Fri, 18 Nov 2016 18:28:30 +1100
Message-Id: <1479454122-26994-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These definitions will be needed by KVM.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/reg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9cd4e8c..df81411 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -153,6 +153,8 @@
 #define PSSCR_EC		0x00100000 /* Exit Criterion */
 #define PSSCR_ESL		0x00200000 /* Enable State Loss */
 #define PSSCR_SD		0x00400000 /* Status Disable */
+#define PSSCR_PLS	0xf000000000000000 /* Power-saving Level Status */
+#define PSSCR_GUEST_VIS	0xf0000000000003ff /* Guest-visible PSSCR fields */
 
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
@@ -236,6 +238,7 @@
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
 #define   TEXASR_FS	__MASK(63-36) /* TEXASR Failure Summary */
 #define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
+#define SPRN_TIDR	144	/* Thread ID register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
@@ -294,6 +297,7 @@
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
 #define SPRN_LMRR	0x32D	/* Load Monitor Region Register */
 #define SPRN_LMSER	0x32E	/* Load Monitor Section Enable Register */
+#define SPRN_ASDR	0x330	/* Access segment descriptor register */
 #define SPRN_IC		0x350	/* Virtual Instruction Count */
 #define SPRN_VTB	0x351	/* Virtual Time Base */
 #define SPRN_LDBAR	0x352	/* LD Base Address Register */
@@ -357,6 +361,7 @@
 #define     LPCR_PECE2		ASM_CONST(0x0000000000001000)	/* machine check etc can cause exit */
 #define   LPCR_MER		ASM_CONST(0x0000000000000800)	/* Mediated External Exception */
 #define   LPCR_MER_SH		11
+#define	  LPCR_GTSE		ASM_CONST(0x0000000000000400)  	/* Guest Translation Shootdown Enable */
 #define   LPCR_TC		ASM_CONST(0x0000000000000200)	/* Translation control */
 #define   LPCR_LPES		0x0000000c
 #define   LPCR_LPES0		ASM_CONST(0x0000000000000008)      /* LPAR Env selector 0 */
-- 
2.7.4
