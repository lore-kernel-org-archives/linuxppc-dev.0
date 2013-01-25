Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc: Change hardware breakpoint to allow longer ranges
Date: Fri, 25 Jan 2013 12:02:59 +1100
Message-Id: <1359075779-27492-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1359075779-27492-1-git-send-email-mikey@neuling.org>
References: <1359075779-27492-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the hardware breakpoint code so that we can support wider ranged
breakpoints.

This means both ptrace and perf hardware breakpoints can use upto 512 byte long
breakpoints when using the DAWR and only 8 byte when using the DABR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h |    2 --
 arch/powerpc/kernel/hw_breakpoint.c      |   12 ++++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 96437e5..eb0f4ac 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -57,8 +57,6 @@ struct pmu;
 struct perf_sample_data;
 
 #define HW_BREAKPOINT_ALIGN 0x7
-/* Maximum permissible length of any HW Breakpoint */
-#define HW_BREAKPOINT_LEN 0x8
 
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 2a3e8dd..a949bdf 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -142,7 +142,7 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
  */
 int arch_validate_hwbkpt_settings(struct perf_event *bp)
 {
-	int ret = -EINVAL;
+	int ret = -EINVAL, length_max;
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
 	if (!bp)
@@ -171,8 +171,16 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
 	 * 'symbolsize' should satisfy the check below.
 	 */
+	length_max = 8; /* DABR */
+	if (cpu_has_feature(CPU_FTR_DAWR)) {
+		length_max = 512 ; /* 64 doublewords */
+		/* DAWR region can't cross 512 boundary */
+		if ((bp->attr.bp_addr >> 10) != 
+		    ((bp->attr.bp_addr + bp->attr.bp_len) >> 10))
+			return -EINVAL;
+	}
 	if (info->len >
-	    (HW_BREAKPOINT_LEN - (info->address & HW_BREAKPOINT_ALIGN)))
+	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
 		return -EINVAL;
 	return 0;
 }
-- 
1.7.10.4
