Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 667C12BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 04:10:34 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iB2HC0Ni028524
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Dec 2004 10:12:00 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by il06exr04.mot.com (Motorola/il06exr04) with ESMTP id iB2H93Qc003114
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Dec 2004 11:09:04 -0600
Date: Thu, 2 Dec 2004 11:10:18 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0412021107180.24029@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Fix prototypes & externs in e500 oprofile support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Remove prototypes and externs out of the .c files

Signed-off-by: Andy Fleming <afleming@freescale.com> 
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--


diff -Nru a/arch/ppc/kernel/perfmon_fsl_booke.c b/arch/ppc/kernel/perfmon_fsl_booke.c
--- a/arch/ppc/kernel/perfmon_fsl_booke.c	2004-12-02 10:44:03 -06:00
+++ b/arch/ppc/kernel/perfmon_fsl_booke.c	2004-12-02 10:44:03 -06:00
@@ -32,15 +32,7 @@
 #include <asm/io.h>
 #include <asm/reg.h>
 #include <asm/xmon.h>
-
-void init_pmc_stop(int ctr);
-void set_pmc_event(int ctr, int event);
-void set_pmc_user_kernel(int ctr, int user, int kernel);
-void set_pmc_marked(int ctr, int mark0, int mark1);
-void pmc_start_ctr(int ctr, int enable);
-void pmc_start_ctrs(int enable);
-void pmc_stop_ctrs(void);
-void dump_pmcs(void);
+#include <asm/perfmon.h>
 
 static inline u32 get_pmlca(int ctr);
 static inline void set_pmlca(int ctr, u32 pmlca);
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2004-12-02 10:44:03 -06:00
+++ b/arch/ppc/kernel/traps.c	2004-12-02 10:44:03 -06:00
@@ -41,6 +41,7 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
+#include <asm/perfmon.h>
 
 #ifdef CONFIG_XMON
 void (*debugger)(struct pt_regs *regs) = xmon;
@@ -70,8 +71,6 @@
 /*
  * Trap & Exception support
  */
-
-extern void (*perf_irq)(struct pt_regs *);
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
diff -Nru a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- a/arch/ppc/oprofile/common.c	2004-12-02 10:44:03 -06:00
+++ b/arch/ppc/oprofile/common.c	2004-12-02 10:44:03 -06:00
@@ -25,7 +25,6 @@
 
 #include "op_impl.h"
 
-extern struct op_ppc32_model op_model_fsl_booke;
 static struct op_ppc32_model *model;
 
 static struct op_counter_config ctr[OP_MAX_COUNTER];
diff -Nru a/include/asm-ppc/perfmon.h b/include/asm-ppc/perfmon.h
--- a/include/asm-ppc/perfmon.h	2004-12-02 10:44:03 -06:00
+++ b/include/asm-ppc/perfmon.h	2004-12-02 10:44:03 -06:00
@@ -1,6 +1,8 @@
 #ifndef __PERFMON_H
 #define __PERFMON_H
 
+extern void (*perf_irq)(struct pt_regs *);
+
 int request_perfmon_irq(void (*handler)(struct pt_regs *));
 void free_perfmon_irq(void);
 
@@ -13,6 +15,8 @@
 void pmc_start_ctrs(int enable);
 void pmc_stop_ctrs(void);
 void dump_pmcs(void);
+
+extern struct op_ppc32_model op_model_fsl_booke;
 #endif
 
 #endif /* __PERFMON_H */
