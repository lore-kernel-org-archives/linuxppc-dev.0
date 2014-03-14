Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 02/20] powerpc/perf: Define perf_event_print_debug() to print
 PMU register values
Date: Fri, 14 Mar 2014 16:00:27 +1100
Message-Id: <1394773245-18328-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Currently the sysrq ShowRegs command does not print any PMU registers as
we have an empty definition for perf_event_print_debug(). This patch
defines perf_event_print_debug() to print various PMU registers.

Example output:

CPU: 0 PMU registers, ppmu = POWER7 n_counters = 6
PMC1:  00000000 PMC2: 00000000 PMC3: 00000000 PMC4: 00000000
PMC5:  00000000 PMC6: 00000000 PMC7: deadbeef PMC8: deadbeef
MMCR0: 0000000080000000 MMCR1: 0000000000000000 MMCRA: 0f00000001000000
SIAR:  0000000000000000 SDAR:  0000000000000000 SIER:  0000000000000000

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[mpe: Fix 32 bit build and rework formatting for compactness]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h |  1 +
 arch/powerpc/perf/core-book3s.c              | 55 ++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 3fd2f1b..9ed73714 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <uapi/asm/perf_event.h>
 
+/* Update perf_event_print_debug() if this changes */
 #define MAX_HWEVENTS		8
 #define MAX_EVENT_ALTERNATIVES	8
 #define MAX_LIMITED_HWCOUNTERS	2
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 67cf220..704d1c5 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -563,10 +563,6 @@ out:
 
 static void perf_event_interrupt(struct pt_regs *regs);
 
-void perf_event_print_debug(void)
-{
-}
-
 /*
  * Read one performance monitor counter (PMC).
  */
@@ -645,6 +641,57 @@ static void write_pmc(int idx, unsigned long val)
 	}
 }
 
+/* Called from sysrq_handle_showregs() */
+void perf_event_print_debug(void)
+{
+	unsigned long sdar, sier, flags;
+	u32 pmcs[MAX_HWEVENTS];
+	int i;
+
+	if (!ppmu->n_counter)
+		return;
+
+	local_irq_save(flags);
+
+	pr_info("CPU: %d PMU registers, ppmu = %s n_counters = %d",
+		 smp_processor_id(), ppmu->name, ppmu->n_counter);
+
+	for (i = 0; i < ppmu->n_counter; i++)
+		pmcs[i] = read_pmc(i + 1);
+
+	for (; i < MAX_HWEVENTS; i++)
+		pmcs[i] = 0xdeadbeef;
+
+	pr_info("PMC1:  %08x PMC2: %08x PMC3: %08x PMC4: %08x\n",
+		 pmcs[0], pmcs[1], pmcs[2], pmcs[3]);
+
+	if (ppmu->n_counter > 4)
+		pr_info("PMC5:  %08x PMC6: %08x PMC7: %08x PMC8: %08x\n",
+			 pmcs[4], pmcs[5], pmcs[6], pmcs[7]);
+
+	pr_info("MMCR0: %016lx MMCR1: %016lx MMCRA: %016lx\n",
+		mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCRA));
+
+	sdar = sier = 0;
+#ifdef CONFIG_PPC64
+	sdar = mfspr(SPRN_SDAR);
+
+	if (ppmu->flags & PPMU_HAS_SIER)
+		sier = mfspr(SPRN_SIER);
+
+	if (ppmu->flags & PPMU_EBB) {
+		pr_info("MMCR2: %016lx EBBHR: %016lx\n",
+			mfspr(SPRN_MMCR2), mfspr(SPRN_EBBHR));
+		pr_info("EBBRR: %016lx BESCR: %016lx\n",
+			mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
+	}
+#endif
+	pr_info("SIAR:  %016lx SDAR:  %016lx SIER:  %016lx\n",
+		mfspr(SPRN_SIAR), sdar, sier);
+
+	local_irq_restore(flags);
+}
+
 /*
  * Check if a set of events can all go on the PMU at once.
  * If they can't, this will look at alternative codes for the events
-- 
1.8.3.2
