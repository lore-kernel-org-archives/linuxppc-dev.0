Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFBDBDDF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 14:03:46 +1000 (EST)
Date: Mon, 27 Aug 2007 23:03:29 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: [PATCH] qemu-system-ppc -prep initial port
Message-Id: <miltonm-qemu-0@bga.com>
To: <linuxppc-dev@ozlabs.org>
Cc: firmware@them.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Some people have been asking about booting powerpc kernels on qemu.

Based on some comments about the existing rom for qemu, I looked
at OpenHackWare enough to discern how qemu started its execution
and how it gets its config.   

I then proceeded to write a wrapper patch to use as the rom and then
proceeded with a minimal platform (based on David Gibson's prep patch)
to boot a ARCH=powerpc kernel.

These patches are being posted early to allow others to use them,
they are not ready to be merged.

What works:
	-prep  (not default pmac, or core99 in later qemu)
	serial console in bootwrapper
	serial console in kernel (console=ttyS0)
	kernel must be loaded with --kernel=
		vmlinux, or vmlinuz (gzip'ed elf).
		zImage.qemu, zImage.initrd.qemu (with compiler assumptions)
	-initrd (optional)
	-append (optional)
	ide-disk and cdrom appear to work
	floppy is untested, and needs io port added.

What doesn't work:
	boot from disk
	vga (needs bios post, maybe pci)
	pci (config cycles are not working, at least on 0.6.3)

How it works:
	wrapper is compiled to run as rom
		copied from rom to ram (linked address)
		supplies initial device tree blob (because dtb = NULL)
		reads nvram for memory size, kernel, initrd, command line
	if invoked with device tree, then it only uses attached kernel
		initrd either attached or from kernel

what you need:
	2.6.23-rc3 + [ from powerpc.git for-2.6.24 branch ]
	commit 0602801c22ea1767cd0298b11da140bd5cb764d2
	    [POWERPC] bootwrapper: dt_xlate_range() bugfixes
	commit a73ac50c4787b1b28d5c94bb18c60352f5dd7d6f
	    [POWERPC] bootwrapper: Add dt_is_compatible()
	commit 6e913c67b3eb93e2b8bc1dc0ff854f00a760f41b
	    [POWERPC] bootwrapper: Add 16-bit I/O, sync(), eieio(), and barrier()
	commit dc4f397d6e385c4ea0fe9732df911a86f1a78c9a
	    [POWERPC] bootwrapper: serial_console_init() fixes
	commit 2f1d4899321be87bc5f0c4ee0e62c9d9ced05f80
	    [POWERPC] bootwrapper: Move linker symbols into ops.h

	tell wrapper where initrd is, so it can move it if needed
		http://patchwork.ozlabs.org/linuxppc/patch?id=12168

	tell code where vmlinuz is
		http://patchwork.ozlabs.org/linuxppc/patch?id=12178

	build rom without vmlinuz
		http://patchwork.ozlabs.org/linuxppc/patch?id=12180

	Subject: Move serial_dev_init to device_initcall()
		http://patchwork.ozlabs.org/linuxppc/patch?id=13097


To run:
	build ppc_rom.bin using CONFIG_DEVICE_TREE=prep.dts with the
	dtc installed.  This will be based on zBoot.qemu and will not
	have a kernel attached.  Put this in a directory and invoke
	qemu-system-ppc -prep -L <dir-with-rom> -kernel <kernel>
	where kernel is either zImage.qemu or a (possibly compressed)
	vmlinux elf , add ide drives, -append, and -initrd as desired.

My tree has all patches in for-2.6.24 that touch arch/powerpc/boot plus
ojn's patch plus my kexec series plus the prep patch, so there will be
some rejects, especially to makefiles etc.

The first hunk to main.c to check loader_info for a command line after
the fixup callback should be a seperate patch.

The boot/Makefile has a hack to avoid ovewriting qemu.dtb.

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-08-24 03:49:35.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-08-24 03:50:21.000000000 -0500
@@ -181,6 +181,11 @@ void start(void)
 	if (platform_ops.fixups)
 		platform_ops.fixups();
 
+	/* check again, in case fixups told us about it */
+	if ((loader_info.cmdline_len > 0) && (cmdline[0] == '\0'))
+		memmove(cmdline, loader_info.cmdline,
+			min(loader_info.cmdline_len, COMMAND_LINE_SIZE-1));
+
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, get_sp());
 
Index: kernel/arch/powerpc/boot/qemu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/qemu.c	2007-08-27 20:46:10.000000000 -0500
@@ -0,0 +1,237 @@
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
+/* if loaded with a device tree, then just read the tree */
+static void tree_fixups(void)
+{
+	/* get initrd from tree */
+	dt_find_initrd();
+
+	/* we must have an attached image for device-tree boot */
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
+
+	// platform_ops.vmlinux_alloc = of_vmlinux_alloc;
+}
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-08-24 05:46:36.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-08-27 22:49:03.000000000 -0500
@@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main
 		cpm-serial.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c crt0_kexec.S \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c crt0_bml.S bml.c \
-		ps3-head.S ps3-hvcall.S ps3.c prep.c \
+		ps3-head.S ps3-hvcall.S ps3.c prep.c qemu.c \
 		treeboot-bamboo.c cuboot-8xx.c cuboot-pq2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
@@ -144,6 +144,7 @@ image-$(CONFIG_PPC_HOLLY)		+= zImage.hol
 image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_PPC_PREP)		+= zImage.prep
+image-$(CONFIG_PPC_QEMU)		+= zImage.qemu zBoot.qemu
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 image-$(CONFIG_KEXEC)			+= $(kexec-y)
 image-$(CONFIG_KEXEC)			+= $(patsubst zImage%,zBoot%,$(kexec-y))
@@ -201,6 +202,9 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/zBoot.%: $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts),,,$(obj)/empty.o)
 
+# horrible hack to avoid overlapping calls to wrapper script clobbering dtb.
+$(obj)/zImage.qemu: $(obj)/zBoot.qemu
+
 $(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts
 	$(STRIP) -s -R .comment $< -o vmlinux.strip
 	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
@@ -234,8 +238,8 @@ install: $(CONFIGURE) $(addprefix $(obj)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.* \
-	otheros.bld $(kexec-)
+clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* treeImage.*
+clean-files += otheros.bld ppc_rom.bin $(kexec-)
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin empty.o.bin
Index: kernel/arch/powerpc/boot/dts/qemu.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/dts/qemu.dts	2007-08-27 20:48:34.000000000 -0500
@@ -0,0 +1,100 @@
+/*
+ * QEMU PReP skeleton device tree
+ * from PReP skeleton device tree
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
+			timebase-frequency = <d#25000000>;	/* correct? */
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
+	pci@80000000 {
+		device_type = "pci";
+		compatible = "prep-pci";
+		clock-frequency = <01fca055>;
+		reg = <80000000 7ffff>;
+		/* 8259-interrupt-acknowledge = <bffffff0>; */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges=<01000000 00000000 00000000 80000000 00000000 00800000
+			02000000 00000000 00000000 c0000000 00000000 01000000>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <6000 0 0 1	&PIC8259 6 0
+				 8000 0 0 1	&PIC8259 7 0
+				 9000 0 0 1	&PIC8259 2 0
+				 b000 0 0 1	&PIC8259 1 0>;
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
+				device_type = "i8259";
+				compatible = "prep,iic";
+				interrupt-controller;
+				reg = <	00000001 00000020  00000002
+					00000001 000000a0  00000002
+					00000001 000004d0  00000002>;
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/pci/isa/serial@3f8";
+	};
+};
+
Index: kernel/arch/powerpc/platforms/Kconfig
===================================================================
--- kernel.orig/arch/powerpc/platforms/Kconfig	2007-08-24 05:46:36.000000000 -0500
+++ kernel/arch/powerpc/platforms/Kconfig	2007-08-24 05:46:58.000000000 -0500
@@ -47,6 +47,7 @@ source "arch/powerpc/platforms/chrp/Kcon
 source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/powermac/Kconfig"
 source "arch/powerpc/platforms/prep/Kconfig"
+source "arch/powerpc/platforms/qemu/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
 source "arch/powerpc/platforms/pasemi/Kconfig"
 source "arch/powerpc/platforms/celleb/Kconfig"
Index: kernel/arch/powerpc/boot/wrapper
===================================================================
--- kernel.orig/arch/powerpc/boot/wrapper	2007-08-24 05:46:36.000000000 -0500
+++ kernel/arch/powerpc/boot/wrapper	2007-08-27 22:49:09.000000000 -0500
@@ -320,4 +320,53 @@ ps3)
 
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
Index: kernel/arch/powerpc/platforms/qemu/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/platforms/qemu/Kconfig	2007-08-24 05:46:58.000000000 -0500
@@ -0,0 +1,10 @@
+config PPC_QEMU
+	bool "PowerPC Reference Platform (PReP) based QEMU emulated systems"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	select WANT_DEVICE_TREE
+	default n
+
Index: kernel/arch/powerpc/platforms/qemu/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/platforms/qemu/Makefile	2007-08-24 05:46:58.000000000 -0500
@@ -0,0 +1,2 @@
+obj-y			+= setup.o
+obj-$(CONFIG_PCI)	+= pci.o
Index: kernel/arch/powerpc/platforms/qemu/pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/platforms/qemu/pci.c	2007-08-27 20:14:37.000000000 -0500
@@ -0,0 +1,133 @@
+/*
+ * Port to arch/powerpc:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Port to qemu:
+ * Copyright 2007 Milton Miller, IBM Corporation.
+ *
+ * Based on OpenHackware 0.4
+ * Copyright (c) 2004-2005 Jocelyn Mayer
+ *
+ * pci config based on arch/powerpc/platforms/chrp/pci.c GoldenGate code
+ *
+ */
+
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/udbg.h>
+
+static volatile void __iomem *qemu_config_addr(struct pci_bus *bus,
+	unsigned int devfn, int off)
+{
+	int dev, fn;
+	struct pci_controller *hose = bus->sysdata;
+
+	if (!hose->cfg_data)
+		return NULL;
+
+	if (bus->number != 0)
+		return NULL;
+
+	dev = devfn >> 3;
+	fn = devfn & 7;
+
+	if (dev < 11 || dev > 21)
+		return NULL;
+
+	return hose->cfg_data + ((1 << dev) | (fn << 8) | off);
+}
+
+int qemu_read_config(struct pci_bus *bus, unsigned int devfn, int off,
+			   int len, u32 *val)
+{
+	volatile void __iomem *cfg_data = qemu_config_addr(bus, devfn, off);
+
+	/* check, should this be 0? */
+	if (cfg_data == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that off is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val =  in_8(cfg_data);
+		break;
+	case 2:
+		*val = in_le16(cfg_data);
+		break;
+	default:
+		*val = in_le32(cfg_data);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int qemu_write_config(struct pci_bus *bus, unsigned int devfn, int off,
+			    int len, u32 val)
+{
+	volatile void __iomem *cfg_data = qemu_config_addr(bus, devfn, off);
+
+	if (cfg_data == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/*
+	 * Note: the caller has already checked that off is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		out_8(cfg_data, val);
+		break;
+	case 2:
+		out_le16(cfg_data, val);
+		break;
+	default:
+		out_le32(cfg_data, val);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops qemu_pci_ops =
+{
+	qemu_read_config,
+	qemu_write_config
+};
+
+void __init qemu_find_bridges(void)
+{
+	struct device_node *phb;
+	struct pci_controller *hose;
+
+	phb = of_find_node_by_type(NULL, "pci");
+	if (!phb) {
+		printk(KERN_ERR "PReP: Cannot find PCI bridge OF node\n");
+		return;
+	}
+
+	hose = pcibios_alloc_controller(phb);
+	if (!hose)
+		return;
+
+	pci_process_bridge_OF_ranges(hose, phb, 1);
+
+#define PREP_PCI_DRAM_OFFSET 	0x80000000
+
+	pci_dram_offset = PREP_PCI_DRAM_OFFSET;
+	ISA_DMA_THRESHOLD = 0x00ffffff;
+	DMA_MODE_READ = 0x44;
+	DMA_MODE_WRITE = 0x48;
+
+	hose->cfg_data = ioremap(0x80000000, 1 << 22);
+
+	hose->ops = &qemu_pci_ops;
+
+	udbg_init_uart(hose->io_base_virt + 0x3f8, 0, 0);
+	register_early_udbg_console();
+	printk(KERN_INFO "qemu_find_bridges: config at %p\n", hose->cfg_data);
+}
+
Index: kernel/arch/powerpc/platforms/qemu/setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/platforms/qemu/setup.c	2007-08-27 20:24:59.000000000 -0500
@@ -0,0 +1,290 @@
+/*
+ * Copyright (C) 1995  Linus Torvalds
+ * Adapted from 'alpha' version by Gary Thomas
+ * Modified by Cort Dougan (cort@cs.nmt.edu)
+ *
+ * Support for PReP (Motorola MTX/MVME)
+ * by Troy Benjegerdes (hozer@drgw.net)
+ *
+ * Port to arch/powerpc:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Port to qemu:
+ * Copyright 2007 Milton Miller, IBM Corporation.
+ *
+ * Based on OpenHackware 0.4
+ * Copyright (c) 2004-2005 Jocelyn Mayer
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/initrd.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+/* #include <asm/mpic.h> */
+#include <asm/i8259.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+
+static const char *qemu_model = "(unknown)";
+
+extern void qemu_find_bridges(void);
+
+#if 0
+
+/* useful ISA ports */
+#define PREP_SYSCTL	0x81c
+/* present in the IBM reference design; possibly identical in Mot boxes: */
+#define PREP_IBM_PM1	0x82a	/* power management register 1 */
+#define PREP_IBM_PLANAR	0x852	/* planar ID - identifies the motherboard */
+#define PREP_IBM_DISP	0x8c0	/* 4-digit LED display */
+
+
+
+
+/* Used by all Motorola PReP */
+static void prep_restart(char *cmd)
+{
+	local_irq_disable(); /* no interrupts */
+
+	/* set exception prefix high - to the prom */
+	mtmsr(mfmsr() | MSR_IP);
+
+	/* make sure bit 0 (reset) is a 0 */
+	outb(inb(0x92) & ~1L, 0x92);
+	/* signal a reset to system control port A - soft reset */
+	outb(inb(0x92) | 1, 0x92);
+
+	for (;;)
+		;
+	/* not reached */
+}
+
+static void prep_halt(void)
+{
+	local_irq_disable(); /* no interrupts */
+
+	/* set exception prefix high - to the prom */
+	mtmsr(mfmsr() | MSR_IP);
+
+	for (;;)
+		;
+	/* not reached */
+}
+
+/*
+ * On most IBM PReP's, power management is handled by a Signetics 87c750
+ * behind the Utah component on the ISA bus. To access the 750 you must write
+ * a series of nibbles to port 0x82a (decoded by the Utah). This is described
+ * somewhat in the IBM Carolina Technical Specification.
+ * -Hollis
+ */
+static void
+utah_sig87c750_setbit(unsigned int bytenum, unsigned int bitnum, int value)
+{
+	/*
+	 * byte1: 0 0 0 1 0  d  a5 a4
+	 * byte2: 0 0 0 1 a3 a2 a1 a0
+	 *
+	 * d = the bit's value, enabled or disabled
+	 * (a5 a4 a3) = the byte number, minus 20
+	 * (a2 a1 a0) = the bit number
+	 *
+	 * example: set the 5th bit of byte 21 (21.5)
+	 *     a5 a4 a3 = 001 (byte 1)
+	 *     a2 a1 a0 = 101 (bit 5)
+	 *
+	 *     byte1 = 0001 0100 (0x14)
+	 *     byte2 = 0001 1101 (0x1d)
+	 */
+	unsigned char byte1=0x10, byte2=0x10;
+
+	/* the 750's '20.0' is accessed as '0.0' through Utah (which adds 20) */
+	bytenum -= 20;
+
+	byte1 |= (!!value) << 2;		/* set d */
+	byte1 |= (bytenum >> 1) & 0x3;	/* set a5, a4 */
+
+	byte2 |= (bytenum & 0x1) << 3;	/* set a3 */
+	byte2 |= bitnum & 0x7;			/* set a2, a1, a0 */
+
+	outb(byte1, PREP_IBM_PM1);	/* first nibble */
+	mb();
+	udelay(100);				/* important: let controller recover */
+
+	outb(byte2, PREP_IBM_PM1);	/* second nibble */
+	mb();
+	udelay(100);				/* important: let controller recover */
+}
+
+static void prep_sig750_poweroff(void)
+{
+	/* tweak the power manager found in most IBM PRePs (except Thinkpads) */
+
+	local_irq_disable();
+	/* set exception prefix high - to the prom */
+	mtmsr(mfmsr() | MSR_IP);
+
+	utah_sig87c750_setbit(21, 5, 1); /* set bit 21.5, "PMEXEC_OFF" */
+
+	for (;;)
+		;
+	/* not reached */
+}
+
+#endif
+
+/* cpuinfo code common to all IBM PReP */
+static void qemu_ibm_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "machine\t\t: PReP %s\n", qemu_model);
+}
+
+#define NVRAM_AS0 0x74
+#define NVRAM_AS1 0x75
+#define NVRAM_DAT 0x77
+
+static unsigned char qemu_nvram_read_val(int addr)
+{
+	outb(NVRAM_AS0, addr & 0xff);
+	outb(NVRAM_AS1, (addr >> 8) & 0xff);
+	return inb(NVRAM_DAT);
+}
+
+
+static void qemu_nvram_write_val(int addr, unsigned char val)
+{
+	outb(NVRAM_AS0, addr & 0xff);
+	outb(NVRAM_AS1, (addr >> 8) & 0xff);
+	outb(NVRAM_DAT, val);
+}
+
+
+static void __init qemu_setup_arch(void)
+{
+	struct device_node *root;
+	const char *model;
+
+	root = of_find_node_by_path("/");
+	model = of_get_property(root, "model", NULL);
+	of_node_put(root);
+	if (model)
+		qemu_model = model;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	/* loops_per_jiffy = 50000000; */
+
+	/* Lookup PCI host bridges */
+	qemu_find_bridges();
+
+	/* Read in NVRAM data */
+/* 	init_qemu_nvram(); */
+}
+
+static void __init qemu_find_8259(void)
+{
+	struct device_node *pic = NULL;
+	unsigned long int_ack = 0;
+
+	pic = of_find_node_by_type(NULL, "i8259");
+	if (!pic) {
+		printk(KERN_ERR "No interrupt controller found!\n");
+		return;
+	}
+
+	/* polling */
+	i8259_init(pic, int_ack);
+	ppc_md.get_irq = i8259_irq;
+
+	/* hack: set default host until interrupt map and pci fixed */
+	irq_set_default_host(i8259_get_host());
+}
+
+static void __init qemu_init_IRQ(void)
+{
+	qemu_find_8259();
+}
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+/*
+ * IDE stuff.
+ */
+static int qemu_ide_default_irq(unsigned long base)
+{
+	switch (base) {
+	case 0x1f0: return 13;
+	case 0x170: return 13;
+	case 0x1e8: return 11;
+	case 0x168: return 10;
+	case 0xfff0: return 14;		/* MCP(N)750 ide0 */
+	case 0xffe0: return 15;		/* MCP(N)750 ide1 */
+	default: return 0;
+	}
+}
+
+static unsigned long qemu_ide_default_io_base(int index)
+{
+	switch (index) {
+	case 0: return 0x1f0;
+	case 1: return 0x170;
+	case 2: return 0x1e8;
+	case 3: return 0x168;
+	default:
+		return 0;
+	}
+}
+#endif
+
+#if 0
+static int __init prep_request_io(void)
+{
+#ifdef CONFIG_NVRAM
+	request_region(PREP_NVRAM_AS0, 0x8, "nvram");
+#endif
+	request_region(0x00,0x20,"dma1");
+	request_region(0x40,0x20,"timer");
+	request_region(0x80,0x10,"dma page reg");
+	request_region(0xc0,0x20,"dma2");
+
+	return 0;
+}
+device_initcall(prep_request_io);
+#endif
+
+
+static int __init qemu_probe(void)
+{
+	if (! of_flat_dt_is_compatible(of_get_flat_dt_root(), "qemu-prep"))
+		return 0;
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	ppc_ide_md.default_irq = qemu_ide_default_irq;
+	ppc_ide_md.default_io_base = qemu_ide_default_io_base;
+#endif
+
+	return 1;
+}
+
+define_machine(qemu) {
+	.name			= "QEMU",
+	.probe			= qemu_probe,
+	.setup_arch		= qemu_setup_arch,
+	.progress		= udbg_progress,
+	.show_cpuinfo		= qemu_ibm_cpuinfo,
+	.init_IRQ		= qemu_init_IRQ,
+/* 	.pcibios_fixup		= qemu_pcibios_fixup, */
+/*	.restart		= qemu_restart, */
+/*	.power_off		= qemu_halt, */
+/*	.halt			= qemu_halt, */
+/* 	.time_init		= todc_time_init, */
+/* 	.set_rtc_time		= todc_set_rtc_time, */
+/* 	.get_rtc_time		= todc_get_rtc_time, */
+	.calibrate_decr		= generic_calibrate_decr,
+ 	.nvram_read_val		= qemu_nvram_read_val,
+ 	.nvram_write_val	= qemu_nvram_write_val,
+	.phys_mem_access_prot	= pci_phys_mem_access_prot,
+};
Index: kernel/arch/powerpc/platforms/Makefile
===================================================================
--- kernel.orig/arch/powerpc/platforms/Makefile	2007-08-24 05:46:36.000000000 -0500
+++ kernel/arch/powerpc/platforms/Makefile	2007-08-24 05:46:58.000000000 -0500
@@ -7,6 +7,7 @@ endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_PPC_PREP)		+= prep/
+obj-$(CONFIG_PPC_QEMU)		+= qemu/
 #obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_44x)		+= 44x/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
Index: kernel/arch/powerpc/boot/.gitignore
===================================================================
--- kernel.orig/arch/powerpc/boot/.gitignore	2007-08-27 21:10:42.000000000 -0500
+++ kernel/arch/powerpc/boot/.gitignore	2007-08-27 21:11:02.000000000 -0500
@@ -17,6 +17,7 @@ infutil.h
 kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
+ppc_rom.bin
 uImage
 cuImage.*
 zImage
