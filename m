Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:17:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/6] bootwrapper: Add support for the sandpoint platform
Message-ID: <20060719231725.GG3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the Freescale Sandpoint platform
to the bootwrapper.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 Makefile    |    3 +
 mpc10x.c    |  109 ++++++++++++++++++++++++++++++++++++++++++++
 sandpoint.c |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 3e767e5..daad857 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -40,6 +40,9 @@ src-boot := crt0.S string.S stdio.c main
 ifeq ($(CONFIG_PPC_MULTIPLATFORM),y)
 src-boot += of.c
 endif
+ifeq ($(CONFIG_SANDPOINT),y)
+src-boot += sandpoint.c mpc10x.c dink.c serial.c ns16550.c util.S
+endif
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
diff --git a/arch/powerpc/boot/mpc10x.c b/arch/powerpc/boot/mpc10x.c
new file mode 100644
index 0000000..3e4de93
--- /dev/null
+++ b/arch/powerpc/boot/mpc10x.c
@@ -0,0 +1,109 @@
+/*
+ * Freescale mpc10[67] & mpc824[015] specific code.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
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
+
+/* Map B (CHRP Map) Defines */
+#define	MPC10X_MAPB_CNFG_ADDR		0xfec00000
+#define	MPC10X_MAPB_CNFG_DATA		0xfee00000
+
+/* Define offsets for the memory controller registers in the config space */
+#define MPC10X_MCTLR_MEM_START_1	0x80	/* Banks 0-3 */
+#define MPC10X_MCTLR_MEM_START_2	0x84	/* Banks 4-7 */
+#define MPC10X_MCTLR_EXT_MEM_START_1	0x88	/* Banks 0-3 */
+#define MPC10X_MCTLR_EXT_MEM_START_2	0x8c	/* Banks 4-7 */
+
+#define MPC10X_MCTLR_MEM_END_1		0x90	/* Banks 0-3 */
+#define MPC10X_MCTLR_MEM_END_2		0x94	/* Banks 4-7 */
+#define MPC10X_MCTLR_EXT_MEM_END_1	0x98	/* Banks 0-3 */
+#define MPC10X_MCTLR_EXT_MEM_END_2	0x9c	/* Banks 4-7 */
+
+#define MPC10X_MCTLR_MEM_BANK_ENABLES	0xa0
+
+#define	PCI_DEVFN(slot,func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+
+/* Indirect PCI config space access routines */
+static inline void
+pci_indirect_read_config_byte(u32 *cfg_addr, u32 *cfg_data, int devfn,
+		int offset, u8 *val)
+{
+	out_be32(cfg_addr,
+		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
+	*val = in_8((u8 *)(cfg_data + (offset & 3)));
+	return;
+}
+
+static inline void
+pci_indirect_read_config_dword(u32 *cfg_addr, u32 *cfg_data, int devfn,
+		int offset, u32 *val)
+{
+	out_be32(cfg_addr,
+		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
+	*val = in_le32(cfg_data + (offset & 3));
+	return;
+}
+
+/*
+ * Read the memory controller registers to determine the amount of memory in
+ * the system.  This assumes that the firmware has correctly set up the memory
+ * controller registers.
+ * Assume memory map B (CHRP).
+ */
+u32
+mpc10x_get_mem_size(void)
+{
+	u32 *config_addr, *config_data, val;
+	u32 start, end, total, offset, i;
+	u8 bank_enables;
+
+	config_addr = (u32 *)MPC10X_MAPB_CNFG_ADDR;
+	config_data = (u32 *)MPC10X_MAPB_CNFG_DATA;
+
+	pci_indirect_read_config_byte(config_addr, config_data, PCI_DEVFN(0,0),
+			MPC10X_MCTLR_MEM_BANK_ENABLES, &bank_enables);
+
+	total = 0;
+
+	for (i=0; i<8; i++) {
+		if (bank_enables & (1 << i)) {
+			offset = MPC10X_MCTLR_MEM_START_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			start = (val >> ((i & 3) << 3)) & 0xff;
+
+			offset = MPC10X_MCTLR_EXT_MEM_START_1 + ((i>3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			val = (val >> ((i & 3) << 3)) & 0x03;
+			start = (val << 28) | (start << 20);
+
+			offset = MPC10X_MCTLR_MEM_END_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			end = (val >> ((i & 3) << 3)) & 0xff;
+
+			offset = MPC10X_MCTLR_EXT_MEM_END_1 + ((i > 3) ? 4 : 0);
+			pci_indirect_read_config_dword(config_addr, config_data,
+					PCI_DEVFN(0,0), offset, &val);
+			val = (val >> ((i & 3) << 3)) & 0x03;
+			end = (val << 28) | (end << 20) | 0xfffff;
+
+			total += (end - start + 1);
+		}
+	}
+
+	return total;
+}
diff --git a/arch/powerpc/boot/sandpoint.c b/arch/powerpc/boot/sandpoint.c
new file mode 100644
index 0000000..b5a5462
--- /dev/null
+++ b/arch/powerpc/boot/sandpoint.c
@@ -0,0 +1,147 @@
+/*
+ * Sandpoint specific fixups.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
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
+#define	CPU_824X	0
+#define	CPU_7XX		1
+#define	CPU_7457	2
+#define	CPU_NUM		3
+
+static u32 cpu_pll[CPU_NUM][32] = {
+	[CPU_824X] = { /* 824x */
+		5, 6, 9, 4, 4, 5, 2, 6, 6, 4, 9, 6, 5, 7, 6, 7,
+		4, 5, 4, 6, 7, 8, 8, 4, 6, 5, 8, 6, 6, 5, 7, 0
+	},
+	[CPU_7XX] = { /* 750/755 */
+		0, 15, 14, 2, 4, 13, 20, 9, 6, 11, 8, 10, 16, 12, 7, 0,
+		0,  0,  0, 0, 0,  0,  0, 0, 0,  0, 0,  0,  0,  0, 0, 0
+
+	},
+	[CPU_7457] = { /* 7457 */
+		23, 34, 15, 30, 14, 36,  2, 40,  4, 42, 13, 26, 17, 48, 19, 18,
+		 6, 21, 11, 22,  8, 20, 10, 24, 16, 28, 12, 32, 27, 56,  0, 25
+	}
+};
+
+static struct processor_info {
+	u32	pvr;
+	u32	mask;
+	u32	bus_freq;
+	u32	hid1_shift;
+	u32	hid1_mask;
+	u32	pll_tbl_idx;
+	u32	max_mem;	/* DINK still sets up mem ctlr wrong */
+} processor_info_tbl[] = { /* From cputable -- MHz are only guesses */
+	/* 824x */
+	{ 0x00810000, 0x7fff0000, 100000000, 27, 0x1f, CPU_824X, 0x08000000 },
+	/* 750 */
+	{ 0x00084202, 0xffffffff, 100000000, 28, 0xf, CPU_7XX, 0x08000000 },
+	/* 745/755 */
+	{ 0x00083000, 0xfffff000, 100000000, 28, 0xf, CPU_7XX, 0x08000000 },
+	/* 7447/7457 Rev 1.0 */
+	{ 0x80020100, 0xffffffff, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.1 */
+	{ 0x80020101, 0xffffffff, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447/7457 Rev 1.2 & up*/
+	{ 0x80020000, 0xffff0000, 100000000, 12, 0x1f, CPU_7457, 0x04000000 },
+	/* 7447A */
+	{ 0x80030000, 0xffff0000, 100000000, 12, 0x1f, CPU_7457, 0x80000000 },
+};
+
+static struct processor_info *
+get_processor_info(u32 pvr)
+{
+	struct processor_info *pit = processor_info_tbl;
+	u32 i;
+
+	for (i=0; i<ARRAY_SIZE(processor_info_tbl); i++, pit++)
+		if (pit->pvr == (pvr & pit->mask))
+			return pit;
+	return NULL;
+}
+
+#define	__stringify_1(x)	#x
+#define	__stringify(x)		__stringify_1(x)
+
+#define SPRN_PVR	0x11F	/* Processor Version Register */
+#define SPRN_HID1	0x3F1	/* Hardware Implementation Register 1 */
+#define mfspr(rn)	({unsigned long rval; \
+			asm volatile("mfspr %0," __stringify(rn) \
+				: "=r" (rval)); rval;})
+
+static void
+sandpoint_fixups(void)
+{
+	u32 i, v[2], hid1, max_mem = 0xffffffff;
+	void *devp;
+	struct processor_info *pit;
+	extern u32 mpc10x_get_mem_size(void);
+
+	/* Update cpu's clock-frequency & timebase-frequency in fdt */
+	if ((pit = get_processor_info(mfspr(SPRN_PVR)))
+			&& (devp = finddevice("/cpus/PowerPC,603e"))) {
+
+		max_mem = pit->max_mem;
+
+		hid1 = (mfspr(SPRN_HID1) >> pit->hid1_shift) & pit->hid1_mask;
+		v[0] = pit->bus_freq * cpu_pll[pit->pll_tbl_idx][hid1]/2;
+		setprop(devp, "clock-frequency", v, sizeof(v[0]));
+
+		v[0] = pit->bus_freq / 4;
+		setprop(devp, "timebase-frequency", v, sizeof(v[0]));
+	}
+
+	/* Get the RAM size from the memory controller & update fdt */
+	if ((devp = finddevice("/memory"))) {
+		i = mpc10x_get_mem_size();
+		v[0] = 0;
+		v[1] = min(i, max_mem);
+		setprop(devp, "reg", v, sizeof(v));
+	}
+
+	/* XXXX stuff from platforms/.../sandpoint.c should be here */
+}
+
+static void
+sandpoint_reset(void)
+{
+	void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+	_nmask_and_or_msr(0, (1<<6)); /* Set exception prefix high - firmware */
+
+	/* Reset system via Port 92 */
+	out_8((volatile unsigned char *)0xfe000092, 0x00);
+	out_8((volatile unsigned char *)0xfe000092, 0x01);
+
+	for(;;);	/* Spin until reset happens */
+}
+
+static struct ops sandpoint_ops;
+static struct platform_ops sandpoint_platform_ops;
+
+struct ops *
+platform_init(void *promptr)
+{
+	sandpoint_platform_ops.fixups = sandpoint_fixups;
+	sandpoint_platform_ops.exit = sandpoint_reset;
+
+	sandpoint_ops.platform_ops = &sandpoint_platform_ops;
+	sandpoint_ops.fw_ops = dink_init();
+	sandpoint_ops.console_ops = ns16550_init();
+
+	return &sandpoint_ops;
+}
