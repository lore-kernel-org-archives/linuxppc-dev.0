Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Move perf core & PMU code into a subdirectory
Date: Tue, 21 Feb 2012 14:02:09 +1100
Message-Id: <1329793329-22549-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1329790742-19308-1-git-send-email-michael@ellerman.id.au>
References: <1329790742-19308-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf code has grown a lot since it started, and is big enough to
warrant its own subdirectory. For reference it's ~60% bigger than the
oprofile code. It declutters the kernel directory, makes it simpler to
grep for "just perf stuff", and allows us to shorten some filenames.

While we're at it, make it more obvious that we have two implementations
of the core perf logic. One for (roughly) Book3S CPUs, which was the
original implementation, and the other for Freescale embedded CPUs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Resent with -M to make the moves look nicer.

 arch/powerpc/Makefile                              |    1 +
 arch/powerpc/kernel/Makefile                       |    9 ---------
 arch/powerpc/perf/Makefile                         |   14 ++++++++++++++
 .../{kernel/perf_callchain.c => perf/callchain.c}  |    2 +-
 .../{kernel/perf_event.c => perf/core-book3s.c}    |    0
 .../perf_event_fsl_emb.c => perf/core-fsl-emb.c}   |    0
 arch/powerpc/{kernel => perf}/e500-pmu.c           |    0
 arch/powerpc/{kernel => perf}/mpc7450-pmu.c        |    0
 arch/powerpc/{kernel => perf}/power4-pmu.c         |    0
 arch/powerpc/{kernel => perf}/power5+-pmu.c        |    0
 arch/powerpc/{kernel => perf}/power5-pmu.c         |    0
 arch/powerpc/{kernel => perf}/power6-pmu.c         |    2 +-
 arch/powerpc/{kernel => perf}/power7-pmu.c         |    0
 arch/powerpc/{kernel => perf}/ppc970-pmu.c         |    2 +-
 14 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/perf/Makefile
 rename arch/powerpc/{kernel/perf_callchain.c => perf/callchain.c} (99%)
 rename arch/powerpc/{kernel/perf_event.c => perf/core-book3s.c} (100%)
 rename arch/powerpc/{kernel/perf_event_fsl_emb.c => perf/core-fsl-emb.c} (100%)
 rename arch/powerpc/{kernel => perf}/e500-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/mpc7450-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/power4-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/power5+-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/power5-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/power6-pmu.c (99%)
 rename arch/powerpc/{kernel => perf}/power7-pmu.c (100%)
 rename arch/powerpc/{kernel => perf}/ppc970-pmu.c (99%)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b8b105c..6524c6e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -157,6 +157,7 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/net/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
+core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ee728e4..e373ce3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -113,15 +113,6 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
-obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
-
-obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
-obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
-				   power5+-pmu.o power6-pmu.o power7-pmu.o
-obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
-
-obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
-obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
 
 obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
 
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
new file mode 100644
index 0000000..af3fac2
--- /dev/null
+++ b/arch/powerpc/perf/Makefile
@@ -0,0 +1,14 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
+obj-$(CONFIG_PERF_EVENTS)	+= callchain.o
+
+obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
+obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
+				   power5+-pmu.o power6-pmu.o power7-pmu.o
+obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
+
+obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
+obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
+
+obj-$(CONFIG_PPC64)		+= $(obj64-y)
+obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/kernel/perf_callchain.c b/arch/powerpc/perf/callchain.c
similarity index 99%
rename from arch/powerpc/kernel/perf_callchain.c
rename to arch/powerpc/perf/callchain.c
index 564c1d8..e8a18d1 100644
--- a/arch/powerpc/kernel/perf_callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -20,7 +20,7 @@
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
 #ifdef CONFIG_PPC64
-#include "ppc32.h"
+#include "../kernel/ppc32.h"
 #endif
 
 
diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/perf/core-book3s.c
similarity index 100%
rename from arch/powerpc/kernel/perf_event.c
rename to arch/powerpc/perf/core-book3s.c
diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/perf/core-fsl-emb.c
similarity index 100%
rename from arch/powerpc/kernel/perf_event_fsl_emb.c
rename to arch/powerpc/perf/core-fsl-emb.c
diff --git a/arch/powerpc/kernel/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/e500-pmu.c
rename to arch/powerpc/perf/e500-pmu.c
diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/mpc7450-pmu.c
rename to arch/powerpc/perf/mpc7450-pmu.c
diff --git a/arch/powerpc/kernel/power4-pmu.c b/arch/powerpc/perf/power4-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/power4-pmu.c
rename to arch/powerpc/perf/power4-pmu.c
diff --git a/arch/powerpc/kernel/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/power5+-pmu.c
rename to arch/powerpc/perf/power5+-pmu.c
diff --git a/arch/powerpc/kernel/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/power5-pmu.c
rename to arch/powerpc/perf/power5-pmu.c
diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
similarity index 99%
rename from arch/powerpc/kernel/power6-pmu.c
rename to arch/powerpc/perf/power6-pmu.c
index 0bbc901..31128e0 100644
--- a/arch/powerpc/kernel/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -131,7 +131,7 @@ static u32 marked_bus_events[16] = {
 	0x00000022,	/* BFP set 2: byte 0 bits 1, 5 */
 	0, 0
 };
-	
+
 /*
  * Returns 1 if event counts things relating to marked instructions
  * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
similarity index 100%
rename from arch/powerpc/kernel/power7-pmu.c
rename to arch/powerpc/perf/power7-pmu.c
diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
similarity index 99%
rename from arch/powerpc/kernel/ppc970-pmu.c
rename to arch/powerpc/perf/ppc970-pmu.c
index 8c21902..111eb25 100644
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -252,7 +252,7 @@ static int p970_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 		alt[1] = event ^ 0x1000;
 		return 2;
 	}
-		
+
 	return 1;
 }
 
-- 
1.7.5.4
