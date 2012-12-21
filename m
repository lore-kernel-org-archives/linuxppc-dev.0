Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/7] powerpc: Add the DAWR support to the set_break()
Date: Fri, 21 Dec 2012 11:06:45 +1100
Message-Id: <1356048405-20560-8-git-send-email-mikey@neuling.org>
In-Reply-To: <1356048405-20560-1-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
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

This adds DAWR supoprt to the set_break().

It does both bare metal and PAPR versions of setting the DAWR.

There is still some work we can do to make full use of the watchpoint but that
will come later.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/machdep.h     |    4 ++++
 arch/powerpc/kernel/process.c          |   23 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |   12 ++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 19d9d96..3d6b410 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -180,6 +180,10 @@ struct machdep_calls {
 	int		(*set_dabr)(unsigned long dabr,
 				    unsigned long dabrx);
 
+	/* Set DAWR for this platform, leave empty for default implemenation */
+	int		(*set_dawr)(unsigned long dawr,
+				    unsigned long dawrx);
+
 #ifdef CONFIG_PPC32	/* XXX for now */
 	/* A general init function, called by ppc_init in init/main.c.
 	   May be NULL. */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5a64028..fec5f46 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -412,10 +412,33 @@ static inline int set_dabr(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
+static inline int set_dawr(struct arch_hw_breakpoint *brk)
+{
+	unsigned long dawr, dawrx;
+
+	dawr = brk->address;
+
+	dawrx  = (brk->type & (HW_BRK_TYPE_READ | HW_BRK_TYPE_WRITE)) \
+		                   << (63 - 58); //* read/write bits */
+	dawrx |= ((brk->type & (HW_BRK_TYPE_TRANSLATE)) >> 2) \
+		                   << (63 - 59); //* translate */
+	dawrx |= (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
+		                   >> 3; //* PRIM bits */
+
+	if (ppc_md.set_dawr)
+		return ppc_md.set_dawr(dawr, dawrx);
+	mtspr(SPRN_DAWR, dawr);
+	mtspr(SPRN_DAWRX, dawrx);
+	return 0;
+}
+
 int set_break(struct arch_hw_breakpoint *brk)
 {
 	__get_cpu_var(current_brk) = *brk;
 
+	if (cpu_has_feature(CPU_FTR_DAWR))
+		return set_dawr(brk);
+
 	return set_dabr(brk);
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1890730..b1f60d1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -65,6 +65,7 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <asm/eeh.h>
+#include <asm/reg.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -500,6 +501,14 @@ static int pseries_set_xdabr(unsigned long dabr, unsigned long dabrx)
 	return plpar_hcall_norets(H_SET_XDABR, dabr, dabrx);
 }
 
+static int pseries_set_dawr(unsigned long dawr, unsigned long dawrx)
+{
+	/* PAPR says we can't set HYP */
+	dawrx &= ~DAWRX_HYP;
+
+	return  plapr_set_watchpoint0(dawr, dawrx);
+}
+
 #define CMO_CHARACTERISTICS_TOKEN 44
 #define CMO_MAXLENGTH 1026
 
@@ -606,6 +615,9 @@ static void __init pSeries_init_early(void)
 	else if (firmware_has_feature(FW_FEATURE_DABR))
 		ppc_md.set_dabr = pseries_set_dabr;
 
+	if (firmware_has_feature(FW_FEATURE_SET_MODE))
+		ppc_md.set_dawr = pseries_set_dawr;
+
 	pSeries_cmo_feature_init();
 	iommu_init_early_pSeries();
 
-- 
1.7.10.4
