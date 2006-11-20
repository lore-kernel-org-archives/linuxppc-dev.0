Return-Path: <arnd@arndb.de>
Message-Id: <20061120180527.114978000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:13 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 19/22] cell: PMU register macros
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kevin Corry <kevcorry@us.ibm.com>
More macros for manipulating bits in the Cell PMU control registers.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -38,7 +38,28 @@
 /* Macros for the pm_control register. */
 #define CBE_PM_16BIT_CTR(ctr)			(1 << (24 - ((ctr) & (NR_PHYS_CTRS - 1))))
 #define CBE_PM_ENABLE_PERF_MON			0x80000000
+#define CBE_PM_STOP_AT_MAX			0x40000000
+#define CBE_PM_TRACE_MODE_GET(pm_control)	(((pm_control) >> 28) & 0x3)
+#define CBE_PM_TRACE_MODE_SET(mode)		(((mode)  & 0x3) << 28)
+#define CBE_PM_COUNT_MODE_SET(count)		(((count) & 0x3) << 18)
+#define CBE_PM_FREEZE_ALL_CTRS			0x00100000
+#define CBE_PM_ENABLE_EXT_TRACE			0x00008000
+
+/* Macros for the trace_address register. */
+#define CBE_PM_TRACE_BUF_FULL			0x00000800
+#define CBE_PM_TRACE_BUF_EMPTY			0x00000400
+#define CBE_PM_TRACE_BUF_DATA_COUNT(ta)		((ta) & 0x3ff)
+#define CBE_PM_TRACE_BUF_MAX_COUNT		0x400
+
+/* Macros for the pm07_control registers. */
+#define CBE_PM_CTR_INPUT_MUX(pm07_control)	(((pm07_control) >> 26) & 0x3f)
+#define CBE_PM_CTR_INPUT_CONTROL		0x02000000
+#define CBE_PM_CTR_POLARITY			0x01000000
+#define CBE_PM_CTR_COUNT_CYCLES			0x00800000
+#define CBE_PM_CTR_ENABLE			0x00400000
 
+/* Macros for the pm_status register. */
+#define CBE_PM_CTR_OVERFLOW_INTR(ctr)		(1 << (31 - ((ctr) & 7)))
 
 union spe_reg {
 	u64 val;

--
