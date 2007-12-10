Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4B9ADDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:55:41 +1100 (EST)
Subject: Re: [PATCH 8/25] powerpc: Improve support for 4xx indirect DCRs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206201913.498185e6@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080117.754FEDDE45@ozlabs.org>
	<20071206201913.498185e6@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 15:54:05 +1100
Message-Id: <1197262445.6563.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Improve support for 4xx indirect DCRs

Accessing indirect DCRs is done via a pair of address/data DCRs.

Such accesses are thus inherently racy, vs. interrupts, preemption
and possibly SMP if 4xx SMP cores are ever used.

This updates the mfdcri/mtdcri macros in dcr-native.h (which were
so far unused) to use a spinlock.

In addition, add some common definitions to a new dcr-regs.h file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/include/asm-powerpc/dcr-native.h
===================================================================
--- linux-work.orig/include/asm-powerpc/dcr-native.h	2007-12-10 15:52:26.000000000 +1100
+++ linux-work/include/asm-powerpc/dcr-native.h	2007-12-10 15:53:36.000000000 +1100
@@ -22,6 +22,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#include <linux/spinlock.h>
+
 typedef struct {
 	unsigned int base;
 } dcr_host_t;
@@ -55,20 +57,28 @@ do {								\
 } while (0)
 
 /* R/W of indirect DCRs make use of standard naming conventions for DCRs */
-#define mfdcri(base, reg)			\
-({						\
-	mtdcr(base ## _CFGADDR, base ## _ ## reg);	\
-	mfdcr(base ## _CFGDATA);			\
+extern spinlock_t dcr_ind_lock;
+
+#define mfdcri(base, reg)				\
+({							\
+	unsigned long flags; 				\
+	unsigned int val;				\
+	spin_lock_irqsave(&dcr_ind_lock, flags);	\
+	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);	\
+	val = mfdcr(DCRN_ ## base ## _CONFIG_DATA);	\
+	spin_unlock_irqrestore(&dcr_ind_lock, flags);	\
+	val;						\
 })
 
-#define mtdcri(base, reg, data)			\
-do {						\
-	mtdcr(base ## _CFGADDR, base ## _ ## reg);	\
-	mtdcr(base ## _CFGDATA, data);		\
+#define mtdcri(base, reg, data)				\
+do {							\
+	unsigned long flags; 				\
+	spin_lock_irqsave(&dcr_ind_lock, flags);	\
+	mtdcr(DCRN_ ## base ## _CONFIG_ADDR, reg);	\
+	mtdcr(DCRN_ ## base ## _CONFIG_DATA, data);	\
+	spin_unlock_irqrestore(&dcr_ind_lock, flags);	\
 } while (0)
 
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_NATIVE_H */
-
-
Index: linux-work/include/asm-powerpc/dcr-regs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-powerpc/dcr-regs.h	2007-12-10 15:53:33.000000000 +1100
@@ -0,0 +1,71 @@
+/*
+ * Common DCR / SDR / CPR register definitions used on various IBM/AMCC
+ * 4xx processors
+ *
+ *    Copyright 2007 Benjamin Herrenschmidt, IBM Corp
+ *                   <benh@kernel.crashing.org>
+ *
+ * Mostly lifted from asm-ppc/ibm4xx.h by
+ *
+ *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *
+ */
+
+#ifndef __DCR_REGS_H__
+#define __DCR_REGS_H__
+
+/*
+ * Most DCRs used for controlling devices such as the MAL, DMA engine,
+ * etc... are obtained for the device tree.
+ *
+ * The definitions in this files are fixed DCRs and indirect DCRs that
+ * are commonly used outside of specific drivers or refer to core
+ * common registers that may occasionally have to be tweaked outside
+ * of the driver main register set
+ */
+
+/* CPRs (440GX and 440SP/440SPe) */
+#define DCRN_CPR0_CONFIG_ADDR	0xc
+#define DCRN_CPR0_CONFIG_DATA	0xd
+
+/* SDRs (440GX and 440SP/440SPe) */
+#define DCRN_SDR0_CONFIG_ADDR 	0xe
+#define DCRN_SDR0_CONFIG_DATA	0xf
+
+#define SDR0_PFC0		0x4100
+#define SDR0_PFC1		0x4101
+#define SDR0_PFC1_EPS		0x1c00000
+#define SDR0_PFC1_EPS_SHIFT	22
+#define SDR0_PFC1_RMII		0x02000000
+#define SDR0_MFR		0x4300
+#define SDR0_MFR_TAH0 		0x80000000  	/* TAHOE0 Enable */
+#define SDR0_MFR_TAH1 		0x40000000  	/* TAHOE1 Enable */
+#define SDR0_MFR_PCM  		0x10000000  	/* PPC440GP irq compat mode */
+#define SDR0_MFR_ECS  		0x08000000  	/* EMAC int clk */
+#define SDR0_MFR_T0TXFL		0x00080000
+#define SDR0_MFR_T0TXFH		0x00040000
+#define SDR0_MFR_T1TXFL		0x00020000
+#define SDR0_MFR_T1TXFH		0x00010000
+#define SDR0_MFR_E0TXFL		0x00008000
+#define SDR0_MFR_E0TXFH		0x00004000
+#define SDR0_MFR_E0RXFL		0x00002000
+#define SDR0_MFR_E0RXFH		0x00001000
+#define SDR0_MFR_E1TXFL		0x00000800
+#define SDR0_MFR_E1TXFH		0x00000400
+#define SDR0_MFR_E1RXFL		0x00000200
+#define SDR0_MFR_E1RXFH		0x00000100
+#define SDR0_MFR_E2TXFL		0x00000080
+#define SDR0_MFR_E2TXFH		0x00000040
+#define SDR0_MFR_E2RXFL		0x00000020
+#define SDR0_MFR_E2RXFH		0x00000010
+#define SDR0_MFR_E3TXFL		0x00000008
+#define SDR0_MFR_E3TXFH		0x00000004
+#define SDR0_MFR_E3RXFL		0x00000002
+#define SDR0_MFR_E3RXFH		0x00000001
+#define SDR0_UART0		0x0120
+#define SDR0_UART1		0x0121
+#define SDR0_UART2		0x0122
+#define SDR0_UART3		0x0123
+#define SDR0_CUST0		0x4000
+
+#endif /* __DCR_REGS_H__ */
