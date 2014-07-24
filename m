Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C28F81A01F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 14:37:22 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93891140184
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2014 14:37:22 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 14:37:14 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BCE802BB0023
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2014 14:37:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O4EP2T4915546
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2014 14:14:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O4bHmw018752
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2014 14:37:18 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] powerpc,
 xmon: Enable hardware instruction breakpoint support on POWER8
Date: Thu, 24 Jul 2014 10:07:15 +0530
Message-Id: <1406176635-13759-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for hardware instruction breakpoints on POWER8 with
the help of a new register called CIABR (Completed Instruction Address Breakpoint
Register). With this patch, single hardware instruction breakpoint can be added
and cleared during any active xmon debug session. This hardware based instruction
breakpoint mechanism works correctly along with the existing TRAP based instruction
breakpoints available on xmon. Example usage as follows.

(A) Start xmon:
$echo x > /proc/sysrq-trigger
SysRq : Entering xmon
cpu 0x0: Vector: 0  at [c000001f6c67f960]
    pc: c000000000072078: .sysrq_handle_xmon+0x58/0x60
    lr: c000000000072078: .sysrq_handle_xmon+0x58/0x60
    sp: c000001f6c67fac0
   msr: 9000000000009032
  current = 0xc000001f6e709ac0
  paca    = 0xc00000000fffa000   softe: 0        irq_happened: 0x00
    pid   = 3250, comm = bash
enter ? for help
0:mon> b
   type            address

(B) Set the breakpoint:
0:mon> ls .power_pmu_add
.power_pmu_add: c000000000078f50
0:mon> bi c000000000078f50
0:mon> b
   type            address
 1 inst   c000000000078f50  .power_pmu_add+0x0/0x2e0
0:mon> ls .perf_event_interrupt
.perf_event_interrupt: c00000000007aee0
0:mon> bi c00000000007aee0
One instruction breakpoint possible with CIABR
0:mon> x

(C) Run the workload (with the breakpoint):
$./perf record ls
cpu 0x2: Vector: d00 (Single Step) at [c000001f718133a0]
    pc: c000000000078f54: .power_pmu_add+0x4/0x2e0
    lr: c000000000155be0: .event_sched_in+0x90/0x1d0
    sp: c000001f71813620
   msr: 9000000040109032
  current = 0xc000001f6ce30000
  paca    = 0xc00000000fffa600   softe: 0        irq_happened: 0x01
    pid   = 3270, comm = ls
        std     r22,-80(r1)
enter ? for help

(D) Clear the breakpoint:
2:mon> bc
All breakpoints cleared
2:mon> x
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (~66 samples) ]

(E) Run the workload again (without any breakpoints):
$./perf record ls
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (~61 samples) ]

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:
- Fixed the compilation problem in 32 bit archs
- Selective inclusion of plapr_set_ciabr for required platforms
- Cleaned up the white space issues

v1: https://patchwork.ozlabs.org/patch/354108/

 arch/powerpc/include/asm/xmon.h |  6 +++++
 arch/powerpc/xmon/xmon.c        | 57 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 4 deletions(-)

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
index d199bfa..64f9a3b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -89,6 +89,7 @@ struct bpt {
 /* Bits in bpt.enabled */
 #define BP_IABR_TE	1		/* IABR translation enabled */
 #define BP_IABR		2
+#define BP_CIABR	4
 #define BP_TRAP		8
 #define BP_DABR		0x10
 
@@ -97,6 +98,7 @@ static struct bpt bpts[NBPTS];
 static struct bpt dabr;
 static struct bpt *iabr;
 static unsigned bpinstr = 0x7fe00008;	/* trap */
+static bool ciabr_used = false;		/* CIABR instruction breakpoint */
 
 #define BP_NUM(bp)	((bp) - bpts + 1)
 
@@ -269,6 +271,31 @@ static inline void cinval(void *p)
 	asm volatile ("dcbi 0,%0; icbi 0,%0" : : "r" (p));
 }
 
+static void write_ciabr(unsigned long ciabr)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_CIABR, ciabr);
+		return;
+	}
+	plapr_set_ciabr(ciabr);
+}
+
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
+static void clear_ciabr(void)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		write_ciabr(0);
+}
+
 /*
  * Disable surveillance (the service processor watchdog function)
  * while we are in xmon.
@@ -764,6 +791,9 @@ static void insert_cpu_bpts(void)
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
+
+	if (iabr && cpu_has_feature(CPU_FTR_ARCH_207S))
+		set_ciabr(iabr->address);
 }
 
 static void remove_bpts(void)
@@ -791,6 +821,7 @@ static void remove_cpu_bpts(void)
 	hw_breakpoint_disable();
 	if (cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, 0);
+	clear_ciabr();
 }
 
 /* Command interpreting routine */
@@ -1124,7 +1155,7 @@ static char *breakpoint_help_string =
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
     "bc               clear all breakpoints\n"
     "bc <n/addr>      clear breakpoint number n or at addr\n"
-    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
+    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64/POWER8 only)\n"
     "bd <addr> [cnt]  set hardware data breakpoint\n"
     "";
 
@@ -1163,11 +1194,20 @@ bpt_cmds(void)
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
-		if (!cpu_has_feature(CPU_FTR_IABR)) {
+		if (!cpu_has_feature(CPU_FTR_IABR) && !cpu_has_feature(CPU_FTR_ARCH_207S)) {
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
@@ -1178,7 +1218,11 @@ bpt_cmds(void)
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
@@ -1191,6 +1235,7 @@ bpt_cmds(void)
 				bpts[i].enabled = 0;
 			iabr = NULL;
 			dabr.enabled = 0;
+			ciabr_used = false;
 			printf("All breakpoints cleared\n");
 			break;
 		}
@@ -1207,6 +1252,9 @@ bpt_cmds(void)
 			}
 		}
 
+		if (bp->enabled & BP_CIABR)
+			ciabr_used = false;
+
 		printf("Cleared breakpoint %lx (", BP_NUM(bp));
 		xmon_print_symbol(bp->address, " ", ")\n");
 		bp->enabled = 0;
@@ -1235,7 +1283,8 @@ bpt_cmds(void)
 				if (!bp->enabled)
 					continue;
 				printf("%2x %s   ", BP_NUM(bp),
-				    (bp->enabled & BP_IABR)? "inst": "trap");
+					(bp->enabled & (BP_IABR | BP_CIABR)) ?
+								"inst" : "trap");
 				xmon_print_symbol(bp->address, "  ", "\n");
 			}
 			break;
-- 
1.9.3
