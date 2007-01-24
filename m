Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 60DF0DDFE2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:36 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0OL7Zxa028922
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:35 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7Wit029305
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:32 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKntP8008154
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:55 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 66C644B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:31 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7VWY010613
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:31 -0600
Date: Wed, 24 Jan 2007 15:07:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/18] Bootwrapper compatibility layer for old U-Boots (a.k.a.
	cuImage, cuboot)
Message-ID: <20070124210731.GP10527@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/Kconfig         |   21 +++++
 arch/powerpc/boot/.gitignore |    2 +
 arch/powerpc/boot/Makefile   |   13 +++-
 arch/powerpc/boot/cuboot.c   |  170 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ppcboot.h  |  103 +++++++++++++++++++++++++
 arch/powerpc/boot/wrapper    |   41 ++++++++---
 6 files changed, 339 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0855d55..d933f8c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -910,6 +910,27 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config COMPAT_UIMAGE
+	bool "Build kernel for old non-device-tree PPCBoot/U-Boot"
+	depends on DEFAULT_UIMAGE
+	default n
+	help
+	  If selected, the kernel will be built for older U-Boot
+	  (and PPCBoot) bootloaders that pass a bd_t instead of
+	  a device tree.  Such a kernel will not work with a newer
+	  U-Boot that passes the device tree itself.  If your
+	  U-Boot does not mention a device tree in "help bootm",
+	  say Y.
+
+config CUIMAGE_DTS
+	string "Device tree source file"
+	depends on COMPAT_UIMAGE
+	help
+	  This specifies the device tree source (.dts) file to
+	  be compiled and included in the kernel image.  If
+	  a relative filename is given, then it will be relative
+	  to arch/powerpc/boot/dts.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 0734b2f..ff8852d 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -18,6 +18,8 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 uImage
+uImage.bin.gz
+uImage.elf
 zImage
 zImage.chrp
 zImage.coff
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e95c1b0..39b7149 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,7 +44,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 
 src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S $(zlib)
-src-plat := of.c
+src-plat := of.c cuboot.c
 src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -121,6 +121,12 @@ quiet_cmd_wrap_initrd = WRAP    $@
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
 
@@ -157,8 +163,13 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+ifeq ($(CONFIG_COMPAT_UIMAGE),y)
+$(obj)/uImage: vmlinux $(wrapperbits)
+	$(call cmd,wrap_dt,cuboot)
+else
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
+endif
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
diff --git a/arch/powerpc/boot/cuboot.c b/arch/powerpc/boot/cuboot.c
new file mode 100644
index 0000000..6f2729e
--- /dev/null
+++ b/arch/powerpc/boot/cuboot.c
@@ -0,0 +1,170 @@
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
+extern struct ft_cxt fdtm_cxt;
+extern char _start[], _end[];
+
+static void set_memory(void)
+{
+	void *devp;
+	unsigned long mem[2] = { bd.bi_memstart, bd.bi_memsize };
+
+	devp = finddevice("/memory");
+	if (!devp) {
+		ft_begin_tree(&fdtm_cxt);
+		ft_begin_node(&fdtm_cxt, "memory");
+		ft_prop_str(&fdtm_cxt, "device_type", "memory");
+		ft_end_node(&fdtm_cxt);
+
+		devp = finddevice("/memory");
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
+	if (!devp) {
+		ft_begin_tree(&fdtm_cxt);
+		ft_begin_node(&fdtm_cxt, "chosen");
+		ft_end_node(&fdtm_cxt);
+
+		devp = finddevice("/chosen");
+	}
+
+	setprop(devp, "bootargs", (void *)cmdline_start, cmdline_size);
+}
+
+static void *set_one_mac(void *last_node, unsigned char *addr)
+{
+	void *node = ft_find_prop_str(&fdtm_cxt, last_node,
+	                              "device_type", "network");
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
+	while ((node = ft_find_prop_str(&fdtm_cxt, node,
+	                                "device_type", "cpu"))) {
+		unsigned long tbfreq;
+
+		setprop(node, "clock-frequency", &bd.bi_intfreq,
+		        sizeof(bd.bi_intfreq));
+		setprop(node, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+#ifdef CONFIG_6xx
+		tbfreq = bd.bi_busfreq / 4;
+#elif defined(CONFIG_E500)
+		tbfreq = bd.bi_busfreq / 8;
+#else
+#error Unknown timebase frequency.
+#endif
+
+		setprop(node, "timebase-frequency", &tbfreq, sizeof(tbfreq));
+	}
+
+#if defined(CONFIG_83xx) || defined(CONFIG_85xx) || defined(CONFIG_86xx)
+	node = ft_find_prop_str(&fdtm_cxt, NULL, "device_type", "soc");
+	if (node) {
+		void *serial;
+
+		setprop(node, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+		serial = ft_find_device_rel(&fdtm_cxt, node, "serial@4500");
+		if (serial)
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+
+		serial = ft_find_device_rel(&fdtm_cxt, node, "serial@4600");
+		if (serial)
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+	}
+#endif
+}
+
+/* There's not enough room on 8MiB boards to put the full
+ * heap (including a kernel image) after _end, but the device
+ * tree cannot stay in a heap that is before _start, or it
+ * will get overwritten when the kernel relocates itself.
+ *
+ * Ideally, we wouldn't move the kernel at all if not uncompressing,
+ * but that requires making sure all platforms leave enough room
+ * after _end for the BSS when setting up the heap.
+ */
+static unsigned long cuboot_finalize(void)
+{
+	struct boot_param_header *dt =
+		(struct boot_param_header *)ft_finalize();
+
+	memcpy(_end, dt, dt->totalsize);
+	return (unsigned long)_end;
+}
+
+int platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                  unsigned long r6, unsigned long r7,
+                  char *dt_blob_start, char *dt_blob_end)
+{
+	memcpy(&bd, (bd_t *)r3, sizeof(bd));
+	initrd.addr = r4;
+	initrd.size = r4 ? r5 : 0;
+
+	if (simple_alloc_init(0, (unsigned long)_start - 0x80000, 4096, 32) >
+	    (void *)_start)
+		return -1;
+	if (ft_init(dt_blob_start, dt_blob_end - dt_blob_start, 32))
+		return -1;
+
+	set_memory();
+	set_bootargs(r6, r7 - r6 + 1);
+	set_mac_addrs();
+	set_clocks();
+
+	dt_ops.finalize = cuboot_finalize;
+	return serial_console_init();
+}
diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
new file mode 100644
index 0000000..d9782ae
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
+#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx) ||\
+	defined(CONFIG_83xx)
+	unsigned long	bi_immr_base;	/* base of IMMR register */
+#endif
+#if defined(CONFIG_PPC_MPC52xx)
+	unsigned long   bi_mbar_base;   /* base of internal registers */
+#endif
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
+	unsigned long	bi_ip_addr;	/* IP Address */
+	unsigned char	bi_enetaddr[6];	/* Ethernet address */
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
+#if defined(CONFIG_CPM2)
+	unsigned long	bi_cpmfreq;	/* CPM_CLK Freq, in MHz */
+	unsigned long	bi_brgfreq;	/* BRG_CLK Freq, in MHz */
+	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
+	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
+#endif
+#if defined(CONFIG_PPC_MPC52xx)
+	unsigned long   bi_ipbfreq;     /* IPB Bus Freq, in MHz */
+	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
+#endif
+	unsigned long	bi_baudrate;	/* Console Baudrate */
+#if defined(CONFIG_4xx)
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
+	unsigned int	bi_procfreq;	/* CPU (Internal) Freq, in Hz */
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+#endif
+#if defined(CONFIG_HYMOD)
+	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
+#endif
+#if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
+	defined(CONFIG_85xx) ||	defined(CONFIG_83xx)
+	/* second onboard ethernet port */
+	unsigned char	bi_enet1addr[6];
+#define HAVE_ENET1ADDR
+#endif
+#if defined(CONFIG_EVB64260) || defined(CONFIG_440GX) || defined(CONFIG_85xx)
+	/* third onboard ethernet ports */
+	unsigned char	bi_enet2addr[6];
+#define HAVE_ENET2ADDR
+#endif
+#if defined(CONFIG_440GX)
+	/* fourth onboard ethernet ports */
+	unsigned char	bi_enet3addr[6];
+#define HAVE_ENET3ADDR
+#endif
+#if defined(CONFIG_4xx)
+	unsigned int	bi_opbfreq;		/* OB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+#if defined(CONFIG_440GX)
+	int		bi_phynum[4];		/* phy mapping */
+	int		bi_phymode[4];		/* phy mode */
+#endif
+} bd_t;
+
+#define bi_tbfreq	bi_intfreq
+
+#endif	/* __PPCBOOT_H__ */
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 024e4d4..a1539c7 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -29,6 +29,7 @@ initrd=
 dtb=
 dts=
 cacheit=
+gzip=.gz
 
 # cross-compilation prefix
 CROSS=
@@ -106,7 +107,7 @@ if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
 	dtb="$platform.dtb"
     fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+    dtc -f -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
 fi
 
 if [ -z "$kernel" ]; then
@@ -137,31 +138,44 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+cuboot)
+    platformo=$object/cuboot.o
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
+
+    vmz="$vmz$gzip"
 fi
 
-case "$platform" in
-uboot)
-    rm -f "$ofile"
+if [ "$platform" = uboot -o "$platform" = cuboot ]; then
     version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
 	cut -d' ' -f3`
     if [ -n "$version" ]; then
 	version="-n Linux-$version"
     fi
+fi
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
@@ -173,9 +187,9 @@ addsec() {
 	--set-section-flags=$3=contents,alloc,load,readonly,data
 }
 
-addsec $tmp "$vmz.gz" $ksection $object/empty.o
+addsec $tmp "$vmz" $ksection $object/empty.o
 if [ -z "$cacheit" ]; then
-    rm -f "$vmz.gz"
+    rm -f "$vmz"
 fi
 
 if [ -n "$initrd" ]; then
@@ -204,4 +218,11 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start 0x500000 "$ofile"
     $object/hack-coff "$ofile"
     ;;
+cuboot)
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
+    gzip -f -9 "$ofile".bin
+    mkimage -A ppc -O linux -T kernel -C gzip -a 00400000 -e 00400010 \
+            $version -d "$ofile".bin.gz "$ofile"
+    ;;
 esac
-- 
1.4.4
