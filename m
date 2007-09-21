Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD4C8DF511
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:09:00 +1000 (EST)
Date: Fri, 21 Sep 2007 18:08:47 -0500 (CDT)
Subject: [PATCH 2/2] qemu platform rom, v2
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <qemu-8-02.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the second rev of patches to boot a powerpc port kernel on
qemu with the prep architecture.

The goal is to provide a environment for use with the existing qemu
hardware suppplied hardware, as oposed to changing the qemu
machine description.

This patch has the changes to the boot wrapper and the device tree.
It applies to the additon of my kexec series to the for-2.6.24 branch
as of 2007/09/21.

The wrapper code zBoot is packaged as ppc_rom.bin, provding a replacement
for OpenHackware.   [OpenHackware requires the kernel boot device to
have a partition table, even if its laoded in memory (which prep sort
of provides).  It also only gueses the execution of boot sripts and any
forth, and has noot seen any development in 3 years].

This rom copies its contents to ram where it then invokes the normal
wrapper starup path, using the serial port for the console.  It proceeds
to locate the commandline, kernel, and initrd using nvram.  It supports
only nvram at the prep location of 0x8000074 indicating a boot from
"memory" aka qemu -kernel or drive "m".  The loaded image can be a
kernel or a zImage (in this mode it will ignore any attached device
tree preferring the one supplied via r3), but the contianed kernel and
optionally a initrd as per the normal build process will be used.

Specifically, the patch requrires (1) external vmlinux hook and wrapper
(2) check loader_info command line after fixups, and (3) obtain initrd
from device-tree, (4) several patches committed to the for-2.6.24 branch.

When building the rom, configure the device tree as "qemu.dts".  When
building the vmlinux or zImage -kernel, you can use the empty string
("") to suppress the call to dtc as the code will ignore any attached dtb.

When invoking qemu, use the -L flag to specify the directory with the
ppc_rom.bin file.

Index: kernel/arch/powerpc/boot/qemu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/qemu.c	2007-09-21 04:53:32.000000000 -0500
@@ -0,0 +1,235 @@
+/*
+ * QEMU PReP-specific stuff for the zImage boot wrapper.
+ *
+ * Copyright (C) 2007 Milton Miller, IBM Corp. <miltonm@bga.com>
+ * Copyright (C) 2006 Paul Mackerras, IBM Corp. <paulus@samba.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License.
+ *
+ * nvram format obtained from OpenHackWare 0.4
+ * Copyright (C) 2004-2005 Jocelyn Mayer (l_indien@magic.fr)
+ *
+ */
+
+asm(
+/*
+ * gcc 4.1.2 seems to place this first, even with the block at the end of
+ * the file.  Put it first for good measure.  If the branch ends up at the
+ * beginning of the image then it can be started like a kernel.
+ */
+"	b	_zimage_start\n"	/* gcc 4.1.2 places this first */
+
+/*
+ * This code will be loaded by qemu as a rom at the end of memory, and
+ * execution will start at address -4.  Since the rom is read only, we
+ * and the zImage code wants to run where loaded, we must copy it to ram.
+ *
+ * move to linked place
+ * end with a branch to this code
+ * this code will be copied with dd to the end of the rom image
+ */
+
+"	.globl	copy_rom_start\n"
+"copy_rom_start:\n"
+"	bl	1f\n"
+"1:	mflr	4\n"
+"	clrrwi	4,4,19\n"		/* ROM_BITS -- get beginning of rom */
+"	lis	5,_end@ha\n"
+"	addi	5,5,_end@l\n"
+"	lis	3,_start@ha\n"
+"	addi	3,3,_start@l\n"
+"	subf	5,3,5\n"
+"	addi	5,5,0x1f\n"
+"	srwi	5,5,5\n"
+"	mtctr	5\n"
+"2:	lwz	24,0(4)\n"		/* copy to linked addresss */
+"	lwz	25,4(4)\n"
+"	lwz	26,8(4)\n"
+"	lwz	27,12(4)\n"
+"	lwz	28,16(4)\n"
+"	lwz	29,20(4)\n"
+"	lwz	30,24(4)\n"
+"	lwz	31,28(4)\n"
+"	stw	24,0(3)\n"
+"	stw	25,4(3)\n"
+"	stw	26,8(3)\n"
+"	stw	27,12(3)\n"
+"	stw	28,16(3)\n"
+"	stw	29,20(3)\n"
+"	stw	30,24(3)\n"
+"	stw	31,28(3)\n"
+"	dcbf	0,3\n"
+"	sync\n"
+"	icbi	0,3\n"
+"	addi	3,3,32\n"
+"	addi	4,4,32\n"
+"	bdnz	2b\n"
+"	sync\n"
+"	isync\n"
+
+	/*
+	 * Put a branch to self on a few vectors in case we get an unexpected
+	 * interrupt.  At least you can dump regs in the qemu monitor.
+	 */
+"	lis	0,0x48000000@h\n"
+"	stw	0,0x700(0)\n"
+"	stw	0,0x300(0)\n"
+"	stw	0,0x400(0)\n"
+"	stw	0,0x900(0)\n"
+"	stw	0,0x800(0)\n"
+"	stw	0,0x200(0)\n"
+
+	/* branch to linked address */
+"	lis	0,_zimage_start@h\n"
+"	ori	0,0,_zimage_start@l\n"
+"	mtctr	0\n"
+"	li	3,0\n"
+"	bctrl\n"
+
+	/* must be last word before copy_rom_end */
+"	b	copy_rom_start\n"
+"	.globl	copy_rom_end\n"
+"copy_rom_end:\n"
+);
+
+
+#include <stddef.h>
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+#include "page.h"
+#include "io.h"
+#include "gunzip_util.h"
+#include "flatdevtree.h"
+
+BSS_STACK(16*1024);
+
+unsigned char *nvram = (void *)0x80000074;	/* address of nvram on PReP */
+
+static void qemu_nvram_write(unsigned short addr, char data)
+{
+	out_8(nvram + 0, addr & 0xff);
+	out_8(nvram + 1, addr >> 8);
+	out_8(nvram + 3, data);
+}
+
+static char qemu_nvram_read(unsigned short addr)
+{
+	char data;
+	out_8(nvram + 0, addr & 0xff);
+	out_8(nvram + 1, addr >> 8);
+	data = in_8(nvram + 3);
+
+	return data;
+}
+
+static void qemu_nvram_fetch(unsigned short addr, unsigned short len, void *p)
+{
+	char *buf = p;
+	int i;
+
+	for (i = 0; i < len; i ++)
+		buf[i] = qemu_nvram_read(addr + i);	/* big endian */
+}
+
+static char arch[17];
+static void * image_start;
+static unsigned int image_len;
+
+void qemu_find_vmlinuz(struct gunzip_state *state, void **srcp,
+	unsigned long *lenp)
+{
+	*srcp = image_start;
+	*lenp = image_len;
+	gunzip_start(state, image_start, image_len);
+}
+
+/* if no device tree, read the nvram to find out about our system */
+/* based on openhackware 0.4 nvram.c get_nvram_config */
+static void qemu_fixups(void)
+{
+	char buf[32];
+	int word;
+
+	printf("qemu_fixups\n\r");
+
+	qemu_nvram_fetch(0, 16, buf);
+	printf("sig: %s", buf);
+	if (strcmp(buf, "QEMU_BIOS"))
+		fatal("no qemu sig found");
+	qemu_nvram_fetch(0x10, 16, &word);
+	if (word != 2)
+		fatal("wrong qemu nvram version");
+	/* compute crc over 0-0xfc, compare to crc in 0xfc */
+	/* size at 0x14, mult 256 0x400-0x2000 */
+	qemu_nvram_fetch(0x20, 16, buf);
+	strncpy(arch, buf, sizeof(arch)-1);
+	if (strcmp(arch,"PREP"))
+		fatal("don't understand arch %s", arch);
+
+	/* XXX: put the model in the device tree */
+
+	qemu_nvram_fetch(0x30, 16, &word);
+	printf("memory: %x\n\r", word);
+	dt_fixup_memory(0, word);
+	printf("boot device %c\n\r", qemu_nvram_read(0x34));
+	qemu_nvram_fetch(0x38, 16, &word);
+	image_start = (void *)word;
+	qemu_nvram_fetch(0x3c, 16, &word);
+	image_len = word;
+	printf("kernel %p %x\n\r", image_start, image_len);
+	qemu_nvram_fetch(0x40, 16, &word);
+	loader_info.cmdline = (void *)word;
+	qemu_nvram_fetch(0x44, 16, &word);
+	loader_info.cmdline_len = word;
+	printf("cmdline %p %x\n\r", loader_info.cmdline,
+		loader_info.cmdline_len);
+	printf("cmdline is %s\n\r", loader_info.cmdline);
+	qemu_nvram_fetch(0x48, 16, &word);
+	loader_info.initrd_addr = word;
+	qemu_nvram_fetch(0x4c, 16, &word);
+	loader_info.initrd_size = word;
+	printf("initrd %lx %lx\n\r", loader_info.initrd_addr,
+		loader_info.initrd_size);
+	/* XXX: nvram image addr at 50 */
+	/* XXX: vga width, height, depth = shorts at 54, 56, 58 */
+}
+
+/* If loaded with a device tree, then just read the tree */
+static void tree_fixups(void)
+{
+	/* get initrd from tree */
+	dt_find_initrd();
+
+	/* we must have an attached image for boot with supplied device-tree */
+}
+
+static void *heap_end;	/* set in platform_init */
+
+static void *qemu_vmlinux_alloc(unsigned long size)
+{
+	if (size < (unsigned long)_start)
+		return 0;
+
+	return (void *)_ALIGN_UP((unsigned long) heap_end, 4096);
+}
+
+void platform_init(void *r3)
+{
+	struct boot_param_header *bph = r3;
+
+	heap_end = simple_alloc_init(_end, 4096*1024, 4096, 512);
+
+	if (bph)  {
+		ft_init(bph, bph->totalsize, 128);
+		platform_ops.fixups = tree_fixups;
+	} else {
+		ft_init(_dtb_start, _dtb_end - _dtb_start, 128);
+		platform_ops.fixups = qemu_fixups;
+		platform_ops.find_vmlinuz = qemu_find_vmlinuz;
+	}
+	platform_ops.vmlinux_alloc = qemu_vmlinux_alloc;
+
+	serial_console_init();
+}
Index: kernel/arch/powerpc/boot/dts/qemu.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/dts/qemu.dts	2007-09-21 04:53:32.000000000 -0500
@@ -0,0 +1,132 @@
+/*
+ * QEMU PReP skeleton device tree
+ * from PReP skeleton device tree
+ * and qemu source
+ *
+ * Milton Miller
+ */
+
+/ {
+	device_type = "qemu";
+	model = "QEMU,PReP";
+	compatible = "qemu-prep";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency =<d#200000000>;
+			bus-frequency = <d#100000000>;
+			timebase-frequency = <d#100000000>;
+			i-cache-line-size = <d#32>;
+			d-cache-line-size = <d#32>;
+			d-cache-size = <0>;
+			i-cache-size = <0>;
+
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		// dummy range here, zImage wrapper will fill in the actual
+		// amount of memory from the nvram
+		reg = <00000000 01000000>;
+	};
+
+	pci@80800000 {
+		device_type = "pci";
+		compatible = "prep-pci";
+		clock-frequency = <01fca055>;
+		reg = <80800000 00400000>;	/* pci config space */
+		8259-interrupt-acknowledge = <bffffff0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges=<01000000 00000000 00000000 80000000 00000000 00800000
+			02000000 00000000 00000000 c0000000 00000000 01000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0800 0 0 0>;
+		interrupt-map = <0800 0 0 0	&PIC8259 b 3
+				 0000 0 0 0	&PIC8259 9 3>;
+
+		isa {
+			device_type = "isa";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			ranges = <00000001 00000000
+				  01005800 00000000 00000000  00010000
+				  00000000 00000000
+				  02005800 00000000 00000000  01000000>;
+
+			parallel {
+				device_type = "parallel";
+				compatible = "pnpPNP,401", "pnpPNP,400";
+				reg =  <00000001 000003bc  00000008
+					00000001 000007bc  00000006>;
+				interrupts = <00000007 00000003>;
+				interrupt-parent = <&PIC8259>;
+			};
+
+			serial@3f8 {
+				device_type = "serial";
+				compatible = "pnpPNP,501", "pnpPNP,500",
+						"ns16550";
+				virtual-reg = <800003f8>;
+				clock-frequency = <001c2000>;
+				reg =  <00000001 000003f8  00000008>;
+				interrupts = <00000004 00000003>;
+				interrupt-parent = <&PIC8259>;
+			};
+			PIC8259: interrupt-controller {
+				#interrupt-cells = <2>;
+				device_type = "i8259";
+				compatible = "prep,iic";
+				interrupt-controller;
+				reg = <	00000001 00000020  00000002
+					00000001 000000a0  00000002
+					00000001 000004d0  00000002>;
+			};
+			ne2000@300 {
+				reg = <00000001 00000300 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<9 3>;
+			};
+			ne2000@320 {
+				reg = <00000001 00000320 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<a 3>;
+			};
+			ne2000@340 {
+				reg = <00000001 00000340 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<b 3>;
+			};
+			ne2000@360 {
+				reg = <00000001 00000360 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<3 3>;
+			};
+			ne2000@280 {
+				reg = <00000001 00000280 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<4 3>;
+			};
+			ne2000@380 {
+				reg = <00000001 00000380 00000020>;
+				interrupt-parent = <&PIC8259>;
+				interrupts=<5 3>;
+			};
+
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/pci/isa/serial@3f8";
+	};
+};
+
Index: kernel/arch/powerpc/boot/wrapper
===================================================================
--- kernel.orig/arch/powerpc/boot/wrapper	2007-09-21 04:52:59.000000000 -0500
+++ kernel/arch/powerpc/boot/wrapper	2007-09-21 04:53:32.000000000 -0500
@@ -310,4 +310,53 @@ ps3)
 
     gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
     ;;
+qemu)
+    # this part makes the zBoot.qemu a bootrom for qemu.
+    #
+    # the qemu bootrom is 512k , located at the top of the 32 bit address
+    # space.   The fixed entrypoint is address -4.
+
+    copy_rom_start=0x`${CROSS}nm "$ofile" \
+        | grep ' copy_rom_start$'       \
+        | cut -d' ' -f1`
+    copy_rom_start=`printf "%d" $copy_rom_start`
+    copy_rom_end=0x`${CROSS}nm "$ofile" \
+        | grep ' copy_rom_end$'       \
+        | cut -d' ' -f1`
+    copy_rom_end=`printf "%d" $copy_rom_end`
+    rom_start=0x`${CROSS}nm "$ofile" \
+        | grep ' _start$'       \
+        | cut -d' ' -f1`
+
+    rom_start=`printf "%d" $rom_start`
+    rom_size=$((1<<19))
+    copy_rom_len=$(($copy_rom_end-$copy_rom_start))
+    copy_rom_dst=$(($rom_size-$copy_rom_len))
+    copy_rom_src=$(($copy_rom_start-$rom_start))
+
+    img_size=`${CROSS}size "$ofile" | tail -n1 | cut -f4`
+    if [ $img_size -gt $copy_rom_dst ]
+    then
+	echo Image "${ofile##*/}" too big to fit in rom, skipping rom build.
+    else
+	romfile="$object/ppc_rom.bin"
+	tmpfile="$object/ppc_rom.$$"
+
+	rm -f "$tmpfile"
+	${CROSS}objcopy -O binary --pad-to=$(($rom_size+$rom_start)) \
+	    --gap-fill=0xff  "$ofile" "$tmpfile"
+
+	msg=$(dd if="$tmpfile" of="$tmpfile" conv=notrunc \
+	    skip=$copy_rom_src seek=$copy_rom_dst      \
+	    count=$copy_rom_len bs=1 2>&1)
+
+	if [ $? -ne "0" ]; then
+	    echo $msg
+	    rm -f "$tmpfile"
+	    exit 2
+	fi
+
+	mv "$tmpfile" "$romfile"
+    fi
+    ;;
 esac
Index: kernel/arch/powerpc/boot/.gitignore
===================================================================
--- kernel.orig/arch/powerpc/boot/.gitignore	2007-09-21 04:51:30.000000000 -0500
+++ kernel/arch/powerpc/boot/.gitignore	2007-09-21 04:53:32.000000000 -0500
@@ -17,6 +17,7 @@ infutil.h
 kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
+ppc_rom.bin
 uImage
 cuImage.*
 zImage
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-09-21 04:52:59.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-09-21 04:53:32.000000000 -0500
@@ -48,7 +48,7 @@ src-wlib := string.S crt0.S stdio.c main
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c crt0_kexec.S \
-		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
+		cuboot-ebony.c treeboot-ebony.c prpmc2800.c qemu.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c
 src-boot := $(src-wlib) $(src-plat) empty.c
@@ -143,6 +143,7 @@ image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_PPC_HOLLY)		+= zImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
+image-$(CONFIG_PPC_QEMU)		+= zImage.qemu zBoot.qemu
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 image-$(CONFIG_KEXEC)			+= $(kexec-y)
 image-$(CONFIG_KEXEC)			+= $(patsubst zImage%,zBoot%,$(kexec-y))
@@ -202,6 +203,9 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/zBoot.%: $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts),,,$(obj)/empty.o)
 
+# horrible hack to avoid overlapping calls to wrapper script clobbering dtb.
+$(obj)/zImage.qemu: $(obj)/zBoot.qemu
+
 $(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts
 	$(STRIP) -s -R .comment $< -o vmlinux.strip
 	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
@@ -235,8 +239,8 @@ install: $(CONFIGURE) $(addprefix $(obj)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.* \
-	otheros.bld $(kexec-)
+clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.*
+clean-files += otheros.bld ppc_rom.bin $(kexec-)
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin empty.o.bin
