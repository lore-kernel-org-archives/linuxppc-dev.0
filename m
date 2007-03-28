Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:09:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 1/8] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
Message-ID: <20070328010903.GC302@mag.az.mvista.com>
References: <20070328010444.GB302@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070328010444.GB302@mag.az.mvista.com>
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

More will be added in future respins of this patch.

 Makefile  |    2 
 mv64x60.c |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mv64x60.h |   25 ++++++
 3 files changed, 278 insertions(+), 1 deletion(-)
---

diff --git a/arch/powerpc/boot/mv64x60.c b/arch/powerpc/boot/mv64x60.c
Index: powerpc/arch/powerpc/boot/mv64x60.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/boot/mv64x60.c
@@ -0,0 +1,252 @@
+/*
+ * Marvell hostbridge routines
+ *
+ * Author: Mark A. Greer <source@mvista.com>
+ *
+ * 2004, 2005, 2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+#include "mv64x60.h"
+
+#define	MV64x60_CPU2MEM_WINDOWS			4
+#define	MV64x60_CPU_BAR_ENABLE			0x0278
+#define	MV64x60_CPU2MEM_0_BASE			0x0008
+#define	MV64x60_CPU2MEM_0_SIZE			0x0010
+#define	MV64x60_CPU2MEM_1_BASE			0x0208
+#define	MV64x60_CPU2MEM_1_SIZE			0x0210
+#define	MV64x60_CPU2MEM_2_BASE			0x0018
+#define	MV64x60_CPU2MEM_2_SIZE			0x0020
+#define	MV64x60_CPU2MEM_3_BASE			0x0218
+#define	MV64x60_CPU2MEM_3_SIZE			0x0220
+
+#define	MV64x60_ENET2MEM_BAR_ENABLE		0x2290
+#define	MV64x60_ENET2MEM_0_BASE			0x2200
+#define	MV64x60_ENET2MEM_0_SIZE			0x2204
+#define	MV64x60_ENET2MEM_1_BASE			0x2208
+#define	MV64x60_ENET2MEM_1_SIZE			0x220c
+#define	MV64x60_ENET2MEM_2_BASE			0x2210
+#define	MV64x60_ENET2MEM_2_SIZE			0x2214
+#define	MV64x60_ENET2MEM_3_BASE			0x2218
+#define	MV64x60_ENET2MEM_3_SIZE			0x221c
+#define	MV64x60_ENET2MEM_4_BASE			0x2220
+#define	MV64x60_ENET2MEM_4_SIZE			0x2224
+#define	MV64x60_ENET2MEM_5_BASE			0x2228
+#define	MV64x60_ENET2MEM_5_SIZE			0x222c
+#define	MV64x60_ENET2MEM_ACC_PROT_0		0x2294
+#define	MV64x60_ENET2MEM_ACC_PROT_1		0x2298
+#define	MV64x60_ENET2MEM_ACC_PROT_2		0x229c
+
+#define	MV64x60_MPSC2MEM_BAR_ENABLE		0xf250
+#define	MV64x60_MPSC2MEM_0_BASE			0xf200
+#define	MV64x60_MPSC2MEM_0_SIZE			0xf204
+#define	MV64x60_MPSC2MEM_1_BASE			0xf208
+#define	MV64x60_MPSC2MEM_1_SIZE			0xf20c
+#define	MV64x60_MPSC2MEM_2_BASE			0xf210
+#define	MV64x60_MPSC2MEM_2_SIZE			0xf214
+#define	MV64x60_MPSC2MEM_3_BASE			0xf218
+#define	MV64x60_MPSC2MEM_3_SIZE			0xf21c
+#define MV64x60_MPSC_0_REMAP			0xf240
+#define MV64x60_MPSC_1_REMAP			0xf244
+#define	MV64x60_MPSC2MEM_ACC_PROT_0		0xf254
+#define	MV64x60_MPSC2MEM_ACC_PROT_1		0xf258
+#define	MV64x60_MPSC2REGS_BASE			0xf25c
+
+#define	MV64x60_IDMA2MEM_BAR_ENABLE		0x0a80
+#define	MV64x60_IDMA2MEM_0_BASE			0x0a00
+#define	MV64x60_IDMA2MEM_0_SIZE			0x0a04
+#define	MV64x60_IDMA2MEM_1_BASE			0x0a08
+#define	MV64x60_IDMA2MEM_1_SIZE			0x0a0c
+#define	MV64x60_IDMA2MEM_2_BASE			0x0a10
+#define	MV64x60_IDMA2MEM_2_SIZE			0x0a14
+#define	MV64x60_IDMA2MEM_3_BASE			0x0a18
+#define	MV64x60_IDMA2MEM_3_SIZE			0x0a1c
+#define	MV64x60_IDMA2MEM_4_BASE			0x0a20
+#define	MV64x60_IDMA2MEM_4_SIZE			0x0a24
+#define	MV64x60_IDMA2MEM_5_BASE			0x0a28
+#define	MV64x60_IDMA2MEM_5_SIZE			0x0a2c
+#define	MV64x60_IDMA2MEM_6_BASE			0x0a30
+#define	MV64x60_IDMA2MEM_6_SIZE			0x0a34
+#define	MV64x60_IDMA2MEM_7_BASE			0x0a38
+#define	MV64x60_IDMA2MEM_7_SIZE			0x0a3c
+#define	MV64x60_IDMA2MEM_ACC_PROT_0		0x0a70
+#define	MV64x60_IDMA2MEM_ACC_PROT_1		0x0a74
+#define	MV64x60_IDMA2MEM_ACC_PROT_2		0x0a78
+#define	MV64x60_IDMA2MEM_ACC_PROT_3		0x0a7c
+
+static u32 cpu_base_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_CPU2MEM_0_BASE, MV64x60_CPU2MEM_1_BASE,
+	MV64x60_CPU2MEM_2_BASE, MV64x60_CPU2MEM_3_BASE
+};
+
+static u32 cpu_size_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_CPU2MEM_0_SIZE, MV64x60_CPU2MEM_1_SIZE,
+	MV64x60_CPU2MEM_2_SIZE, MV64x60_CPU2MEM_3_SIZE
+};
+
+static u32 enet_base_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_ENET2MEM_0_BASE, MV64x60_ENET2MEM_1_BASE,
+	MV64x60_ENET2MEM_2_BASE, MV64x60_ENET2MEM_3_BASE
+};
+
+static u32 enet_size_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_ENET2MEM_0_SIZE, MV64x60_ENET2MEM_1_SIZE,
+	MV64x60_ENET2MEM_2_SIZE, MV64x60_ENET2MEM_3_SIZE
+};
+
+static u32 mpsc_base_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_MPSC2MEM_0_BASE, MV64x60_MPSC2MEM_1_BASE,
+	MV64x60_MPSC2MEM_2_BASE, MV64x60_MPSC2MEM_3_BASE
+};
+
+static u32 mpsc_size_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_MPSC2MEM_0_SIZE, MV64x60_MPSC2MEM_1_SIZE,
+	MV64x60_MPSC2MEM_2_SIZE, MV64x60_MPSC2MEM_3_SIZE
+};
+
+static u32 idma_base_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_IDMA2MEM_0_BASE, MV64x60_IDMA2MEM_1_BASE,
+	MV64x60_IDMA2MEM_2_BASE, MV64x60_IDMA2MEM_3_BASE
+};
+
+static u32 idma_size_reg[MV64x60_CPU2MEM_WINDOWS] = {
+	MV64x60_IDMA2MEM_0_SIZE, MV64x60_IDMA2MEM_1_SIZE,
+	MV64x60_IDMA2MEM_2_SIZE, MV64x60_IDMA2MEM_3_SIZE
+};
+
+static u32 dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb, 0x7 };
+
+/*
+ * ENET, MPSC, and IDMA ctlrs on the MV64x60 have separate windows that
+ * must be set up so that the respective ctlr can access system memory.
+ * Configure them to be same as cpu->memory windows.
+ */
+void mv64x60_config_ctlr_windows(u8 *bridge_base, u8 *bridge_pbase,
+		u8 cache_coherent)
+{
+	u32 i, base, size, enables, prot = 0, snoop_bits = 0;
+
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_BAR_ENABLE), 0x3f);
+	out_le32((u32 *)(bridge_base + MV64x60_MPSC2MEM_BAR_ENABLE), 0xf);
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_BAR_ENABLE), 0xff);
+
+	if (cache_coherent)
+		snoop_bits = 0x2 << 12; /* Writeback */
+
+	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE)) & 0xf;
+
+	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++) {
+		if (enables & (1 << i)) /* Set means disabled */
+			continue;
+
+		base = in_le32((u32 *)(bridge_base + cpu_base_reg[i])) << 16;
+		base |= snoop_bits | (dram_selects[i] << 8);
+		size = in_le32((u32 *)(bridge_base + cpu_size_reg[i])) << 16;
+		prot |= (0x3 << (i << 1)); /* RW access */
+
+		out_le32((u32 *)(bridge_base + enet_base_reg[i]), base);
+		out_le32((u32 *)(bridge_base + enet_size_reg[i]), size);
+		out_le32((u32 *)(bridge_base + mpsc_base_reg[i]), base);
+		out_le32((u32 *)(bridge_base + mpsc_size_reg[i]), size);
+		out_le32((u32 *)(bridge_base + idma_base_reg[i]), base);
+		out_le32((u32 *)(bridge_base + idma_size_reg[i]), size);
+	}
+
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_ACC_PROT_0), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_ACC_PROT_1), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_ACC_PROT_2), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_MPSC2MEM_ACC_PROT_0), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_MPSC2MEM_ACC_PROT_1), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_IDMA2MEM_ACC_PROT_0), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_IDMA2MEM_ACC_PROT_1), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_IDMA2MEM_ACC_PROT_2), prot);
+	out_le32((u32 *)(bridge_base + MV64x60_IDMA2MEM_ACC_PROT_3), prot);
+
+	/* Set mpsc->bridge's reg window to the bridge's internal registers. */
+	out_le32((u32 *)(bridge_base + MV64x60_MPSC2REGS_BASE),
+			(u32)bridge_pbase);
+
+	out_le32((u32 *)(bridge_base + MV64x60_ENET2MEM_BAR_ENABLE), enables);
+	out_le32((u32 *)(bridge_base + MV64x60_MPSC2MEM_BAR_ENABLE), enables);
+	out_le32((u32 *)(bridge_base + MV64x60_IDMA2MEM_BAR_ENABLE), enables);
+}
+
+/* Read mem ctlr to get the amount of mem in system */
+u32 mv64x60_get_mem_size(u8 *bridge_base)
+{
+	u32 enables, i, v;
+	u32 mem = 0;
+
+	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE)) & 0xf;
+
+	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++)
+		if (!(enables & (1<<i))) {
+			v = in_le32((u32*)(bridge_base + cpu_size_reg[i]));
+			v = ((v & 0xffff) + 1) << 16;
+			mem += v;
+		}
+
+	return mem;
+}
+
+/* Get physical address of bridge's registers */
+u8 *mv64x60_get_bridge_pbase(void)
+{
+	u32 v[2];
+	void *devp;
+
+	devp = finddevice("/mv64x60");
+	if (devp == NULL)
+		goto err_out;
+	if (getprop(devp, "reg", v, sizeof(v)) != sizeof(v))
+		goto err_out;
+
+	return (u8 *)v[0];
+
+err_out:
+	return 0;
+}
+
+/* Get virtual address of bridge's registers */
+u8 *mv64x60_get_bridge_base(void)
+{
+	u32 v;
+	void *devp;
+
+	devp = finddevice("/mv64x60");
+	if (devp == NULL)
+		goto err_out;
+	if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
+		goto err_out;
+
+	return (u8 *)v;
+
+err_out:
+	return 0;
+}
+
+u8 mv64x60_is_coherency(void)
+{
+	u32 v;
+	void *devp;
+
+	devp = finddevice("/");
+	if (devp == NULL)
+		return 1; /* Assume coherency on */
+
+	if (getprop(devp, "coherency-off", &v, sizeof(v)) < 0)
+		return 1; /* Coherency on */
+	else
+		return 0;
+}
Index: powerpc/arch/powerpc/boot/mv64x60.h
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/boot/mv64x60.h
@@ -0,0 +1,25 @@
+/*
+ * Author: Mark A. Greer <source@mvista.com>
+ *
+ * 2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _PPC_BOOT_MV64x60_H_
+#define _PPC_BOOT_MV64x60_H_
+
+void mv64x60_config_ctlr_windows(u8 *bridge_base, u8 *bridge_pbase,
+		u8 cache_coherent);
+u32 mv64x60_get_mem_size(u8 *bridge_base);
+u8 *mv64x60_get_bridge_pbase(void);
+u8 *mv64x60_get_bridge_base(void);
+u8 mv64x60_is_coherency(void);
+
+int mv64x60_i2c_open(void);
+int mv64x60_i2c_read(u32 devaddr, u8 *buf, u32 offset, u32 offset_size,
+		u32 count);
+void mv64x60_i2c_close(void);
+
+#endif /* _PPC_BOOT_MV64x60_H_ */
Index: powerpc/arch/powerpc/boot/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/boot/Makefile
+++ powerpc/arch/powerpc/boot/Makefile
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c devtree.c elf_util.c $(zlib)
+		gunzip_util.c devtree.c elf_util.c mv64x60.c $(zlib)
 cuboot-plats := 83xx
 src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
