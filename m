Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17278.40894.898159.724090@cargo.ozlabs.ibm.com>
Date: Sat, 19 Nov 2005 14:45:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051118221309.GA12724@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> So we either need a ld script for coff with kernel and initrd in the
> .data section. Or we write a tool to extract the vmlinux.gz and initrd
> based on nm or readelf -a output.

Here's a new version that does the first of those...

The zImage base address could go back to 4MB now.  In fact one could
argue that if OF is based at 12MB and load-base is near zero, linking
it at 6MB would be best.

There is still something I haven't got right: if you do make -j3, it
does this sort of thing:

  STRIP   vmlinux.strip
  STRIP   vmlinux.strip
  GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
  GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
  BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
  BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
mv: cannot stat `arch/powerpc/boot/.kernel-vmlinux.strip.o.tmp': No such file or directory
make[2]: *** [arch/powerpc/boot/kernel-vmlinux.strip.o] Error 1
make[1]: *** [zImage] Error 2

I have no idea why it tries to make those things twice in parallel.
It doesn't do that for vmlinux.

Paul.

diff -urN powerpc/arch/powerpc/Makefile merge-hack/arch/powerpc/Makefile
--- powerpc/arch/powerpc/Makefile	2005-11-18 17:19:11.000000000 +1100
+++ merge-hack/arch/powerpc/Makefile	2005-11-18 17:20:06.000000000 +1100
@@ -138,7 +138,7 @@
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
-defaultimage-$(CONFIG_PPC32)	:= zImage
+defaultimage-$(CONFIG_PPC32)	:= zImage zImage.coff
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
 defaultimage-$(CONFIG_PPC_PSERIES) := zImage
 KBUILD_IMAGE := $(defaultimage-y)
@@ -149,7 +149,8 @@
 # All the instructions talk about "make bzImage".
 bzImage: zImage
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm \
+	       zImage.vmode zImage.initrd.vmode zImage.coff zImage.initrd.coff
 
 .PHONY: $(BOOT_TARGETS)
 
diff -urN powerpc/arch/powerpc/boot/Makefile merge-hack/arch/powerpc/boot/Makefile
--- powerpc/arch/powerpc/boot/Makefile	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/Makefile	2005-11-19 14:18:04.000000000 +1100
@@ -25,8 +25,8 @@
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
 		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
-BOOTLFLAGS	:= -T $(srctree)/$(src)/zImage.lds
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
+OBJCOPY_COFF_ARGS := -O aixcoff-rs6000 --set-start 0x500000
 
 zlib       := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
 zlibheader := infblock.h infcodes.h inffast.h inftrees.h infutil.h
@@ -35,7 +35,7 @@
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := string.S prom.c main.c div64.S crt0.S
+src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
@@ -70,7 +70,7 @@
       cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootld = BOOTLD  $@
-      cmd_bootld = $(CROSS32LD) $(BOOTLFLAGS) -o $@ $(2)
+      cmd_bootld = $(CROSS32LD) -T $(srctree)/$(src)/$(3) -o $@ $(2)
 
 $(patsubst %.c,%.o, $(filter %.c, $(src-boot))): %.o: %.c
 	$(call if_changed_dep,bootcc)
@@ -87,12 +87,13 @@
 src-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.c, $(section)))
 gz-sec  = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.gz, $(section)))
 
-hostprogs-y		:= addnote addRamDisk
-targets 		+= zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
-			   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
-			   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
-			   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
-			   vmlinux.initrd
+hostprogs-y		:= addnote addRamDisk hack-coff
+
+targets += zImage.vmode zImage.initrd.vmode zImage zImage.initrd \
+	   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
+	   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
+	   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
+	   vmlinux.initrd
 extra-y			:= initrd.o
 
 quiet_cmd_ramdisk = RAMDISK $@
@@ -114,6 +115,10 @@
 quiet_cmd_addnote = ADDNOTE $@
       cmd_addnote = $(obj)/addnote $@
 
+quiet_cmd_gencoff = COFF    $@
+      cmd_gencoff = $(OBJCOPY) $(OBJCOPY_COFF_ARGS) $@ && \
+		    $(obj)/hack-coff $@
+
 $(call gz-sec, $(required)): $(obj)/kernel-%.gz: %
 	$(call if_changed,gzip)
 
@@ -127,13 +132,13 @@
 	$(call if_changed_dep,bootcc)
 	$(call cmd,addsection)
 
-$(obj)/zImage.vmode: obj-boot += $(call obj-sec, $(required))
+$(obj)/zImage.vmode $(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
 $(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.lds
-	$(call cmd,bootld,$(obj-boot))
+	$(call cmd,bootld,$(obj-boot),zImage.lds)
 
-$(obj)/zImage.initrd.vmode: obj-boot += $(call obj-sec, $(required) $(initrd))
+$(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff: obj-boot += $(call obj-sec, $(required) $(initrd))
 $(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds
-	$(call cmd,bootld,$(obj-boot))
+	$(call cmd,bootld,$(obj-boot),zImage.lds)
 
 $(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote
 	@cp -f $< $@
@@ -143,6 +148,15 @@
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
+$(obj)/zImage.coff: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff
+	$(call cmd,bootld,$(obj-boot),zImage.coff.lds)
+	$(call cmd,gencoff)
+
+$(obj)/zImage.initrd.coff: $(call obj-sec, $(required) $(initrd)) $(obj-boot) \
+			   $(srctree)/$(src)/zImage.coff.lds $(obj)/hack-coff
+	$(call cmd,bootld,$(obj-boot),zImage.coff.lds)
+	$(call cmd,gencoff)
+
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
diff -urN powerpc/arch/powerpc/boot/crt0.S merge-hack/arch/powerpc/boot/crt0.S
--- powerpc/arch/powerpc/boot/crt0.S	2005-11-18 15:57:30.000000000 +1100
+++ merge-hack/arch/powerpc/boot/crt0.S	2005-11-18 22:07:18.000000000 +1100
@@ -12,17 +12,23 @@
 #include "ppc_asm.h"
 
 	.text
+	/* a procedure descriptor used when booting this as a COFF file */
+_zimage_start_opd:
+	.long	_zimage_start, 0, 0, 0
+
 	.globl	_zimage_start
 _zimage_start:
+	/* Work out the offset between the address we were linked at
+	   and the address where we're running. */
 	bl	1f
-
-1:
-	mflr	r0
+1:	mflr	r0
 	lis	r9,1b@ha
 	addi	r9,r9,1b@l
 	subf.	r0,r9,r0
-	beq	3f
+	beq	3f		/* if running at same address as linked */
 
+	/* The .got2 section contains a list of addresses, so add
+	   the address offset onto each entry. */
 	lis	r9,__got2_start@ha
 	addi	r9,r9,__got2_start@l
 	lis	r8,__got2_end@ha
@@ -32,15 +38,14 @@
 	srwi.	r8,r8,2
 	mtctr	r8
 	add	r9,r0,r9
-2:
-	lwz	r8,0(r9)
+2:	lwz	r8,0(r9)
 	add	r8,r8,r0
 	stw	r8,0(r9)
 	addi	r9,r9,4
 	bdnz	2b
 
-3:
-	lis	r9,_start@h
+	/* Do a cache flush for our text, in case OF didn't */
+3:	lis	r9,_start@h
 	add	r9,r0,r9
 	lis	r8,_etext@ha
 	addi	r8,r8,_etext@l
diff -urN powerpc/arch/powerpc/boot/hack-coff.c merge-hack/arch/powerpc/boot/hack-coff.c
--- /dev/null	2005-11-19 12:36:29.626282000 +1100
+++ merge-hack/arch/powerpc/boot/hack-coff.c	2005-11-17 14:57:08.000000000 +1100
@@ -0,0 +1,84 @@
+/*
+ * hack-coff.c - hack the header of an xcoff file to fill in
+ * a few fields needed by the Open Firmware xcoff loader on
+ * Power Macs but not initialized by objcopy.
+ *
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include "rs6000.h"
+
+#define AOUT_MAGIC	0x010b
+
+#define get_16be(x)	((((unsigned char *)(x))[0] << 8) \
+			 + ((unsigned char *)(x))[1])
+#define put_16be(x, v)	(((unsigned char *)(x))[0] = (v) >> 8, \
+			 ((unsigned char *)(x))[1] = (v) & 0xff)
+#define get_32be(x)	((((unsigned char *)(x))[0] << 24) \
+			 + (((unsigned char *)(x))[1] << 16) \
+			 + (((unsigned char *)(x))[2] << 8) \
+			 + ((unsigned char *)(x))[3])
+
+int
+main(int ac, char **av)
+{
+    int fd;
+    int i, nsect;
+    int aoutsz;
+    struct external_filehdr fhdr;
+    AOUTHDR aout;
+    struct external_scnhdr shdr;
+
+    if (ac != 2) {
+	fprintf(stderr, "Usage: hack-coff coff-file\n");
+	exit(1);
+    }
+    if ((fd = open(av[1], 2)) == -1) {
+	perror(av[2]);
+	exit(1);
+    }
+    if (read(fd, &fhdr, sizeof(fhdr)) != sizeof(fhdr))
+	goto readerr;
+    i = get_16be(fhdr.f_magic);
+    if (i != U802TOCMAGIC && i != U802WRMAGIC && i != U802ROMAGIC) {
+	fprintf(stderr, "%s: not an xcoff file\n", av[1]);
+	exit(1);
+    }
+    aoutsz = get_16be(fhdr.f_opthdr);
+    if (read(fd, &aout, aoutsz) != aoutsz)
+	goto readerr;
+    nsect = get_16be(fhdr.f_nscns);
+    for (i = 0; i < nsect; ++i) {
+	if (read(fd, &shdr, sizeof(shdr)) != sizeof(shdr))
+	    goto readerr;
+	if (strcmp(shdr.s_name, ".text") == 0) {
+	    put_16be(aout.o_snentry, i+1);
+	    put_16be(aout.o_sntext, i+1);
+	} else if (strcmp(shdr.s_name, ".data") == 0) {
+	    put_16be(aout.o_sndata, i+1);
+	} else if (strcmp(shdr.s_name, ".bss") == 0) {
+	    put_16be(aout.o_snbss, i+1);
+	}
+    }
+    put_16be(aout.magic, AOUT_MAGIC);
+    if (lseek(fd, (long) sizeof(struct external_filehdr), 0) == -1
+	|| write(fd, &aout, aoutsz) != aoutsz) {
+	fprintf(stderr, "%s: write error\n", av[1]);
+	exit(1);
+    }
+    close(fd);
+    exit(0);
+
+readerr:
+    fprintf(stderr, "%s: read error or file too short\n", av[1]);
+    exit(1);
+}
diff -urN powerpc/arch/powerpc/boot/main.c merge-hack/arch/powerpc/boot/main.c
--- powerpc/arch/powerpc/boot/main.c	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/main.c	2005-11-17 14:41:13.000000000 +1100
@@ -21,8 +21,8 @@
 
 
 /* Value picked to match that used by yaboot */
-#define PROG_START	0x01400000
-#define RAM_END		(512<<20) // Fixme: use OF */
+#define PROG_START	0x01400000	/* only used on 64-bit systems */
+#define RAM_END		(512<<20)	/* Fixme: use OF */
 #define	ONE_MB		0x100000
 
 extern char _start[];
@@ -160,6 +160,17 @@
 	elfoffset = (unsigned long)elf64ph->p_offset;
 	vmlinux.size = (unsigned long)elf64ph->p_filesz + elfoffset;
 	vmlinux.memsize = (unsigned long)elf64ph->p_memsz + elfoffset;
+
+#if defined(PROG_START)
+	/*
+	 * Maintain a "magic" minimum address. This keeps some older
+	 * firmware platforms running.
+	 */
+
+	if (claim_base < PROG_START)
+		claim_base = PROG_START;
+#endif
+
 	return 1;
 }
 
@@ -206,12 +217,18 @@
 		exit();
 	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
 		exit();
-	stderr = stdout;
-	if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
-		exit();
 
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
 
+	/*
+	 * The first available claim_base must be above the end of the
+	 * the loaded kernel wrapper file (_start to _end includes the
+	 * initrd image if it is present) and rounded up to a nice
+	 * 1 MB boundary for good measure.
+	 */
+
+	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
 
@@ -228,25 +245,6 @@
 		exit();
 	}
 
-	/*
-	 * The first available claim_base must be above the end of the
-	 * the loaded kernel wrapper file (_start to _end includes the
-	 * initrd image if it is present) and rounded up to a nice
-	 * 1 MB boundary for good measure.
-	 */
-
-	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
-
-#if defined(PROG_START)
-	/*
-	 * Maintain a "magic" minimum address. This keeps some older
-	 * firmware platforms running.
-	 */
-
-	if (claim_base < PROG_START)
-		claim_base = PROG_START;
-#endif
-
 	/* We need to claim the memsize plus the file offset since gzip
 	 * will expand the header (file offset), then the kernel, then
 	 * possible rubbish we don't care about. But the kernel bss must
diff -urN powerpc/arch/powerpc/boot/prom.c merge-hack/arch/powerpc/boot/prom.c
--- powerpc/arch/powerpc/boot/prom.c	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/prom.c	2005-11-17 14:37:12.000000000 +1100
@@ -13,487 +13,153 @@
 #include "prom.h"
 
 int (*prom)(void *);
+phandle chosen_handle;
+ihandle stdout;
 
-void *chosen_handle;
-
-void *stdin;
-void *stdout;
-void *stderr;
-
-
-int
-write(void *handle, void *ptr, int nb)
-{
-	struct prom_args {
-		char *service;
-		int nargs;
-		int nret;
-		void *ihandle;
-		void *addr;
-		int len;
-		int actual;
-	} args;
-
-	args.service = "write";
-	args.nargs = 3;
-	args.nret = 1;
-	args.ihandle = handle;
-	args.addr = ptr;
-	args.len = nb;
-	args.actual = -1;
-	(*prom)(&args);
-	return args.actual;
-}
-
-int
-read(void *handle, void *ptr, int nb)
+int call_prom(const char *service, int nargs, int nret, ...)
 {
+	int i;
 	struct prom_args {
-		char *service;
+		const char *service;
 		int nargs;
 		int nret;
-		void *ihandle;
-		void *addr;
-		int len;
-		int actual;
+		unsigned int args[12];
 	} args;
+	va_list list;
 
-	args.service = "read";
-	args.nargs = 3;
-	args.nret = 1;
-	args.ihandle = handle;
-	args.addr = ptr;
-	args.len = nb;
-	args.actual = -1;
-	(*prom)(&args);
-	return args.actual;
-}
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
 
-void
-exit()
-{
-	struct prom_args {
-		char *service;
-	} args;
+	va_start(list, nret);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
 
-	for (;;) {
-		args.service = "exit";
-		(*prom)(&args);
-	}
-}
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
 
-void
-pause(void)
-{
-	struct prom_args {
-		char *service;
-	} args;
-
-	args.service = "enter";
-	(*prom)(&args);
-}
-
-void *
-finddevice(const char *name)
-{
-	struct prom_args {
-		char *service;
-		int nargs;
-		int nret;
-		const char *devspec;
-		void *phandle;
-	} args;
-
-	args.service = "finddevice";
-	args.nargs = 1;
-	args.nret = 1;
-	args.devspec = name;
-	args.phandle = (void *) -1;
-	(*prom)(&args);
-	return args.phandle;
-}
-
-void *
-claim(unsigned long virt, unsigned long size, unsigned long align)
-{
-	struct prom_args {
-		char *service;
-		int nargs;
-		int nret;
-		unsigned int virt;
-		unsigned int size;
-		unsigned int align;
-		void *ret;
-	} args;
+	if (prom(&args) < 0)
+		return -1;
 
-	args.service = "claim";
-	args.nargs = 3;
-	args.nret = 1;
-	args.virt = virt;
-	args.size = size;
-	args.align = align;
-	(*prom)(&args);
-	return args.ret;
+	return (nret > 0)? args.args[nargs]: 0;
 }
 
-int
-getprop(void *phandle, const char *name, void *buf, int buflen)
+int call_prom_ret(const char *service, int nargs, int nret,
+		  unsigned int *rets, ...)
 {
+	int i;
 	struct prom_args {
-		char *service;
+		const char *service;
 		int nargs;
 		int nret;
-		void *phandle;
-		const char *name;
-		void *buf;
-		int buflen;
-		int size;
+		unsigned int args[12];
 	} args;
+	va_list list;
 
-	args.service = "getprop";
-	args.nargs = 4;
-	args.nret = 1;
-	args.phandle = phandle;
-	args.name = name;
-	args.buf = buf;
-	args.buflen = buflen;
-	args.size = -1;
-	(*prom)(&args);
-	return args.size;
-}
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
 
-int
-putc(int c, void *f)
-{
-	char ch = c;
+	va_start(list, rets);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
 
-	if (c == '\n')
-		putc('\r', f);
-	return write(f, &ch, 1) == 1? c: -1;
-}
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
 
-int
-putchar(int c)
-{
-	return putc(c, stdout);
-}
+	if (prom(&args) < 0)
+		return -1;
 
-int
-fputs(char *str, void *f)
-{
-	int n = strlen(str);
+	if (rets != (void *) 0)
+		for (i = 1; i < nret; ++i)
+			rets[i-1] = args.args[nargs+i];
 
-	return write(f, str, n) == n? 0: -1;
+	return (nret > 0)? args.args[nargs]: 0;
 }
 
-size_t strnlen(const char * s, size_t count)
+int write(void *handle, void *ptr, int nb)
 {
-	const char *sc;
-
-	for (sc = s; count-- && *sc != '\0'; ++sc)
-		/* nothing */;
-	return sc - s;
+	return call_prom("write", 3, 1, handle, ptr, nb);
 }
 
-extern unsigned int __div64_32(unsigned long long *dividend,
-			       unsigned int divisor);
-
-/* The unnecessary pointer compare is there
- * to check for type safety (n must be 64bit)
+/*
+ * Older OF's require that when claiming a specific range of addresses,
+ * we claim the physical space in the /memory node and the virtual
+ * space in the chosen mmu node, and then do a map operation to
+ * map virtual to physical.
  */
-# define do_div(n,base) ({						\
-	unsigned int __base = (base);					\
-	unsigned int __rem;						\
-	(void)(((typeof((n)) *)0) == ((unsigned long long *)0));	\
-	if (((n) >> 32) == 0) {						\
-		__rem = (unsigned int)(n) % __base;			\
-		(n) = (unsigned int)(n) / __base;			\
-	} else								\
-		__rem = __div64_32(&(n), __base);			\
-	__rem;								\
- })
+static int need_map = -1;
+static ihandle chosen_mmu;
+static phandle memory;
 
-static int skip_atoi(const char **s)
+/* returns true if s2 is a prefix of s1 */
+static int string_match(const char *s1, const char *s2)
 {
-	int i, c;
-
-	for (i = 0; '0' <= (c = **s) && c <= '9'; ++*s)
-		i = i*10 + c - '0';
-	return i;
+	for (; *s2; ++s2)
+		if (*s1++ != *s2)
+			return 0;
+	return 1;
 }
 
-#define ZEROPAD	1		/* pad with zero */
-#define SIGN	2		/* unsigned/signed long */
-#define PLUS	4		/* show plus */
-#define SPACE	8		/* space if plus */
-#define LEFT	16		/* left justified */
-#define SPECIAL	32		/* 0x */
-#define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
-
-static char * number(char * str, unsigned long long num, int base, int size, int precision, int type)
+static int check_of_version(void)
 {
-	char c,sign,tmp[66];
-	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
-	int i;
+	phandle oprom, chosen;
+	char version[64];
 
-	if (type & LARGE)
-		digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
-	if (type & LEFT)
-		type &= ~ZEROPAD;
-	if (base < 2 || base > 36)
+	oprom = finddevice("/openprom");
+	if (oprom == (phandle) -1)
+		return 0;
+	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
 		return 0;
-	c = (type & ZEROPAD) ? '0' : ' ';
-	sign = 0;
-	if (type & SIGN) {
-		if ((signed long long)num < 0) {
-			sign = '-';
-			num = - (signed long long)num;
-			size--;
-		} else if (type & PLUS) {
-			sign = '+';
-			size--;
-		} else if (type & SPACE) {
-			sign = ' ';
-			size--;
+	version[sizeof(version)-1] = 0;
+	printf("OF version = '%s'\r\n", version);
+	if (!string_match(version, "Open Firmware, 1.")
+	    && !string_match(version, "FirmWorks,3."))
+		return 0;
+	chosen = finddevice("/chosen");
+	if (chosen == (phandle) -1) {
+		chosen = finddevice("/chosen@0");
+		if (chosen == (phandle) -1) {
+			printf("no chosen\n");
+			return 0;
 		}
 	}
-	if (type & SPECIAL) {
-		if (base == 16)
-			size -= 2;
-		else if (base == 8)
-			size--;
-	}
-	i = 0;
-	if (num == 0)
-		tmp[i++]='0';
-	else while (num != 0) {
-		tmp[i++] = digits[do_div(num, base)];
+	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
+		printf("no mmu\n");
+		return 0;
 	}
-	if (i > precision)
-		precision = i;
-	size -= precision;
-	if (!(type&(ZEROPAD+LEFT)))
-		while(size-->0)
-			*str++ = ' ';
-	if (sign)
-		*str++ = sign;
-	if (type & SPECIAL) {
-		if (base==8)
-			*str++ = '0';
-		else if (base==16) {
-			*str++ = '0';
-			*str++ = digits[33];
+	memory = (ihandle) call_prom("open", 1, 1, "/memory");
+	if (memory == (ihandle) -1) {
+		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
+		if (memory == (ihandle) -1) {
+			printf("no memory node\n");
+			return 0;
 		}
 	}
-	if (!(type & LEFT))
-		while (size-- > 0)
-			*str++ = c;
-	while (i < precision--)
-		*str++ = '0';
-	while (i-- > 0)
-		*str++ = tmp[i];
-	while (size-- > 0)
-		*str++ = ' ';
-	return str;
+	printf("old OF detected\r\n");
+	return 1;
 }
 
-int vsprintf(char *buf, const char *fmt, va_list args)
+void *claim(unsigned long virt, unsigned long size, unsigned long align)
 {
-	int len;
-	unsigned long long num;
-	int i, base;
-	char * str;
-	const char *s;
-
-	int flags;		/* flags to number() */
-
-	int field_width;	/* width of output field */
-	int precision;		/* min. # of digits for integers; max
-				   number of chars for from string */
-	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
-	                        /* 'z' support added 23/7/1999 S.H.    */
-				/* 'z' changed to 'Z' --davidm 1/25/99 */
+	int ret;
+	unsigned int result;
 
+	if (need_map < 0)
+		need_map = check_of_version();
+	if (align || !need_map)
+		return (void *) call_prom("claim", 3, 1, virt, size, align);
 	
-	for (str=buf ; *fmt ; ++fmt) {
-		if (*fmt != '%') {
-			*str++ = *fmt;
-			continue;
-		}
-			
-		/* process flags */
-		flags = 0;
-		repeat:
-			++fmt;		/* this also skips first '%' */
-			switch (*fmt) {
-				case '-': flags |= LEFT; goto repeat;
-				case '+': flags |= PLUS; goto repeat;
-				case ' ': flags |= SPACE; goto repeat;
-				case '#': flags |= SPECIAL; goto repeat;
-				case '0': flags |= ZEROPAD; goto repeat;
-				}
-		
-		/* get field width */
-		field_width = -1;
-		if ('0' <= *fmt && *fmt <= '9')
-			field_width = skip_atoi(&fmt);
-		else if (*fmt == '*') {
-			++fmt;
-			/* it's the next argument */
-			field_width = va_arg(args, int);
-			if (field_width < 0) {
-				field_width = -field_width;
-				flags |= LEFT;
-			}
-		}
-
-		/* get the precision */
-		precision = -1;
-		if (*fmt == '.') {
-			++fmt;	
-			if ('0' <= *fmt && *fmt <= '9')
-				precision = skip_atoi(&fmt);
-			else if (*fmt == '*') {
-				++fmt;
-				/* it's the next argument */
-				precision = va_arg(args, int);
-			}
-			if (precision < 0)
-				precision = 0;
-		}
-
-		/* get the conversion qualifier */
-		qualifier = -1;
-		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
-			qualifier = *fmt;
-			++fmt;
-		}
-
-		/* default base */
-		base = 10;
-
-		switch (*fmt) {
-		case 'c':
-			if (!(flags & LEFT))
-				while (--field_width > 0)
-					*str++ = ' ';
-			*str++ = (unsigned char) va_arg(args, int);
-			while (--field_width > 0)
-				*str++ = ' ';
-			continue;
-
-		case 's':
-			s = va_arg(args, char *);
-			if (!s)
-				s = "<NULL>";
-
-			len = strnlen(s, precision);
-
-			if (!(flags & LEFT))
-				while (len < field_width--)
-					*str++ = ' ';
-			for (i = 0; i < len; ++i)
-				*str++ = *s++;
-			while (len < field_width--)
-				*str++ = ' ';
-			continue;
-
-		case 'p':
-			if (field_width == -1) {
-				field_width = 2*sizeof(void *);
-				flags |= ZEROPAD;
-			}
-			str = number(str,
-				(unsigned long) va_arg(args, void *), 16,
-				field_width, precision, flags);
-			continue;
-
-
-		case 'n':
-			if (qualifier == 'l') {
-				long * ip = va_arg(args, long *);
-				*ip = (str - buf);
-			} else if (qualifier == 'Z') {
-				size_t * ip = va_arg(args, size_t *);
-				*ip = (str - buf);
-			} else {
-				int * ip = va_arg(args, int *);
-				*ip = (str - buf);
-			}
-			continue;
-
-		case '%':
-			*str++ = '%';
-			continue;
-
-		/* integer number formats - set up the flags and "break" */
-		case 'o':
-			base = 8;
-			break;
-
-		case 'X':
-			flags |= LARGE;
-		case 'x':
-			base = 16;
-			break;
-
-		case 'd':
-		case 'i':
-			flags |= SIGN;
-		case 'u':
-			break;
-
-		default:
-			*str++ = '%';
-			if (*fmt)
-				*str++ = *fmt;
-			else
-				--fmt;
-			continue;
-		}
-		if (qualifier == 'l') {
-			num = va_arg(args, unsigned long);
-			if (flags & SIGN)
-				num = (signed long) num;
-		} else if (qualifier == 'Z') {
-			num = va_arg(args, size_t);
-		} else if (qualifier == 'h') {
-			num = (unsigned short) va_arg(args, int);
-			if (flags & SIGN)
-				num = (signed short) num;
-		} else {
-			num = va_arg(args, unsigned int);
-			if (flags & SIGN)
-				num = (signed int) num;
-		}
-		str = number(str, num, base, field_width, precision, flags);
-	}
-	*str = '\0';
-	return str-buf;
-}
-
-int sprintf(char * buf, const char *fmt, ...)
-{
-	va_list args;
-	int i;
-
-	va_start(args, fmt);
-	i=vsprintf(buf,fmt,args);
-	va_end(args);
-	return i;
-}
-
-static char sprint_buf[1024];
-
-int
-printf(const char *fmt, ...)
-{
-	va_list args;
-	int n;
-
-	va_start(args, fmt);
-	n = vsprintf(sprint_buf, fmt, args);
-	va_end(args);
-	write(stdout, sprint_buf, n);
-	return n;
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
+			    align, size, virt);
+	if (ret != 0 || result == -1)
+		return (void *) -1;
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
+			    align, size, virt);
+	/* 0x12 == coherent + read/write */
+	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
+			0x12, size, virt, virt);
+	return (void *) virt;
 }
diff -urN powerpc/arch/powerpc/boot/prom.h merge-hack/arch/powerpc/boot/prom.h
--- powerpc/arch/powerpc/boot/prom.h	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/prom.h	2005-11-17 11:11:47.000000000 +1100
@@ -1,18 +1,34 @@
 #ifndef _PPC_BOOT_PROM_H_
 #define _PPC_BOOT_PROM_H_
 
+typedef void *phandle;
+typedef void *ihandle;
+
 extern int (*prom) (void *);
-extern void *chosen_handle;
+extern phandle chosen_handle;
+extern ihandle stdout;
 
-extern void *stdin;
-extern void *stdout;
-extern void *stderr;
+int	call_prom(const char *service, int nargs, int nret, ...);
+int	call_prom_ret(const char *service, int nargs, int nret,
+		      unsigned int *rets, ...);
 
 extern int write(void *handle, void *ptr, int nb);
-extern int read(void *handle, void *ptr, int nb);
-extern void exit(void);
-extern void pause(void);
-extern void *finddevice(const char *);
-extern void *claim(unsigned long virt, unsigned long size, unsigned long align);
-extern int getprop(void *phandle, const char *name, void *buf, int buflen);
+extern void *claim(unsigned long virt, unsigned long size, unsigned long aln);
+
+static inline void exit(void)
+{
+	call_prom("exit", 0, 0);
+}
+
+static inline phandle finddevice(const char *name)
+{
+	return (phandle) call_prom("finddevice", 1, 1, name);
+}
+
+static inline int getprop(void *phandle, const char *name,
+			  void *buf, int buflen)
+{
+	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+}
+
 #endif				/* _PPC_BOOT_PROM_H_ */
diff -urN powerpc/arch/powerpc/boot/rs6000.h merge-hack/arch/powerpc/boot/rs6000.h
--- /dev/null	2005-11-19 12:36:29.626282000 +1100
+++ merge-hack/arch/powerpc/boot/rs6000.h	2005-11-17 14:57:47.000000000 +1100
@@ -0,0 +1,243 @@
+/* IBM RS/6000 "XCOFF" file definitions for BFD.
+   Copyright (C) 1990, 1991 Free Software Foundation, Inc.
+   FIXME: Can someone provide a transliteration of this name into ASCII?
+   Using the following chars caused a compiler warning on HIUX (so I replaced
+   them with octal escapes), and isn't useful without an understanding of what
+   character set it is.
+   Written by Mimi Ph\373\364ng-Th\345o V\365 of IBM
+   and John Gilmore of Cygnus Support.  */
+
+/********************** FILE HEADER **********************/
+
+struct external_filehdr {
+	char f_magic[2];	/* magic number			*/
+	char f_nscns[2];	/* number of sections		*/
+	char f_timdat[4];	/* time & date stamp		*/
+	char f_symptr[4];	/* file pointer to symtab	*/
+	char f_nsyms[4];	/* number of symtab entries	*/
+	char f_opthdr[2];	/* sizeof(optional hdr)		*/
+	char f_flags[2];	/* flags			*/
+};
+
+        /* IBM RS/6000 */
+#define U802WRMAGIC     0730    /* writeable text segments **chh**      */
+#define U802ROMAGIC     0735    /* readonly sharable text segments      */
+#define U802TOCMAGIC    0737    /* readonly text segments and TOC       */
+
+#define BADMAG(x)	\
+	((x).f_magic != U802ROMAGIC && (x).f_magic != U802WRMAGIC && \
+	 (x).f_magic != U802TOCMAGIC)
+
+#define	FILHDR	struct external_filehdr
+#define	FILHSZ	20
+
+
+/********************** AOUT "OPTIONAL HEADER" **********************/
+
+
+typedef struct
+{
+  unsigned char	magic[2];	/* type of file			*/
+  unsigned char	vstamp[2];	/* version stamp		*/
+  unsigned char	tsize[4];	/* text size in bytes, padded to FW bdry */
+  unsigned char	dsize[4];	/* initialized data "  "	*/
+  unsigned char	bsize[4];	/* uninitialized data "   "	*/
+  unsigned char	entry[4];	/* entry pt.			*/
+  unsigned char	text_start[4];	/* base of text used for this file */
+  unsigned char	data_start[4];	/* base of data used for this file */
+  unsigned char	o_toc[4];	/* address of TOC */
+  unsigned char	o_snentry[2];	/* section number of entry point */
+  unsigned char	o_sntext[2];	/* section number of .text section */
+  unsigned char	o_sndata[2];	/* section number of .data section */
+  unsigned char	o_sntoc[2];	/* section number of TOC */
+  unsigned char	o_snloader[2];	/* section number of .loader section */
+  unsigned char	o_snbss[2];	/* section number of .bss section */
+  unsigned char	o_algntext[2];	/* .text alignment */
+  unsigned char	o_algndata[2];	/* .data alignment */
+  unsigned char	o_modtype[2];	/* module type (??) */
+  unsigned char o_cputype[2];	/* cpu type */
+  unsigned char	o_maxstack[4];	/* max stack size (??) */
+  unsigned char o_maxdata[4];	/* max data size (??) */
+  unsigned char	o_resv2[12];	/* reserved */
+}
+AOUTHDR;
+
+#define AOUTSZ 72
+#define SMALL_AOUTSZ (28)
+#define AOUTHDRSZ 72
+
+#define	RS6K_AOUTHDR_OMAGIC	0x0107	/* old: text & data writeable */
+#define	RS6K_AOUTHDR_NMAGIC	0x0108	/* new: text r/o, data r/w */
+#define	RS6K_AOUTHDR_ZMAGIC	0x010B	/* paged: text r/o, both page-aligned */
+
+
+/********************** SECTION HEADER **********************/
+
+
+struct external_scnhdr {
+	char		s_name[8];	/* section name			*/
+	char		s_paddr[4];	/* physical address, aliased s_nlib */
+	char		s_vaddr[4];	/* virtual address		*/
+	char		s_size[4];	/* section size			*/
+	char		s_scnptr[4];	/* file ptr to raw data for section */
+	char		s_relptr[4];	/* file ptr to relocation	*/
+	char		s_lnnoptr[4];	/* file ptr to line numbers	*/
+	char		s_nreloc[2];	/* number of relocation entries	*/
+	char		s_nlnno[2];	/* number of line number entries*/
+	char		s_flags[4];	/* flags			*/
+};
+
+/*
+ * names of "special" sections
+ */
+#define _TEXT	".text"
+#define _DATA	".data"
+#define _BSS	".bss"
+#define _PAD	".pad"
+#define _LOADER	".loader"
+
+#define	SCNHDR	struct external_scnhdr
+#define	SCNHSZ	40
+
+/* XCOFF uses a special .loader section with type STYP_LOADER.  */
+#define STYP_LOADER 0x1000
+
+/* XCOFF uses a special .debug section with type STYP_DEBUG.  */
+#define STYP_DEBUG 0x2000
+
+/* XCOFF handles line number or relocation overflow by creating
+   another section header with STYP_OVRFLO set.  */
+#define STYP_OVRFLO 0x8000
+
+/********************** LINE NUMBERS **********************/
+
+/* 1 line number entry for every "breakpointable" source line in a section.
+ * Line numbers are grouped on a per function basis; first entry in a function
+ * grouping will have l_lnno = 0 and in place of physical address will be the
+ * symbol table index of the function name.
+ */
+struct external_lineno {
+	union {
+		char l_symndx[4];	/* function name symbol index, iff l_lnno == 0*/
+		char l_paddr[4];	/* (physical) address of line number	*/
+	} l_addr;
+	char l_lnno[2];	/* line number		*/
+};
+
+
+#define	LINENO	struct external_lineno
+#define	LINESZ	6
+
+
+/********************** SYMBOLS **********************/
+
+#define E_SYMNMLEN	8	/* # characters in a symbol name	*/
+#define E_FILNMLEN	14	/* # characters in a file name		*/
+#define E_DIMNUM	4	/* # array dimensions in auxiliary entry */
+
+struct external_syment
+{
+  union {
+    char e_name[E_SYMNMLEN];
+    struct {
+      char e_zeroes[4];
+      char e_offset[4];
+    } e;
+  } e;
+  char e_value[4];
+  char e_scnum[2];
+  char e_type[2];
+  char e_sclass[1];
+  char e_numaux[1];
+};
+
+
+
+#define N_BTMASK	(017)
+#define N_TMASK		(060)
+#define N_BTSHFT	(4)
+#define N_TSHIFT	(2)
+
+
+union external_auxent {
+	struct {
+		char x_tagndx[4];	/* str, un, or enum tag indx */
+		union {
+			struct {
+			    char  x_lnno[2]; /* declaration line number */
+			    char  x_size[2]; /* str/union/array size */
+			} x_lnsz;
+			char x_fsize[4];	/* size of function */
+		} x_misc;
+		union {
+			struct {		/* if ISFCN, tag, or .bb */
+			    char x_lnnoptr[4];	/* ptr to fcn line # */
+			    char x_endndx[4];	/* entry ndx past block end */
+			} x_fcn;
+			struct {		/* if ISARY, up to 4 dimen. */
+			    char x_dimen[E_DIMNUM][2];
+			} x_ary;
+		} x_fcnary;
+		char x_tvndx[2];		/* tv index */
+	} x_sym;
+
+	union {
+		char x_fname[E_FILNMLEN];
+		struct {
+			char x_zeroes[4];
+			char x_offset[4];
+		} x_n;
+	} x_file;
+
+	struct {
+		char x_scnlen[4];			/* section length */
+		char x_nreloc[2];	/* # relocation entries */
+		char x_nlinno[2];	/* # line numbers */
+	} x_scn;
+
+        struct {
+		char x_tvfill[4];	/* tv fill value */
+		char x_tvlen[2];	/* length of .tv */
+		char x_tvran[2][2];	/* tv range */
+	} x_tv;		/* info about .tv section (in auxent of symbol .tv)) */
+
+	struct {
+		unsigned char x_scnlen[4];
+		unsigned char x_parmhash[4];
+		unsigned char x_snhash[2];
+		unsigned char x_smtyp[1];
+		unsigned char x_smclas[1];
+		unsigned char x_stab[4];
+		unsigned char x_snstab[2];
+	} x_csect;
+
+};
+
+#define	SYMENT	struct external_syment
+#define	SYMESZ	18
+#define	AUXENT	union external_auxent
+#define	AUXESZ	18
+#define DBXMASK 0x80		/* for dbx storage mask */
+#define SYMNAME_IN_DEBUG(symptr) ((symptr)->n_sclass & DBXMASK)
+
+
+
+/********************** RELOCATION DIRECTIVES **********************/
+
+
+struct external_reloc {
+  char r_vaddr[4];
+  char r_symndx[4];
+  char r_size[1];
+  char r_type[1];
+};
+
+
+#define RELOC struct external_reloc
+#define RELSZ 10
+
+#define DEFAULT_DATA_SECTION_ALIGNMENT 4
+#define DEFAULT_BSS_SECTION_ALIGNMENT 4
+#define DEFAULT_TEXT_SECTION_ALIGNMENT 4
+/* For new sections we havn't heard of before */
+#define DEFAULT_SECTION_ALIGNMENT 4
diff -urN powerpc/arch/powerpc/boot/stdio.c merge-hack/arch/powerpc/boot/stdio.c
--- /dev/null	2005-11-19 12:36:29.626282000 +1100
+++ merge-hack/arch/powerpc/boot/stdio.c	2005-11-17 14:36:52.000000000 +1100
@@ -0,0 +1,325 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "string.h"
+#include "stdio.h"
+#include "prom.h"
+
+size_t strnlen(const char * s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
+extern unsigned int __div64_32(unsigned long long *dividend,
+			       unsigned int divisor);
+
+/* The unnecessary pointer compare is there
+ * to check for type safety (n must be 64bit)
+ */
+# define do_div(n,base) ({						\
+	unsigned int __base = (base);					\
+	unsigned int __rem;						\
+	(void)(((typeof((n)) *)0) == ((unsigned long long *)0));	\
+	if (((n) >> 32) == 0) {						\
+		__rem = (unsigned int)(n) % __base;			\
+		(n) = (unsigned int)(n) / __base;			\
+	} else								\
+		__rem = __div64_32(&(n), __base);			\
+	__rem;								\
+ })
+
+static int skip_atoi(const char **s)
+{
+	int i, c;
+
+	for (i = 0; '0' <= (c = **s) && c <= '9'; ++*s)
+		i = i*10 + c - '0';
+	return i;
+}
+
+#define ZEROPAD	1		/* pad with zero */
+#define SIGN	2		/* unsigned/signed long */
+#define PLUS	4		/* show plus */
+#define SPACE	8		/* space if plus */
+#define LEFT	16		/* left justified */
+#define SPECIAL	32		/* 0x */
+#define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
+
+static char * number(char * str, unsigned long long num, int base, int size, int precision, int type)
+{
+	char c,sign,tmp[66];
+	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
+	int i;
+
+	if (type & LARGE)
+		digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+	if (type & LEFT)
+		type &= ~ZEROPAD;
+	if (base < 2 || base > 36)
+		return 0;
+	c = (type & ZEROPAD) ? '0' : ' ';
+	sign = 0;
+	if (type & SIGN) {
+		if ((signed long long)num < 0) {
+			sign = '-';
+			num = - (signed long long)num;
+			size--;
+		} else if (type & PLUS) {
+			sign = '+';
+			size--;
+		} else if (type & SPACE) {
+			sign = ' ';
+			size--;
+		}
+	}
+	if (type & SPECIAL) {
+		if (base == 16)
+			size -= 2;
+		else if (base == 8)
+			size--;
+	}
+	i = 0;
+	if (num == 0)
+		tmp[i++]='0';
+	else while (num != 0) {
+		tmp[i++] = digits[do_div(num, base)];
+	}
+	if (i > precision)
+		precision = i;
+	size -= precision;
+	if (!(type&(ZEROPAD+LEFT)))
+		while(size-->0)
+			*str++ = ' ';
+	if (sign)
+		*str++ = sign;
+	if (type & SPECIAL) {
+		if (base==8)
+			*str++ = '0';
+		else if (base==16) {
+			*str++ = '0';
+			*str++ = digits[33];
+		}
+	}
+	if (!(type & LEFT))
+		while (size-- > 0)
+			*str++ = c;
+	while (i < precision--)
+		*str++ = '0';
+	while (i-- > 0)
+		*str++ = tmp[i];
+	while (size-- > 0)
+		*str++ = ' ';
+	return str;
+}
+
+int vsprintf(char *buf, const char *fmt, va_list args)
+{
+	int len;
+	unsigned long long num;
+	int i, base;
+	char * str;
+	const char *s;
+
+	int flags;		/* flags to number() */
+
+	int field_width;	/* width of output field */
+	int precision;		/* min. # of digits for integers; max
+				   number of chars for from string */
+	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+	                        /* 'z' support added 23/7/1999 S.H.    */
+				/* 'z' changed to 'Z' --davidm 1/25/99 */
+
+	
+	for (str=buf ; *fmt ; ++fmt) {
+		if (*fmt != '%') {
+			*str++ = *fmt;
+			continue;
+		}
+			
+		/* process flags */
+		flags = 0;
+		repeat:
+			++fmt;		/* this also skips first '%' */
+			switch (*fmt) {
+				case '-': flags |= LEFT; goto repeat;
+				case '+': flags |= PLUS; goto repeat;
+				case ' ': flags |= SPACE; goto repeat;
+				case '#': flags |= SPECIAL; goto repeat;
+				case '0': flags |= ZEROPAD; goto repeat;
+				}
+		
+		/* get field width */
+		field_width = -1;
+		if ('0' <= *fmt && *fmt <= '9')
+			field_width = skip_atoi(&fmt);
+		else if (*fmt == '*') {
+			++fmt;
+			/* it's the next argument */
+			field_width = va_arg(args, int);
+			if (field_width < 0) {
+				field_width = -field_width;
+				flags |= LEFT;
+			}
+		}
+
+		/* get the precision */
+		precision = -1;
+		if (*fmt == '.') {
+			++fmt;	
+			if ('0' <= *fmt && *fmt <= '9')
+				precision = skip_atoi(&fmt);
+			else if (*fmt == '*') {
+				++fmt;
+				/* it's the next argument */
+				precision = va_arg(args, int);
+			}
+			if (precision < 0)
+				precision = 0;
+		}
+
+		/* get the conversion qualifier */
+		qualifier = -1;
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
+			qualifier = *fmt;
+			++fmt;
+		}
+
+		/* default base */
+		base = 10;
+
+		switch (*fmt) {
+		case 'c':
+			if (!(flags & LEFT))
+				while (--field_width > 0)
+					*str++ = ' ';
+			*str++ = (unsigned char) va_arg(args, int);
+			while (--field_width > 0)
+				*str++ = ' ';
+			continue;
+
+		case 's':
+			s = va_arg(args, char *);
+			if (!s)
+				s = "<NULL>";
+
+			len = strnlen(s, precision);
+
+			if (!(flags & LEFT))
+				while (len < field_width--)
+					*str++ = ' ';
+			for (i = 0; i < len; ++i)
+				*str++ = *s++;
+			while (len < field_width--)
+				*str++ = ' ';
+			continue;
+
+		case 'p':
+			if (field_width == -1) {
+				field_width = 2*sizeof(void *);
+				flags |= ZEROPAD;
+			}
+			str = number(str,
+				(unsigned long) va_arg(args, void *), 16,
+				field_width, precision, flags);
+			continue;
+
+
+		case 'n':
+			if (qualifier == 'l') {
+				long * ip = va_arg(args, long *);
+				*ip = (str - buf);
+			} else if (qualifier == 'Z') {
+				size_t * ip = va_arg(args, size_t *);
+				*ip = (str - buf);
+			} else {
+				int * ip = va_arg(args, int *);
+				*ip = (str - buf);
+			}
+			continue;
+
+		case '%':
+			*str++ = '%';
+			continue;
+
+		/* integer number formats - set up the flags and "break" */
+		case 'o':
+			base = 8;
+			break;
+
+		case 'X':
+			flags |= LARGE;
+		case 'x':
+			base = 16;
+			break;
+
+		case 'd':
+		case 'i':
+			flags |= SIGN;
+		case 'u':
+			break;
+
+		default:
+			*str++ = '%';
+			if (*fmt)
+				*str++ = *fmt;
+			else
+				--fmt;
+			continue;
+		}
+		if (qualifier == 'l') {
+			num = va_arg(args, unsigned long);
+			if (flags & SIGN)
+				num = (signed long) num;
+		} else if (qualifier == 'Z') {
+			num = va_arg(args, size_t);
+		} else if (qualifier == 'h') {
+			num = (unsigned short) va_arg(args, int);
+			if (flags & SIGN)
+				num = (signed short) num;
+		} else {
+			num = va_arg(args, unsigned int);
+			if (flags & SIGN)
+				num = (signed int) num;
+		}
+		str = number(str, num, base, field_width, precision, flags);
+	}
+	*str = '\0';
+	return str-buf;
+}
+
+int sprintf(char * buf, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i=vsprintf(buf,fmt,args);
+	va_end(args);
+	return i;
+}
+
+static char sprint_buf[1024];
+
+int
+printf(const char *fmt, ...)
+{
+	va_list args;
+	int n;
+
+	va_start(args, fmt);
+	n = vsprintf(sprint_buf, fmt, args);
+	va_end(args);
+	write(stdout, sprint_buf, n);
+	return n;
+}
diff -urN powerpc/arch/powerpc/boot/stdio.h merge-hack/arch/powerpc/boot/stdio.h
--- powerpc/arch/powerpc/boot/stdio.h	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/stdio.h	2005-11-17 11:07:34.000000000 +1100
@@ -7,10 +7,4 @@
 
 extern int vsprintf(char *buf, const char *fmt, va_list args);
 
-extern int putc(int c, void *f);
-extern int putchar(int c);
-extern int getchar(void);
-
-extern int fputs(char *str, void *f);
-
 #endif				/* _PPC_BOOT_STDIO_H_ */
diff -urN powerpc/arch/powerpc/boot/zImage.coff.lds merge-hack/arch/powerpc/boot/zImage.coff.lds
--- /dev/null	2005-11-19 12:36:29.626282000 +1100
+++ merge-hack/arch/powerpc/boot/zImage.coff.lds	2005-11-18 22:19:31.000000000 +1100
@@ -0,0 +1,46 @@
+OUTPUT_ARCH(powerpc:common)
+ENTRY(_start)
+SECTIONS
+{
+  . = (5*1024*1024);
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
+
+    _vmlinux_start =  .;
+    *(.kernel:vmlinux.strip)
+    _vmlinux_end =  .;
+
+    _initrd_start =  .;
+    *(.kernel:initrd)
+    _initrd_end =  .;
+  }
+
+  . = ALIGN(4096);
+  _edata  =  .;
+  __bss_start = .;
+  .bss       :
+  {
+   *(.sbss)
+   *(.bss)
+  }
+  _end = . ;
+
+  /DISCARD/ :
+  {
+    *(.comment)
+  }
+}
diff -urN powerpc/arch/powerpc/boot/zImage.lds merge-hack/arch/powerpc/boot/zImage.lds
--- powerpc/arch/powerpc/boot/zImage.lds	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/zImage.lds	2005-11-18 21:21:04.000000000 +1100
@@ -2,7 +2,7 @@
 ENTRY(_zimage_start)
 SECTIONS
 {
-  . = (4*1024*1024);
+  . = (5*1024*1024);
   _start = .;
   .text      :
   {
@@ -33,8 +33,6 @@
 
   . = ALIGN(4096);
   _edata  =  .;
-
-  . = ALIGN(4096);
   __bss_start = .;
   .bss       :
   {
