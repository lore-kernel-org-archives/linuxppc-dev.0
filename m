Return-Path: <michael@ozlabs.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 12 Oct 2006 22:03:08 +1000
Subject: [PATCH 1/2] Add support for stopping spus from xmon
In-Reply-To: <1160654587.449977.520618728447.qpush@concordia>
Message-Id: <20061012120310.6B5A967BD5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for stopping, and restarting, spus
from xmon. We use the spu master runcntl bit to stop execution,
this is apparently the "right" way to control spu execution and
spufs will be changed in the future to use this bit.

Testing has shown that to restart execution we have to turn the
master runcntl bit on and also rewrite the spu runcntl bit, even
if it is already set to 1 (running).

Stopping spus is triggered by the xmon command 'ss' - "spus stop"
perhaps. Restarting them is triggered via 'sr'. Restart doesn't
start execution on spus unless they were running prior to being
stopped by xmon.

Walking the spu->full_list in xmon after a panic, would mean
corruption of any spu struct would make all the others
inaccessible. To avoid this, and also to make the next patch
easier, we cache pointers to all spus during boot.

We attempt to catch and recover from errors while stopping and
restarting the spus, but as with most xmon functionality there are
no guarantees that performing these operations won't crash xmon
itself.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/cell/spu_base.c |    4 
 arch/powerpc/xmon/xmon.c               |  142 ++++++++++++++++++++++++++++++++-
 include/asm-powerpc/xmon.h             |    2 
 3 files changed, 146 insertions(+), 2 deletions(-)

Index: to-merge/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/cell/spu_base.c
+++ to-merge/arch/powerpc/platforms/cell/spu_base.c
@@ -38,6 +38,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/mmu_context.h>
+#include <asm/xmon.h>
 
 #include "interrupt.h"
 
@@ -914,6 +915,9 @@ static int __init init_spu_base(void)
 			break;
 		}
 	}
+
+	xmon_register_spus(&spu_full_list);
+
 	return ret;
 }
 module_init(init_spu_base);
Index: to-merge/arch/powerpc/xmon/xmon.c
===================================================================
--- to-merge.orig/arch/powerpc/xmon/xmon.c
+++ to-merge/arch/powerpc/xmon/xmon.c
@@ -35,6 +35,8 @@
 #include <asm/rtas.h>
 #include <asm/sstep.h>
 #include <asm/bug.h>
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -145,6 +147,8 @@ static void xmon_print_symbol(unsigned l
 			      const char *after);
 static const char *getvecname(unsigned long vec);
 
+static int do_spu_cmd(void);
+
 int xmon_no_auto_backtrace;
 
 extern int print_insn_powerpc(unsigned long, unsigned long, int);
@@ -207,8 +211,12 @@ Commands:\n\
   mi	show information about memory allocation\n\
   p 	call a procedure\n\
   r	print registers\n\
-  s	single step\n\
-  S	print special registers\n\
+  s	single step\n"
+#ifdef CONFIG_PPC_CELL
+"  ss	stop execution on all spus\n\
+  sr	restore execution on stopped spus\n"
+#endif
+"  S	print special registers\n\
   t	print backtrace\n\
   x	exit monitor and recover\n\
   X	exit monitor and dont recover\n"
@@ -516,6 +524,7 @@ int xmon(struct pt_regs *excp)
 		xmon_save_regs(&regs);
 		excp = &regs;
 	}
+
 	return xmon_core(excp, 0);
 }
 EXPORT_SYMBOL(xmon);
@@ -808,6 +817,8 @@ cmds(struct pt_regs *excp)
 			cacheflush();
 			break;
 		case 's':
+			if (do_spu_cmd() == 0)
+				break;
 			if (do_step(excp))
 				return cmd;
 			break;
@@ -2630,3 +2641,130 @@ void __init xmon_setup(void)
 	if (xmon_early)
 		debugger(NULL);
 }
+
+#ifdef CONFIG_PPC_CELL
+
+struct spu_info {
+	struct spu *spu;
+	u64 saved_mfc_sr1_RW;
+	u32 saved_spu_runcntl_RW;
+	u8 stopped_ok;
+};
+
+#define XMON_NUM_SPUS	16	/* Enough for current hardware */
+
+static struct spu_info spu_info[XMON_NUM_SPUS];
+
+void xmon_register_spus(struct list_head *list)
+{
+	struct spu *spu;
+
+	list_for_each_entry(spu, list, full_list) {
+		if (spu->number >= XMON_NUM_SPUS) {
+			WARN_ON(1);
+			continue;
+		}
+
+		spu_info[spu->number].spu = spu;
+		spu_info[spu->number].stopped_ok = 0;
+	}
+}
+
+static void stop_spus(void)
+{
+	struct spu *spu;
+	int i;
+	u64 tmp;
+
+	for (i = 0; i < XMON_NUM_SPUS; i++) {
+		if (!spu_info[i].spu)
+			continue;
+
+		if (setjmp(bus_error_jmp) == 0) {
+			catch_memory_errors = 1;
+			sync();
+
+			spu = spu_info[i].spu;
+
+			spu_info[i].saved_spu_runcntl_RW =
+				in_be32(&spu->problem->spu_runcntl_RW);
+
+			tmp = spu_mfc_sr1_get(spu);
+			spu_info[i].saved_mfc_sr1_RW = tmp;
+
+			tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+			spu_mfc_sr1_set(spu, tmp);
+
+			sync();
+			__delay(200);
+
+			spu_info[i].stopped_ok = 1;
+			printf("Stopped spu %.2d\n", i);
+		} else {
+			catch_memory_errors = 0;
+			printf("*** Error stopping spu %.2d\n", i);
+		}
+		catch_memory_errors = 0;
+	}
+}
+
+static void restart_spus(void)
+{
+	struct spu *spu;
+	int i;
+
+	for (i = 0; i < XMON_NUM_SPUS; i++) {
+		if (!spu_info[i].spu)
+			continue;
+
+		if (!spu_info[i].stopped_ok) {
+			printf("*** Error, spu %d was not successfully stopped"
+					", not restarting\n", i);
+			continue;
+		}
+
+		if (setjmp(bus_error_jmp) == 0) {
+			catch_memory_errors = 1;
+			sync();
+
+			spu = spu_info[i].spu;
+			spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
+			out_be32(&spu->problem->spu_runcntl_RW,
+					spu_info[i].saved_spu_runcntl_RW);
+
+			sync();
+			__delay(200);
+
+			printf("Restarted spu %.2d\n", i);
+		} else {
+			catch_memory_errors = 0;
+			printf("*** Error restarting spu %.2d\n", i);
+		}
+		catch_memory_errors = 0;
+	}
+}
+
+static int do_spu_cmd(void)
+{
+	int cmd;
+
+	cmd = inchar();
+	switch (cmd) {
+	case 's':
+		stop_spus();
+		break;
+	case 'r':
+		restart_spus();
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+#else /* ! CONFIG_PPC_CELL */
+static int do_spu_cmd(void)
+{
+	return -1;
+}
+#endif
Index: to-merge/include/asm-powerpc/xmon.h
===================================================================
--- to-merge.orig/include/asm-powerpc/xmon.h
+++ to-merge/include/asm-powerpc/xmon.h
@@ -14,8 +14,10 @@
 
 #ifdef CONFIG_XMON
 extern void xmon_setup(void);
+extern void xmon_register_spus(struct list_head *list);
 #else
 static inline void xmon_setup(void) { };
+static inline void xmon_register_spus(struct list_head *list) { };
 #endif
 
 #endif /* __KERNEL __ */
