Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: Fix setting FSCR for HV=0 and on secondary CPUs
Date: Tue,  5 Mar 2013 16:45:50 +1100
Message-Id: <1362462352-12009-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1362462352-12009-1-git-send-email-mikey@neuling.org>
References: <1362462352-12009-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we only set the FSCR (Facility Status and Control Register) when HV=1
but this feature is available when HV=0 also.  This patch sets FSCR when HV=0.

Also, we currently only set the FSCR on the master CPU.  This patch also sets
the FSCR on secondary CPUs.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/cpu_setup_power.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index d29facb..bb2d203 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -48,6 +48,7 @@ _GLOBAL(__restore_cpu_power7)
 
 _GLOBAL(__setup_cpu_power8)
 	mflr	r11
+	bl	__init_FSCR
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -56,13 +57,13 @@ _GLOBAL(__setup_cpu_power8)
 	mfspr	r3,SPRN_LPCR
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
-	bl	__init_FSCR
 	bl	__init_TLB
 	mtlr	r11
 	blr
 
 _GLOBAL(__restore_cpu_power8)
 	mflr	r11
+	bl	__init_FSCR
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	beqlr
-- 
1.7.10.4
