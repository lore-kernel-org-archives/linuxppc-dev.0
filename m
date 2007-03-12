Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 032C5DDF64
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:10 +1100 (EST)
Date: Mon, 12 Mar 2007 14:42:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
U-Boot, and inserts data from it into a device tree which has been
compiled into the kernel.  This should help ease the transition to
arch/powerpc in cases where U-Boot has not yet been updated to pass a
device tree, or where upgrading firmware isn't practical.

The device trees currently in the kernel tree must have
/chosen/linux,stdout-path added to work with cuboot.

The kernel command line, mac addresses, and various clocks will be filled
in based on the bd_t.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig                      |   16 ++++
 arch/powerpc/Makefile                     |    2 +-
 arch/powerpc/boot/.gitignore              |    3 +
 arch/powerpc/boot/Makefile                |   20 ++++-
 arch/powerpc/boot/cuboot-83xx.c           |    4 +
 arch/powerpc/boot/cuboot-85xx.c           |    4 +
 arch/powerpc/boot/cuboot-86xx.c           |    4 +
 arch/powerpc/boot/cuboot.c                |  137 +++++++++++++++++++++++++++++
 arch/powerpc/boot/ppcboot.h               |  103 ++++++++++++++++++++++
 arch/powerpc/boot/wrapper                 |   46 ++++++++--
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    5 +-
 11 files changed, 329 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-83xx.c
 create mode 100644 arch/powerpc/boot/cuboot-85xx.c
 create mode 100644 arch/powerpc/boot/cuboot-86xx.c
 create mode 100644 arch/powerpc/boot/cuboot.c
 create mode 100644 arch/powerpc/boot/ppcboot.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6dfbd52..54f7b34 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -967,6 +967,22 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config CUIMAGE_DTS
+	string "Device tree source file"
+	depends on DEFAULT_UIMAGE
+	help
+	  This specifies the device tree source (.dts) file to be
+	  compiled and included when building the cuImage target.  If a
+	  relative filename is given, then it will be relative to
+	  arch/powerpc/boot/dts.
+
+	  The cuImage target is used for booting on older U-Boot (and
+	  PPCBoot) bootloaders that pass a bd_t instead of a device tree.
+	  Such a kernel will not work with a newer U-Boot that passes the
+	  device tree itself.  If your U-Boot does not mention a device
+	  tree in "help bootm", then use the uImage target instead of
+	  cuImage.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8e93565..d9964f2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -152,7 +152,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd uImage cuImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 0734b2f..eec7af7 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -18,6 +18,9 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 uImage
+cuImage
+cuImage.bin.gz
+cuImage.elf
 zImage
 zImage.chrp
 zImage.coff
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1a5a60..7738cc1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -35,6 +35,8 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
+cuboot-plats := 83xx 85xx 86xx
+
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader := zlib.h zconf.h zutil.h
@@ -45,7 +47,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c devtree.c $(zlib)
-src-plat := of.c
+src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -122,6 +124,12 @@ quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
+dts = $(if $(shell echo $(CONFIG_CUIMAGE_DTS) | grep '^/'),\
+       ,$(srctree)/$(src)/dts/)$(CONFIG_CUIMAGE_DTS)
+quiet_cmd_wrap_dt = WRAP    $@
+      cmd_wrap_dt = $(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+                    -s "$(dts)" vmlinux
+
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
 
@@ -158,6 +166,14 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+cuboot-plat-$(CONFIG_83xx) += 83xx
+cuboot-plat-$(CONFIG_85xx) += 85xx
+cuboot-plat-$(CONFIG_86xx) += 86xx
+cuboot-plat-y += unknown-platform
+
+$(obj)/cuImage: vmlinux $(wrapperbits)
+	$(call cmd,wrap_dt,cuboot-$(word 1,$(cuboot-plat-y)))
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
@@ -169,7 +185,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
new file mode 100644
index 0000000..bfa300b
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-83xx.c
@@ -0,0 +1,4 @@
+#define TARGET_83xx
+#define TARGET_6xx
+
+#include "cuboot.c"
diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
new file mode 100644
index 0000000..7774ff8
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -0,0 +1,4 @@
+#define TARGET_85xx
+#define TARGET_E500
+
+#include "cuboot.c"
diff --git a/arch/powerpc/boot/cuboot-86xx.c b/arch/powerpc/boot/cuboot-86xx.c
new file mode 100644
index 0000000..41967a4
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-86xx.c
@@ -0,0 +1,4 @@
+#define TARGET_86xx
+#define TARGET_6xx
+
+#include "cuboot.c"
diff --git a/arch/powerpc/boot/cuboot.c b/arch/powerpc/boot/cuboot.c
new file mode 100644
index 0000000..9689117
--- /dev/null
+++ b/arch/powerpc/boot/cuboot.c
@@ -0,0 +1,137 @@
+/*
+ * Compatibility with old U-Boots
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "flatdevtree.h"
+#include "ppcboot.h"
+
+static bd_t bd;
+extern char _start[], _end[];
+extern char _dtb_start[], _dtb_end[];
+
+static void set_memory(void)
+{
+	void *devp;
+	unsigned long mem[2] = { bd.bi_memstart, bd.bi_memsize };
+
+	devp = finddevice("/memory");
+	if (!devp) {
+		devp = create_node(NULL, "memory");
+		setprop_str(devp, "device_type", "memory");
+	}
+
+	setprop(devp, "reg", mem, sizeof(mem));
+}
+
+static void set_bootargs(unsigned long cmdline_start,
+                         unsigned long cmdline_size)
+{
+	void *devp;
+
+	devp = finddevice("/chosen");
+	if (!devp)
+		devp = create_node(NULL, "chosen");
+
+	setprop(devp, "bootargs", (void *)cmdline_start, cmdline_size);
+}
+
+static void *set_one_mac(void *last_node, unsigned char *addr)
+{
+	void *node = find_node_by_prop_value_str(last_node, "device_type",
+	                                         "network");
+
+	if (node)
+		setprop(node, "local-mac-address", addr, 6);
+
+	return node;
+}
+
+static void set_mac_addrs(void)
+{
+	__attribute__((unused)) void *node =
+		set_one_mac(NULL, bd.bi_enetaddr);
+
+#ifdef HAVE_ENET1ADDR
+	if (node)
+		node = set_one_mac(node, bd.bi_enet1addr);
+#endif
+#ifdef HAVE_ENET2ADDR
+	if (node)
+		node = set_one_mac(node, bd.bi_enet2addr);
+#endif
+#ifdef HAVE_ENET3ADDR
+	if (node)
+		node = set_one_mac(node, bd.bi_enet3addr);
+#endif
+}
+
+static void set_clocks(void)
+{
+	void *node = NULL;
+
+	while ((node = find_node_by_prop_value_str(node, "device_type",
+	                                           "cpu"))) {
+		unsigned long tbfreq;
+
+		setprop(node, "clock-frequency", &bd.bi_intfreq,
+		        sizeof(bd.bi_intfreq));
+		setprop(node, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+#ifdef TARGET_6xx
+		tbfreq = bd.bi_busfreq / 4;
+#elif defined(TARGET_E500)
+		tbfreq = bd.bi_busfreq / 8;
+#else
+#error Unknown timebase frequency.
+#endif
+
+		setprop(node, "timebase-frequency", &tbfreq, sizeof(tbfreq));
+	}
+
+#if defined(TARGET_83xx) || defined(TARGET_85xx) || defined(TARGET_86xx)
+	node = find_node_by_prop_value_str(NULL, "device_type", "soc");
+	if (node) {
+		void *serial;
+
+		setprop(node, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+		serial = finddevice_rel(node, "serial@4500");
+		if (serial)
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+
+		serial = finddevice_rel(node, "serial@4600");
+		if (serial)
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+	}
+#endif
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	memcpy(&bd, (bd_t *)r3, sizeof(bd));
+	loader_info.initrd_addr = r4;
+	loader_info.initrd_size = r4 ? r5 : 0;
+
+	simple_alloc_init(_end, 512 * 1024, 32, 64);
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+
+	set_memory();
+	set_bootargs(r6, r7 - r6 + 1);
+	set_mac_addrs();
+	set_clocks();
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
new file mode 100644
index 0000000..2cbf2a9
--- /dev/null
+++ b/arch/powerpc/boot/ppcboot.h
@@ -0,0 +1,103 @@
+/*
+ * (C) Copyright 2000, 2001
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef __PPCBOOT_H__
+#define __PPCBOOT_H__
+
+/*
+ * Board information passed to kernel from PPCBoot
+ *
+ * include/asm-ppc/ppcboot.h
+ */
+
+#include "types.h"
+
+typedef struct bd_info {
+	unsigned long	bi_memstart;	/* start of DRAM memory */
+	unsigned long	bi_memsize;	/* size	 of DRAM memory in bytes */
+	unsigned long	bi_flashstart;	/* start of FLASH memory */
+	unsigned long	bi_flashsize;	/* size	 of FLASH memory */
+	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
+	unsigned long	bi_sramstart;	/* start of SRAM memory */
+	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
+#if defined(TARGET_8xx) || defined(TARGET_CPM2) || defined(TARGET_85xx) ||\
+	defined(TARGET_83xx)
+	unsigned long	bi_immr_base;	/* base of IMMR register */
+#endif
+#if defined(TARGET_PPC_MPC52xx)
+	unsigned long   bi_mbar_base;   /* base of internal registers */
+#endif
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
+	unsigned long	bi_ip_addr;	/* IP Address */
+	unsigned char	bi_enetaddr[6];	/* Ethernet address */
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
+#if defined(TARGET_CPM2)
+	unsigned long	bi_cpmfreq;	/* CPM_CLK Freq, in MHz */
+	unsigned long	bi_brgfreq;	/* BRG_CLK Freq, in MHz */
+	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
+	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
+#endif
+#if defined(TARGET_PPC_MPC52xx)
+	unsigned long   bi_ipbfreq;     /* IPB Bus Freq, in MHz */
+	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
+#endif
+	unsigned long	bi_baudrate;	/* Console Baudrate */
+#if defined(TARGET_4xx)
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
+	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz */
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+#endif
+#if defined(TARGET_HYMOD)
+	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
+#endif
+#if defined(TARGET_EVB64260) || defined(TARGET_405EP) || defined(TARGET_44x) || \
+	defined(TARGET_85xx) ||	defined(TARGET_83xx)
+	/* second onboard ethernet port */
+	unsigned char	bi_enet1addr[6];
+#define HAVE_ENET1ADDR
+#endif
+#if defined(TARGET_EVB64260) || defined(TARGET_440GX) || defined(TARGET_85xx)
+	/* third onboard ethernet ports */
+	unsigned char	bi_enet2addr[6];
+#define HAVE_ENET2ADDR
+#endif
+#if defined(TARGET_440GX)
+	/* fourth onboard ethernet ports */
+	unsigned char	bi_enet3addr[6];
+#define HAVE_ENET3ADDR
+#endif
+#if defined(TARGET_4xx)
+	unsigned int	bi_opbfreq;		/* OB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+#if defined(TARGET_440GX)
+	int		bi_phynum[4];		/* phy mapping */
+	int		bi_phymode[4];		/* phy mode */
+#endif
+} bd_t;
+
+#define bi_tbfreq	bi_intfreq
+
+#endif	/* __PPCBOOT_H__ */
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 157d8c8..99bf85e 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -29,6 +29,7 @@ initrd=
 dtb=
 dts=
 cacheit=
+gzip=.gz
 
 # cross-compilation prefix
 CROSS=
@@ -104,9 +105,9 @@ done
 
 if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
-	dtb="$platform.dtb"
+	dtb="$tmpdir/$platform.dtb"
     fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+    dtc -f -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
 fi
 
 if [ -z "$kernel" ]; then
@@ -137,31 +138,46 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+cuboot*)
+    platformo=$object/"$platform".o
+    gzip=
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
 if [ -z "$cacheit" -o ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
-    gzip -f -9 "$vmz.$$"
+
+    if [ -n "$gzip" ]; then
+        gzip -f -9 "$vmz.$$"
+    fi
+
     if [ -n "$cacheit" ]; then
-	mv -f "$vmz.$$.gz" "$vmz.gz"
+	mv -f "$vmz.$$$gzip" "$vmz$gzip"
     else
 	vmz="$vmz.$$"
     fi
 fi
 
+vmz="$vmz$gzip"
+
 case "$platform" in
-uboot)
-    rm -f "$ofile"
+uboot|cuboot*)
     version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
 	cut -d' ' -f3`
     if [ -n "$version" ]; then
 	version="-n Linux-$version"
     fi
+    ;;
+esac
+
+case "$platform" in
+uboot)
+    rm -f "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
-	$version -d "$vmz.gz" "$ofile"
+	$version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
-	rm -f $vmz.gz
+	rm -f $vmz
     fi
     exit 0
     ;;
@@ -173,9 +189,9 @@ addsec() {
 	--set-section-flags=$3=contents,alloc,load,readonly,data
 }
 
-addsec $tmp "$vmz.gz" $ksection $object/empty.o
+addsec $tmp "$vmz" $ksection $object/empty.o
 if [ -z "$cacheit" ]; then
-    rm -f "$vmz.gz"
+    rm -f "$vmz"
 fi
 
 if [ -n "$initrd" ]; then
@@ -206,4 +222,14 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
+cuboot*)
+    base=`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
+    entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | \
+           cut -d' ' -f3`
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
+    gzip -f -9 "$ofile".bin
+    mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+            $version -d "$ofile".bin.gz "$ofile"
+    ;;
 esac
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index e5d8191..77c298c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -180,9 +180,10 @@ late_initcall(mpc834x_rtc_hookup);
  */
 static int __init mpc834x_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC834xMDS");
+	return 1;
+	return of_flat_dt_is_compatible(root, "MPC834xMDS");
 }
 
 define_machine(mpc834x_mds) {
-- 
1.5.0.3
