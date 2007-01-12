Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13643DE133
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:19:03 +1100 (EST)
Date: Fri, 12 Jan 2007 10:18:38 +0900 (JST)
Message-Id: <200701120118.l0C1IdGH004976@toshiba.co.jp>
Subject: [PATCH 18/19] powerpc: Basic supports for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds base support for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/Kconfig
diff -u linux-powerpc-git/arch/powerpc/Kconfig:1.1.1.3 linux-powerpc-git/arch/powerpc/Kconfig:1.10
--- linux-powerpc-git/arch/powerpc/Kconfig:1.1.1.3	Thu Jan 11 11:16:20 2007
+++ linux-powerpc-git/arch/powerpc/Kconfig	Thu Jan 11 13:50:43 2007
@@ -532,6 +532,16 @@
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
 
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+	select PPC_UDBG_BEAT
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO
+
 config PPC_NATIVE
 	bool
 	depends on PPC_MULTIPLATFORM
@@ -545,6 +555,11 @@
 	depends on PPC_RTAS
 	default n
 
+config PPC_UDBG_BEAT
+	bool "BEAT based debug console"
+	depends on PPC_CELLEB
+	default n
+
 config XICS
 	depends on PPC_PSERIES
 	bool
Index: linux-powerpc-git/arch/powerpc/Kconfig.debug
diff -u linux-powerpc-git/arch/powerpc/Kconfig.debug:1.1.1.1 linux-powerpc-git/arch/powerpc/Kconfig.debug:1.3
--- linux-powerpc-git/arch/powerpc/Kconfig.debug:1.1.1.1	Wed Dec  6 08:25:42 2006
+++ linux-powerpc-git/arch/powerpc/Kconfig.debug	Wed Dec 13 21:26:13 2006
@@ -185,6 +185,13 @@
 	  Select this to enable early debugging for legacy iSeries. You need
 	  to hit "Ctrl-x Ctrl-x" to see the messages on the console.
 
+config PPC_EARLY_DEBUG_BEAT
+	bool "Beat HV Console"
+	depends on PPC_CELLEB
+	select PPC_UDBG_BEAT
+	help
+	  Select this to enable early debugging for Celleb with Beat.
+
 endchoice
 
 endmenu
Index: linux-powerpc-git/arch/powerpc/boot/Makefile
diff -u linux-powerpc-git/arch/powerpc/boot/Makefile:1.1.1.2 linux-powerpc-git/arch/powerpc/boot/Makefile:1.3
--- linux-powerpc-git/arch/powerpc/boot/Makefile:1.1.1.2	Thu Jan 11 11:16:20 2007
+++ linux-powerpc-git/arch/powerpc/boot/Makefile	Thu Jan 11 13:50:43 2007
@@ -162,6 +162,7 @@
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= zImage.ps3
+image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
Index: linux-powerpc-git/arch/powerpc/platforms/Makefile
diff -u linux-powerpc-git/arch/powerpc/platforms/Makefile:1.1.1.2 linux-powerpc-git/arch/powerpc/platforms/Makefile:1.3
--- linux-powerpc-git/arch/powerpc/platforms/Makefile:1.1.1.2	Thu Jan 11 11:16:31 2007
+++ linux-powerpc-git/arch/powerpc/platforms/Makefile	Thu Jan 11 13:50:43 2007
@@ -17,4 +17,5 @@
 obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
+obj-$(CONFIG_PPC_CELLEB)	+= celleb/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.8
--- /dev/null	Thu Jan 11 22:03:30 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile	Wed Dec 13 21:26:13 2006
@@ -0,0 +1,9 @@
+obj-y				+= interrupt.o iommu.o setup.o \
+				   htab.o beat.o pci.o \
+				   scc_epci.o hvCall.o
+
+obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
+obj-$(CONFIG_USB)		+= scc_uhc.o
+obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
+obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o spu_manage.o
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c:1.5
--- /dev/null	Thu Jan 11 22:03:31 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c	Tue Jan  9 16:56:57 2007
@@ -0,0 +1,163 @@
+/*
+ * Simple routines for Celleb/Beat
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+
+#include <asm/hvconsole.h>
+#include <asm/time.h>
+
+#include "beat_wrapper.h"
+#include "beat.h"
+
+void beat_restart(char *cmd)
+{
+	beat_shutdown_logical_partition(1);
+}
+
+void beat_power_off(void)
+{
+	beat_shutdown_logical_partition(0);
+}
+
+u64 beat_halt_code = 0x1000000000000000UL;
+
+void beat_halt(void)
+{
+	beat_shutdown_logical_partition(beat_halt_code);
+}
+
+int beat_set_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+	tim = mktime(rtc_time->tm_year+1900,
+		     rtc_time->tm_mon+1, rtc_time->tm_mday,
+		     rtc_time->tm_hour, rtc_time->tm_min, rtc_time->tm_sec);
+	if (beat_rtc_write(tim))
+		return -1;
+	return 0;
+}
+
+void beat_get_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+
+	if (beat_rtc_read(&tim))
+		tim = 0;
+	to_tm(tim, rtc_time);
+	rtc_time->tm_year -= 1900;
+	rtc_time->tm_mon -= 1;
+}
+
+#define	BEAT_NVRAM_SIZE	4096
+
+ssize_t beat_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		if (beat_eeprom_read(i, len, p)) {
+			return -EIO;
+		}
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		if (beat_eeprom_write(i, len, p)) {
+			return -EIO;
+		}
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_get_size(void)
+{
+	return BEAT_NVRAM_SIZE;
+}
+
+int beat_set_xdabr(unsigned long dabr)
+{
+	if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
+		return -1;
+	return 0;
+}
+
+int64_t beat_get_term_char(u64 vterm, u64 *len, u64 *t1, u64 *t2)
+{
+	u64 db[2];
+	s64 ret;
+
+	ret = beat_get_characters_from_console(vterm, len, (u8*)db);
+	if (ret == 0) {
+		*t1 = db[0];
+		*t2 = db[1];
+	}
+	return ret;
+}
+
+int64_t beat_put_term_char(u64 vterm, u64 len, u64 t1, u64 t2)
+{
+	u64 db[2];
+
+	db[0] = t1;
+	db[1] = t2;
+	return beat_put_characters_to_console(vterm, len, (u8*)db);
+}
+
+EXPORT_SYMBOL(beat_get_term_char);
+EXPORT_SYMBOL(beat_put_term_char);
+EXPORT_SYMBOL(beat_halt_code);
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h:1.2
--- /dev/null	Thu Jan 11 22:03:31 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h	Tue Jan  9 11:37:49 2007
@@ -0,0 +1,40 @@
+/*
+ * Guest OS Interfaces.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_BEAT_H
+#define _CELLEB_BEAT_H
+
+#define DABRX_KERNEL		(1UL<<1)
+#define DABRX_USER		(1UL<<0)
+
+int64_t beat_get_term_char(uint64_t,uint64_t*,uint64_t*,uint64_t*);
+int64_t beat_put_term_char(uint64_t,uint64_t,uint64_t,uint64_t);
+int64_t beat_repository_encode(int, const char *, uint64_t[4]);
+void beat_restart(char *);
+void beat_power_off(void);
+void beat_halt(void);
+int beat_set_rtc_time(struct rtc_time *);
+void beat_get_rtc_time(struct rtc_time *);
+ssize_t beat_nvram_get_size(void);
+ssize_t beat_nvram_read(char *, size_t, loff_t *);
+ssize_t beat_nvram_write(char *, size_t, loff_t *);
+int beat_set_xdabr(unsigned long);
+
+#endif /* _CELLEB_BEAT_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.19
--- /dev/null	Thu Jan 11 22:03:31 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Thu Jan 11 21:34:46 2007
@@ -0,0 +1,191 @@
+/*
+ * Celleb setup code
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/setup.c:
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/kexec.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/irq.h>
+#include <asm/spu_priv1.h>
+#include <asm/firmware.h>
+#include <asm/of_platform.h>
+
+#include "interrupt.h"
+#include "beat_wrapper.h"
+#include "beat.h"
+#include "pci.h"
+
+static char celleb_machine_type[128] = "Celleb";
+
+static void celleb_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	/* using "CHRP" is to trick anaconda into installing FCx into Celleb */
+	seq_printf(m, "machine\t\t: %s %s\n", celleb_machine_type, model);
+	of_node_put(root);
+}
+
+static int celleb_machine_type_hack(char *ptr)
+{
+	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
+	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
+	return 0;
+}
+
+__setup("celleb_machine_type_hack", celleb_machine_type_hack);
+
+static void celleb_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static void __init celleb_setup_arch(void)
+{
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops = &spu_priv1_beat_ops;
+	spu_management_ops = &spu_management_beat_ops;
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_celleb();
+#endif
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	if (ROOT_DEV == 0) {
+		printk("No ramdisk, default root is /dev/hda2\n");
+		ROOT_DEV = Root_HDA2;
+	}
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+}
+
+static void beat_power_save(void)
+{
+	beat_pause(0);
+}
+
+static int __init celleb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Beat"))
+		return 0;
+
+	powerpc_firmware_features |= FW_FEATURE_CELLEB_POSSIBLE;
+	hpte_init_beat();
+	return 1;
+}
+
+/*
+ * Cell has no legacy IO; anything calling this function has to
+ * fail or bad things will happen
+ */
+static int celleb_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
+static void celleb_kexec_cpu_down(int crash, int secondary)
+{
+	beatic_deinit_IRQ();
+}
+
+static struct of_device_id celleb_bus_ids[] = {
+	{ .type = "scc", },
+	{ .type = "ioif", },	/* old style */
+	{},
+};
+
+static int __init celleb_publish_devices(void)
+{
+	if (!machine_is(celleb))
+		return 0;
+
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
+
+	return 0;
+}
+device_initcall(celleb_publish_devices);
+
+define_machine(celleb) {
+	.name			= "Cell Reference Set",
+	.probe			= celleb_probe,
+	.setup_arch		= celleb_setup_arch,
+	.show_cpuinfo		= celleb_show_cpuinfo,
+	.restart		= beat_restart,
+	.power_off		= beat_power_off,
+	.halt			= beat_halt,
+	.get_rtc_time		= beat_get_rtc_time,
+	.set_rtc_time		= beat_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.check_legacy_ioport	= celleb_check_legacy_ioport,
+	.progress		= celleb_progress,
+	.power_save		= beat_power_save,
+	.nvram_size		= beat_nvram_get_size,
+	.nvram_read		= beat_nvram_read,
+	.nvram_write		= beat_nvram_write,
+	.set_dabr		= beat_set_xdabr,
+	.init_IRQ		= beatic_init_IRQ,
+	.get_irq		= beatic_get_irq,	
+	.pci_probe_mode 	= celleb_pci_probe_mode,
+	.pci_setup_phb		= celleb_setup_phb,
+#ifdef CONFIG_KEXEC
+	.kexec_cpu_down		= celleb_kexec_cpu_down,
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c:1.3
--- /dev/null	Thu Jan 11 22:03:31 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/smp.c	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,124 @@
+/*
+ * SMP support for Celleb platform. (Incomplete)
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/smp.c:
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ * Plus various changes from other IBM teams...
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/threads.h>
+#include <linux/cpu.h>
+
+#include <asm/irq.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "interrupt.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/*
+ * The primary thread of each non-boot processor is recorded here before
+ * smp init.
+ */
+/* static cpumask_t of_spin_map; */
+
+/**
+ * smp_startup_cpu() - start the given cpu
+ *
+ * At boot time, there is nothing to do for primary threads which were
+ * started from Open Firmware.  For anything else, call RTAS with the
+ * appropriate start location.
+ *
+ * Returns:
+ *	0	- failure
+ *	1	- success
+ */
+static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+{
+	return 0;
+}
+
+static void smp_beatic_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		beatic_cause_IPI(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			beatic_cause_IPI(i, msg);
+		}
+	}
+}
+
+static int __init smp_beatic_probe(void)
+{
+	return cpus_weight(cpu_possible_map);
+}
+
+static void __devinit smp_beatic_setup_cpu(int cpu)
+{
+	beatic_setup_cpu(cpu);
+}
+
+static void __devinit smp_celleb_kick_cpu(int nr)
+{
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	if (!smp_startup_cpu(nr))
+		return;
+}
+
+static int smp_celleb_cpu_bootable(unsigned int nr)
+{
+	return 1;
+}
+static struct smp_ops_t bpa_beatic_smp_ops = {
+	.message_pass	= smp_beatic_message_pass,
+	.probe		= smp_beatic_probe,
+	.kick_cpu	= smp_celleb_kick_cpu,
+	.setup_cpu	= smp_beatic_setup_cpu,
+	.cpu_bootable	= smp_celleb_cpu_bootable,
+};
+
+/* This is called very early */
+void __init smp_init_celleb(void)
+{
+	DBG(" -> smp_init_celleb()\n");
+
+	smp_ops = &bpa_beatic_smp_ops;
+
+	DBG(" <- smp_init_celleb()\n");
+}
Index: linux-powerpc-git/include/asm-powerpc/firmware.h
diff -u linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/firmware.h:1.3
--- linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/firmware.h	Tue Dec 12 21:59:26 2006
@@ -43,6 +43,7 @@
 #define FW_FEATURE_ISERIES	ASM_CONST(0x0000000000200000)
 #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
 #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
+#define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
 
 #ifndef __ASSEMBLY__
 
@@ -61,6 +62,8 @@
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
+	FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_BEAT,
+	FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_BEAT,
 	FW_FEATURE_NATIVE_POSSIBLE = 0,
 	FW_FEATURE_NATIVE_ALWAYS = 0,
 	FW_FEATURE_POSSIBLE =
@@ -73,6 +76,9 @@
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_POSSIBLE |
 #endif
+#ifdef CONFIG_PPC_CELLEB
+		FW_FEATURE_CELLEB_POSSIBLE |
+#endif
 #ifdef CONFIG_PPC_NATIVE
 		FW_FEATURE_NATIVE_ALWAYS |
 #endif
@@ -87,6 +93,9 @@
 #ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_ALWAYS &
 #endif
+#ifdef CONFIG_PPC_CELLEB
+		FW_FEATURE_CELLEB_ALWAYS &
+#endif
 #ifdef CONFIG_PPC_NATIVE
 		FW_FEATURE_NATIVE_ALWAYS &
 #endif
Index: linux-powerpc-git/include/asm-powerpc/smp.h
diff -u linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/smp.h:1.2
--- linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/smp.h	Wed Dec  6 08:43:16 2006
@@ -75,6 +75,7 @@
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
+void smp_init_celleb(void);
 void smp_setup_cpu_maps(void);
 
 extern int __cpu_disable(void);
