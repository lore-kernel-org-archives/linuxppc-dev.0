Return-Path: <mgreer@mvista.com>
Date: Fri, 11 May 2007 17:54:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell MPSC
Message-ID: <20070512005431.GC3365@mag.az.mvista.com>
References: <20070512004605.GA2808@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070512004605.GA2808@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The bootwrapper requires a serial driver to allow cmdline editing
and information reporting on the console.  This driver is required
by platforms that boot a zImage and use the MPSC for the console.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 arch/powerpc/boot/Makefile |    2 
 arch/powerpc/boot/mpsc.c   |  170 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h    |    1 
 arch/powerpc/boot/serial.c |    2 
 4 files changed, 174 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/boot/mpsc.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/boot/mpsc.c
@@ -0,0 +1,170 @@
+/*
+ * MPSC/UART driver for the Marvell mv64360, mv64460, ...
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+
+extern void udelay(long delay);
+
+#define MPSC_CHR_1		0x000c
+
+#define MPSC_CHR_2		0x0010
+#define MPSC_CHR_2_TA		(1<<7)
+#define MPSC_CHR_2_TCS		(1<<9)
+#define MPSC_CHR_2_RA		(1<<23)
+#define MPSC_CHR_2_CRD		(1<<25)
+#define MPSC_CHR_2_EH		(1<<31)
+
+#define MPSC_CHR_4		0x0018
+#define MPSC_CHR_4_Z		(1<<29)
+
+#define MPSC_CHR_5		0x001c
+#define MPSC_CHR_5_CTL1_INTR	(1<<12)
+#define MPSC_CHR_5_CTL1_VALID	(1<<15)
+
+#define MPSC_CHR_10		0x0030
+
+#define MPSC_INTR_CAUSE		0x0000
+#define MPSC_INTR_CAUSE_RCC	(1<<6)
+#define MPSC_INTR_MASK		0x0080
+
+#define SDMA_SDCM		0x0008
+#define SDMA_SDCM_AR		(1<<15)
+#define SDMA_SDCM_AT		(1<<31)
+
+static volatile char *mpsc_base;
+static volatile char *mpscintr_base;
+static u32 chr1, chr2;
+
+static int mpsc_open(void)
+{
+	chr1 = in_le32((u32 *)(mpsc_base + MPSC_CHR_1)) & 0x00ff0000;
+	chr2 = in_le32((u32 *)(mpsc_base + MPSC_CHR_2)) & ~(MPSC_CHR_2_TA
+			| MPSC_CHR_2_TCS | MPSC_CHR_2_RA | MPSC_CHR_2_CRD
+			| MPSC_CHR_2_EH);
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_4), MPSC_CHR_4_Z);
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_5),
+			MPSC_CHR_5_CTL1_INTR | MPSC_CHR_5_CTL1_VALID);
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_2), chr2 | MPSC_CHR_2_EH);
+	return 0;
+}
+
+static void mpsc_putc(unsigned char c)
+{
+	while (in_le32((u32 *)(mpsc_base + MPSC_CHR_2)) & MPSC_CHR_2_TCS);
+
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_1), chr1 | c);
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_2), chr2 | MPSC_CHR_2_TCS);
+}
+
+static unsigned char mpsc_getc(void)
+{
+	u32 cause = 0;
+	unsigned char c;
+
+	while (!(cause & MPSC_INTR_CAUSE_RCC))
+		cause = in_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE));
+
+	c = in_8((u8 *)(mpsc_base + MPSC_CHR_10 + 2));
+	out_8((u8 *)(mpsc_base + MPSC_CHR_10 + 2), c);
+	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE),
+			cause & ~MPSC_INTR_CAUSE_RCC);
+
+	return c;
+}
+
+static u8 mpsc_tstc(void)
+{
+	return (u8)((in_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE))
+				& MPSC_INTR_CAUSE_RCC) != 0);
+}
+
+static void mpsc_stop_dma(volatile char *sdma_base)
+{
+	out_le32((u32 *)(mpsc_base + MPSC_CHR_2),MPSC_CHR_2_TA | MPSC_CHR_2_RA);
+	out_le32((u32 *)(sdma_base + SDMA_SDCM), SDMA_SDCM_AR | SDMA_SDCM_AT);
+
+	while ((in_le32((u32 *)(sdma_base + SDMA_SDCM))
+				& (SDMA_SDCM_AR | SDMA_SDCM_AT)) != 0)
+		udelay(100);
+}
+
+static volatile char *mpsc_get_virtreg_of_phandle(void *devp, char *prop)
+{
+	void *v;
+	int n;
+
+	n = getprop(devp, prop, &v, sizeof(v));
+	if (n != sizeof(v))
+		goto err_out;
+
+	devp = find_node_by_linuxphandle((u32)v);
+	if (devp == NULL)
+		goto err_out;
+
+	n = getprop(devp, "virtual-reg", &v, sizeof(v));
+	if (n == sizeof(v))
+		return v;
+
+err_out:
+	return NULL;
+}
+
+int mpsc_console_init(void *devp, struct serial_console_data *scdp)
+{
+	void *v;
+	int n, reg_set;
+	volatile char *sdma_base;
+
+	n = getprop(devp, "virtual-reg", &v, sizeof(v));
+	if (n != sizeof(v))
+		goto err_out;
+	mpsc_base = v;
+
+	sdma_base = mpsc_get_virtreg_of_phandle(devp, "sdma");
+	if (sdma_base == NULL)
+		goto err_out;
+
+	mpscintr_base = mpsc_get_virtreg_of_phandle(devp, "mpscintr");
+	if (mpscintr_base == NULL)
+		goto err_out;
+
+	n = getprop(devp, "block-index", &v, sizeof(v));
+	if (n != sizeof(v))
+		goto err_out;
+	reg_set = (int)v;
+
+	mpscintr_base += (reg_set == 0) ? 0x4 : 0xc;
+
+	/* Make sure the mpsc ctlrs are shutdown */
+	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE), 0);
+	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE), 0);
+	out_le32((u32 *)(mpscintr_base + MPSC_INTR_MASK), 0);
+	out_le32((u32 *)(mpscintr_base + MPSC_INTR_MASK), 0);
+
+	mpsc_stop_dma(sdma_base);
+
+	scdp->open = mpsc_open;
+	scdp->putc = mpsc_putc;
+	scdp->getc = mpsc_getc;
+	scdp->tstc = mpsc_tstc;
+	scdp->close = NULL;
+
+	return 0;
+
+err_out:
+	return -1;
+}
Index: powerpc/arch/powerpc/boot/serial.c
===================================================================
--- powerpc.orig/arch/powerpc/boot/serial.c
+++ powerpc/arch/powerpc/boot/serial.c
@@ -125,6 +125,8 @@ int serial_console_init(void)
 
 	if (!strcmp(compat, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
+	else if (!strcmp(compat, "marvell,mpsc"))
+		rc = mpsc_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
Index: powerpc/arch/powerpc/boot/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/boot/Makefile
+++ powerpc/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c \
-		44x.c ebony.c mv64x60.c
+		44x.c ebony.c mv64x60.c mpsc.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c
 src-boot := $(src-wlib) $(src-plat) empty.c
Index: powerpc/arch/powerpc/boot/ops.h
===================================================================
--- powerpc.orig/arch/powerpc/boot/ops.h
+++ powerpc/arch/powerpc/boot/ops.h
@@ -79,6 +79,7 @@ void start(void);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
+int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
