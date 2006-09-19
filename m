Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17679.25131.721027.405431@cargo.ozlabs.ibm.com>
Date: Tue, 19 Sep 2006 13:21:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH] Start arch/powerpc/boot code reorganization
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a reworked version of Mark's patches 1/6 and 2/6.  This boots
on powermac (newworld) and pseries (power5 partition) at least.

I intend to commit this with Mark as the author and a suitable commit
message, unless there are adverse comments.

Paul.

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index afc776f..e737741 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -36,7 +36,8 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
+src-boot-$(CONFIG_PPC_MULTIPLATFORM) := of.c
+src-boot := crt0.S string.S stdio.c main.c div64.S $(src-boot-y)
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index b66634c..d719bb9 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -14,17 +14,12 @@ #include "elf.h"
 #include "page.h"
 #include "string.h"
 #include "stdio.h"
-#include "prom.h"
 #include "zlib.h"
+#include "ops.h"
+#include "flatdevtree.h"
 
 extern void flush_cache(void *, unsigned long);
 
-
-/* Value picked to match that used by yaboot */
-#define PROG_START	0x01400000	/* only used on 64-bit systems */
-#define RAM_END		(512<<20)	/* Fixme: use OF */
-#define	ONE_MB		0x100000
-
 extern char _start[];
 extern char __bss_start[];
 extern char _end[];
@@ -33,14 +28,6 @@ extern char _vmlinux_end[];
 extern char _initrd_start[];
 extern char _initrd_end[];
 
-/* A buffer that may be edited by tools operating on a zImage binary so as to
- * edit the command line passed to vmlinux (by setting /chosen/bootargs).
- * The buffer is put in it's own section so that tools may locate it easier.
- */
-static char builtin_cmdline[512]
-	__attribute__((section("__builtin_cmdline")));
-
-
 struct addr_range {
 	unsigned long addr;
 	unsigned long size;
@@ -51,21 +38,16 @@ static struct addr_range vmlinuz;
 static struct addr_range initrd;
 
 static unsigned long elfoffset;
+static int is_64bit;
 
-static char scratch[46912];	/* scratch space for gunzip, from zlib_inflate_workspacesize() */
+/* scratch space for gunzip; 46912 is from zlib_inflate_workspacesize() */
+static char scratch[46912];
 static char elfheader[256];
 
-
-typedef void (*kernel_entry_t)( unsigned long,
-                                unsigned long,
-                                void *,
-				void *);
-
+typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
 
 #undef DEBUG
 
-static unsigned long claim_base;
-
 #define HEAD_CRC	2
 #define EXTRA_FIELD	4
 #define ORIG_NAME	8
@@ -123,24 +105,6 @@ static void gunzip(void *dst, int dstlen
 	zlib_inflateEnd(&s);
 }
 
-static unsigned long try_claim(unsigned long size)
-{
-	unsigned long addr = 0;
-
-	for(; claim_base < RAM_END; claim_base += ONE_MB) {
-#ifdef DEBUG
-		printf("    trying: 0x%08lx\n\r", claim_base);
-#endif
-		addr = (unsigned long)claim(claim_base, size, 0);
-		if ((void *)addr != (void *)-1)
-			break;
-	}
-	if (addr == 0)
-		return 0;
-	claim_base = PAGE_ALIGN(claim_base + size);
-	return addr;
-}
-
 static int is_elf64(void *hdr)
 {
 	Elf64_Ehdr *elf64 = hdr;
@@ -169,16 +133,7 @@ static int is_elf64(void *hdr)
 	vmlinux.size = (unsigned long)elf64ph->p_filesz + elfoffset;
 	vmlinux.memsize = (unsigned long)elf64ph->p_memsz + elfoffset;
 
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
+	is_64bit = 1;
 	return 1;
 }
 
@@ -212,47 +167,9 @@ static int is_elf32(void *hdr)
 	return 1;
 }
 
-void export_cmdline(void* chosen_handle)
-{
-        int len;
-        char cmdline[2] = { 0, 0 };
-
-	if (builtin_cmdline[0] == 0)
-		return;
-
-        len = getprop(chosen_handle, "bootargs", cmdline, sizeof(cmdline));
-        if (len > 0 && cmdline[0] != 0)
-		return;
-
-	setprop(chosen_handle, "bootargs", builtin_cmdline,
-		strlen(builtin_cmdline) + 1);
-}
-
-
-void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+static void prep_kernel(unsigned long *a1, unsigned long *a2)
 {
 	int len;
-	kernel_entry_t kernel_entry;
-
-	memset(__bss_start, 0, _end - __bss_start);
-
-	prom = (int (*)(void *)) promptr;
-	chosen_handle = finddevice("/chosen");
-	if (chosen_handle == (void *) -1)
-		exit();
-	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
-		exit();
-
-	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
-
-	/*
-	 * The first available claim_base must be above the end of the
-	 * the loaded kernel wrapper file (_start to _end includes the
-	 * initrd image if it is present) and rounded up to a nice
-	 * 1 MB boundary for good measure.
-	 */
-
-	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
 
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
@@ -263,43 +180,51 @@ void start(unsigned long a1, unsigned lo
 		gunzip(elfheader, sizeof(elfheader),
 				(unsigned char *)vmlinuz.addr, &len);
 	} else
-		memcpy(elfheader, (const void *)vmlinuz.addr, sizeof(elfheader));
+		memcpy(elfheader, (const void *)vmlinuz.addr,
+		       sizeof(elfheader));
 
 	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
 		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 		exit();
 	}
+	if (platform_ops.image_hdr)
+		platform_ops.image_hdr(elfheader);
 
-	/* We need to claim the memsize plus the file offset since gzip
+	/* We need to alloc the memsize plus the file offset since gzip
 	 * will expand the header (file offset), then the kernel, then
 	 * possible rubbish we don't care about. But the kernel bss must
 	 * be claimed (it will be zero'd by the kernel itself)
 	 */
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
-	vmlinux.addr = try_claim(vmlinux.memsize);
+	vmlinux.addr = (unsigned long)malloc(vmlinux.memsize);
 	if (vmlinux.addr == 0) {
 		printf("Can't allocate memory for kernel image !\n\r");
 		exit();
 	}
 
 	/*
-	 * Now we try to claim memory for the initrd (and copy it there)
+	 * Now we try to alloc memory for the initrd (and copy it there)
 	 */
 	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
 	initrd.memsize = initrd.size;
 	if ( initrd.size > 0 ) {
-		printf("Allocating 0x%lx bytes for initrd ...\n\r", initrd.size);
-		initrd.addr = try_claim(initrd.size);
+		printf("Allocating 0x%lx bytes for initrd ...\n\r",
+		       initrd.size);
+		initrd.addr = (unsigned long)malloc((u32)initrd.size);
 		if (initrd.addr == 0) {
-			printf("Can't allocate memory for initial ramdisk !\n\r");
+			printf("Can't allocate memory for initial "
+					"ramdisk !\n\r");
 			exit();
 		}
-		a1 = initrd.addr;
-		a2 = initrd.size;
-		printf("initial ramdisk moving 0x%lx <- 0x%lx (0x%lx bytes)\n\r",
-		       initrd.addr, (unsigned long)_initrd_start, initrd.size);
-		memmove((void *)initrd.addr, (void *)_initrd_start, initrd.size);
-		printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd.addr));
+		*a1 = initrd.addr;
+		*a2 = initrd.size;
+		printf("initial ramdisk moving 0x%lx <- 0x%lx "
+			"(0x%lx bytes)\n\r", initrd.addr,
+			(unsigned long)_initrd_start, initrd.size);
+		memmove((void *)initrd.addr, (void *)_initrd_start,
+			initrd.size);
+		printf("initrd head: 0x%lx\n\r",
+				*((unsigned long *)initrd.addr));
 	}
 
 	/* Eventually gunzip the kernel */
@@ -311,11 +236,10 @@ void start(unsigned long a1, unsigned lo
 			(unsigned char *)vmlinuz.addr, &len);
 		printf("done 0x%lx bytes\n\r", len);
 	} else {
-		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,vmlinuz.size);
+		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,
+			vmlinuz.size);
 	}
 
-	export_cmdline(chosen_handle);
-
 	/* Skip over the ELF header */
 #ifdef DEBUG
 	printf("... skipping 0x%lx bytes of ELF header\n\r",
@@ -324,23 +248,107 @@ #endif
 	vmlinux.addr += elfoffset;
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
+}
 
-	kernel_entry = (kernel_entry_t)vmlinux.addr;
-#ifdef DEBUG
-	printf( "kernel:\n\r"
-		"        entry addr = 0x%lx\n\r"
-		"        a1         = 0x%lx,\n\r"
-		"        a2         = 0x%lx,\n\r"
-		"        prom       = 0x%lx,\n\r"
-		"        bi_recs    = 0x%lx,\n\r",
-		(unsigned long)kernel_entry, a1, a2,
-		(unsigned long)prom, NULL);
-#endif
+void __attribute__ ((weak)) ft_init(void *dt_blob)
+{
+}
 
-	kernel_entry(a1, a2, prom, NULL);
+/* A buffer that may be edited by tools operating on a zImage binary so as to
+ * edit the command line passed to vmlinux (by setting /chosen/bootargs).
+ * The buffer is put in it's own section so that tools may locate it easier.
+ */
+static char builtin_cmdline[COMMAND_LINE_SIZE]
+	__attribute__((__section__("__builtin_cmdline")));
 
-	printf("Error: Linux kernel returned to zImage bootloader!\n\r");
+static void get_cmdline(char *buf, int size)
+{
+	void *devp;
+	int len = strlen(builtin_cmdline);
 
-	exit();
+	buf[0] = '\0';
+
+	if (len > 0) { /* builtin_cmdline overrides dt's /chosen/bootargs */
+		len = min(len, size-1);
+		strncpy(buf, builtin_cmdline, len);
+		buf[len] = '\0';
+	}
+	else if ((devp = finddevice("/chosen")))
+		getprop(devp, "bootargs", buf, size);
+}
+
+static void set_cmdline(char *buf)
+{
+	void *devp;
+
+	if ((devp = finddevice("/chosen")))
+		setprop(devp, "bootargs", buf, strlen(buf) + 1);
 }
 
+/* Section where ft can be tacked on after zImage is built */
+union blobspace {
+	struct boot_param_header hdr;
+	char space[8*1024];
+} dt_blob __attribute__((__section__("__builtin_ft")));
+
+struct platform_ops platform_ops;
+struct dt_ops dt_ops;
+struct console_ops console_ops;
+
+void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
+{
+	int have_dt = 0;
+	kernel_entry_t kentry;
+	char cmdline[COMMAND_LINE_SIZE];
+
+	memset(__bss_start, 0, _end - __bss_start);
+	memset(&platform_ops, 0, sizeof(platform_ops));
+	memset(&dt_ops, 0, sizeof(dt_ops));
+	memset(&console_ops, 0, sizeof(console_ops));
+
+	/* Override the dt_ops and device tree if there was an flat dev
+	 * tree attached to the zImage.
+	 */
+	if (dt_blob.hdr.magic == OF_DT_HEADER) {
+		have_dt = 1;
+		ft_init(&dt_blob);
+	}
+
+	if (platform_init(promptr))
+		exit();
+	if (console_ops.open && (console_ops.open() < 0))
+		exit();
+	if (platform_ops.fixups)
+		platform_ops.fixups();
+
+	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
+	       _start, sp);
+
+	prep_kernel(&a1, &a2);
+
+	/* If cmdline came from zimage wrapper or if we can edit the one
+	 * in the dt, print it out and edit it, if possible.
+	 */
+	if ((strlen(builtin_cmdline) > 0) || console_ops.edit_cmdline) {
+		get_cmdline(cmdline, COMMAND_LINE_SIZE);
+		printf("\n\rLinux/PowerPC load: %s", cmdline);
+		if (console_ops.edit_cmdline)
+			console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
+		printf("\n\r");
+		set_cmdline(cmdline);
+	}
+
+	if (console_ops.close)
+		console_ops.close();
+
+	kentry = (kernel_entry_t) vmlinux.addr;
+	if (have_dt)
+		kentry(dt_ops.ft_addr(), 0, NULL);
+	else
+		/* XXX initrd addr/size should be passed in properties */
+		kentry(a1, a2, promptr);
+
+	/* console closed so printf below may not work */
+	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");
+	exit();
+}
diff --git a/arch/powerpc/boot/prom.c b/arch/powerpc/boot/prom.c
deleted file mode 100644
index fa00577..0000000
--- a/arch/powerpc/boot/prom.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (C) Paul Mackerras 1997.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <stdarg.h>
-#include <stddef.h>
-#include "string.h"
-#include "stdio.h"
-#include "prom.h"
-
-int (*prom)(void *);
-phandle chosen_handle;
-ihandle stdout;
-
-int call_prom(const char *service, int nargs, int nret, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, nret);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int call_prom_ret(const char *service, int nargs, int nret,
-		  unsigned int *rets, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, rets);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	if (rets != (void *) 0)
-		for (i = 1; i < nret; ++i)
-			rets[i-1] = args.args[nargs+i];
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int write(void *handle, void *ptr, int nb)
-{
-	return call_prom("write", 3, 1, handle, ptr, nb);
-}
-
-/*
- * Older OF's require that when claiming a specific range of addresses,
- * we claim the physical space in the /memory node and the virtual
- * space in the chosen mmu node, and then do a map operation to
- * map virtual to physical.
- */
-static int need_map = -1;
-static ihandle chosen_mmu;
-static phandle memory;
-
-/* returns true if s2 is a prefix of s1 */
-static int string_match(const char *s1, const char *s2)
-{
-	for (; *s2; ++s2)
-		if (*s1++ != *s2)
-			return 0;
-	return 1;
-}
-
-static int check_of_version(void)
-{
-	phandle oprom, chosen;
-	char version[64];
-
-	oprom = finddevice("/openprom");
-	if (oprom == (phandle) -1)
-		return 0;
-	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
-		return 0;
-	version[sizeof(version)-1] = 0;
-	printf("OF version = '%s'\r\n", version);
-	if (!string_match(version, "Open Firmware, 1.")
-	    && !string_match(version, "FirmWorks,3."))
-		return 0;
-	chosen = finddevice("/chosen");
-	if (chosen == (phandle) -1) {
-		chosen = finddevice("/chosen@0");
-		if (chosen == (phandle) -1) {
-			printf("no chosen\n");
-			return 0;
-		}
-	}
-	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
-		printf("no mmu\n");
-		return 0;
-	}
-	memory = (ihandle) call_prom("open", 1, 1, "/memory");
-	if (memory == (ihandle) -1) {
-		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
-		if (memory == (ihandle) -1) {
-			printf("no memory node\n");
-			return 0;
-		}
-	}
-	printf("old OF detected\r\n");
-	return 1;
-}
-
-void *claim(unsigned long virt, unsigned long size, unsigned long align)
-{
-	int ret;
-	unsigned int result;
-
-	if (need_map < 0)
-		need_map = check_of_version();
-	if (align || !need_map)
-		return (void *) call_prom("claim", 3, 1, virt, size, align);
-	
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
-			    align, size, virt);
-	if (ret != 0 || result == -1)
-		return (void *) -1;
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
-			    align, size, virt);
-	/* 0x12 == coherent + read/write */
-	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
-			0x12, size, virt, virt);
-	return (void *) virt;
-}
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
deleted file mode 100644
index a57b184..0000000
--- a/arch/powerpc/boot/prom.h
+++ /dev/null
@@ -1,41 +0,0 @@
-#ifndef _PPC_BOOT_PROM_H_
-#define _PPC_BOOT_PROM_H_
-
-typedef void *phandle;
-typedef void *ihandle;
-
-extern int (*prom) (void *);
-extern phandle chosen_handle;
-extern ihandle stdout;
-
-int	call_prom(const char *service, int nargs, int nret, ...);
-int	call_prom_ret(const char *service, int nargs, int nret,
-		      unsigned int *rets, ...);
-
-extern int write(void *handle, void *ptr, int nb);
-extern void *claim(unsigned long virt, unsigned long size, unsigned long aln);
-
-static inline void exit(void)
-{
-	call_prom("exit", 0, 0);
-}
-
-static inline phandle finddevice(const char *name)
-{
-	return (phandle) call_prom("finddevice", 1, 1, name);
-}
-
-static inline int getprop(void *phandle, const char *name,
-			  void *buf, int buflen)
-{
-	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
-}
-
-
-static inline int setprop(void *phandle, const char *name,
-			  void *buf, int buflen)
-{
-	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
-}
-
-#endif				/* _PPC_BOOT_PROM_H_ */
diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index b5aa522..6d5f638 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -10,7 +10,7 @@ #include <stdarg.h>
 #include <stddef.h>
 #include "string.h"
 #include "stdio.h"
-#include "prom.h"
+#include "ops.h"
 
 size_t strnlen(const char * s, size_t count)
 {
@@ -320,6 +320,6 @@ printf(const char *fmt, ...)
 	va_start(args, fmt);
 	n = vsprintf(sprint_buf, fmt, args);
 	va_end(args);
-	write(stdout, sprint_buf, n);
+	console_ops.write(sprint_buf, n);
 	return n;
 }
diff --git a/arch/powerpc/boot/stdio.h b/arch/powerpc/boot/stdio.h
index eb9e16c..73b8a91 100644
--- a/arch/powerpc/boot/stdio.h
+++ b/arch/powerpc/boot/stdio.h
@@ -1,8 +1,16 @@
 #ifndef _PPC_BOOT_STDIO_H_
 #define _PPC_BOOT_STDIO_H_
 
+#include <stdarg.h>
+
+#define	ENOMEM		12	/* Out of Memory */
+#define	EINVAL		22	/* Invalid argument */
+#define ENOSPC		28	/* No space left on device */
+
 extern int printf(const char *fmt, ...);
 
+#define fprintf(fmt, args...)	printf(args)
+
 extern int sprintf(char *buf, const char *fmt, ...);
 
 extern int vsprintf(char *buf, const char *fmt, va_list args);
--- /dev/null	2006-09-18 11:33:23.687982711 +1000
+++ arch/powerpc/boot/flatdevtree.h	2006-09-19 11:46:47.000000000 +1000
@@ -0,0 +1,46 @@
+/*
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef FLATDEVTREE_H
+#define FLATDEVTREE_H
+
+#include "types.h"
+
+/* Definitions used by the flattened device tree */
+#define OF_DT_HEADER            0xd00dfeed      /* marker */
+#define OF_DT_BEGIN_NODE        0x1     /* Start of node, full name */
+#define OF_DT_END_NODE          0x2     /* End node */
+#define OF_DT_PROP              0x3     /* Property: name off, size, content */
+#define OF_DT_NOP               0x4     /* nop */
+#define OF_DT_END               0x9
+
+#define OF_DT_VERSION           0x10
+
+struct boot_param_header {
+	u32 magic;              /* magic word OF_DT_HEADER */
+	u32 totalsize;          /* total size of DT block */
+	u32 off_dt_struct;      /* offset to structure */
+	u32 off_dt_strings;     /* offset to strings */
+	u32 off_mem_rsvmap;     /* offset to memory reserve map */
+	u32 version;            /* format version */
+	u32 last_comp_version;  /* last compatible version */
+	/* version 2 fields below */
+	u32 boot_cpuid_phys;    /* Physical CPU id we're booting on */
+	/* version 3 fields below */
+	u32 dt_strings_size;    /* size of the DT strings block */
+};
+
+#endif /* FLATDEVTREE_H */
--- /dev/null	2006-09-18 11:33:23.687982711 +1000
+++ arch/powerpc/boot/of.c	2006-09-18 17:35:59.000000000 +1000
@@ -0,0 +1,283 @@
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
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+typedef void *ihandle;
+typedef void *phandle;
+
+extern char _end[];
+
+/* Value picked to match that used by yaboot */
+#define PROG_START	0x01400000	/* only used on 64-bit systems */
+#define RAM_END		(512<<20)	/* Fixme: use OF */
+#define	ONE_MB		0x100000
+
+int (*prom) (void *);
+
+
+static unsigned long claim_base;
+
+static int call_prom(const char *service, int nargs, int nret, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, nret);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+static int call_prom_ret(const char *service, int nargs, int nret,
+		  unsigned int *rets, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, rets);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	if (rets != (void *) 0)
+		for (i = 1; i < nret; ++i)
+			rets[i-1] = args.args[nargs+i];
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+/*
+ * Older OF's require that when claiming a specific range of addresses,
+ * we claim the physical space in the /memory node and the virtual
+ * space in the chosen mmu node, and then do a map operation to
+ * map virtual to physical.
+ */
+static int need_map = -1;
+static ihandle chosen_mmu;
+static phandle memory;
+
+/* returns true if s2 is a prefix of s1 */
+static int string_match(const char *s1, const char *s2)
+{
+	for (; *s2; ++s2)
+		if (*s1++ != *s2)
+			return 0;
+	return 1;
+}
+
+static int check_of_version(void)
+{
+	phandle oprom, chosen;
+	char version[64];
+
+	oprom = finddevice("/openprom");
+	if (oprom == (phandle) -1)
+		return 0;
+	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
+		return 0;
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
+		}
+	}
+	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
+		printf("no mmu\n");
+		return 0;
+	}
+	memory = (ihandle) call_prom("open", 1, 1, "/memory");
+	if (memory == (ihandle) -1) {
+		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
+		if (memory == (ihandle) -1) {
+			printf("no memory node\n");
+			return 0;
+		}
+	}
+	printf("old OF detected\r\n");
+	return 1;
+}
+
+static void *claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+	int ret;
+	unsigned int result;
+
+	if (need_map < 0)
+		need_map = check_of_version();
+	if (align || !need_map)
+		return (void *) call_prom("claim", 3, 1, virt, size, align);
+
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
+}
+
+static void *of_try_claim(u32 size)
+{
+	unsigned long addr = 0;
+	static u8 first_time = 1;
+
+	if (first_time) {
+		claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+		first_time = 0;
+	}
+
+	for(; claim_base < RAM_END; claim_base += ONE_MB) {
+#ifdef DEBUG
+		printf("    trying: 0x%08lx\n\r", claim_base);
+#endif
+		addr = (unsigned long)claim(claim_base, size, 0);
+		if ((void *)addr != (void *)-1)
+			break;
+	}
+	if (addr == 0)
+		return NULL;
+	claim_base = PAGE_ALIGN(claim_base + size);
+	return (void *)addr;
+}
+
+static void of_image_hdr(const void *hdr)
+{
+	const Elf64_Ehdr *elf64 = hdr;
+
+	if (elf64->e_ident[EI_CLASS] == ELFCLASS64) {
+		/*
+		 * Maintain a "magic" minimum address. This keeps some older
+		 * firmware platforms running.
+		 */
+		if (claim_base < PROG_START)
+			claim_base = PROG_START;
+	}
+}
+
+static void of_exit(void)
+{
+	call_prom("exit", 0, 0);
+}
+
+/*
+ * OF device tree routines
+ */
+static void *of_finddevice(const char *name)
+{
+	return (phandle) call_prom("finddevice", 1, 1, name);
+}
+
+static int of_getprop(const void *phandle, const char *name, void *buf,
+		const int buflen)
+{
+	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+}
+
+static int of_setprop(const void *phandle, const char *name, const void *buf,
+		const int buflen)
+{
+	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
+
+/*
+ * OF console routines
+ */
+static void *of_stdout_handle;
+
+static int of_console_open(void)
+{
+	void *devp;
+
+	if (((devp = finddevice("/chosen")) != NULL)
+			&& (getprop(devp, "stdout", &of_stdout_handle,
+				sizeof(of_stdout_handle))
+				== sizeof(of_stdout_handle)))
+		return 0;
+
+	return -1;
+}
+
+static void of_console_write(char *buf, int len)
+{
+	call_prom("write", 3, 1, of_stdout_handle, buf, len);
+}
+
+int platform_init(void *promptr)
+{
+	platform_ops.fixups = NULL;
+	platform_ops.image_hdr = of_image_hdr;
+	platform_ops.malloc = of_try_claim;
+	platform_ops.free = NULL;
+	platform_ops.exit = of_exit;
+
+	dt_ops.finddevice = of_finddevice;
+	dt_ops.getprop = of_getprop;
+	dt_ops.setprop = of_setprop;
+	dt_ops.translate_addr = NULL;
+
+	console_ops.open = of_console_open;
+	console_ops.write = of_console_write;
+	console_ops.edit_cmdline = NULL;
+	console_ops.close = NULL;
+	console_ops.data = NULL;
+
+	prom = (int (*)(void *))promptr;
+	return 0;
+}
--- /dev/null	2006-09-18 11:33:23.687982711 +1000
+++ arch/powerpc/boot/types.h	2006-09-18 13:48:20.000000000 +1000
@@ -0,0 +1,23 @@
+#ifndef _TYPES_H_
+#define _TYPES_H_
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef unsigned char		u8;
+typedef unsigned short		u16;
+typedef unsigned int		u32;
+typedef unsigned long long	u64;
+
+#define min(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x > _y ? _x : _y; })
+
+#endif /* _TYPES_H_ */
