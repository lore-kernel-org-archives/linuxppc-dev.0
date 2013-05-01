Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc: Turn on the EBB H/FSCR bits
Date: Wed,  1 May 2013 16:17:03 +1000
Message-Id: <1367389024-20391-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1367389024-20391-1-git-send-email-mikey@neuling.org>
References: <1367389024-20391-1-git-send-email-mikey@neuling.org>
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

This turns Event Based Branching (EBB) on in the Hypervisor Facility Status and
Control Register (HFSCR) and Facility Status and Control Register (FSCR).

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h        |    2 ++
 arch/powerpc/kernel/cpu_setup_power.S |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0b1ea1f..cd241ed 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -267,9 +267,11 @@
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
 #define   FSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
+#define   FSCR_EBB	(1 << (63-56)) /* Enable Event Based Branching */
 #define   FSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
 #define   HFSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
+#define   HFSCR_EBB	(1 << (63-56)) /* Enable Event Based Branching */
 #define   HFSCR_TM	(1 << (63-58)) /* Enable Transactional Memory */
 #define   HFSCR_BHRB	(1 << (63-59)) /* Enable Branch History Rolling Buffer */
 #define   HFSCR_PM	(1 << (63-60)) /* Enable prob/priv access to PMU SPRs */
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 256766d..2df2276 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -123,13 +123,13 @@ __init_LPCR:
 
 __init_FSCR:
 	mfspr	r3,SPRN_FSCR
-	ori	r3,r3,FSCR_TAR|FSCR_DSCR
+	ori	r3,r3,FSCR_TAR|FSCR_EBB|FSCR_DSCR
 	mtspr	SPRN_FSCR,r3
 	blr
 
 __init_HFSCR:
 	mfspr	r3,SPRN_HFSCR
-	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_BHRB|\
+	ori	r3,r3,HFSCR_TAR|HFSCR_EBB|HFSCR_TM|HFSCR_BHRB|\
 				HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP
 	mtspr	SPRN_HFSCR,r3
 	blr
-- 
1.7.10.4
