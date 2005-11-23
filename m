Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B6508687F6
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 04:50:34 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: <tglx@linutronix.de>
Date: Wed, 23 Nov 2005 18:50:30 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNKEMMCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1132754409.32542.161.camel@tglx.tec.linutronix.de>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Subject: RE: [PATCH]	MTD:	Add support for the PM82x Boards.
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

i made the changes in the code you suggested to me.

Additional changes:
- I now use the CFI interface (I tested it, and it seems OK
  to me)
- MB -> MiB
- Code reworked

[PATCH]	MTD:	Add support for the PM82x Board.

Included support for the NOR flashes on the Modul,
and for the DiskOnChip on the Board.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
 drivers/mtd/maps/Kconfig      |    6 +
 drivers/mtd/maps/Makefile     |    1 
 drivers/mtd/maps/pm82x.c      |  337 +++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/diskonchip.c |    4 
 4 files changed, 348 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 846a533..237abe8 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -256,6 +256,12 @@ config MTD_SBC8240
           Flash access on the SBC8240 board from Wind River.  See
           <http://www.windriver.com/products/sbc8240/>
 
+config MTD_PM82X
+	tristate "Flash device on PM82X Boards"
+	depends on PPC32 && 6xx && 8260 && MTD_COMPLEX_MAPPINGS && MTD_PARTITIONS
+	help
+	  Flash access on the PM82X boards from Microsys.
+
 config MTD_TQM8XXL
 	tristate "CFI Flash device mapped on TQM8XXL"
 	depends on MTD_CFI && TQM8xxL
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 7d9e940..e3733b1 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_PQ2FADS)	+= pq2fads.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
+obj-$(CONFIG_MTD_PM82X)	+= pm82x.o
diff --git a/drivers/mtd/maps/pm82x.c b/drivers/mtd/maps/pm82x.c
new file mode 100644
index 0000000..840fc29
--- /dev/null
+++ b/drivers/mtd/maps/pm82x.c
@@ -0,0 +1,337 @@
+/*
+ * Copyright(C) 2005
+ * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
+ *
+ * Copyright(C) 2005
+ * Josef Wagner, MicroSys GmbH <wagner@microsys.de>
+ *
+ * This code is GPLed
+ *
+ */
+
+/*
+ * PM825/PM826 uses 4 x Intel 28F160C3B (16 Mbit)
+ * 4 x Intel 28F160C3 (16 Mbit) in one bank (64 bit bankwidth)
+ * for a total of 8MiB flash
+ *
+ * PM827/PM828 uses 4 x Intel 28F640C3 (64 Mbit)
+ * in one bank (64 bit bankwidth)
+ * for a total of 32MiB flash
+
+ * Thus we have to chose:
+ * - Support 64-bit bankwidth => CONFIG_MTD_CFI_B8
+ * - Support 4-chip flash interleave => CONFIG_MTD_CFI_I4
+*/
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+#include <asm/ppcboot.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#define FLASH_BANK_MAX 1
+
+/* The "residual" data board information structure the boot loader
+ * hands to us.
+ */
+extern unsigned char __res[];
+
+/* trivial struct to describe partition information */
+struct mtd_part_def
+{
+	int nums;
+	unsigned char *type;
+	struct mtd_partition* mtd_part;
+};
+
+static struct mtd_info* mtd_banks[FLASH_BANK_MAX];
+static struct map_info* map_banks[FLASH_BANK_MAX];
+static struct mtd_part_def part_banks[FLASH_BANK_MAX];
+static unsigned long num_banks;
+static __iomem void *start_scan_addr;
+
+static map_word pm82x_read64(struct map_info *map, unsigned long ofs)
+{
+	map_word val;
+	val.x[0] = *((volatile __u32 *)(map->map_priv_1 + ofs));
+	val.x[1] = *(((volatile __u32 *)(map->map_priv_1 + ofs)) + 1);
+	return val;
+}
+
+static void pm82x_copy_from(struct map_info *map,
+		void *to, unsigned long from, ssize_t len)
+{
+	memcpy_fromio(to, (void *)(map->map_priv_1 + from), len);
+}
+
+static void pm82x_write64 (struct map_info *map, map_word map_d,
+		unsigned long adr)
+{
+	ulong addr = map->map_priv_1 + adr;
+	__u64 d = ((__u64)map_d.x[0] << 32) + map_d.x[1];
+	__u64 * data = &d;
+	ulong flags;
+	volatile ulong msr;
+	ulong saved_msr;
+	volatile long saved_fr[2];
+
+	local_irq_save (flags);
+
+	__asm__ __volatile__ ("mfmsr %0" : "=r" (msr):);
+	saved_msr = msr;
+	msr |= MSR_FP;
+	msr &= ~(MSR_FE0 | MSR_FE1);
+
+	__asm__ __volatile__ (
+		"mtmsr %0\n"
+		"isync\n"
+		:
+		: "r" (msr));
+
+	__asm__ __volatile__ (
+		"stfd 1, 0(%2)\n"
+		"lfd  1, 0(%0)\n"
+		"stfd 1, 0(%1)\n"
+		"lfd  1, 0(%2)\n"
+		 :
+		 : "r" (data), "r" (addr), "b" (saved_fr)
+	);
+
+	__asm__ __volatile__ (
+		"mtmsr %0\n"
+		"isync\n"
+		:
+		: "r" (saved_msr));
+
+	local_irq_restore (flags);
+}
+
+static void pm82x_copy_to(struct map_info *map,
+		unsigned long to, const void *from, ssize_t len)
+{
+	memcpy_toio((void *)(map->map_priv_1 + to), from, len);
+}
+
+/*
+ * The following defines the partition layout of PM825/PM826 boards.
+ *
+ * See include/linux/mtd/partitions.h for definition of the
+ * mtd_partition structure.
+ *
+ */
+
+#ifdef CONFIG_MTD_PARTITIONS
+/* partition definition for first (and only) flash bank
+ * also ref. to "drivers/char/flash_config.c"
+ */
+static struct mtd_partition pm82x_partitions_8M[] = {
+	{
+		.name =		"U-Boot",		/* U-Boot image		*/
+		.offset =	0x00000000,
+		.size =		0x00040000,		/* 256 KB		*/
+	},
+	{
+		.name =		"kernel",		/* Linux kernel image	*/
+		.offset =	0x00040000,
+		.size =		0x000C0000,		/* 768 KB		*/
+	},
+	{
+		.name =		"ramdisk",		/* Ramdisk image	*/
+		.offset =	0x00100000,
+		.size =		0x00300000,		/* 3 MiB		*/
+	},
+	{
+		.name =		"user",			/* User file system	*/
+		.offset =	0x00400000,
+		.size =		0x00400000,		/* 4 MiB		*/
+	},
+};
+
+static struct mtd_partition pm82x_partitions_32M[] = {
+	{
+		.name =		"U-Boot",		/* U-Boot image		*/
+		.offset =	0x00000000,
+		.size =		0x00040000,		/* 256 KB		*/
+	},
+	{
+		.name = 	"kernel",		/* Linux kernel image	*/
+		.offset =	0x00040000,
+		.size =		0x000C0000,		/* 768 KB		*/
+	},
+	{
+		.name =		"ramdisk",		/* Ramdisk image	*/
+		.offset =	0x00100000,
+		.size =		0x00300000,		/* 3 MiB		*/
+	},
+	{
+		.name =		"user",			/* User file system	*/
+		.offset =	0x00400000,
+		.size =		0x01C00000,		/* 28 MiB		*/
+	},
+};
+
+#endif	/* CONFIG_MTD_PARTITIONS */
+
+int __init init_pm82x_mtd(void)
+{
+	int idx = 0, ret = 0;
+	unsigned long flash_addr, flash_size, mtd_size = 0;
+
+	/* pointer to PM82x board info data */
+	bd_t *bd = (bd_t *)__res;
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	int n;
+	const char *part_probes[] = { "cmdlinepart", NULL };
+#endif
+
+	flash_addr = bd->bi_flashstart;
+	flash_size = bd->bi_flashsize;
+
+	/* request maximum flash size address space */
+	start_scan_addr = ioremap(flash_addr, flash_size);
+	if (!start_scan_addr) {
+		printk(KERN_ERR "%s: Failed to ioremap address: 0x%lx\n",
+			__FUNCTION__, flash_addr);
+		return -EIO;
+	}
+
+	for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
+		if (mtd_size >= flash_size)
+			break;
+
+		pr_debug ("%s: chip probing count %d\n", __FUNCTION__, idx);
+
+		map_banks[idx] = kmalloc(sizeof(struct map_info) + 16, 
+								GFP_KERNEL);
+		if (map_banks[idx] == NULL) {
+			ret = -ENOMEM;
+			goto error_mem;
+		}
+		memset(map_banks[idx]->name, 0, 16);
+		sprintf(map_banks[idx]->name, "PM82x-%d", idx);
+		map_banks[idx]->size	  = flash_size;
+		map_banks[idx]->bankwidth = 8;
+		map_banks[idx]->read	  = pm82x_read64;
+		map_banks[idx]->copy_from = pm82x_copy_from;
+		map_banks[idx]->write	  = pm82x_write64;
+		map_banks[idx]->copy_to	  = pm82x_copy_to;
+		map_banks[idx]->map_priv_1= (unsigned long)
+			start_scan_addr + ((idx > 0) ?
+			(mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0);
+
+		/* start to probe flash chips */
+		mtd_banks[idx] = do_map_probe("cfi_probe", map_banks[idx]);
+		if (mtd_banks[idx]) {
+			mtd_banks[idx]->owner = THIS_MODULE;
+			mtd_size += mtd_banks[idx]->size;
+			num_banks++;
+			pr_debug ("%s: bank %ld, name: %s, size: %d bytes \n",
+				__FUNCTION__,
+				num_banks,
+				mtd_banks[idx]->name,
+				mtd_banks[idx]->size);
+		}
+	}
+
+	/* no supported flash chips found */
+	if (!num_banks) {
+		printk(KERN_ERR "PM82x: No supported flash chips found!\n");
+		ret = -ENXIO;
+		goto error_mem;
+	}
+
+#ifdef CONFIG_MTD_PARTITIONS
+	/*
+	 * Select static partition definitions
+	 */
+	if (flash_size == 0x800000) {
+		part_banks[0].mtd_part	= pm82x_partitions_8M;
+		part_banks[0].nums	= ARRAY_SIZE(pm82x_partitions_8M);
+	} else {
+		part_banks[0].mtd_part	= pm82x_partitions_32M;
+		part_banks[0].nums	= ARRAY_SIZE(pm82x_partitions_32M);
+	}
+	part_banks[0].type	= "static image";
+
+	for(idx = 0; idx < num_banks ; idx++) {
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+		n = parse_mtd_partitions(mtd_banks[idx],
+						part_probes,
+						&part_banks[idx].mtd_part,
+						0);
+		pr_debug ("%s: %d command line partitions on bank %d\n",
+			__FUNCTION__, n, idx);
+		if (n > 0) {
+			part_banks[idx].type = "command line";
+			part_banks[idx].nums = n;
+		}
+#endif	/* CONFIG_MTD_CMDLINE_PARTS */
+
+		if (part_banks[idx].nums == 0) {
+			printk (KERN_NOTICE
+					"PM82x flash bank %d: no partition info "
+					"available, registering whole device\n", idx);
+			add_mtd_device(mtd_banks[idx]);
+		} else {
+			printk (KERN_NOTICE
+					"PM82x flash bank %d: Using %s partition "
+					"definition\n", idx, part_banks[idx].type);
+			add_mtd_partitions (mtd_banks[idx],
+					part_banks[idx].mtd_part,
+					part_banks[idx].nums);
+		}
+	}
+#else	/* ! CONFIG_MTD_PARTITIONS */
+	printk (KERN_NOTICE "PM82x flash: registering %d flash banks "
+			"at once\n", num_banks);
+
+	for(idx = 0 ; idx < num_banks ; idx++)
+		add_mtd_device(mtd_banks[idx]);
+
+#endif	/* CONFIG_MTD_PARTITIONS */
+
+	return 0;
+error_mem:
+	for (idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
+		if (map_banks[idx] != NULL) {
+			kfree(map_banks[idx]);
+			map_banks[idx] = NULL;
+		}
+	}
+	iounmap(start_scan_addr);
+
+	return ret;
+}
+
+static void __exit cleanup_pm82x_mtd(void)
+{
+	unsigned int idx = 0;
+	for(idx = 0 ; idx < num_banks ; idx++) {
+		/* destroy mtd_info previously allocated */
+		if (mtd_banks[idx]) {
+			del_mtd_partitions(mtd_banks[idx]);
+			map_destroy(mtd_banks[idx]);
+		}
+		/* release map_info not used anymore */
+		kfree(map_banks[idx]);
+	}
+	if (start_scan_addr) {
+		iounmap(start_scan_addr);
+		start_scan_addr = NULL;
+	}
+}
+
+module_init(init_pm82x_mtd);
+module_exit(cleanup_pm82x_mtd);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wolfgang Denk <wd@denx.de>");
+MODULE_DESCRIPTION("MTD map driver for PM82x boards");
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 21d4e8f..bf7cf54 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -55,7 +55,11 @@ static unsigned long __initdata doc_loca
 	0xe8000, 0xea000, 0xec000, 0xee000,
 #endif /*  CONFIG_MTD_DOCPROBE_HIGH */
 #elif defined(__PPC__)
+#if defined(CONFIG_PM82X)
+	0xff800000,
+#else
 	0xe4000000,
+#endif
 #elif defined(CONFIG_MOMENCO_OCELOT)
 	0x2f000000,
         0xff000000,
