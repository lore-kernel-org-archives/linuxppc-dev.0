Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57AF41A0282
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 21:09:07 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE2DF1401DC
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 21:09:05 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 15:39:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 49B28E005C
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 15:39:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPA8jt436700164
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 15:38:47 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPA8mP2017853
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 15:38:49 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RESEND PATCH V3] powerpc,
 xmon: Enable HW instruction breakpoint on POWER8
Date: Tue, 25 Nov 2014 15:38:48 +0530
Message-Id: <1416910128-23466-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for hardware instruction breakpoints
on POWER8 with the help of a new register CIABR (Completed
Instruction Address Breakpoint Register). With this patch, single
hardware instruction breakpoint can be added and cleared during
any active xmon debug session. This hardware based instruction
breakpoint mechanism works correctly along with the existing TRAP
based instruction breakpoints available on xmon.

With this new patch, we would be able to interact with xmon debugger
as demonstrated in the following sample debug session.
-----------------------------
(A) Start xmon session:
$echo x > /proc/sysrq-trigger
SysRq : Entering xmon
cpu 0x0: Vector: 0  at [c000001f6c67f960]
    pc: c000000000072078: .sysrq_handle_xmon+0x58/0x60
    lr: c000000000072078: .sysrq_handle_xmon+0x58/0x60
    sp: c000001f6c67fac0
   msr: 9000000000009032
  current = 0xc000001f6e709ac0
  paca    = 0xc00000000fffa000 softe: 0 irq_happened: 0x00
    pid   = 3250, comm = bash
enter ? for help
0:mon> b
   type            address

(B) Set one HW instruction breakpoint:
0:mon> ls .power_pmu_add
.power_pmu_add: c000000000078f50
0:mon> bi c000000000078f50
0:mon> b
   type            address
 1 inst   c000000000078f50  .power_pmu_add+0x0/0x2e0
0:mon> ls .perf_event_interrupt
.perf_event_interrupt: c00000000007aee0
0:mon> bi c00000000007aee0
One instruction breakpoint possible with CIABR [as expected]
0:mon> x

(C) Run the sampple workload [with the breakpoint in place]:
$./perf record ls
cpu 0x2: Vector: d00 (Single Step) at [c000001f718133a0]
    pc: c000000000078f54: .power_pmu_add+0x4/0x2e0
    lr: c000000000155be0: .event_sched_in+0x90/0x1d0
    sp: c000001f71813620
   msr: 9000000040109032
  current = 0xc000001f6ce30000
  paca    = 0xc00000000fffa600 softe: 0 irq_happened: 0x01
    pid   = 3270, comm = ls
        std     r22,-80(r1)
enter ? for help

(D) Clear the breakpoint:
2:mon> bc
All breakpoints cleared
2:mon> x
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (~66 samples) ]

(E) Run the workload again [without any breakpoints]:
$./perf record ls
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (~61 samples) ]

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V3:
- Moved the 'ciabr_used' early init inside 'cmds' function
- Some minor code cleanup
- Added more in-code documentation
- Changed the commit message

Changes in V2: (http://patchwork.ozlabs.org/patch/373114/)
- Fixed the compilation problem in 32 bit archs
- Selective inclusion of plapr_set_ciabr for required platforms
- Cleaned up the white space issues

 arch/powerpc/include/asm/xmon.h |  6 +++
 arch/powerpc/xmon/xmon.c        | 83 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
index 5eb8e59..5d17aec 100644
--- a/arch/powerpc/include/asm/xmon.h
+++ b/arch/powerpc/include/asm/xmon.h
@@ -29,5 +29,11 @@ static inline void xmon_register_spus(struct list_head *list) { };
 extern int cpus_are_in_xmon(void);
 #endif
 
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_SPLPAR)
+#include <asm/plpar_wrappers.h>
+#else
+static inline long plapr_set_ciabr(unsigned long ciabr) {return 0; };
+#endif
+
 #endif /* __KERNEL __ */
 #endif /* __ASM_POWERPC_XMON_H */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b988b5a..c2f601a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -90,6 +90,7 @@ struct bpt {
 /* Bits in bpt.enabled */
 #define BP_IABR_TE	1		/* IABR translation enabled */
 #define BP_IABR		2
+#define BP_CIABR	4
 #define BP_TRAP		8
 #define BP_DABR		0x10
 
@@ -98,6 +99,7 @@ static struct bpt bpts[NBPTS];
 static struct bpt dabr;
 static struct bpt *iabr;
 static unsigned bpinstr = 0x7fe00008;	/* trap */
+static bool ciabr_used;			/* CIABR instruction breakpoint */
 
 #define BP_NUM(bp)	((bp) - bpts + 1)
 
@@ -271,6 +273,55 @@ static inline void cinval(void *p)
 }
 
 /*
+ * write_ciabr
+ *
+ * This function writes a value to the
+ * CIARB register either directly through
+ * mtspr instruction if the kernel is in HV
+ * privilege mode or call a hypervisor function
+ * to achieve the same in case the kernel is in
+ * supervisor privilege mode.
+ */
+static void write_ciabr(unsigned long ciabr)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_CIABR, ciabr);
+		return;
+	}
+	plapr_set_ciabr(ciabr);
+}
+
+/*
+ * set_ciabr
+ *
+ * This function sets the correct privilege
+ * value into the the HW breakpoint address
+ * before writing it up in the CIABR register.
+ */
+static void set_ciabr(unsigned long addr)
+{
+	addr &= ~CIABR_PRIV;
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		addr |= CIABR_PRIV_HYPER;
+	else
+		addr |= CIABR_PRIV_SUPER;
+	write_ciabr(addr);
+}
+
+/*
+ * clear_ciabr
+ *
+ * This function clears the CIABR register
+ * which in turn removes the hardware
+ * instruction breakpoint from the CPU.
+ */
+static void clear_ciabr(void)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		write_ciabr(0);
+}
+
+/*
  * Disable surveillance (the service processor watchdog function)
  * while we are in xmon.
  * XXX we should re-enable it when we leave. :)
@@ -767,6 +818,9 @@ static void insert_cpu_bpts(void)
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
+
+	if (iabr && cpu_has_feature(CPU_FTR_ARCH_207S))
+		set_ciabr(iabr->address);
 }
 
 static void remove_bpts(void)
@@ -794,6 +848,7 @@ static void remove_cpu_bpts(void)
 	hw_breakpoint_disable();
 	if (cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, 0);
+	clear_ciabr();
 }
 
 /* Command interpreting routine */
@@ -806,6 +861,7 @@ cmds(struct pt_regs *excp)
 
 	last_cmd = NULL;
 	xmon_regs = excp;
+	ciabr_used = false;
 
 	if (!xmon_no_auto_backtrace) {
 		xmon_no_auto_backtrace = 1;
@@ -1127,7 +1183,7 @@ static char *breakpoint_help_string =
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
     "bc               clear all breakpoints\n"
     "bc <n/addr>      clear breakpoint number n or at addr\n"
-    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
+    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64/POWER8 only)\n"
     "bd <addr> [cnt]  set hardware data breakpoint\n"
     "";
 
@@ -1166,11 +1222,21 @@ bpt_cmds(void)
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
-		if (!cpu_has_feature(CPU_FTR_IABR)) {
+		if (!cpu_has_feature(CPU_FTR_IABR) &&
+					!cpu_has_feature(CPU_FTR_ARCH_207S)) {
 			printf("Hardware instruction breakpoint "
 			       "not supported on this cpu\n");
 			break;
 		}
+
+		if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+			if (ciabr_used) {
+				printf("One instruction breakpoint "
+					"possible with CIABR\n");
+				break;
+			}
+		}
+
 		if (iabr) {
 			iabr->enabled &= ~(BP_IABR | BP_IABR_TE);
 			iabr = NULL;
@@ -1181,7 +1247,11 @@ bpt_cmds(void)
 			break;
 		bp = new_breakpoint(a);
 		if (bp != NULL) {
-			bp->enabled |= BP_IABR | BP_IABR_TE;
+			if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+				bp->enabled |= BP_CIABR;
+				ciabr_used = true;
+			} else
+				bp->enabled |= BP_IABR | BP_IABR_TE;
 			iabr = bp;
 		}
 		break;
@@ -1194,6 +1264,7 @@ bpt_cmds(void)
 				bpts[i].enabled = 0;
 			iabr = NULL;
 			dabr.enabled = 0;
+			ciabr_used = false;
 			printf("All breakpoints cleared\n");
 			break;
 		}
@@ -1210,6 +1281,9 @@ bpt_cmds(void)
 			}
 		}
 
+		if (bp->enabled & BP_CIABR)
+			ciabr_used = false;
+
 		printf("Cleared breakpoint %lx (", BP_NUM(bp));
 		xmon_print_symbol(bp->address, " ", ")\n");
 		bp->enabled = 0;
@@ -1238,7 +1312,8 @@ bpt_cmds(void)
 				if (!bp->enabled)
 					continue;
 				printf("%2x %s   ", BP_NUM(bp),
-				    (bp->enabled & BP_IABR)? "inst": "trap");
+					(bp->enabled & (BP_IABR | BP_CIABR))
+							? "inst" : "trap");
 				xmon_print_symbol(bp->address, "  ", "\n");
 			}
 			break;
-- 
1.9.3
