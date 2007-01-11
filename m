Return-Path: <dogoil@etinsys.com>
Received: from jupiter.etinsys.com (unknown [220.76.45.3])
	by ozlabs.org (Postfix) with ESMTP id 07A8ADDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:34:51 +1100 (EST)
Received: from smkim (dogoil.etinsys.com [220.76.45.33])
	by jupiter.etinsys.com (8.13.8/8.13.8) with ESMTP id l0B6RGn1001140
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 15:27:16 +0900 (KST)
Message-Id: <200701110627.l0B6RGn1001140@jupiter.etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] kvme080 board support patch
Date: Thu, 11 Jan 2007 15:26:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch add supports for kvme080 board to linux-2.6.20-rc4 kernel.
kvme080 is a VME board with PowerPC MPC8245 processor.
It has 128MB memory, 2 Ethernets, 4 UARTs and a VME interface.

Regards,
Sangmoon Kim

Signed-off-by: Sangmoon Kim <dogoil@etinsys.com>

diff --git a/arch/powerpc/boot/dts/kvme080.dts
b/arch/powerpc/boot/dts/kvme080.dts
new file mode 100644
index 0000000..8628421
--- /dev/null
+++ b/arch/powerpc/boot/dts/kvme080.dts
@@ -0,0 +1,169 @@
+/*
+ * Device Tree Souce for kvme080
+ *
+ * Copyright 2007 Sangmoon Kim <dogoil@etinsys.com>.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "kvme080";
+	compatible = "kvme080";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8245@0 {
+			device_type = "cpu";
+			reg = <0>;
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+			timebase-frequency = <0>;	// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg =	<00000000 00000000>;		// from bootloader
+	};
+
+	soc8245@fc000000 {
+		device_type = "soc";
+		ranges = <80000000 80000000 70000000	// pci mem space
+			  fc000000 fc000000 00100000	// EUMB
+			  fe000000 fe000000 00c00000	// pci i/o space
+			  fec00000 fec00000 00300000	// pci cfg regs
+			  fef00000 fef00000 00100000	// pci iack
+			  ff080000 ff080000 00000040>;	// UARTs
+		reg = <fc000000 00100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+
+		i2c@fc003000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			clock-frequency = <0>;
+			reg = <fc003000 1000>;
+			interrupts = <32 0>;
+			interrupt-parent = <40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+		};
+
+		pic@fc040000 {
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			reg = <fc040000 40000>;
+			clock-frequency = <0>;
+			serial-mode = <1>;
+			built-in;
+			linux,phandle = <40000>;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+		};
+
+		pci@fec00000 {
+			device_type = "pci";
+			compatible = "8245";
+			reg = <fec00000 00400000>;
+			ranges = <01000000 0        0 fe000000 0 00c00000
+				  02000000 0 80000000 80000000 0 70000000>;
+			bus-range = <0 ff>;
+			interrupt-parent = <40000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				// IDSEL 16
+				8000 0 0 1 40000 0 1
+				8000 0 0 2 40000 1 1
+				8000 0 0 3 40000 2 1
+				8000 0 0 4 40000 3 1
+				// IDSEL 17
+				8800 0 0 1 40000 1 1
+				8800 0 0 2 40000 2 1
+				8800 0 0 3 40000 3 1
+				8800 0 0 4 40000 4 1
+				// IDSEL 18
+				9000 0 0 1 40000 2 1
+				9000 0 0 2 40000 3 1
+				9000 0 0 3 40000 4 1
+				9000 0 0 4 40000 0 1
+				// IDSEL 19
+				9800 0 0 1 40000 3 1
+				9800 0 0 2 40000 4 1
+				9800 0 0 3 40000 0 1
+				9800 0 0 4 40000 1 1
+				// IDSEL 20
+				a000 0 0 1 40000 4 1
+				a000 0 0 2 40000 0 1
+				a000 0 0 3 40000 1 1
+				a000 0 0 4 40000 2 1
+			>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+		};
+
+		serial@ff080000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <ff080000 8>;
+			clock-frequency = <e10000>;
+			current-speed = <1c200>;
+			interrupts = <5 1>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@ff080010 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <ff080010 8>;
+			clock-frequency = <e10000>;
+			current-speed = <1c200>;
+			interrupts = <5 1>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@ff080020 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <ff080020 8>;
+			clock-frequency = <e10000>;
+			current-speed = <1c200>;
+			interrupts = <5 1>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@ff080030 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <ff080030 8>;
+			clock-frequency = <e10000>;
+			current-speed = <1c200>;
+			interrupts = <5 1>;
+			interrupt-parent = <40000>;
+		};
+	};
+
+	nvram@ff000000 {
+		device_type = "nvram";
+		reg = <ff000000 7fff0>;
+	};
+
+	rtc@ff07fff8 {
+		device_type = "rtc";
+		reg = <ff07fff8 8>;
+	};
+};
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig
b/arch/powerpc/platforms/embedded6xx/Kconfig
index b3c2ce4..c3ef832 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -163,6 +163,13 @@ config EV64360
 	help
 	  Select EV64360 if configuring a Marvell EV64360BP Evaluation
 	  platform.
+
+config KVME080
+	bool "KVME080"
+	select MPIC
+	select PPC_UDBG_16550
+	help
+	  Select KVME080 if configuring for a kvme080 board.
 endchoice
 
 config PQ2ADS
@@ -282,13 +289,13 @@ config EPIC_SERIAL_MODE
 
 config MPC10X_BRIDGE
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION ||
KVME080
 	select PPC_INDIRECT_PCI
 	default y
 
 config MPC10X_OPENPIC
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION ||
KVME080
 	default y
 
 config MPC10X_STORE_GATHERING
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile
b/arch/powerpc/platforms/embedded6xx/Makefile
index d3d11a3..5c621bf 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -3,3 +3,4 @@ # Makefile for the 6xx/7xx/7xxxx linux k
 #
 obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
 obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
+obj-$(CONFIG_KVME080)		+= kvme080.o
diff --git a/arch/powerpc/platforms/embedded6xx/kvme080.c
b/arch/powerpc/platforms/embedded6xx/kvme080.c
new file mode 100644
index 0000000..6f904ca
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/kvme080.c
@@ -0,0 +1,298 @@
+/*
+ * Board setup routines for KVME080.
+ *
+ * Copyright 2007 Sangmoon Kim <dogoil@etinsys.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/initrd.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/root_dev.h>
+#include <linux/bcd.h>
+#include <linux/mc146818rtc.h>
+
+#include <asm/time.h>
+#include <asm/i8259.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+static unsigned char *nvram_base = (unsigned char *)NULL;
+static ssize_t nvram_size = 0;
+
+static int __init
+kvme080_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "kvme080"))
+		return 1;
+	return 0;
+}
+
+static int __init
+kvme080_setup_pci(struct device_node *dnp)
+{
+	int len;
+	struct pci_controller *hose;
+	int *bus_range;
+
+	bus_range = (int *) get_property(dnp, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+				" bus 0\n", dnp->full_name);
+
+	hose = pcibios_alloc_controller();
+	if (hose == NULL) {
+		printk("PCI Host bridge init failed\n");
+		return -ENOMEM;
+	}
+	hose->arch_data = dnp;
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	hose->set_cfg_type = 1;
+	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
+
+	printk(KERN_INFO "Found PCI host bridge %s", dnp->full_name);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dnp, 1);
+	return 0;
+}
+
+static void __init
+kvme080_setup_arch(void)
+{
+	struct device_node *dnp;
+	const u32 *prop;
+	u64 size;
+	phys_addr_t paddr;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef	CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+	for (dnp = NULL; (dnp=of_find_node_by_type(dnp,"pci")) != NULL;)
+		kvme080_setup_pci(dnp);
+
+	dnp = of_find_node_by_type(NULL, "nvram");
+	if (dnp) {
+		prop = of_get_address(dnp, 0, &size, NULL);
+		paddr = (phys_addr_t)of_translate_address(dnp, prop);
+		if (paddr != (phys_addr_t)OF_BAD_ADDR) {
+			nvram_size = (ssize_t) size;
+			nvram_base = ioremap(paddr, nvram_size);
+		}
+	}
+
+	printk(KERN_INFO "Etin Systems KVME080 Board\n");
+	printk(KERN_INFO "Port by Sangmoon Kim (dogoil@etinsys.com)\n");
+}
+
+static void __init
+kvme080_init_IRQ(void)
+{
+	struct mpic *mpic;
+	struct device_node *dnp;
+	const u32 *prop;
+	int size;
+	phys_addr_t paddr;
+
+	dnp = of_find_node_by_type(NULL, "open-pic");
+	if (dnp == NULL)
+		return;
+
+	prop = of_get_address(dnp, 0, NULL, NULL);
+	paddr = (phys_addr_t)of_translate_address(dnp, prop);
+
+	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET, 0, 0,
+			  "EPIC");
+
+	prop = (u32 *)get_property(dnp, "serial-mode", &size);
+	if (prop != NULL)
+		mpic_set_serial_int(mpic, *(u32 *)prop);
+
+	mpic_assign_isu(mpic, 0, paddr + 0x10200);
+	mpic_init(mpic);
+}
+
+static void
+kvme080_restart(char *cmd)
+{
+	unsigned long srr;
+
+	local_irq_disable();
+	asm volatile(
+	" lis %0,0xfff0\n \
+	  ori %0,%0,0x0100\n \
+	  mtspr 26,%0\n \
+	  sync\n \
+	  lis %0,0x0000\n \
+	  ori %0,%0,0x0000\n \
+	  mtspr 27,%0\n \
+	  sync\n \
+	  rfi "
+	  : "=r" (srr));
+}
+
+static void
+kvme080_power_off(void)
+{
+	local_irq_disable();
+	for(;;);	/* No way to shut power off with software */
+	/* NOTREACHED */
+}
+
+static void
+kvme080_halt(void)
+{
+	kvme080_power_off();
+	/* NOTREACHED */
+}
+
+extern spinlock_t rtc_lock;
+static unsigned char *rtc_base = (unsigned char*)NULL;
+
+static long __init
+kvme080_time_init(void)
+{
+	char val;
+	struct device_node *dnp;
+	const u32 *prop;
+	u64 size;
+	phys_addr_t paddr;
+
+	dnp = of_find_node_by_type(NULL, "rtc");
+	if (!dnp)
+		return -1;
+
+	prop = of_get_address(dnp, 0, &size, NULL);
+	if (!prop)
+		return -1;
+
+	paddr = (phys_addr_t)of_translate_address(dnp, prop);
+	if (paddr == (phys_addr_t)OF_BAD_ADDR)
+		return -1;
+
+	rtc_base = (unsigned char *)ioremap(paddr, (ssize_t)size);
+
+	if(!rtc_base)
+		return -1;
+
+	spin_lock(&rtc_lock);
+	val = readb(rtc_base);
+	if (val & 0xc0)
+		writeb(val & 0x3f, rtc_base);
+	spin_unlock(&rtc_lock);
+
+	return 0;
+}
+
+static int
+kvme080_set_rtc_time(struct rtc_time *tp)
+{
+	if (!rtc_base)
+		return -1;
+
+	spin_lock(&rtc_lock);
+
+	writeb(readb(rtc_base) | 0x80, rtc_base);
+
+	writeb(BIN2BCD(tp->tm_sec), rtc_base + 1);
+	writeb(BIN2BCD(tp->tm_min), rtc_base + 2);
+	writeb(BIN2BCD(tp->tm_hour), rtc_base + 3);
+	writeb(BIN2BCD(tp->tm_mday), rtc_base + 5);
+	writeb(BIN2BCD(tp->tm_mon), rtc_base + 6);
+	writeb(BIN2BCD(tp->tm_year % 100), rtc_base + 7);
+
+	writeb((readb(rtc_base) & 0x40) |
+	       BIN2BCD((tp->tm_year < 100) ? 20 : 21), rtc_base);
+
+	spin_unlock(&rtc_lock);
+
+	return 0;
+}
+
+static void
+kvme080_get_rtc_time(struct rtc_time *tp)
+{
+	if (!rtc_base)
+		return;
+
+	spin_lock(&rtc_lock);
+
+	writeb(readb(rtc_base) | 0x40, rtc_base);
+
+	tp->tm_sec = readb(rtc_base + 1) & 0x7f;
+	tp->tm_min = readb(rtc_base + 2) & 0x7f;
+	tp->tm_hour = readb(rtc_base + 3) & 0x3f;
+	tp->tm_mday = readb(rtc_base + 5) & 0x3f;
+	tp->tm_mon = readb(rtc_base + 6) & 0x1f;
+	tp->tm_year = readb(rtc_base + 7) & 0xff;
+
+	writeb(readb(rtc_base) & ~0x40, rtc_base);
+
+	tp->tm_sec = BCD2BIN(tp->tm_sec);
+	tp->tm_min = BCD2BIN(tp->tm_min);
+	tp->tm_hour = BCD2BIN(tp->tm_hour);
+	tp->tm_mday = BCD2BIN(tp->tm_mday);
+	tp->tm_mon = BCD2BIN(tp->tm_mon);
+	tp->tm_year = BCD2BIN(tp->tm_year);
+
+	if (tp->tm_year < 80)
+		tp->tm_year += 100;
+
+	spin_unlock(&rtc_lock);
+}
+
+static unsigned char
+kvme080_nvram_read_val(int addr)
+{
+	if (!nvram_base)
+		return 0;
+	return readb(nvram_base + addr);
+}
+
+static void
+kvme080_nvram_write_val(int addr, unsigned char val)
+{
+	if (!nvram_base)
+		return;
+	writeb(val, nvram_base + addr);
+}
+
+static ssize_t
+kvme080_nvram_size(void)
+{
+	return nvram_size;
+}
+
+define_machine(kvme080) {
+	.name			= "kvme080",
+	.probe			= kvme080_probe,
+	.setup_arch		= kvme080_setup_arch,
+	.init_IRQ		= kvme080_init_IRQ,
+	.get_irq		= mpic_get_irq,
+	.restart		= kvme080_restart,
+	.power_off		= kvme080_power_off,
+	.halt			= kvme080_halt,
+	.time_init		= kvme080_time_init,
+	.set_rtc_time		= kvme080_set_rtc_time,
+	.get_rtc_time		= kvme080_get_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.nvram_read_val		= kvme080_nvram_read_val,
+	.nvram_write_val	= kvme080_nvram_write_val,
+	.nvram_size		= kvme080_nvram_size,
+	.progress		= udbg_progress,
+};
diff --git a/arch/powerpc/configs/kvme080_defconfig
b/arch/powerpc/configs/kvme080_defconfig
new file mode 100644
index 0000000..65db375
--- /dev/null
+++ b/arch/powerpc/configs/kvme080_defconfig
@@ -0,0 +1,1276 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.20-rc4
+# Thu Jan 11 11:45:45 2007
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+
+#
+# Processor support
+#
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_86xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_SMP is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+CONFIG_EMBEDDED6xx=y
+# CONFIG_APUS is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_LINKSTATION is not set
+# CONFIG_MPC7448HPC2 is not set
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_EV64360 is not set
+CONFIG_KVME080=y
+CONFIG_MPC10X_BRIDGE=y
+CONFIG_MPC10X_OPENPIC=y
+# CONFIG_MPC10X_STORE_GATHERING is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_MPIC=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=m
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=m
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+CONFIG_CARDBUS=y
+
+#
+# PC-card bridges
+#
+CONFIG_YENTA=m
+CONFIG_YENTA_O2=y
+CONFIG_YENTA_RICOH=y
+CONFIG_YENTA_TI=y
+CONFIG_YENTA_ENE_TUNE=y
+CONFIG_YENTA_TOSHIBA=y
+# CONFIG_PD6729 is not set
+# CONFIG_I82092 is not set
+CONFIG_PCCARD_NONSTATIC=m
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_DCCP=m
+CONFIG_INET_DCCP_DIAG=m
+CONFIG_IP_DCCP_ACKVEC=y
+
+#
+# DCCP CCIDs Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_DCCP_CCID2=m
+# CONFIG_IP_DCCP_CCID2_DEBUG is not set
+CONFIG_IP_DCCP_CCID3=m
+CONFIG_IP_DCCP_TFRC_LIB=m
+# CONFIG_IP_DCCP_CCID3_DEBUG is not set
+CONFIG_IP_DCCP_CCID3_RTO=100
+
+#
+# DCCP Kernel Hacking
+#
+# CONFIG_IP_DCCP_DEBUG is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x7c000000
+CONFIG_MTD_PHYSMAP_LEN=0x1000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+# CONFIG_BLK_DEV_IDECS is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+# CONFIG_MAC_EMUMOUSEBTN is not set
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+# CONFIG_DE2104X is not set
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
+# CONFIG_PCMCIA_XIRCOM is not set
+# CONFIG_PCMCIA_XIRTULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+CONFIG_PCNET32=y
+# CONFIG_PCNET32_NAPI is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+CONFIG_8139TOO=y
+CONFIG_8139TOO_PIO=y
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_CS is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
+CONFIG_NVRAM=y
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=y
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# HID Devices
+#
+CONFIG_HID=y
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
+# Virtualization
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_IOMAP_COPY=y
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
