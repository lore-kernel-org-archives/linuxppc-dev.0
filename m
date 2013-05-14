Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 3/3] powerpc/perf: Fix setting of "to" addresses for BHRB
Date: Tue, 14 May 2013 14:44:58 +1000
Message-Id: <1368506698-22400-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1368506698-22400-1-git-send-email-mikey@neuling.org>
References: <1368506698-22400-1-git-send-email-mikey@neuling.org>
In-Reply-To: <9911.1368179795@ale.ozlabs.ibm.com>
References: <9911.1368179795@ale.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we only set the "to" address in the branch stack when the CPU
explicitly gives us a value.  Unfortunately it only does this for XL form
branches (eg blr, bctr, bctar) and not I and B form branches (eg b, bc).

Fortunately if we read the instruction from memory we can extract the offset of
a branch and calculate the target address.

This adds a function power_pmu_bhrb_to() to calculate the target/to address of
the corresponding I and B form branches.  It handles branches in both user and
kernel spaces.  It also plumbs this into the perf brhb reading code.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/perf/core-book3s.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3fdfe45..426180b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -13,11 +13,13 @@
 #include <linux/perf_event.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/uaccess.h>
 #include <asm/reg.h>
 #include <asm/pmc.h>
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
+#include <asm/code-patching.h>
 
 #define BHRB_MAX_ENTRIES	32
 #define BHRB_TARGET		0x0000000000000002
@@ -362,6 +364,32 @@ void power_pmu_flush_branch_stack(void)
 	if (ppmu->bhrb_nr)
 		power_pmu_bhrb_reset();
 }
+/* Calculate the to address for a branch */
+static __u64 power_pmu_bhrb_to(u64 addr)
+{
+	unsigned int instr;
+	int ret;
+	__u64 target;
+
+	if (is_kernel_addr(addr))
+		return branch_target((unsigned int *)addr);
+
+	/* Userspace: need copy instruction here then translate it */
+	pagefault_disable();
+	ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
+	if (ret) {
+		pagefault_enable();
+		return 0;
+	}
+	pagefault_enable();
+
+	target = branch_target(&instr);
+	if ((!target) || (instr & BRANCH_ABSOLUTE))
+		return target;
+
+	/* Translate relative branch target from kernel to user address */
+	return target - (unsigned long)&instr + addr;
+}
 
 /* Processing BHRB entries */
 void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
@@ -426,7 +454,8 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 				/* Branches to immediate field 
 				   (ie I or B form) */
 				cpuhw->bhrb_entries[u_index].from = addr;
-				cpuhw->bhrb_entries[u_index].to = 0;
+				cpuhw->bhrb_entries[u_index].to =
+					power_pmu_bhrb_to(addr);
 				cpuhw->bhrb_entries[u_index].mispred = pred;
 				cpuhw->bhrb_entries[u_index].predicted = ~pred;
 			}
-- 
1.7.10.4
