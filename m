Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87F83DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:38 +1000 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 5E852368004
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:38 +1000 (EST)
Date: Thu, 10 Apr 2008 16:43:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] [POWERPC] iSeries: make iseries_reg_save private to
	iSeries
Message-Id: <20080410164347.2e3c4661.sfr@canb.auug.org.au>
In-Reply-To: <20080410163918.257405e7.sfr@canb.auug.org.au>
References: <20080410163918.257405e7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have the alpaca, the reg_save_ptr is no longer needed in the
paca.  Eradicate all global uses of it and make it static in the iSeries
lpardata.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/paca.c                   |   33 +++--------
 arch/powerpc/platforms/iseries/lpardata.c    |   72 +++++++++++++++++++---
 arch/powerpc/xmon/xmon.c                     |   11 ---
 include/asm-powerpc/iseries/it_lp_reg_save.h |   85 --------------------------
 include/asm-powerpc/paca.h                   |   12 +---
 5 files changed, 73 insertions(+), 140 deletions(-)
 delete mode 100644 include/asm-powerpc/iseries/it_lp_reg_save.h

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 55f1a25..867b22d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -15,7 +15,6 @@
 #include <asm/ptrace.h>
 #include <asm/page.h>
 #include <asm/lppaca.h>
-#include <asm/iseries/it_lp_reg_save.h>
 #include <asm/paca.h>
 #include <asm/mmu.h>
 
@@ -25,13 +24,13 @@
 extern unsigned long __toc_start;
 
 /*
- * iSeries structure which the hypervisor knows about - this structure
+ * The structure which the hypervisor knows about - this structure
  * should not cross a page boundary.  The vpa_init/register_vpa call
  * is now known to fail if the lppaca structure crosses a page
- * boundary.  The lppaca is also used on POWER5 pSeries boxes.  The
- * lppaca is 640 bytes long, and cannot readily change since the
- * hypervisor knows its layout, so a 1kB alignment will suffice to
- * ensure that it doesn't cross a page boundary.
+ * boundary.  The lppaca is also used on legacy iSeries and POWER5
+ * pSeries boxes.  The lppaca is 640 bytes long, and cannot readily
+ * change since the hypervisor knows its layout, so a 1kB alignment
+ * will suffice to ensure that it doesn't cross a page boundary.
  */
 struct lppaca lppaca[] = {
 	[0 ... (NR_CPUS-1)] = {
@@ -66,32 +65,16 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
  * processors.  The processor VPD array needs one entry per physical
  * processor (not thread).
  */
-#define PACA_INIT_COMMON(number)					    \
+#define PACA_INIT(number)						    \
+{									    \
 	.lppaca_ptr = &lppaca[number],					    \
 	.lock_token = 0x8000,						    \
 	.paca_index = (number),		/* Paca Index */		    \
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
 	.hw_cpu_id = 0xffff,						    \
-	.slb_shadow_ptr = &slb_shadow[number],
-
-#ifdef CONFIG_PPC_ISERIES
-#define PACA_INIT_ISERIES(number)					    \
-	.reg_save_ptr = &iseries_reg_save[number],
-
-#define PACA_INIT(number)						    \
-{									    \
-	PACA_INIT_COMMON(number)					    \
-	PACA_INIT_ISERIES(number)					    \
+	.slb_shadow_ptr = &slb_shadow[number],				    \
 }
 
-#else
-#define PACA_INIT(number)						    \
-{									    \
-	PACA_INIT_COMMON(number)					    \
-}
-
-#endif
-
 struct paca_struct paca[] = {
 	PACA_INIT(0),
 #if NR_CPUS > 1
diff --git a/arch/powerpc/platforms/iseries/lpardata.c b/arch/powerpc/platforms/iseries/lpardata.c
index dc84708..2331d97 100644
--- a/arch/powerpc/platforms/iseries/lpardata.c
+++ b/arch/powerpc/platforms/iseries/lpardata.c
@@ -14,7 +14,6 @@
 #include <asm/ptrace.h>
 #include <asm/abs_addr.h>
 #include <asm/lppaca.h>
-#include <asm/iseries/it_lp_reg_save.h>
 #include <asm/paca.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/iseries/it_lp_queue.h>
@@ -62,6 +61,63 @@ struct naca_struct naca = {
 	.xRamDiskSize = 0,
 };
 
+struct ItLpRegSave {
+	u32	xDesc;		// Eye catcher  "LpRS" ebcdic	000-003
+	u16	xSize;		// Size of this class		004-005
+	u8	xInUse;         // Area is live                 006-007
+	u8	xRsvd1[9];	// Reserved			007-00F
+
+	u8      xFixedRegSave[352]; // Fixed Register Save Area 010-16F
+	u32	xCTRL;		// Control Register		170-173
+	u32	xDEC;		// Decrementer			174-177
+	u32	xFPSCR;		// FP Status and Control Reg	178-17B
+	u32	xPVR;		// Processor Version Number	17C-17F
+
+	u64	xMMCR0;		// Monitor Mode Control Reg 0	180-187
+	u32	xPMC1;		// Perf Monitor Counter 1	188-18B
+	u32	xPMC2;		// Perf Monitor Counter 2	18C-18F
+	u32	xPMC3;		// Perf Monitor Counter 3	190-193
+	u32	xPMC4;		// Perf Monitor Counter 4	194-197
+	u32	xPIR;		// Processor ID Reg		198-19B
+
+	u32	xMMCR1;		// Monitor Mode Control Reg 1	19C-19F
+	u32	xMMCRA;		// Monitor Mode Control Reg A	1A0-1A3
+	u32	xPMC5;		// Perf Monitor Counter 5	1A4-1A7
+	u32	xPMC6;		// Perf Monitor Counter 6	1A8-1AB
+	u32	xPMC7;		// Perf Monitor Counter 7	1AC-1AF
+	u32	xPMC8;		// Perf Monitor Counter 8	1B0-1B3
+	u32	xTSC;		// Thread Switch Control	1B4-1B7
+	u32	xTST;		// Thread Switch Timeout	1B8-1BB
+	u32	xRsvd;          // Reserved                     1BC-1BF
+
+	u64	xACCR;		// Address Compare Control Reg	1C0-1C7
+	u64	xIMR;		// Instruction Match Register	1C8-1CF
+	u64	xSDR1;		// Storage Description Reg 1	1D0-1D7
+	u64	xSPRG0;		// Special Purpose Reg General0	1D8-1DF
+	u64	xSPRG1;		// Special Purpose Reg General1	1E0-1E7
+	u64	xSPRG2;		// Special Purpose Reg General2	1E8-1EF
+	u64	xSPRG3;		// Special Purpose Reg General3	1F0-1F7
+	u64	xTB;		// Time Base Register		1F8-1FF
+
+	u64	xFPR[32];	// Floating Point Registers	200-2FF
+
+	u64	xMSR;		// Machine State Register	300-307
+	u64	xNIA;		// Next Instruction Address	308-30F
+
+	u64	xDABR;		// Data Address Breakpoint Reg	310-317
+	u64	xIABR;		// Inst Address Breakpoint Reg	318-31F
+
+	u64	xHID0;		// HW Implementation Dependent0	320-327
+
+	u64	xHID4;		// HW Implementation Dependent4	328-32F
+	u64	xSCOMd;		// SCON Data Reg (SPRG4)	330-337
+	u64	xSCOMc;		// SCON Command Reg (SPRG5)	338-33F
+	u64	xSDAR;		// Sample Data Address Register	340-347
+	u64	xSIAR;		// Sample Inst Address Register	348-34F
+
+	u8	xRsvd3[176];	// Reserved			350-3FF
+};
+
 extern void system_reset_iSeries(void);
 extern void machine_check_iSeries(void);
 extern void data_access_iSeries(void);
@@ -160,6 +216,13 @@ struct SpCommArea xSpCommArea = {
 	.xFormat = 1,
 };
 
+static struct ItLpRegSave iseries_reg_save[] = {
+	[0 ... (NR_CPUS-1)] = {
+		.xDesc = 0xd397d9e2,	/* "LpRS" */
+		.xSize = sizeof(struct ItLpRegSave),
+	},
+};
+
 #define ALPACA_INIT(number)						\
 {									\
 	.lppaca_ptr = &lppaca[number],					\
@@ -254,10 +317,3 @@ struct ItVpdAreas itVpdAreas = {
 		0,0
 	}
 };
-
-struct ItLpRegSave iseries_reg_save[] = {
-	[0 ... (NR_CPUS-1)] = {
-		.xDesc = 0xd397d9e2,	/* "LpRS" */
-		.xSize = sizeof(struct ItLpRegSave),
-	},
-};
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a34172d..00fd764 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -45,7 +45,6 @@
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
-#include <asm/iseries/it_lp_reg_save.h>
 #endif
 
 #include "nonstdio.h"
@@ -1598,7 +1597,6 @@ void super_regs(void)
 		if (firmware_has_feature(FW_FEATURE_ISERIES)) {
 			struct paca_struct *ptrPaca;
 			struct lppaca *ptrLpPaca;
-			struct ItLpRegSave *ptrLpRegSave;
 
 			/* Dump out relevant Paca data areas. */
 			printf("Paca: \n");
@@ -1611,15 +1609,6 @@ void super_regs(void)
 			printf("    Saved Gpr3=%.16lx  Saved Gpr4=%.16lx \n",
 			       ptrLpPaca->saved_gpr3, ptrLpPaca->saved_gpr4);
 			printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->saved_gpr5);
-
-			printf("  Local Processor Register Save Area (LpRegSave): \n");
-			ptrLpRegSave = ptrPaca->reg_save_ptr;
-			printf("    Saved Sprg0=%.16lx  Saved Sprg1=%.16lx \n",
-			       ptrLpRegSave->xSPRG0, ptrLpRegSave->xSPRG0);
-			printf("    Saved Sprg2=%.16lx  Saved Sprg3=%.16lx \n",
-			       ptrLpRegSave->xSPRG2, ptrLpRegSave->xSPRG3);
-			printf("    Saved Msr  =%.16lx  Saved Nia  =%.16lx \n",
-			       ptrLpRegSave->xMSR, ptrLpRegSave->xNIA);
 		}
 #endif
 
diff --git a/include/asm-powerpc/iseries/it_lp_reg_save.h b/include/asm-powerpc/iseries/it_lp_reg_save.h
deleted file mode 100644
index 5403b75..0000000
--- a/include/asm-powerpc/iseries/it_lp_reg_save.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _ASM_POWERPC_ISERIES_IT_LP_REG_SAVE_H
-#define _ASM_POWERPC_ISERIES_IT_LP_REG_SAVE_H
-
-/*
- * This control block contains the data that is shared between PLIC
- * and the OS
- */
-
-struct ItLpRegSave {
-	u32	xDesc;		// Eye catcher  "LpRS" ebcdic	000-003
-	u16	xSize;		// Size of this class		004-005
-	u8	xInUse;         // Area is live                 006-007
-	u8	xRsvd1[9];	// Reserved			007-00F
-
-	u8      xFixedRegSave[352]; // Fixed Register Save Area 010-16F
-	u32	xCTRL;		// Control Register		170-173
-	u32	xDEC;		// Decrementer			174-177
-	u32	xFPSCR;		// FP Status and Control Reg	178-17B
-	u32	xPVR;		// Processor Version Number	17C-17F
-
-	u64	xMMCR0;		// Monitor Mode Control Reg 0	180-187
-	u32	xPMC1;		// Perf Monitor Counter 1	188-18B
-	u32	xPMC2;		// Perf Monitor Counter 2	18C-18F
-	u32	xPMC3;		// Perf Monitor Counter 3	190-193
-	u32	xPMC4;		// Perf Monitor Counter 4	194-197
-	u32	xPIR;		// Processor ID Reg		198-19B
-
-	u32	xMMCR1;		// Monitor Mode Control Reg 1	19C-19F
-	u32	xMMCRA;		// Monitor Mode Control Reg A	1A0-1A3
-	u32	xPMC5;		// Perf Monitor Counter 5	1A4-1A7
-	u32	xPMC6;		// Perf Monitor Counter 6	1A8-1AB
-	u32	xPMC7;		// Perf Monitor Counter 7	1AC-1AF
-	u32	xPMC8;		// Perf Monitor Counter 8	1B0-1B3
-	u32	xTSC;		// Thread Switch Control	1B4-1B7
-	u32	xTST;		// Thread Switch Timeout	1B8-1BB
-	u32	xRsvd;          // Reserved                     1BC-1BF
-
-	u64	xACCR;		// Address Compare Control Reg	1C0-1C7
-	u64	xIMR;		// Instruction Match Register	1C8-1CF
-	u64	xSDR1;		// Storage Description Reg 1	1D0-1D7
-	u64	xSPRG0;		// Special Purpose Reg General0	1D8-1DF
-	u64	xSPRG1;		// Special Purpose Reg General1	1E0-1E7
-	u64	xSPRG2;		// Special Purpose Reg General2	1E8-1EF
-	u64	xSPRG3;		// Special Purpose Reg General3	1F0-1F7
-	u64	xTB;		// Time Base Register		1F8-1FF
-
-	u64	xFPR[32];	// Floating Point Registers	200-2FF
-
-	u64	xMSR;		// Machine State Register	300-307
-	u64	xNIA;		// Next Instruction Address	308-30F
-
-	u64	xDABR;		// Data Address Breakpoint Reg	310-317
-	u64	xIABR;		// Inst Address Breakpoint Reg	318-31F
-
-	u64	xHID0;		// HW Implementation Dependent0	320-327
-
-	u64	xHID4;		// HW Implementation Dependent4	328-32F
-	u64	xSCOMd;		// SCON Data Reg (SPRG4)	330-337
-	u64	xSCOMc;		// SCON Command Reg (SPRG5)	338-33F
-	u64	xSDAR;		// Sample Data Address Register	340-347
-	u64	xSIAR;		// Sample Inst Address Register	348-34F
-
-	u8	xRsvd3[176];	// Reserved			350-3FF
-};
-
-extern struct ItLpRegSave iseries_reg_save[];
-
-#endif /* _ASM_POWERPC_ISERIES_IT_LP_REG_SAVE_H */
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 748b35a..eb61b9c 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -42,10 +42,7 @@ struct task_struct;
  * Defines the layout of the paca.
  *
  * This structure is not directly accessed by firmware or the service
- * processor except for the first two pointers that point to the
- * lppaca area and the ItLpRegSave area for this CPU.  The lppaca
- * object is currently contained within the PACA but it doesn't need
- * to be.
+ * processor.
  */
 struct paca_struct {
 	/*
@@ -55,14 +52,7 @@ struct paca_struct {
 	 * avoid cacheline bouncing.
 	 */
 
-	/*
-	 * MAGIC: These first two pointers can't be moved - they're
-	 * accessed by the firmware
-	 */
 	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
-#ifdef CONFIG_PPC_ISERIES
-	void *reg_save_ptr; /* Pointer to LpRegSave for PLIC */
-#endif /* CONFIG_PPC_ISERIES */
 
 	/*
 	 * MAGIC: the spinlock functions in arch/powerpc/lib/locks.c 
-- 
1.5.4.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
