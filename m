Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:20:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 1/3] powerpc: Add bootwrapper support for Motorola PrPMC2800
	platform
Message-ID: <20070328012046.GB1586@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070328011924.GA1586@mag.az.mvista.com>
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for Motorola ECC PrPMC280/PrPMC2800 Platform.
The PrPMC280 sits on an F101 baseboard and the PrPMC2800 sits on a
F101e baseboard.  Logic has been added to determine which board
(and variant thereof) the code is being run on.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

These patches depend on the patches in the thread with the subject: 
  "[RFC 0/8] powerpc: Add initial arch/powerpc support for Marvell/mv64x60"

 Makefile    |    3 
 prpmc2800.c |  510 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 512 insertions(+), 1 deletion(-)
---

Index: linux-2.6-powerpc-df/arch/powerpc/boot/prpmc2800.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc-df/arch/powerpc/boot/prpmc2800.c
@@ -0,0 +1,510 @@
+/*
+ * Motorola ECC prpmc280/f101 & prpmc2800/f101e platform code.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
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
+#include "gunzip_util.h"
+#include "mv64x60.h"
+
+extern char _end[];
+extern char _vmlinux_start[], _vmlinux_end[];
+extern char _dtb_start[], _dtb_end[];
+
+#define	KB	1024U
+#define	MB	(KB*KB)
+#define	GB	(KB*MB)
+#define MHz	(1000U*1000U)
+#define	GHz	(1000U*MHz)
+
+#define	BOARD_MODEL	"PrPMC2800"
+#define	BOARD_MODEL_MAX	32 /* max strlen(BOARD_MODEL) + 1 */
+
+BSS_STACK(16*KB);
+
+static u8 *bridge_base;
+
+typedef enum {
+	BOARD_MODEL_PRPMC280,
+	BOARD_MODEL_PRPMC2800,
+} prpmc2800_board_model;
+
+typedef enum {
+	BRIDGE_TYPE_MV64360,
+	BRIDGE_TYPE_MV64362,
+} prpmc2800_bridge_type;
+
+struct prpmc2800_board_info {
+	prpmc2800_board_model model;
+	char variant;
+	prpmc2800_bridge_type bridge_type;
+	u8 subsys0;
+	u8 subsys1;
+	u8 vpd4;
+	u8 vpd4_mask;
+	u32 core_speed;
+	u32 mem_size;
+	u32 boot_flash;
+	u32 user_flash;
+};
+
+static struct prpmc2800_board_info prpmc2800_board_info[] = {
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'a',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'b',
+		.bridge_type	= BRIDGE_TYPE_MV64362,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x01,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 0,
+		.user_flash	= 0,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'c',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x02,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 733*MHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'd',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x03,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 1*GB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'e',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x04,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'f',
+		.bridge_type	= BRIDGE_TYPE_MV64362,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x05,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 733*MHz,
+		.mem_size	= 128*MB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 0,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'g',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x06,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 256*MB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 0,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC280,
+		.variant	= 'h',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xff,
+		.subsys1	= 0xff,
+		.vpd4		= 0x07,
+		.vpd4_mask	= 0x0f,
+		.core_speed	= 1*GHz,
+		.mem_size	= 1*GB,
+		.boot_flash	= 1*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'a',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xb2,
+		.subsys1	= 0x8c,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'b',
+		.bridge_type	= BRIDGE_TYPE_MV64362,
+		.subsys0	= 0xb2,
+		.subsys1	= 0x8d,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 0,
+		.user_flash	= 0,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'c',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xb2,
+		.subsys1	= 0x8e,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 733*MHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'd',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xb2,
+		.subsys1	= 0x8f,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 1*GHz,
+		.mem_size	= 1*GB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'e',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xa2,
+		.subsys1	= 0x8a,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 1*GHz,
+		.mem_size	= 512*MB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'f',
+		.bridge_type	= BRIDGE_TYPE_MV64362,
+		.subsys0	= 0xa2,
+		.subsys1	= 0x8b,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 733*MHz,
+		.mem_size	= 128*MB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 0,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'g',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xa2,
+		.subsys1	= 0x8c,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 1*GHz,
+		.mem_size	= 2*GB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+	{
+		.model		= BOARD_MODEL_PRPMC2800,
+		.variant	= 'h',
+		.bridge_type	= BRIDGE_TYPE_MV64360,
+		.subsys0	= 0xa2,
+		.subsys1	= 0x8d,
+		.vpd4		= 0x00,
+		.vpd4_mask	= 0x00,
+		.core_speed	= 733*MHz,
+		.mem_size	= 1*GB,
+		.boot_flash	= 2*MB,
+		.user_flash	= 64*MB,
+	},
+};
+
+static struct prpmc2800_board_info *prpmc2800_get_board_info(u8 *vpd)
+{
+	struct prpmc2800_board_info *bip;
+	int i;
+
+	for (i=0,bip=prpmc2800_board_info; i<ARRAY_SIZE(prpmc2800_board_info);
+			i++,bip++)
+		if ((vpd[0] == bip->subsys0) && (vpd[1] == bip->subsys1)
+				&& ((vpd[4] & bip->vpd4_mask) == bip->vpd4))
+			return bip;
+
+	return NULL;
+}
+
+/* XXX turn off WDT, DMA engines, timers */
+
+#define EEPROM2_ADDR	0xa4
+#define EEPROM3_ADDR	0xa8
+
+static void prpmc2800_fixups(void)
+{
+	u32 v[2], l;
+	int rc;
+	void *devp;
+	u8 vpd[5];
+	char model[BOARD_MODEL_MAX];
+	struct prpmc2800_board_info *bip;
+
+	if (mv64x60_i2c_open()) {
+		printf("Error: Can't open i2c device\n\r");
+		exit();
+	}
+
+	/* Get VPD from i2c eeprom-2 */
+	memset(vpd, 0, sizeof(vpd));
+	rc = mv64x60_i2c_read(EEPROM2_ADDR, vpd, 0x1fde, 2, sizeof(vpd));
+	if (rc < 0) {
+		printf("Error: Couldn't read eeprom2\n\r");
+		exit();
+	}
+	mv64x60_i2c_close();
+
+	/* Get board type & related info */
+	bip = prpmc2800_get_board_info(vpd);
+	if (bip == NULL) {
+		printf("Error: Unsupported board or corrupted VPD:\n\r");
+		printf("  0x%x 0x%x 0x%x 0x%x 0x%x\n\r",
+				vpd[0], vpd[1], vpd[2], vpd[3], vpd[4]);
+		exit();
+	}
+
+	/* Set /model appropriately */
+	devp = finddevice("/");
+	if (devp == NULL) {
+		printf("Error: Missing '/' device tree node\n\r");
+		exit();
+	}
+	memset(model, 0, BOARD_MODEL_MAX);
+	strncpy(model, BOARD_MODEL, BOARD_MODEL_MAX - 2);
+	l = strlen(model);
+	if (bip->model == BOARD_MODEL_PRPMC280)
+		l--;
+	model[l++] = bip->variant;
+	model[l++] = '\0';
+	setprop(devp, "model", model, l);
+
+	/* Set /cpus/PowerPC,7447/clock-frequency */
+	devp = finddevice("/cpus/PowerPC,7447");
+	if (devp == NULL) {
+		printf("Error: Missing proper /cpus device tree node\n\r");
+		exit();
+	}
+	v[0] = bip->core_speed;
+	setprop(devp, "clock-frequency", &v[0], sizeof(v[0]));
+
+	/* Set /memory/reg size */
+	devp = finddevice("/memory");
+	if (devp == NULL) {
+		printf("Error: Missing /memory device tree node\n\r");
+		exit();
+	}
+	v[0] = 0;
+	v[1] = bip->mem_size;
+	setprop(devp, "reg", v, sizeof(v));
+
+	/* Update /mv64x60/device_type, if this is a mv64362 */
+	if (bip->bridge_type == BRIDGE_TYPE_MV64362) {
+		devp = finddevice("/mv64x60");
+		if (devp == NULL) {
+			printf("Error: Missing /mv64x60 device tree node\n\r");
+			exit();
+		}
+		setprop(devp, "device_type", "mv64362", strlen("mv64362") + 1);
+	}
+
+	/* Set Boot FLASH size */
+	devp = finddevice("/mv64x60/flash@ff800000");
+	if (devp == NULL) {
+		printf("Error: Missing Boot FLASH device tree node\n\r");
+		exit();
+	}
+	rc = getprop(devp, "reg", v, sizeof(v));
+	if (rc != sizeof(v)) {
+		printf("Error: Can't find Boot FLASH reg property\n\r");
+		exit();
+	}
+	v[1] = bip->boot_flash;
+	setprop(devp, "reg", v, sizeof(v));
+
+	/* Set User FLASH size */
+	devp = finddevice("/mv64x60/flash@a0000000");
+	if (devp == NULL) {
+		printf("Error: Missing User FLASH device tree node\n\r");
+		exit();
+	}
+	rc = getprop(devp, "reg", v, sizeof(v));
+	if (rc != sizeof(v)) {
+		printf("Error: Can't find User FLASH reg property\n\r");
+		exit();
+	}
+	v[1] = bip->user_flash;
+	setprop(devp, "reg", v, sizeof(v));
+}
+
+#define MV64x60_MPP_CNTL_0	0xf000
+#define	MV64x60_MPP_CNTL_2	0xf008
+#define	MV64x60_GPP_IO_CNTL	0xf100
+#define	MV64x60_GPP_LEVEL_CNTL	0xf110
+#define	MV64x60_GPP_VALUE_SET	0xf118
+
+static void prpmc2800_reset(void)
+{
+	u32 temp;
+
+	if (bridge_base != 0) {
+		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0));
+		temp &= 0xFFFF0FFF;
+		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL));
+		temp |= 0x00000004;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
+		temp |= 0x00000004;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2));
+		temp &= 0xFFFF0FFF;
+		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL));
+		temp |= 0x00080000;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
+		temp |= 0x00080000;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
+
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_VALUE_SET),
+				0x00080004);
+	}
+
+	for (;;);
+}
+
+static void *prpmc2800_vmlinux_alloc(unsigned long size)
+{
+	void *p = malloc(_ALIGN(size, 4096));
+
+	if (!p) {
+		printf("Can't allocate memory for kernel image!\n\r");
+		exit();
+	}
+	return p;
+}
+
+#define	HEAP_SIZE	(16*MB)
+static struct gunzip_state gzstate;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	struct elf_info ei;
+	char *heap_start, *dtb;
+	int dt_size = _dtb_end - _dtb_start;
+	void *vmlinuz_addr = _vmlinux_start;
+	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
+	char elfheader[256];
+
+	if (dt_size <= 0) /* No fdt */
+		exit();
+
+	/* Start heap after end of the zImage or end of the kernel,
+	 * whichever is higher.  That's so things allocated by
+	 * simple_alloc won't overwrite any part of the zImage or
+	 * get overwritten when the early kernel code decompresses &
+	 * relocates the kernel to 0.
+	 */
+	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
+	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
+
+	if (!parse_elf32(elfheader, &ei))
+		exit();
+
+	heap_start = (char *)_ALIGN(ei.memsize + ei.elfoffset, 4096);
+	heap_start = max(heap_start, (char *)_end);
+
+	if ((unsigned)simple_alloc_init(heap_start, HEAP_SIZE, 2*KB, 16)
+			> (128*MB))
+		exit();
+
+	/* Relocate dtb to safe area past end of zImage & kernel */
+	dtb = malloc(dt_size);
+	if (!dtb)
+		exit();
+	memmove(dtb, _dtb_start, dt_size);
+	if (ft_init(dtb, dt_size, 16))
+		exit();
+
+	/* Need to do some hostbrige init */
+	bridge_base = mv64x60_get_bridge_base();
+	mv64x60_config_ctlr_windows(bridge_base, mv64x60_get_bridge_pbase(),
+			mv64x60_is_coherency());
+
+	platform_ops.fixups = prpmc2800_fixups;
+	platform_ops.vmlinux_alloc = prpmc2800_vmlinux_alloc;
+	platform_ops.exit = prpmc2800_reset;
+
+	if (serial_console_init() < 0)
+		exit();
+}
+
+/* Following code is put at very beginning of zImage */
+asm (" .globl _zimage_start\n _zimage_start:\n b _zimage_start_lib ");
Index: linux-2.6-powerpc-df/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/boot/Makefile
+++ linux-2.6-powerpc-df/arch/powerpc/boot/Makefile
@@ -45,7 +45,7 @@ src-wlib := string.S crt0.S stdio.c main
 		gunzip_util.c devtree.c elf_util.c mv64x60.c mpsc.c \
 		mv64x60_i2c.c $(zlib)
 cuboot-plats := 83xx
-src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
+src-plat := of.c prpmc2800.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -140,6 +140,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_PPC_PRPMC2800)		+= zImage.dts.prpmc2800
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
 
 # For 32-bit powermacs, build the COFF and miboot images
