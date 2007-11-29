Return-Path: <adolnikov@ru.mvista.com>
Received: from barber.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2426DDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 02:39:22 +1100 (EST)
Received: from barber.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by barber.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id lATFdpbT015047
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 18:39:51 +0300
Received: (from root@localhost)
	by barber.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id lATFdpMS015046
	for linuxppc-dev@ozlabs.org; Thu, 29 Nov 2007 18:39:51 +0300
Date: Thu, 29 Nov 2007 18:39:51 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] PowerPC 74xx: Katana Qp bootwrapper
Message-ID: <20071129153951.GD13751@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129150726.GA13751@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bootwrapper sources for Emerson Katana Qp

Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>

---
 Makefile          |    3
 cuboot-katanaqp.c |  470 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 472 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..92b8fac 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,7 +56,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c cuboot-katanaqp.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -159,6 +159,7 @@ image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
+image-$(CONFIG_PPC_KATANAQP)		+= cuImage.katanaqp
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/boot/cuboot-katanaqp.c b/arch/powerpc/boot/cuboot-katanaqp.c
new file mode 100644
index 0000000..19ba901
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-katanaqp.c
@@ -0,0 +1,470 @@
+/*
+ * Emerson Katana Qp platform code.
+ *
+ * Authors: Vladislav Buzov <buzov@ru.mvista.com>
+ *	    Andrei Dolnikov <adolnikov@ru.mvista.com>
+ *
+ * Based on prpmc2800.c by Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "cuboot.h"
+#include "ppcboot.h"
+#include "types.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+#include "mv64x60.h"
+
+#define Mb	(1024U * 1024U)
+#define Gb	(Mb * 1024U)
+
+#define MHz	(1000U * 1000U)
+#define GHz	(MHz * 1000U)
+
+#define BOARD_MODEL		"Katana-Qp"
+#define BOARD_MODEL_MAX		12	/* max strlen(BOARD_MODEL) + 1 */
+#define BOARD_CFG_MAX		28	/* max strlen(BOARD_CFG) + 1 */
+#define BOARD_MODEL_LEN		(BOARD_MODEL_MAX + BOARD_CFG_MAX)
+
+#define MTD_PART_NODE		"partition"
+#define MTD_PART_NUM		3
+#define MTD_PART_NODE_LEN	20
+#define MTD_PART_MONITOR_SIZE	(1*Mb)
+#define MTD_PART_KERNEL_SIZE	(2*Mb)
+
+/*
+ * CPLD registers definitions
+ */
+#define KATANAQP_CPLD_RCR	0x0004	/* Reset command */
+#define KATANAQP_CPLD_RCR_CPUHR	(1 << 7)
+
+#define KATANAQP_CPLD_JSR	0x0020	/* Jumper settings */
+#define KATANAQP_CPLD_JSR_EBFM	(1 << 6)
+
+#define KATANAQP_CPLD_PSR	0x0030	/* PCI status */
+#define KATANAQP_CPLD_PSR_PMCM	(1 << 1)
+
+#define KATANAQP_CPLD_HCR	0x0044	/* Hardware config */
+
+static bd_t bd;
+
+static u8 *bridge_base;
+static u8 *cpld_base;
+
+typedef enum {
+	KATANAQP_UNKNOWN,
+	KATANAQP_CFG_PRPMC_SINGLE,
+	KATANAQP_CFG_PRPMC_DUAL,
+	KATANAQP_CFG_PT2CC_SINGLE,
+	KATANAQP_CFG_PT5CC_SINGLE,
+	KATANAQP_CFG_MEDIA_DUAL,
+	KATANAQP_CFG_PT2CC_DUAL,
+	KATANAQP_CFG_PT5CC_DUAL,
+	KATANAQP_CFG_PT5CC_CUSTOM,
+	KATANAQP_CFG_MEDIA_SINGLE,
+	KATANAQP_CFG_UNKNOWN,
+} katanaqp_board_model;
+
+static katanaqp_board_model katanaqp_cfg;
+
+struct katanaqp_board_info {
+	char *cfg_name;
+	char eth_phys[3];
+};
+
+struct katanaqp_mtd_part {
+	char *name;
+	u32 size;
+	u32 ro;
+};
+
+static struct katanaqp_board_info katanaqp_board_info[] = {
+
+	[KATANAQP_CFG_PRPMC_SINGLE] = {
+		.cfg_name = "PrPMC Single Core",
+		.eth_phys = {10, 13, 6},
+	},
+
+	[KATANAQP_CFG_PRPMC_DUAL] = {
+		.cfg_name = "PrPMC Dual Core",
+		.eth_phys = {10, 13, 6}
+	},
+
+	[KATANAQP_CFG_PT2CC_SINGLE] = {
+		.cfg_name = "PT2CC Single Core",
+		.eth_phys = {9, 8, 6},
+	},
+
+	[KATANAQP_CFG_PT5CC_SINGLE] = {
+		.cfg_name = "PT5CC Single Core",
+		.eth_phys = {10, 13, 6},
+	},
+
+	[KATANAQP_CFG_MEDIA_DUAL] = {
+		.cfg_name = "Dual Core Media Blade",
+		.eth_phys = {10, 13, 6},
+	},
+
+	[KATANAQP_CFG_PT2CC_DUAL] = {
+		.cfg_name = "PT2CC Dual Core",
+		.eth_phys = {9, 8, 6},
+	},
+
+	[KATANAQP_CFG_PT5CC_DUAL] = {
+		.cfg_name = "PT5CC Dual Core",
+		.eth_phys = {10, 13, 6},
+	},
+
+	[KATANAQP_CFG_MEDIA_SINGLE] = {
+		.cfg_name = "Single Core Media Blade",
+		.eth_phys = {10, 13, 6},
+	},
+};
+
+/*
+ * Second flash bank partition layout.
+ */
+static struct katanaqp_mtd_part katanaqp_mtd_parts[MTD_PART_NUM] = {
+	{
+		.name = "Secondary Monitor",
+		.size = MTD_PART_MONITOR_SIZE,
+		.ro = 1,
+	},
+
+	{
+		.name = "Secondary Kernel",
+		.size = MTD_PART_KERNEL_SIZE,
+	},
+
+	{
+		/* Size depends on actual flash bank size */
+		.name = "Secondary FS",
+	},
+};
+
+static u8 *katanaqp_get_cpld_base(void)
+{
+	u32 v;
+	void *devp;
+
+	devp = finddevice("cpld");
+	if (devp == NULL)
+		fatal("Error: Missing CPLD device tree node\n\r");
+
+	if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
+		fatal("Error: Can't get CPLD base address\n\r");
+
+	return (u8 *) v;
+}
+
+static void katanaqp_get_cfg(void)
+{
+	katanaqp_cfg = in_8(cpld_base + KATANAQP_CPLD_HCR) & 0xf;
+
+	if (katanaqp_cfg > 9)
+		katanaqp_cfg = KATANAQP_UNKNOWN;
+}
+
+static int katanaqp_is_monarch(void)
+{
+	return !(in_8(cpld_base + KATANAQP_CPLD_PSR) &
+		 KATANAQP_CPLD_PSR_PMCM);
+}
+
+static void katanaqp_bridge_setup(void)
+{
+	u32 i, v[12], enables, acc_bits;
+	u32 pci_base_hi, pci_base_lo, size, buf[2];
+	unsigned long cpu_base;
+	int rc;
+	void *devp;
+	u8 *bridge_pbase, is_coherent;
+	struct mv64x60_cpu2pci_win *tbl;
+
+	bridge_pbase = mv64x60_get_bridge_pbase();
+	is_coherent = mv64x60_is_coherent();
+
+	if (is_coherent)
+		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_WB
+		    | MV64x60_PCI_ACC_CNTL_SWAP_NONE
+		    | MV64x60_PCI_ACC_CNTL_MBURST_32_BYTES
+		    | MV64x60_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+	else
+		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_NONE
+		    | MV64x60_PCI_ACC_CNTL_SWAP_NONE
+		    | MV64x60_PCI_ACC_CNTL_MBURST_128_BYTES
+		    | MV64x60_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+	/*
+	 * MV64x60 boot code expects PCI host bridge to have 0 device
+	 * number and access PCI configuration bridge registers by
+	 * DEVFN(0, fn). This is not correct for bridges working in PCI-X
+	 * mode since by default it has 0x1f device number stored in P2P
+	 * configuration register.
+	 */
+	mv64x60_set_pci_bus(bridge_base, 1, 0, 0);
+	
+	mv64x60_config_ctlr_windows(bridge_base, bridge_pbase, is_coherent);
+	mv64x60_config_pci_windows(bridge_base, bridge_pbase, 1, 0, acc_bits);
+
+	/* Get the cpu -> pci i/o & mem mappings from the device tree */
+	devp = finddevice("/mv64x60/pci");
+	if (devp == NULL)
+		fatal("Error: Missing /mv64x60/pci device tree node\n\r");
+
+	rc = getprop(devp, "ranges", v, sizeof(v));
+	if (rc != sizeof(v))
+		fatal("Error: Can't find /mv64x60/pci/ranges property\n\r");
+
+	/* Get the cpu -> pci i/o & mem mappings from the device tree */
+	devp = finddevice("/mv64x60");
+	if (devp == NULL)
+		fatal("Error: Missing /mv64x60 device tree node\n\r");
+
+
+	enables = in_le32((u32 *) (bridge_base + MV64x60_CPU_BAR_ENABLE));
+	enables |= 0x0007fe00;	/* Disable all cpu->pci windows */
+	out_le32((u32 *) (bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
+
+	for (i = 0; i < 12; i += 6) {
+		switch (v[i] & 0xff000000) {
+		case 0x01000000:	/* PCI I/O Space */
+			tbl = mv64x60_cpu2pci_io;
+			break;
+		case 0x02000000:	/* PCI MEM Space */
+			tbl = mv64x60_cpu2pci_mem;
+			break;
+		default:
+			continue;
+		}
+
+		pci_base_hi = v[i + 1];
+		pci_base_lo = v[i + 2];
+		cpu_base = v[i + 3];
+		size = v[i + 5];
+
+		buf[0] = cpu_base;
+		buf[1] = size;
+
+		if (!dt_xlate_addr(devp, buf, sizeof(buf), &cpu_base))
+			fatal("Error: Can't translate PCI address 0x%x\n\r",
+			      (u32) cpu_base);
+
+		mv64x60_config_cpu2pci_window(bridge_base, 1, pci_base_hi,
+					      pci_base_lo, cpu_base, size, tbl);
+	}
+
+	/* Enable cpu->pci1 i/o, cpu->pci1 mem0 */
+	enables &= ~0x0000c000;
+	out_le32((u32 *) (bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
+
+}
+
+/*
+ * Different Katana Qp configurations have different flash sizes varying
+ * from 16Mb to 64Mb. This routine determines an exact flash size and
+ * updates the device tree accordingly.
+ */
+static void katanaqp_flash_fixup(void)
+{
+	u32 flash0_size = 0, flash1_size = 0;
+	u32 total_size, size_left;
+	u32 part, part_offset;
+	u32 rc, v[2];
+	void *devp = NULL, *pp = NULL;
+	char part_node[MTD_PART_NODE_LEN];
+
+	devp = finddevice("/mv64x60/flash");
+	if (devp == NULL) {
+		printf("Missing flash device tree node\n\r");
+		return;
+	}
+
+	/*
+	 * Get fist flash size: bank0, bank1 and total
+	 */
+	flash0_size = mv64x60_get_devcs_size(bridge_base, 0);
+	if (flash0_size == 0)
+		return;
+
+	flash1_size = mv64x60_get_devcs_size(bridge_base, 1);
+	total_size = flash0_size + flash1_size;
+
+	/*
+	 * Set total flash size
+	 */
+	rc = getprop(devp, "reg", v, sizeof(v));
+	if (rc != sizeof(v))
+		fatal("Error: Can't find /mv64x60/flash/reg property\n\r");
+	v[1] = total_size;
+	setprop(devp, "reg", v, sizeof(v));
+
+	/*
+	 * Set Primary FS partition size: up to the end of first flash bank
+	 */
+	pp = find_node_by_prop_value_str(NULL, "label", "Primary FS");
+	if (pp == NULL)
+		fatal("Error: Missing flash Primary FS device tree node\n\r");
+
+	rc = getprop(pp, "reg", v, sizeof(v));
+	if (rc != sizeof(v))
+		fatal("Error: Can't find /mv64x60/flash/partition@3000000 "
+		      "property\n\r");
+
+	v[1] = flash0_size - MTD_PART_MONITOR_SIZE - MTD_PART_KERNEL_SIZE;
+	setprop(pp, "reg", v, sizeof(v));
+
+	if (flash1_size == 0)
+		/* Only 1 flash bank is presented */
+		return;
+
+	/*
+	 * Ok, there is a second flash bank. Let's split it to partitions.
+	 */
+
+	part_offset = flash0_size;
+	size_left = flash1_size;
+
+	/* Skip Secondary Monitor if Boot Failover mechanism is disabled */
+	rc = in_8(cpld_base + KATANAQP_CPLD_JSR) & KATANAQP_CPLD_JSR_EBFM;
+	part = rc ? 0 : 1;
+
+	for (; part < MTD_PART_NUM; part++) {
+
+		sprintf(part_node, "%s@%x", MTD_PART_NODE, part_offset);
+		pp = create_node(devp, part_node);
+		if (pp == NULL)
+			fatal("Error: Can't create new partition node\n\r");
+
+		setprop_str(pp, "label", katanaqp_mtd_parts[part].name);
+
+		if (katanaqp_mtd_parts[part].ro)
+			setprop(pp, "read-only", NULL, 0);
+
+		v[0] = part_offset;
+		v[1] = katanaqp_mtd_parts[part].size;
+		if (v[1] == 0)
+			/* Take all remaining space */
+			v[1] = size_left;
+
+		part_offset += v[1];
+		size_left -= v[1];
+
+		setprop(pp, "reg", v, sizeof(v));
+
+	}
+}
+
+static void katanaqp_fixups(void)
+{
+	u32 l, p, pnum;
+	void *devp = NULL;
+	struct katanaqp_board_info katanaqp_bif;
+	char model[BOARD_MODEL_LEN];
+
+	/* Check Katana Qp configuration */
+	katanaqp_get_cfg();
+	if (katanaqp_cfg == KATANAQP_CFG_UNKNOWN)
+		fatal("Error: Unsupported Katana Qp board configuration\n\r");
+
+	if (katanaqp_cfg == KATANAQP_CFG_PT5CC_CUSTOM) {
+		printf("Katana Qp board custom configuration detected, "
+		       "using device tree defaults. Please, supply a correct "
+		       "device tree\n\r");
+		return;
+	}
+
+	katanaqp_bif = katanaqp_board_info[katanaqp_cfg];
+
+	/*
+	 * Set /model appropriately
+	 */
+	devp = finddevice("/");
+	if (devp == NULL)
+		fatal("Error: Missing '/' device tree node\n\r");
+
+	/*
+	 * Fix Board model name in device tree
+	 */
+	memset(model, 0, BOARD_MODEL_LEN);
+
+	strncpy(model, BOARD_MODEL, BOARD_MODEL_MAX - 1);
+	l = strlen(model);
+	model[l++] = ' ';
+
+	strncpy(&model[l], katanaqp_bif.cfg_name, BOARD_CFG_MAX - 1);
+	l += strlen(&model[l]);
+	model[l++] = '\0';
+
+	setprop(devp, "model", model, l);
+
+	/*
+	 * Do necessary bridge setup if we are monarch
+	 */
+	if (katanaqp_is_monarch())
+		katanaqp_bridge_setup();
+
+	/*
+	 * Fix RAM size and setup MV64460 bridge
+	 */
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+
+	/*
+	 * Fix flash size and partition layout
+	 */
+	katanaqp_flash_fixup();
+
+	/*
+	 * Fix clocks
+	 */
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+
+	/*
+	 * Fix phy addresses
+	 */
+	while ((devp = find_node_by_prop_value_str(devp, "comaptible",
+						   "marvell,mv88e1111"))) {
+		getprop(devp, "block-index", &p, sizeof(p));
+		pnum = katanaqp_bif.eth_phys[p];
+		setprop_val(devp, "reg", pnum);
+	}
+}
+
+static void katanaqp_reset(void)
+{
+
+	/* issue hard reset to the reset command register */
+	if (cpld_base)
+		out_8(cpld_base + KATANAQP_CPLD_RCR,
+		      KATANAQP_CPLD_RCR_CPUHR);
+
+	for (;;) ;
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+
+	CUBOOT_INIT();
+
+	if (ft_init(_dtb_start, _dtb_end - _dtb_start, 16))
+		exit();
+
+	bridge_base = mv64x60_get_bridge_base();
+	cpld_base = katanaqp_get_cpld_base();
+
+	platform_ops.fixups = katanaqp_fixups;
+	platform_ops.exit = katanaqp_reset;
+
+	if (serial_console_init() < 0)
+		exit();
+}
