Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc: Setup in HFSCR for POWER8
Date: Wed,  6 Mar 2013 14:35:24 +1100
Message-Id: <1362540924-15253-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1362540924-15253-1-git-send-email-mikey@neuling.org>
References: <1362540924-15253-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Setup the HFSCR (Hypervisor Facility Status and Control Register) for POWER8
when running HV=1.  The HFSCR is the same as the FSCR except it's for
hypervisors.  It controls the available of various facilities in OS and
userspace levels.  It also indicates the cause of a hypervisor facility
unavailable interrupt (although we are not using this here).

This patch sets the facilities Linux knows about incase the firmware doesn't.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index ea847ab..2e6ad11 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -57,6 +57,7 @@ _GLOBAL(__setup_cpu_power8)
 	mfspr	r3,SPRN_LPCR
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
+	bl	__init_HFSCR
 	bl	__init_TLB
 	mtlr	r11
 	blr
@@ -72,6 +73,7 @@ _GLOBAL(__restore_cpu_power8)
 	mfspr   r3,SPRN_LPCR
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
+	bl	__init_HFSCR
 	bl	__init_TLB
 	mtlr	r11
 	blr
@@ -120,6 +122,12 @@ __init_FSCR:
 	mtspr	SPRN_FSCR,r3
 	blr
 
+__init_HFSCR:
+	mfspr	r3,SPRN_HFSCR
+	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP
+	mtspr	SPRN_HFSCR,r3
+	blr
+
 __init_TLB:
 	/* Clear the TLB */
 	li	r6,128
-- 
1.7.10.4
