Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
In-Reply-To: <20070216062458.GA23008@localhost.localdomain>
Message-Id: <20070216062739.6DFDBDDD05@ozlabs.org>
Date: Fri, 16 Feb 2007 17:27:39 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch re-organises the way the zImage wrapper code is entered, to
allow more flexibility on platforms with unusual entry conditions.
After this patch, a platform .o file has two options:

1) It can define a _zimage_start, in which case the platform code gets
   control from the very beginning of execution.  In this case the
   platform code is responsible for relocating the zImage if necessary,
   clearing the BSS, performing any platform specific initialization, and
   finally calling start() to load and enter the kernel.

2) It can define platform_init().  In this case the generic crt0.S
   handles initial entry, and calls platform_init() before calling
   start().  The signature of platform_init() is changed, however, to
   take up to 5 parameters (in r3..r7) as they come from the platform's
   initial loader, instead of a fixed set of parameters based on OF's
   usage.

   When using the generic crt0.S, the platform .o can optionally
   supply a custom stack to use, using the BSS_STACK() macro.  If this
   is not supplied, the crt0.S will assume that the loader has
   supplied a usable stack.

In either case, the platform code communicates information to the
generic code (specifically, a PROM pointer for OF systems, and/or an
initrd image address supplied by the bootloader) via a global
structure "loader_info".

In addition the wrapper script is rearranged to ensure that the
platform .o is always linked first.  This means that platforms where
the zImage entry point is at a fixed address or offset, rather than
being encoded in the binary header can be supported using option (1).

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/Makefile          |    6 +++---
 arch/powerpc/boot/crt0.S            |   30 +++++++++++++++++++++++++++---
 arch/powerpc/boot/main.c            |   18 +++++++-----------
 arch/powerpc/boot/of.c              |    6 ++++--
 arch/powerpc/boot/ops.h             |   12 +++++++++++-
 arch/powerpc/boot/wrapper           |    6 ++++--
 arch/powerpc/boot/zImage.coff.lds.S |    3 ++-
 arch/powerpc/boot/zImage.lds.S      |    1 +
 8 files changed, 59 insertions(+), 23 deletions(-)

Index: working-2.6/arch/powerpc/boot/crt0.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/crt0.S	2006-12-08 10:42:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/crt0.S	2007-02-16 14:12:18.000000000 +1100
@@ -16,6 +16,7 @@
 _zimage_start_opd:
 	.long	_zimage_start, 0, 0, 0
 
+	.weak	_zimage_start
 	.globl	_zimage_start
 _zimage_start:
 	/* Work out the offset between the address we were linked at
@@ -44,7 +45,7 @@ _zimage_start:
 	addi	r9,r9,4
 	bdnz	2b
 
-	/* Do a cache flush for our text, in case OF didn't */
+	/* Do a cache flush for our text, in case the loader didn't */
 3:	lis	r9,_start@ha
 	addi	r9,r9,_start@l
 	add	r9,r0,r9
@@ -59,6 +60,29 @@ _zimage_start:
 	sync
 	isync
 
-	mr	r6,r1
-	b	start
+	/* Possibly set up a custom stack */
+.weak	_platform_stack_top
+	lis	r8,_platform_stack_top@ha
+	addi	r8,r8,_platform_stack_top@l
+	cmpwi	r8,0
+	beq	5f
+	lwz	r1,0(r8)
+5:
+
+	/* Clear the BSS */
+	lis	r9,__bss_start@ha
+	addi	r9,r9,__bss_start@l
+	lis	r8,_end@ha
+	addi	r8,r8,_end@l
+	li	r0,0
+6:	stw	r0,0(r9)
+	addi	r9,r9,4
+	cmplw	cr0,r9,r8
+	blt	6b
+
+	/* Call platform_init() */
+	bl	platform_init
 
+	/* Call start */
+	mr	r3,r1
+	b	start
Index: working-2.6/arch/powerpc/boot/ops.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ops.h	2007-02-16 14:03:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/ops.h	2007-02-16 14:03:27.000000000 +1100
@@ -59,7 +59,13 @@ struct serial_console_data {
 	void		(*close)(void);
 };
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end);
+struct loader_info {
+	void *promptr;
+	unsigned long initrd_addr, initrd_size;
+};
+extern struct loader_info loader_info;
+
+void start(void *sp);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
@@ -100,4 +106,8 @@ static inline void exit(void)
 	for(;;);
 }
 
+#define BSS_STACK(size) \
+	static char _bss_stack[size]; \
+	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
+
 #endif /* _PPC_BOOT_OPS_H_ */
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-02-16 14:03:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-02-16 14:03:27.000000000 +1100
@@ -254,21 +254,15 @@ static void set_cmdline(char *buf)
 struct platform_ops platform_ops;
 struct dt_ops dt_ops;
 struct console_ops console_ops;
+struct loader_info loader_info;
 
-void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+void start(void *sp)
 {
 	struct addr_range vmlinux, initrd;
 	kernel_entry_t kentry;
 	char cmdline[COMMAND_LINE_SIZE];
 	unsigned long ft_addr = 0;
 
-	memset(__bss_start, 0, _end - __bss_start);
-	memset(&platform_ops, 0, sizeof(platform_ops));
-	memset(&dt_ops, 0, sizeof(dt_ops));
-	memset(&console_ops, 0, sizeof(console_ops));
-
-	if (platform_init(promptr, _dtb_start, _dtb_end))
-		exit();
 	if (console_ops.open && (console_ops.open() < 0))
 		exit();
 	if (platform_ops.fixups)
@@ -278,7 +272,8 @@ void start(unsigned long a1, unsigned lo
 	       _start, sp);
 
 	vmlinux = prep_kernel();
-	initrd = prep_initrd(vmlinux, a1, a2);
+	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
+			     loader_info.initrd_size);
 
 	/* If cmdline came from zimage wrapper or if we can edit the one
 	 * in the dt, print it out and edit it, if possible.
@@ -298,7 +293,7 @@ void start(unsigned long a1, unsigned lo
 	if (ft_addr)
 		printf(" flat tree at 0x%lx\n\r", ft_addr);
 	else
-		printf(" using OF tree (promptr=%p)\n\r", promptr);
+		printf(" using OF tree (promptr=%p)\n\r", loader_info.promptr);
 
 	if (console_ops.close)
 		console_ops.close();
@@ -307,7 +302,8 @@ void start(unsigned long a1, unsigned lo
 	if (ft_addr)
 		kentry(ft_addr, 0, NULL);
 	else
-		kentry((unsigned long)initrd.addr, initrd.size, promptr);
+		kentry((unsigned long)initrd.addr, initrd.size,
+		       loader_info.promptr);
 
 	/* console closed so printf below may not work */
 	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");
Index: working-2.6/arch/powerpc/boot/of.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/of.c	2007-02-16 14:03:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/of.c	2007-02-16 14:03:27.000000000 +1100
@@ -267,7 +267,7 @@ static void of_console_write(char *buf, 
 	call_prom("write", 3, 1, of_stdout_handle, buf, len);
 }
 
-int platform_init(void *promptr, char *dt_blob_start, char *dt_blob_end)
+void platform_init(unsigned long a1, unsigned long a2, void *promptr)
 {
 	platform_ops.image_hdr = of_image_hdr;
 	platform_ops.malloc = of_try_claim;
@@ -282,5 +282,7 @@ int platform_init(void *promptr, char *d
 	console_ops.write = of_console_write;
 
 	prom = (int (*)(void *))promptr;
-	return 0;
+	loader_info.promptr = promptr;
+	loader_info.initrd_addr = a1;
+	loader_info.initrd_size = a2;
 }
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-16 14:03:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-16 15:12:06.000000000 +1100
@@ -40,11 +40,11 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 		$(addprefix $(obj)/,$(zlibheader))
 
-src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
+src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
 src-plat := of.c
-src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
+src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
@@ -97,7 +97,7 @@ $(obj)/wrapper.a: $(obj-wlib)
 
 hostprogs-y	:= addnote addRamDisk hack-coff mktree
 
-extra-y		:= $(obj)/crt0.o $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
+extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/wrapper	2007-02-16 15:13:36.000000000 +1100
@@ -191,7 +191,7 @@ fi
 
 if [ "$platform" != "miboot" ]; then
     ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
-	$object/crt0.o $platformo $tmp $object/wrapper.a
+	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
 
@@ -201,7 +201,9 @@ pseries|chrp)
     $object/addnote "$ofile"
     ;;
 pmaccoff)
-    ${CROSS}objcopy -O aixcoff-rs6000 --set-start 0x500000 "$ofile"
+    entry=`objdump -f "$ofile" | grep '^start address ' | \
+	cut -d' ' -f3`
+    ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
 esac
Index: working-2.6/arch/powerpc/boot/zImage.lds.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/zImage.lds.S	2007-02-16 15:09:52.000000000 +1100
+++ working-2.6/arch/powerpc/boot/zImage.lds.S	2007-02-16 15:10:01.000000000 +1100
@@ -1,5 +1,6 @@
 OUTPUT_ARCH(powerpc:common)
 ENTRY(_zimage_start)
+EXTERN(_zimage_start)
 SECTIONS
 {
   . = (4*1024*1024);
Index: working-2.6/arch/powerpc/boot/zImage.coff.lds.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/zImage.coff.lds.S	2007-02-16 15:12:22.000000000 +1100
+++ working-2.6/arch/powerpc/boot/zImage.coff.lds.S	2007-02-16 15:12:34.000000000 +1100
@@ -1,5 +1,6 @@
 OUTPUT_ARCH(powerpc:common)
-ENTRY(_start)
+ENTRY(_zimage_start_opd)
+EXTERN(_zimage_start_opd)
 SECTIONS
 {
   . = (5*1024*1024);
