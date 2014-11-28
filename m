Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B16D21A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 15:36:48 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D45381400E9
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2014 15:36:47 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 28 Nov 2014 10:06:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9C897E003F
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2014 10:07:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAS4cqmT61341726
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2014 10:08:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAS4agQN022621
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2014 10:06:42 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V4] powerpc, xmon: Enable HW instruction breakpoint on POWER8
Date: Fri, 28 Nov 2014 10:06:42 +0530
Message-Id: <1417149402-5493-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for hardware instruction breakpoint in
xmon on POWER8 platform with the help of a new register called the
CIABR (Completed Instruction Address Breakpoint Register). With this
patch, a single hardware instruction breakpoint can be added and
cleared during any active xmon debug session. The hardware based
instruction breakpoint mechanism works correctly with the existing
TRAP based instruction breakpoint available on xmon.

There are no powerpc CPU with CPU_FTR_IABR feature any more. This
patch has re-purposed all the existing IABR related code to work
with CIABR register based HW instruction breakpoint.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V4:
- Moved the external function code block from xmon.h to xmon.c
- Reformatted the in-code documentation as kernel-doc format
- Re-purposed all the IABR related code for CIABR
- Removed all CIABR specific code which existed along with IABR
- Changed the patch commit message

Changes in V3: [Posted at https://patchwork.ozlabs.org/patch/398006/]
- Moved the 'ciabr_used' early init inside 'cmds' function
- Some minor code cleanup
- Added more in-code documentation
- Changed the commit message

Changes in V2: [Posted at http://patchwork.ozlabs.org/patch/373114/]
- Fixed the compilation problem in 32 bit archs
- Selective inclusion of plapr_set_ciabr for required platforms
- Cleaned up the white space issues

 arch/powerpc/xmon/xmon.c | 58 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b988b5a..0ea66e0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -51,6 +51,12 @@
 #include <asm/paca.h>
 #endif
 
+#if defined(CONFIG_PPC_SPLPAR)
+#include <asm/plpar_wrappers.h>
+#else
+static inline long plapr_set_ciabr(unsigned long ciabr) {return 0; };
+#endif
+
 #include "nonstdio.h"
 #include "dis-asm.h"
 
@@ -270,6 +276,45 @@ static inline void cinval(void *p)
 	asm volatile ("dcbi 0,%0; icbi 0,%0" : : "r" (p));
 }
 
+/**
+ * write_ciabr() - write the CIABR SPR
+ * @ciabr:	The value to write.
+ *
+ * This function writes a value to the CIARB register either directly
+ * through mtspr instruction if the kernel is in HV privilege mode or
+ * call a hypervisor function to achieve the same in case the kernel
+ * is in supervisor privilege mode.
+ */
+static void write_ciabr(unsigned long ciabr)
+{
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return;
+
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mtspr(SPRN_CIABR, ciabr);
+		return;
+	}
+	plapr_set_ciabr(ciabr);
+}
+
+/**
+ * set_ciabr() - set the CIABR
+ * @addr:	The value to set.
+ *
+ * This function sets the correct privilege value into the the HW
+ * breakpoint address before writing it up in the CIABR register.
+ */
+static void set_ciabr(unsigned long addr)
+{
+	addr &= ~CIABR_PRIV;
+
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		addr |= CIABR_PRIV_HYPER;
+	else
+		addr |= CIABR_PRIV_SUPER;
+	write_ciabr(addr);
+}
+
 /*
  * Disable surveillance (the service processor watchdog function)
  * while we are in xmon.
@@ -764,9 +809,9 @@ static void insert_cpu_bpts(void)
 		brk.len = 8;
 		__set_breakpoint(&brk);
 	}
-	if (iabr && cpu_has_feature(CPU_FTR_IABR))
-		mtspr(SPRN_IABR, iabr->address
-			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
+
+	if (iabr)
+		set_ciabr(iabr->address);
 }
 
 static void remove_bpts(void)
@@ -792,8 +837,7 @@ static void remove_bpts(void)
 static void remove_cpu_bpts(void)
 {
 	hw_breakpoint_disable();
-	if (cpu_has_feature(CPU_FTR_IABR))
-		mtspr(SPRN_IABR, 0);
+	write_ciabr(0);
 }
 
 /* Command interpreting routine */
@@ -1127,7 +1171,7 @@ static char *breakpoint_help_string =
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
     "bc               clear all breakpoints\n"
     "bc <n/addr>      clear breakpoint number n or at addr\n"
-    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
+    "bi <addr> [cnt]  set hardware instr breakpoint (POWER8 only)\n"
     "bd <addr> [cnt]  set hardware data breakpoint\n"
     "";
 
@@ -1166,7 +1210,7 @@ bpt_cmds(void)
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
-		if (!cpu_has_feature(CPU_FTR_IABR)) {
+		if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
 			printf("Hardware instruction breakpoint "
 			       "not supported on this cpu\n");
 			break;
-- 
1.9.3
