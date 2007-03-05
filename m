Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 11/15] zImage wrapper for Ebony
In-Reply-To: <20070305032307.GB31417@localhost.localdomain>
Message-Id: <20070305032452.EDB2BDDF1D@ozlabs.org>
Date: Mon,  5 Mar 2007 14:24:52 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for building a zImage wrapper suitable for the
Ebony (440GP) evaluation board.  This supports booting both from uboot
(old versions which don't supply a flattened device tree) and IBM
Openbios (aka "treeboot").

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/Makefile |   33 +++++++
 arch/powerpc/boot/dcr.h    |   85 ++++++++++++++++++++
 arch/powerpc/boot/ebony.c  |  188 +++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/mktree.c |   10 --
 arch/powerpc/boot/wrapper  |   33 +++++++
 5 files changed, 342 insertions(+), 7 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-26 13:25:31.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-26 13:25:33.000000000 +1100
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
-src-plat := of.c
+src-plat := of.c ebony.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -95,6 +95,12 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
 $(obj)/wrapper.a: $(obj-wlib)
 	$(call cmd,bootar)
 
+quiet_cmd_dtc = DTC     $@
+      cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $<
+
+$(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
+	$(call if_changed,dtc)
+
 hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
@@ -103,6 +109,8 @@ extra-y		:= $(obj)/wrapper.a $(obj-plat)
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)
 
+dtc		:= dtc
+
 #############
 # Bits for building various flavours of zImage
 
@@ -120,6 +128,13 @@ quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
+quiet_cmd_wrap_dtb	= WRAP    $@
+      cmd_wrap_dtb	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-d $3 vmlinux
+quiet_cmd_wrap_dtb_initrd = WRAP    $@
+      cmd_wrap_dtb_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+				-d $3 -i $(obj)/ramdisk.image.gz vmlinux
+
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
 
@@ -156,6 +171,21 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+$(obj)/zImage.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb
+	$(call cmd,wrap_dtb,ebony,$(obj)/ebony.dtb)
+
+$(obj)/zImage.initrd.ebony-elf: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/ramdisk.image.gz
+	$(call cmd,wrap_dtb_initrd,ebony,$(obj)/ebony.dtb)
+
+$(obj)/zImage.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
+	$(call cmd,wrap_dtb,ebony-tree,$(obj)/ebony.dtb)
+
+$(obj)/zImage.initrd.ebony: vmlinux $(wrapperbits) $(obj)/ebony.dtb $(obj)/mktree
+	$(call cmd,wrap_dtb_initrd,ebony-tree,$(obj)/ebony.dtb)
+
+$(obj)/uImage.ebony: vmlinux $(wrapperbits)  $(obj)/ebony.dtb
+	$(call cmd,wrap_dtb,ebony-uboot,$(obj)/ebony.dtb)
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
@@ -167,6 +197,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_EBONY)			+= zImage.ebony-elf zImage.ebony uImage.ebony
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-02-26 13:46:05.000000000 +1100
@@ -0,0 +1,188 @@
+/*
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Based on earlier code:
+ * Copyright (C) Paul Mackerras 1997.
+ * Copyright 2002-2005 MontaVista Software Inc.
+ * Copyright (c) 2003, 2004 Zultys Technologies
+
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "dcr.h"
+
+extern char _start[];
+extern char _end[];
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+BSS_STACK(4096);
+
+#define OPENBIOS_MAC_BASE	0xfffffe0c
+#define OPENBIOS_MAC_OFFSET	0xc
+
+static inline u32 mfpvr(void)
+{
+	u32 pvr;
+	asm volatile ("mfpvr	%0" : "=r"(pvr));
+	return pvr;
+}
+
+void poke_tree(const char *path, const char *name, void *val, int size)
+{
+	void *devp;
+	int ret;
+
+	devp = finddevice(path);
+	if (! devp) {
+		printf("Couldn't find node %s to poke\n\r", path);
+		exit();
+	}
+
+	ret = setprop(devp, name, val, size);
+	if (ret != 0) {
+		printf("Couldn't set %s property in %s\n\r", name, path);
+		exit();
+	}
+}
+
+#define poke_tree_val(path, name, val)	\
+	do { \
+		typeof(val) x = val; \
+		poke_tree((path),(name),&x,sizeof(x)); \
+	} while (0)
+
+/* Read the 44x memory controller to get size of system memory. */
+static void ibm44x_fixup_memsize(void)
+{
+	int i;
+	unsigned long memsize, bank_config;
+	u32 memreg[3];
+
+	memsize = 0;
+	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
+		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
+		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
+
+		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
+			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
+	}
+
+	printf("PPC44X: %dM RAM\n\r", memsize / 1024 / 1024);
+	memreg[0] = memreg[1] = 0;
+	memreg[2] = memsize;
+	poke_tree("/memory", "reg", memreg, sizeof(memreg));
+}
+
+/* Calculate 440GP clocks */
+void ibm440gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+{
+	u32 sys0 = mfdcr(DCRN_CPC0_SYS0);
+	u32 cr0 = mfdcr(DCRN_CPC0_CR0);
+	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
+	u32 opdv = CPC0_SYS0_OPDV(sys0);
+	u32 epdv = CPC0_SYS0_EPDV(sys0);
+
+	if (sys0 & CPC0_SYS0_BYPASS) {
+		/* Bypass system PLL */
+		cpu = plb = sysclk;
+	} else {
+		if (sys0 & CPC0_SYS0_EXTSL)
+			/* PerClk */
+			m = CPC0_SYS0_FWDVB(sys0) * opdv * epdv;
+		else
+			/* CPU clock */
+			m = CPC0_SYS0_FBDV(sys0) * CPC0_SYS0_FWDVA(sys0);
+		cpu = sysclk * m / CPC0_SYS0_FWDVA(sys0);
+		plb = sysclk * m / CPC0_SYS0_FWDVB(sys0);
+	}
+
+	opb = plb / opdv;
+	ebc = opb / epdv;
+
+	/* FIXME: Check if this is for all 440GP, or just Ebony */
+	if ((mfpvr() & 0xf0000fff) == 0x40000440)
+		/* Rev. B 440GP, use external system clock */
+		tb = sysclk;
+	else
+		/* Rev. C 440GP, errata force us to use internal clock */
+		tb = cpu;
+
+	if (cr0 & CPC0_CR0_U0EC)
+		/* External UART clock */
+		uart0 = ser_clk;
+	else
+		/* Internal UART clock */
+		uart0 = plb / CPC0_CR0_UDIV(cr0);
+
+	if (cr0 & CPC0_CR0_U1EC)
+		/* External UART clock */
+		uart1 = ser_clk;
+	else
+		/* Internal UART clock */
+		uart1 = plb / CPC0_CR0_UDIV(cr0);
+
+	printf("PPC440GP: SysClk = %dMHz (%x)\n\r",
+	       (sysclk + 500000) / 1000000, sysclk);
+	printf("PPC440GP: CPU clock = %dMHz (%x)\n\r",
+	       (cpu + 500000) / 1000000, cpu);
+	poke_tree_val("/cpus/PowerPC,440GP", "clock-frequency", cpu);
+	printf("PPC440GP: timebase frequency = %dMHz (%x)\n\r",
+	       (tb + 500000) / 1000000, tb);
+	poke_tree_val("/cpus/PowerPC,440GP", "timebase-frequency", tb);
+	printf("PPC440GP: PLB clock = %dMHz (%x)\n\r",
+	       (plb + 500000) / 1000000, plb);
+	poke_tree_val("/plb", "clock-frequency", plb);
+	printf("PPC440GP: OPB clock = %dMHz (%x)\n\r",
+	       (opb + 500000) / 1000000, opb);
+	poke_tree_val("/plb/opb", "clock-frequency", opb);
+	printf("PPC440GP: EBC clock = %dMHz (%x)\n\r",
+	       (ebc + 500000) / 1000000, ebc);
+	printf("PPC440GP: UART0 clock = %dMHz (%x)\n\r",
+	       (uart0 + 500000) / 1000000, uart0);
+	poke_tree_val("/plb/opb/serial@140000200", "clock-frequency", uart0);
+	printf("PPC440GP: UART1 clock = %dMHz (%x)\n\r",
+	       (uart1 + 500000) / 1000000, uart1);
+	poke_tree_val("/plb/opb/serial@140000200", "clock-frequency", uart1);
+}
+
+static void ebony_fixups(void)
+{
+	// FIXME: sysclk should be derived by reading the FPGA registers
+	unsigned long sysclk = 33000000;
+	u8 *mac0, *mac1;
+
+	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
+	ibm44x_fixup_memsize();
+
+	mac0 = (u8 *)OPENBIOS_MAC_BASE;
+	mac1 = (u8 *)(OPENBIOS_MAC_BASE + OPENBIOS_MAC_OFFSET);
+	printf("Ebony: EMAC0 addr %02x:%02x:%02x:%02x:%02x:%02x\n\r",
+	       mac0[0], mac0[1], mac0[2], mac0[3], mac0[4], mac0[5]);
+	poke_tree("/plb/opb/ethernet@140000800", "local-mac-address",
+		  mac0, 6);
+	printf("Ebony: EMAC1 addr %02x:%02x:%02x:%02x:%02x:%02x\n\r",
+	       mac1[0], mac1[1], mac1[2], mac1[3], mac1[4], mac1[5]);
+	poke_tree("/plb/opb/ethernet@140000900", "local-mac-address",
+		  mac1, 6);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
+
+	platform_ops.fixups = ebony_fixups;
+	simple_alloc_init(_end, heapsize, 32, 64);
+	ft_init(_dtb_start, 0, 32);
+	serial_console_init();
+}
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-02-26 13:25:31.000000000 +1100
+++ working-2.6/arch/powerpc/boot/wrapper	2007-02-26 13:25:33.000000000 +1100
@@ -137,6 +137,12 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+*-tree)
+    platformo=$object/"${platform%%-tree}".o
+    ;;
+*-uboot)
+    platformo=$object/"${platform%%-uboot}".o
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -206,4 +212,31 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
+*-tree)
+    mv "$ofile" "$ofile.elf"
+    entry=`objdump -f "$ofile.elf" | grep '^start address ' | \
+	cut -d' ' -f3`
+    $object/mktree "$ofile.elf" "$ofile" 0x00400000 "$entry"
+    if [ -z "$cacheit" ]; then
+	rm -f "$ofile.elf"
+    fi
+    exit 0
+    ;;
+*-uboot)
+    mv "$ofile" "$ofile.elf"
+    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
+	cut -d' ' -f3`
+    if [ -n "$version" ]; then
+	version="-n Linux-$version"
+    fi
+    entry=`objdump -f "$ofile.elf" | grep '^start address ' | \
+	cut -d' ' -f3`
+    ${CROSS}objcopy -O binary "$ofile.elf" "$ofile.bin"
+    mkimage -A ppc -O linux -T kernel -C none -a 0x00400000 -e $entry \
+	$version -d "$ofile.bin" "$ofile"
+    if [ -z "$cacheit" ]; then
+	rm -f "$ofile.elf" "$ofile.bin"
+    fi
+    exit 0
+    ;;
 esac
Index: working-2.6/arch/powerpc/boot/mktree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/mktree.c	2007-02-26 13:25:31.000000000 +1100
+++ working-2.6/arch/powerpc/boot/mktree.c	2007-02-26 13:25:33.000000000 +1100
@@ -46,8 +46,8 @@ int main(int argc, char *argv[])
 	struct	stat	st;
 	boot_block_t	bt;
 
-	if (argc < 3) {
-		fprintf(stderr, "usage: %s <zImage-file> <boot-image> [entry-point]\n",argv[0]);
+	if (argc < 5) {
+		fprintf(stderr, "usage: %s <zImage-file> <boot-image> <load address> <entry point>\n",argv[0]);
 		exit(1);
 	}
 
@@ -61,10 +61,8 @@ int main(int argc, char *argv[])
 	bt.bb_magic = htonl(0x0052504F);
 
 	/* If we have the optional entry point parameter, use it */
-	if (argc == 4)
-		bt.bb_dest = bt.bb_entry_point = htonl(strtoul(argv[3], NULL, 0));
-	else
-		bt.bb_dest = bt.bb_entry_point = htonl(0x500000);
+	bt.bb_dest = htonl(strtoul(argv[3], NULL, 0));
+	bt.bb_entry_point = htonl(strtoul(argv[4], NULL, 0));
 
 	/* We know these from the linker command.
 	 * ...and then move it up into memory a little more so the
Index: working-2.6/arch/powerpc/boot/dcr.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/dcr.h	2007-02-26 13:25:33.000000000 +1100
@@ -0,0 +1,85 @@
+#ifndef _PPC_BOOT_DCR_H_
+#define _PPC_BOOT_DCR_H_
+
+#define mfdcr(rn) \
+	({	\
+		unsigned long rval; \
+		asm volatile("mfdcr %0,%1" : "=r"(rval) : "i"(rn)); \
+		rval; \
+	})
+#define mtdcr(rn, val) \
+	asm volatile("mtdcr %0,%1" : : "i"(rn), "r"(val))
+
+/* 440GP/440GX SDRAM controller DCRs */
+#define DCRN_SDRAM0_CFGADDR				0x010
+#define DCRN_SDRAM0_CFGDATA				0x011
+
+#define 	SDRAM0_B0CR				0x40
+#define 	SDRAM0_B1CR				0x44
+#define 	SDRAM0_B2CR				0x48
+#define 	SDRAM0_B3CR				0x4c
+
+static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR, SDRAM0_B2CR, SDRAM0_B3CR };
+
+#define			SDRAM_CONFIG_BANK_ENABLE        0x00000001
+#define			SDRAM_CONFIG_SIZE_MASK          0x000e0000
+#define			SDRAM_CONFIG_BANK_SIZE(reg)	\
+	(0x00400000 << ((reg & SDRAM_CONFIG_SIZE_MASK) >> 17))
+
+/* 440GP Clock, PM, chip control */
+#define DCRN_CPC0_SR					0x0b0
+#define DCRN_CPC0_ER					0x0b1
+#define DCRN_CPC0_FR					0x0b2
+#define DCRN_CPC0_SYS0					0x0e0
+#define		CPC0_SYS0_TUNE				0xffc00000
+#define		CPC0_SYS0_FBDV_MASK			0x003c0000
+#define		CPC0_SYS0_FBDV(reg)			\
+	((((((reg) & CPC0_SYS0_FBDV_MASK) >> 18) - 1) & 0xf) + 1)
+#define		CPC0_SYS0_FWDVA_MASK			0x00038000
+#define		CPC0_SYS0_FWDVA(reg)			\
+	(8 - (((reg) & CPC0_SYS0_FWDVA_MASK) >> 15))
+#define		CPC0_SYS0_FWDVB_MASK			0x00007000
+#define		CPC0_SYS0_FWDVB(reg)			\
+	(8 - (((reg) & CPC0_SYS0_FWDVB_MASK) >> 12))
+#define		CPC0_SYS0_OPDV_MASK			0x00000c00
+#define		CPC0_SYS0_OPDV(reg)			\
+	((((reg) & CPC0_SYS0_OPDV_MASK) >> 10) + 1)
+#define		CPC0_SYS0_EPDV_MASK			0x00000300
+#define		CPC0_SYS0_EPDV(reg)			\
+	((((reg) & CPC0_SYS0_EPDV_MASK) >> 8) + 1)
+#define		CPC0_SYS0_EXTSL				0x00000080
+#define		CPC0_SYS0_RW_MASK			0x00000060
+#define		CPC0_SYS0_RL				0x00000010
+#define		CPC0_SYS0_ZMIISL_MASK			0x0000000c
+#define		CPC0_SYS0_BYPASS			0x00000002
+#define		CPC0_SYS0_NTO1				0x00000001
+#define DCRN_CPC0_SYS1					0x0e1
+#define DCRN_CPC0_CUST0					0x0e2
+#define DCRN_CPC0_CUST1					0x0e3
+#define DCRN_CPC0_STRP0					0x0e4
+#define DCRN_CPC0_STRP1					0x0e5
+#define DCRN_CPC0_STRP2					0x0e6
+#define DCRN_CPC0_STRP3					0x0e7
+#define DCRN_CPC0_GPIO					0x0e8
+#define DCRN_CPC0_PLB					0x0e9
+#define DCRN_CPC0_CR1					0x0ea
+#define DCRN_CPC0_CR0					0x0eb
+#define		CPC0_CR0_SWE				0x80000000
+#define		CPC0_CR0_CETE				0x40000000
+#define		CPC0_CR0_U1FCS				0x20000000
+#define		CPC0_CR0_U0DTE				0x10000000
+#define		CPC0_CR0_U0DRE				0x08000000
+#define		CPC0_CR0_U0DC				0x04000000
+#define		CPC0_CR0_U1DTE				0x02000000
+#define		CPC0_CR0_U1DRE				0x01000000
+#define		CPC0_CR0_U1DC				0x00800000
+#define		CPC0_CR0_U0EC				0x00400000
+#define		CPC0_CR0_U1EC				0x00200000
+#define		CPC0_CR0_UDIV_MASK			0x001f0000
+#define		CPC0_CR0_UDIV(reg)			\
+	((((reg) & CPC0_CR0_UDIV_MASK) >> 16) + 1)
+#define DCRN_CPC0_MIRQ0					0x0ec
+#define DCRN_CPC0_MIRQ1					0x0ed
+#define DCRN_CPC0_JTAGID				0x0ef
+
+#endif	/* _PPC_BOOT_DCR_H_ */
