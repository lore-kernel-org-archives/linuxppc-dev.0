Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/16] powerpc: Register defines for various transactional
 memory registers
Date: Tue, 27 Nov 2012 13:47:57 +1100
Message-Id: <1353984488-1283-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Defines for MSR bits and transactional memory related SPRs TFIAR, TEXASR and
TEXASRU.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 736c6af..bea823f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -29,6 +29,8 @@
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
+#define MSR_TS_LG	33		/* Transactional Mem State (2 bits) */
+#define MSR_TM_LG	32		/* Transactional Mem Available */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
 #define MSR_VSX_LG	23		/* Enable VSX */
 #define MSR_POW_LG	18		/* Enable Power Management */
@@ -98,6 +100,21 @@
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
+#define MSR_TM	        __MASK(MSR_TM_LG)	/* Transactional Mem Available */
+#define MSR_TS_MASK     (__MASK(MSR_TS_LG) | \
+		         __MASK(MSR_TS_LG+1))   /* Transaction State bits */
+#define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
+
+/* Reason codes describing kernel causes for transaction aborts.  By
+   convention, bit0 is copied to TEXASR[56] (IBM bit 7) which is set if
+   the failure is persistent.
+*/
+#define TM_CAUSE_RESCHED	0xfe
+#define TM_CAUSE_TLBI		0xfc
+#define TM_CAUSE_FAC_UNAV	0xfa
+#define TM_CAUSE_SYSCALL	0xf9 /* Persistent */
+#define TM_CAUSE_MISC		0xf6
+
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
 
@@ -193,6 +210,10 @@
 #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
 #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
+#define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr   */
+#define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
+#define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
+#define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
-- 
1.7.9.5
