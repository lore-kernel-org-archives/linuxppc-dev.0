Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D0FE2DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:37 +1000 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 976B6368004
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:44:37 +1000 (EST)
Date: Thu, 10 Apr 2008 16:39:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] [POWERPC] iSeries: boot on a fake paca
Message-Id: <20080410163918.257405e7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The iSeries HV only needs the first two fields of the paca statically
initialised, so create an alternate paca that contains only those and
switch to our real paca immediately after boot.

This is in order to make the 1024 cpu patches easier since they will no
longer have to statically initialise the pacas for iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/asm-offsets.c          |    6 ++++
 arch/powerpc/platforms/iseries/exception.S |   12 +++++++-
 arch/powerpc/platforms/iseries/lpardata.c  |   39 ++++++++++++++++++++++++++-
 include/asm-powerpc/iseries/alpaca.h       |   31 ++++++++++++++++++++++
 4 files changed, 84 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-powerpc/iseries/alpaca.h

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e932b43..292c6d8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -44,6 +44,9 @@
 #include <asm/mmu.h>
 #include <asm/hvcall.h>
 #endif
+#ifdef CONFIG_PPC_ISERIES
+#include <asm/iseries/alpaca.h>
+#endif
 
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -321,6 +324,9 @@ int main(void)
 	DEFINE(PAGE_OFFSET_VSID, KERNEL_VSID(PAGE_OFFSET));
 	DEFINE(VMALLOC_START_ESID, GET_ESID(VMALLOC_START));
 	DEFINE(VMALLOC_START_VSID, KERNEL_VSID(VMALLOC_START));
+
+	/* alpaca */
+	DEFINE(ALPACA_SIZE, sizeof(struct alpaca));
 #endif
 
 	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 5381038..c775cd4 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -38,11 +38,19 @@
 
 	.globl system_reset_iSeries
 system_reset_iSeries:
-	mfspr	r13,SPRN_SPRG3		/* Get paca address */
+	mfspr	r13,SPRN_SPRG3		/* Get alpaca address */
+	LOAD_REG_IMMEDIATE(r23, alpaca)
+	li	r0,ALPACA_SIZE
+	sub	r23,r13,r23
+	divdu	r23,r23,r0		/* r23 has cpu number */
+	LOAD_REG_IMMEDIATE(r13, paca)
+	mulli	r0,r23,PACA_SIZE
+	add	r13,r13,r0
+	mtspr	SPRN_SPRG3,r13		/* Save it away for the future */
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
-	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
+	mr	r24,r23
 	cmpwi	0,r24,0			/* Are we processor 0? */
 	bne	1f
 	b	.__start_initialization_iSeries	/* Start up the first processor */
diff --git a/arch/powerpc/platforms/iseries/lpardata.c b/arch/powerpc/platforms/iseries/lpardata.c
index 8162049..dc84708 100644
--- a/arch/powerpc/platforms/iseries/lpardata.c
+++ b/arch/powerpc/platforms/iseries/lpardata.c
@@ -18,6 +18,7 @@
 #include <asm/paca.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/iseries/it_lp_queue.h>
+#include <asm/iseries/alpaca.h>
 
 #include "naca.h"
 #include "vpd_areas.h"
@@ -159,6 +160,40 @@ struct SpCommArea xSpCommArea = {
 	.xFormat = 1,
 };
 
+#define ALPACA_INIT(number)						\
+{									\
+	.lppaca_ptr = &lppaca[number],					\
+	.reg_save_ptr = &iseries_reg_save[number],			\
+}
+
+struct alpaca alpaca[] = {
+	ALPACA_INIT( 0),
+#if NR_CPUS > 1
+	ALPACA_INIT( 1), ALPACA_INIT( 2), ALPACA_INIT( 3),
+#if NR_CPUS > 4
+	ALPACA_INIT( 4), ALPACA_INIT( 5), ALPACA_INIT( 6), ALPACA_INIT( 7),
+#if NR_CPUS > 8
+	ALPACA_INIT( 8), ALPACA_INIT( 9), ALPACA_INIT(10), ALPACA_INIT(11),
+	ALPACA_INIT(12), ALPACA_INIT(13), ALPACA_INIT(14), ALPACA_INIT(15),
+	ALPACA_INIT(16), ALPACA_INIT(17), ALPACA_INIT(18), ALPACA_INIT(19),
+	ALPACA_INIT(20), ALPACA_INIT(21), ALPACA_INIT(22), ALPACA_INIT(23),
+	ALPACA_INIT(24), ALPACA_INIT(25), ALPACA_INIT(26), ALPACA_INIT(27),
+	ALPACA_INIT(28), ALPACA_INIT(29), ALPACA_INIT(30), ALPACA_INIT(31),
+#if NR_CPUS > 32
+	ALPACA_INIT(32), ALPACA_INIT(33), ALPACA_INIT(34), ALPACA_INIT(35),
+	ALPACA_INIT(36), ALPACA_INIT(37), ALPACA_INIT(38), ALPACA_INIT(39),
+	ALPACA_INIT(40), ALPACA_INIT(41), ALPACA_INIT(42), ALPACA_INIT(43),
+	ALPACA_INIT(44), ALPACA_INIT(45), ALPACA_INIT(46), ALPACA_INIT(47),
+	ALPACA_INIT(48), ALPACA_INIT(49), ALPACA_INIT(50), ALPACA_INIT(51),
+	ALPACA_INIT(52), ALPACA_INIT(53), ALPACA_INIT(54), ALPACA_INIT(55),
+	ALPACA_INIT(56), ALPACA_INIT(57), ALPACA_INIT(58), ALPACA_INIT(59),
+	ALPACA_INIT(60), ALPACA_INIT(61), ALPACA_INIT(62), ALPACA_INIT(63),
+#endif
+#endif
+#endif
+#endif
+};
+
 /* The LparMap data is now located at offset 0x6000 in head.S
  * It was put there so that the HvReleaseData could address it
  * with a 32-bit offset as required by the iSeries hypervisor
@@ -185,7 +220,7 @@ struct ItVpdAreas itVpdAreas = {
 	.xSlicVpdLens = {			/* VPD lengths */
 	        0,0,0,		        /*  0 - 2 */
 		sizeof(xItExtVpdPanel), /*       3 Extended VPD   */
-		sizeof(struct paca_struct),	/*       4 length of Paca  */
+		sizeof(struct alpaca),	/*       4 length of (fake) Paca  */
 		0,			/*       5 */
 		sizeof(struct ItIplParmsReal),/* 6 length of IPL parms */
 		26992,			/*	 7 length of MS VPD */
@@ -203,7 +238,7 @@ struct ItVpdAreas itVpdAreas = {
 	.xSlicVpdAdrs = {			/* VPD addresses */
 		0,0,0,			/*	 0 -  2 */
 		&xItExtVpdPanel,        /*       3 Extended VPD */
-		&paca[0],		/*       4 first Paca */
+		&alpaca[0],		/*       4 first (fake) Paca */
 		0,			/*       5 */
 		&xItIplParmsReal,	/*	 6 IPL parms */
 		&xMsVpd,		/*	 7 MS Vpd */
diff --git a/include/asm-powerpc/iseries/alpaca.h b/include/asm-powerpc/iseries/alpaca.h
new file mode 100644
index 0000000..26fc081
--- /dev/null
+++ b/include/asm-powerpc/iseries/alpaca.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright © 2008  Stephen Rothwell IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ASM_POWERPC_ISERIES_ALPACA_H
+#define _ASM_POWERPC_ISERIES_ALPACA_H
+
+/*
+ * This is the part of the paca that the iSeries hypervisor
+ * needs to be statically initialised. Immediately after boot
+ * we switch to the normal Linux paca.
+ */
+struct alpaca {
+	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
+	void *reg_save_ptr;		/* Pointer to LpRegSave for PLIC */
+};
+
+#endif /* _ASM_POWERPC_ISERIES_ALPACA_H */
-- 
1.5.4.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
