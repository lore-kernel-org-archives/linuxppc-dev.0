Return-Path: <msm@freescale.com>
Subject: [RFC] Updated cuImage target
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 20:00:19 +0000
Message-Id: <1155672019.5273.28.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I have mostly completed reworking a new cuImage target based off the
previous discussion. There are several changes from the version I
presented previously. So to summarize these changes, the cuImage
consists of the following:

1) A copy of the kernel is the first section in the cuImage target.
Furthermore, it is now a binary section (vs. elf for the zImage target).
More on this later.

2) The bootwrapper follows the kernel section.

3) The cuImage target automatically creates the 'uImage' which is
bootable by u-boot. The correct offset to the bootwrapper is set as the
entry point, and the load address is 0x0 to prevent excessive copying of
the data.

So now, when u-boot attempts to load the cuImage with the 'bootm'
command it now extracts the image (the decompression is handled by
u-boot) to the 0x0, and then jumps to the bootwrapper start address
located after the kernel image.

The bootwrapper code executes and fixes up a flat device tree for use by
the kernel proper, and then jumps the 0x0 and the kernel starts up. The
patch below consists of two things:

1) Makefile, Linker script, Config changes to allow the new cuImage
target

2) Beginning of work to allow the boot wrapper to create a correct flat
device tree for a Sandpoint board based off information passed to via
the board device structure.

Mark's boot wrapper patches and Sandpoint patches are required for this
to work.

-Matthew

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 01667d1..cf7b7e0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -146,7 +146,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
uImage vmlinux.bin
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
uImage vmlinux.bin cuImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index daad857..77a0eb7 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -223,3 +223,53 @@ install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux
System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
 clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)
+
+#-----------------------------------------------------------
+# build compatiblity u-boot images
+#-----------------------------------------------------------
+
+targets += cuImage
+
+quiet_cmd_cobjbin = OBJCOPY $@
+      cmd_cobjbin = $(OBJCOPY) --set-section-flags=.bss=$(OBJCOPYFLAGS)
--gap-fill=0xff -O binary $< $@
+
+uiet_cmd_cuimage = UIMAGE $@
+      cmd_cuimage = $(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T
kernel \
+	-C gzip -a 0x0 -e $2 -n 'Linux-$(KERNELRELEASE)' -d $< $@
+
+quiet_cmd_addsection_cuimage = ADDSEC  $@
+      cmd_addsection_cuimage = $(CROSS32OBJCOPY) $@ \
+		--add-section=.kernel:vmlinux.bin=$(obj)/vmlinux-cuimage.bin \
+		--set-section-flags=.kernel:vmlinux.bin=$(OBJCOPYFLAGS)
+
+$(obj)/vmlinux-cuimage.bin: vmlinux FORCE
+	$(call if_changed,cobjbin)
+
+$(obj)/kernel-compat.c:
+	@touch $@
+
+$(obj)/kernel-compat.o: $(obj)/kernel-compat.c
$(obj)/vmlinux-cuimage.bin 
+	$(call if_changed_dep,bootcc)
+	$(call cmd,addsection_cuimage)
+
+$(obj)/vmlinux-compat.elf: $(obj-boot) $(obj)/kernel-compat.o
+	$(call cmd,bootld,$(obj-boot) $(obj)/kernel-compat.o,cuImage.lds)
+	# need a more automated way to do this
+	sh fdt_attach.sh --fdt ../sandpoint_v3.dtb
arch/powerpc/boot/vmlinux-compat.elf
+
+$(obj)/vmlinux-compat.bin: $(obj)/vmlinux-compat.elf
+	$(call if_changed,objbin)
+
+$(obj)/vmlinux-compat.gz: $(obj)/vmlinux-compat.bin
+	$(call if_changed,mygzip)
+
+ENTRY=`objdump -t arch/powerpc/boot/vmlinux-compat.elf | gawk --
'{if($$5=="_zimage_start") {print $$1;}}'`
+
+$(obj)/cuImage: $(obj)/vmlinux-compat.gz $(obj-boot)
+	$(Q)rm -f $@
+	$(call cmd,cuimage,$(ENTRY))
+	@echo -n '  Image: $@ '
+	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
+
+clean-files += vmlinux-compat.elf vmlinux-compat.bin vmlinux-compat.gz
cuImage kernel-compat.c
+
diff --git a/arch/powerpc/boot/cuImage.lds
b/arch/powerpc/boot/cuImage.lds
new file mode 100644
index 0000000..073e19c
--- /dev/null
+++ b/arch/powerpc/boot/cuImage.lds
@@ -0,0 +1,45 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_zimage_start)
+SECTIONS
+{
+  . = 0;
+
+  _vmlinux_start =  .;
+  .kernel:vmlinux.bin : { *(.kernel:vmlinux.bin) }
+  _vmlinux_end =  .;
+
+/* initrd still needs work */
+  _initrd_start = .;
+  _initrd_end = .;
+
+  _start = .;
+  .text      :
+  {
+    *(.text)
+    *(.fixup)
+  }
+  _etext = .;
+  . = ALIGN(4096);
+  .data    :
+  {
+    *(.rodata*)
+    *(.data*)
+    *(.sdata*)
+    __got2_start = .;
+    *(.got2)
+    __got2_end = .;
+  }
+
+  . = ALIGN(4096);
+  _edata  =  .;
+
+  . = ALIGN(4096);
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  . = ALIGN(4096);
+  _end = . ;
+}
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 0e49f58..a67844b 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -286,7 +286,7 @@ void start(unsigned long a1, unsigned lo
 
 	memset(__bss_start, 0, _end - __bss_start);
 
-	ops = platform_init(promptr);
+	ops = platform_init(promptr, a1);
 
 	/* Override the dt_ops if there was an fdt attached to the zImage */
 	if (strcmp(dt_blob_start, EMPTY_SECTION_STR))
@@ -301,7 +301,8 @@ void start(unsigned long a1, unsigned lo
 	if (ops->platform_ops->fixups)
 		ops->platform_ops->fixups();
 
-	prep_kernel(&a1, &a2, sp);
+	if (((unsigned long)_vmlinux_start) != 0)
+		prep_kernel(&a1, &a2, sp);
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 94d97b0..354d0a6 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -65,7 +65,7 @@ struct ops {
 
 extern struct ops *ops;
 
-extern struct ops *platform_init(void *promptr);
+extern struct ops *platform_init(void *promptr, unsigned long a1);
 extern struct fw_ops *dink_init(void);
 extern struct dt_ops *fdt_init(void *dt_blob);
 extern struct console_ops *ns16550_init(void);
diff --git a/arch/powerpc/boot/sandpoint.c
b/arch/powerpc/boot/sandpoint.c
index 0fe15b9..0feabbf 100644
--- a/arch/powerpc/boot/sandpoint.c
+++ b/arch/powerpc/boot/sandpoint.c
@@ -22,6 +22,8 @@ #define	CPU_7XX		1
 #define	CPU_7457	2
 #define	CPU_NUM		3
 
+unsigned long bd_saved;
+
 static u32 cpu_pll[CPU_NUM][32] = {
 	[CPU_824X] = { /* 824x */
 		5, 6, 9, 4, 4, 5, 2, 6, 6, 4, 9, 6, 5, 7, 6, 7,
@@ -84,6 +86,13 @@ #define mfspr(rn)	({unsigned long rval; 
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
 
+#define SANDPOINT_UBOOT_LINK_ADDR	0xfff00000
+#define UBOOT_MAGIC			0x27051956
+#define UBOOT_BD_MEMSTART_OFFSET	0
+#define UBOOT_BD_MEMSIZE_OFFSET		1
+#define UBOOT_BD_CLOCKFREQ_OFFSET	11
+#define UBOOT_BD_BUSFREQ_OFFSET		12
+
 static void
 sandpoint_fixups(void)
 {
@@ -91,7 +100,28 @@ sandpoint_fixups(void)
 	void *devp;
 	struct processor_info *pit;
 	extern u32 mpc10x_get_mem_size(void);
-
+	u32 *test_addr = (u32 *)SANDPOINT_UBOOT_LINK_ADDR;
+	u32 *bd = (u32 *)bd_saved;
+	
+	switch (*test_addr) {
+	case UBOOT_MAGIC:
+		if ((devp = finddevice("/cpus/PowerPC,603e"))) {
+			v[0] = bd[UBOOT_BD_CLOCKFREQ_OFFSET];
+			setprop(devp, "clock-frequency", v, sizeof(v[0]));
+			v[0] = bd[UBOOT_BD_BUSFREQ_OFFSET] / 4;
+			setprop(devp, "timebase-frequency", v, sizeof(v[0]));
+		}
+		if ((devp = finddevice("/soc10x@fc000000"))) {
+			v[0] = bd[UBOOT_BD_BUSFREQ_OFFSET];
+			setprop(devp, "clock-frequency", v, sizeof(v[0]));
+		}	
+		if ((devp = finddevice("/memory"))) {
+			v[0] = bd[UBOOT_BD_MEMSTART_OFFSET];
+		       	v[1] = bd[UBOOT_BD_MEMSIZE_OFFSET] + v[0];
+			setprop(devp, "reg", v, sizeof(v));
+		}
+		break;
+	default:
 	/* Update cpu's clock-frequency & timebase-frequency in fdt */
 	if ((pit = get_processor_info(mfspr(SPRN_PVR)))) {
 		if ((devp = finddevice("/cpus/PowerPC,603e"))) {
@@ -118,6 +148,8 @@ sandpoint_fixups(void)
 		v[1] = min(i, max_mem);
 		setprop(devp, "reg", v, sizeof(v));
 	}
+	break;
+	}
 
 	/* XXXX stuff from platforms/.../sandpoint.c should be here */
 }
@@ -139,8 +171,10 @@ static struct ops sandpoint_ops;
 static struct platform_ops sandpoint_platform_ops;
 
 struct ops *
-platform_init(void *promptr)
+platform_init(void *promptr, unsigned long a1)
 {
+	bd_saved = a1;
+	
 	sandpoint_platform_ops.fixups = sandpoint_fixups;
 	sandpoint_platform_ops.exit = sandpoint_reset;
 
