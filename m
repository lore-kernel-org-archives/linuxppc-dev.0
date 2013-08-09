Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc: Rework setting up H/FSCR bit definitions
Date: Fri,  9 Aug 2013 17:29:28 +1000
Message-Id: <1376033371-28713-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1376033371-28713-1-git-send-email-mikey@neuling.org>
References: <1376033371-28713-1-git-send-email-mikey@neuling.org>
In-Reply-To: <25550.1375872955@ale.ozlabs.ibm.com>
References: <25550.1375872955@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reworks the Facility Status and Control Regsiter (FSCR) config bit
definitions so that we can access the bit numbers.  This is needed for a
subsequent patch to fix the userspace DSCR handling.

HFSCR and FSCR bit definitions are the same, so reuse them.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> [v3.10]
---
 arch/powerpc/include/asm/reg.h | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a6840e4..99222e2 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -254,19 +254,28 @@
 #define SPRN_HRMOR	0x139	/* Real mode offset register */
 #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
+/* HFSCR and FSCR bit numbers are the same */
+#define FSCR_TAR_LG	8	/* Enable Target Address Register */
+#define FSCR_EBB_LG	7	/* Enable Event Based Branching */
+#define FSCR_TM_LG	5	/* Enable Transactional Memory */
+#define FSCR_PM_LG	4	/* Enable prob/priv access to PMU SPRs */
+#define FSCR_BHRB_LG	3	/* Enable Branch History Rolling Buffer*/
+#define FSCR_DSCR_LG	2	/* Enable Data Stream Control Register */
+#define FSCR_VECVSX_LG	1	/* Enable VMX/VSX  */
+#define FSCR_FP_LG	0	/* Enable Floating Point */
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
-#define   FSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
-#define   FSCR_EBB	(1 << (63-56)) /* Enable Event Based Branching */
-#define   FSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
+#define   FSCR_TAR	__MASK(FSCR_TAR_LG)
+#define   FSCR_EBB	__MASK(FSCR_EBB_LG)
+#define   FSCR_DSCR	__MASK(FSCR_DSCR_LG)
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
-#define   HFSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
-#define   HFSCR_EBB	(1 << (63-56)) /* Enable Event Based Branching */
-#define   HFSCR_TM	(1 << (63-58)) /* Enable Transactional Memory */
-#define   HFSCR_PM	(1 << (63-60)) /* Enable prob/priv access to PMU SPRs */
-#define   HFSCR_BHRB	(1 << (63-59)) /* Enable Branch History Rolling Buffer*/
-#define   HFSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
-#define   HFSCR_VECVSX	(1 << (63-62)) /* Enable VMX/VSX  */
-#define   HFSCR_FP	(1 << (63-63)) /* Enable Floating Point */
+#define   HFSCR_TAR	__MASK(FSCR_TAR_LG)
+#define   HFSCR_EBB	__MASK(FSCR_EBB_LG)
+#define   HFSCR_TM	__MASK(FSCR_TM_LG)
+#define   HFSCR_PM	__MASK(FSCR_PM_LG)
+#define   HFSCR_BHRB	__MASK(FSCR_BHRB_LG)
+#define   HFSCR_DSCR	__MASK(FSCR_DSCR_LG)
+#define   HFSCR_VECVSX	__MASK(FSCR_VECVSX_LG)
+#define   HFSCR_FP	__MASK(FSCR_FP_LG)
 #define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
 #define   LPCR_VPM0	(1ul << (63-0))
-- 
1.8.1.2
