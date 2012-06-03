Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1CFC100867
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 17:41:48 +1000 (EST)
Received: from mail24-va3 (localhost [127.0.0.1])	by mail24-va3-R.bigfish.com
 (Postfix) with ESMTP id C78C2400AF	for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2012 07:41:07 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.243])	by
 mail24-va3.bigfish.com (Postfix) with ESMTP id 66F7B2C0086	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 07:41:05 +0000 (UTC)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
 Freescale chips
Date: Sun, 3 Jun 2012 13:11:37 +0530
Message-ID: <1338709297-31133-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, these interrupts would be mapped, but the offset
calculation was broken, and only the first group was initialized.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    5 +++
 arch/powerpc/sysdev/mpic.c      |   58 ++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c9f698a..e14d35d 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -63,6 +63,7 @@
  */
 #define MPIC_TIMER_BASE			0x01100
 #define MPIC_TIMER_STRIDE		0x40
+#define MPIC_TIMER_GROUP_STRIDE		0x1000
 
 #define MPIC_TIMER_CURRENT_CNT		0x00000
 #define MPIC_TIMER_BASE_CNT		0x00010
@@ -110,6 +111,9 @@
 #define 	MPIC_VECPRI_SENSE_MASK			0x00400000
 #define MPIC_IRQ_DESTINATION		0x00010
 
+#define MPIC_FSL_BRR1			0x00000
+#define 	MPIC_FSL_BRR1_VER			0x0000ffff
+
 #define MPIC_MAX_IRQ_SOURCES	2048
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
@@ -296,6 +300,7 @@ struct mpic
 	phys_addr_t paddr;
 
 	/* The various ioremap'ed bases */
+	struct mpic_reg_bank	thiscpuregs;
 	struct mpic_reg_bank	gregs;
 	struct mpic_reg_bank	tmregs;
 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 395af13..a98eb77 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -6,7 +6,7 @@
  *  with various broken implementations of this HW.
  *
  *  Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
- *  Copyright 2010-2011 Freescale Semiconductor, Inc.
+ *  Copyright 2010-2012 Freescale Semiconductor, Inc.
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive
@@ -221,24 +221,24 @@ static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 valu
 	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
 }
 
-static inline u32 _mpic_tm_read(struct mpic *mpic, unsigned int tm)
+static inline unsigned int mpic_tm_offset(struct mpic *mpic, unsigned int tm)
 {
-	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
-			      ((tm & 3) * MPIC_INFO(TIMER_STRIDE));
+	return (tm >> 2) * MPIC_TIMER_GROUP_STRIDE +
+	       (tm & 3) * MPIC_INFO(TIMER_STRIDE);
+}
 
-	if (tm >= 4)
-		offset += 0x1000 / 4;
+static inline u32 _mpic_tm_read(struct mpic *mpic, unsigned int tm)
+{
+	unsigned int offset = mpic_tm_offset(mpic, tm) +
+			      MPIC_INFO(TIMER_VECTOR_PRI);
 
 	return _mpic_read(mpic->reg_type, &mpic->tmregs, offset);
 }
 
 static inline void _mpic_tm_write(struct mpic *mpic, unsigned int tm, u32 value)
 {
-	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
-			      ((tm & 3) * MPIC_INFO(TIMER_STRIDE));
-
-	if (tm >= 4)
-		offset += 0x1000 / 4;
+	unsigned int offset = mpic_tm_offset(mpic, tm) +
+			      MPIC_INFO(TIMER_VECTOR_PRI);
 
 	_mpic_write(mpic->reg_type, &mpic->tmregs, offset, value);
 }
@@ -1301,6 +1301,16 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, mpic->paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
 	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
+	if (mpic->flags & MPIC_FSL) {
+		/*
+		 * Yes, Freescale really did put global registers in the
+		 * magic per-cpu area -- and they don't even show up in the
+		 * non-magic per-cpu copies that this driver normally uses.
+		 */
+		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
+			 MPIC_CPU_THISBASE, 0x1000);
+	}
+
 	/* Reset */
 
 	/* When using a device-node, reset requests are only honored if the MPIC
@@ -1440,6 +1450,7 @@ void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
 void __init mpic_init(struct mpic *mpic)
 {
 	int i, cpu;
+	int num_timers = 4;
 
 	BUG_ON(mpic->num_sources == 0);
 
@@ -1448,15 +1459,30 @@ void __init mpic_init(struct mpic *mpic)
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
+	if (mpic->flags & MPIC_FSL) {
+		u32 brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
+				      MPIC_FSL_BRR1);
+		u32 version = brr1 & MPIC_FSL_BRR1_VER;
+
+		/*
+		 * Timer group B is present at the latest in MPIC 3.1 (e.g.
+		 * mpc8536).  It is not present in MPIC 2.0 (e.g. mpc8544).
+		 * I don't know about the status of intermediate versions (or
+		 * whether they even exist).
+		 */
+		if (version >= 0x0301)
+			num_timers = 8;
+	}
+
 	/* Initialize timers to our reserved vectors and mask them for now */
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < num_timers; i++) {
+		unsigned int offset = mpic_tm_offset(mpic, i);
+
 		mpic_write(mpic->tmregs,
-			   i * MPIC_INFO(TIMER_STRIDE) +
-			   MPIC_INFO(TIMER_DESTINATION),
+			   offset + MPIC_INFO(TIMER_DESTINATION),
 			   1 << hard_smp_processor_id());
 		mpic_write(mpic->tmregs,
-			   i * MPIC_INFO(TIMER_STRIDE) +
-			   MPIC_INFO(TIMER_VECTOR_PRI),
+			   offset + MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
 			   (9 << MPIC_VECPRI_PRIORITY_SHIFT) |
 			   (mpic->timer_vecs[0] + i));
-- 
1.7.2.2
