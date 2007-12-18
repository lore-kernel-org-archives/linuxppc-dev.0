Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7E0D0DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:05 +1100 (EST)
Message-Id: <20071218175103.799448000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:54 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 02/18] OProfile: fix cbe pm signal routing problem
Cc: linuxppc-dev@ozlabs.org, Bob Nelson <rrnelson@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix debug_bus_control and group_control PMU register values set up in
set_pm_event().  Initialize variables before calling set_pm_event().
Delete unused static array and code that initialized it.
Rename constant to better reflect usage.

Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/oprofile/op_model_cell.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

Index: linux-2.6-new/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/oprofile/op_model_cell.c
+++ linux-2.6-new/arch/powerpc/oprofile/op_model_cell.c
@@ -61,7 +61,7 @@ static unsigned int spu_cycle_reset;
 #define NUM_THREADS 2         /* number of physical threads in
 			       * physical processor
 			       */
-#define NUM_TRACE_BUS_WORDS 4
+#define NUM_DEBUG_BUS_WORDS 4
 #define NUM_INPUT_BUS_WORDS 2
 
 #define MAX_SPU_COUNT 0xFFFFFF	/* maximum 24 bit LFSR value */
@@ -169,7 +169,6 @@ static DEFINE_SPINLOCK(virt_cntr_lock);
 
 static u32 ctr_enabled;
 
-static unsigned char trace_bus[NUM_TRACE_BUS_WORDS];
 static unsigned char input_bus[NUM_INPUT_BUS_WORDS];
 
 /*
@@ -298,7 +297,7 @@ static void set_pm_event(u32 ctr, int ev
 
 	p->signal_group = event / 100;
 	p->bus_word = bus_word;
-	p->sub_unit = (unit_mask & 0x0000f000) >> 12;
+	p->sub_unit = GET_SUB_UNIT(unit_mask);
 
 	pm_regs.pm07_cntrl[ctr] = 0;
 	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_COUNT_CYCLES(count_cycles);
@@ -334,16 +333,16 @@ static void set_pm_event(u32 ctr, int ev
 		p->bit = signal_bit;
 	}
 
-	for (i = 0; i < NUM_TRACE_BUS_WORDS; i++) {
+	for (i = 0; i < NUM_DEBUG_BUS_WORDS; i++) {
 		if (bus_word & (1 << i)) {
 			pm_regs.debug_bus_control |=
-			    (bus_type << (31 - (2 * i) + 1));
+			    (bus_type << (30 - (2 * i)));
 
 			for (j = 0; j < NUM_INPUT_BUS_WORDS; j++) {
 				if (input_bus[j] == 0xff) {
 					input_bus[j] = i;
 					pm_regs.group_control |=
-					    (i << (31 - i));
+					    (i << (30 - (2 * j)));
 
 					break;
 				}
@@ -450,6 +449,12 @@ static void cell_virtual_cntr(unsigned l
 	hdw_thread = 1 ^ hdw_thread;
 	next_hdw_thread = hdw_thread;
 
+	pm_regs.group_control = 0;
+	pm_regs.debug_bus_control = 0;
+
+	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
+		input_bus[i] = 0xff;
+
 	/*
 	 * There are some per thread events.  Must do the
 	 * set event, for the thread that is being started
@@ -619,9 +624,6 @@ static int cell_reg_setup(struct op_coun
 		pmc_cntrl[1][i].vcntr = i;
 	}
 
-	for (i = 0; i < NUM_TRACE_BUS_WORDS; i++)
-		trace_bus[i] = 0xff;
-
 	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
 		input_bus[i] = 0xff;
 

-- 
