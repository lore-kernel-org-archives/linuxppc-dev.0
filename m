Message-ID: <56201.193.133.92.239.1028911829.squirrel@lbbrown.homeip.net>
Date: Fri, 9 Aug 2002 17:50:29 +0100 (BST)
Subject: [PATCH] OF Changes to the boot loader
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@samba.org>, <trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20020809175029_77648"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


------=_20020809175029_77648
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

This patch pulls the OF functions out of the CHRP and PMac boot code and
puts them in their own library.

I want to start using OF calls in the PReP boot loader again, but Tom
made me do it this way instead of just adding back the old PReP OF
files - the meanie :)

The next step will be to start using the library in the PReP code to
do the stuff I want to do (use OF to get device info where the residual
data is missing).

Unfortunately, I don't have a CHRP or PMac box to test with, so the
changes are untested.

Patch is against 2_4_devel.

Cheers,

Leigh.



------=_20020809175029_77648
Content-Type: text/plain; name="ofchanges.diff"
Content-Disposition: attachment; filename="ofchanges.diff"

diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/Makefile linuxppc_2_4_devel-fb/arch/ppc/boot/Makefile
--- linuxppc_2_4_devel-140/arch/ppc/boot/Makefile	Sat Aug  3 07:57:44 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/Makefile	Fri Aug  9 09:56:08 2002
@@ -22,12 +22,15 @@
 lib/zlib.a: lib/zlib.c
 	$(MAKE) -C lib

+of1275/of1275.a: of1275/ofinit.c
+	$(MAKE) -C of1275
+
 images/vmlinux.gz: $(TOPDIR)/vmlinux
 	$(MAKE) -C images vmlinux.gz

 # Subdirs and tools needed for each.  Assume we always need to go into
 # 'simple' unless told otherwise.
-subdir-y			:= lib common simple
+subdir-y			:= lib of1275 common simple
 subdir-$(CONFIG_ALL_PPC)	:= chrp pmac prep
 tools-$(CONFIG_ALL_PPC)		:= addnote mknote hack-coff mkprep
 tools-$(CONFIG_PPLUS)		:= mkbugboot mkprep
@@ -56,7 +59,7 @@
 # The targets all boards support for boot images.
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd

-$(BOOT_TARGETS): vmapus lib/zlib.a images/vmlinux.gz maketools
+$(BOOT_TARGETS): vmapus lib/zlib.a of1275/of1275.a images/vmlinux.gz maketools
 ifneq ($(BOOTDIRS),)
 	for d in $(BOOTDIRS); do $(MAKE) -C $$d $@; done
 endif
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/chrp/Makefile linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/Makefile
--- linuxppc_2_4_devel-140/arch/ppc/boot/chrp/Makefile	Sat Aug  3 07:56:54 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/Makefile	Fri Aug  9 10:06:39 2002
@@ -13,7 +13,7 @@

 OBJS = ../common/crt0.o start.o main.o misc.o ../common/string.o image.o \
 	../common/ofcommon.o
-LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a
+LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a ../of1275/of1275.a
 ADDNOTE = ../utils/addnote
 PIGGYBACK = ../utils/piggyback

diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/chrp/main.c linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/main.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/chrp/main.c	Sat Aug  3 07:55:13 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/main.c	Fri Aug  9 10:11:23 2002
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include "nonstdio.h"
+#include "of1275.h"
 #include <asm/processor.h>
 #include <asm/page.h>

@@ -18,15 +19,11 @@
 extern char __ramdisk_begin[], __ramdisk_end;
 extern char _start, _end;

-extern int getprop(void *, const char *, void *, int);
 extern unsigned int heap_max;
-extern void claim(unsigned int virt, unsigned int size, unsigned int align);
-extern void *finddevice(const char *);
 extern void flush_cache(void *, unsigned long);
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void make_bi_recs(unsigned long addr, char *name, unsigned int mach,
 		unsigned int progend);
-extern void pause(void);

 char *avail_ram;
 char *begin_avail, *end_avail;
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/chrp/start.c linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/start.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/chrp/start.c	Sat Aug  3 07:55:30 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/chrp/start.c	Fri Aug  9 09:50:21 2002
@@ -10,17 +10,13 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <stdarg.h>
+#include "of1275.h"

 int (*prom)(void *args);

-void *chosen_handle;
-void *stdin;
-void *stdout;
-void *stderr;
-
-void exit(void);
-void *finddevice(const char *name);
-int getprop(void *phandle, const char *name, void *buf, int buflen);
+phandle stdin;
+phandle stdout;
+phandle stderr;

 void printk(char *fmt, ...);

@@ -30,163 +26,15 @@
 void
 start(int a1, int a2, void *promptr)
 {
-    prom = promptr;
-    chosen_handle = finddevice("/chosen");
-    if (chosen_handle == (void *) -1)
+    ofinit(promptr);
+    if (ofstdio(&stdin, &stdout, &stderr))
 	exit();
-    if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
-	exit();
-    stderr = stdout;
-    if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
-	exit();
-
     chrpboot(a1, a2, promptr);
     for (;;)
 	exit();
 }

 int
-write(void *handle, void *ptr, int nb)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *ihandle;
-	void *addr;
-	int len;
-	int actual;
-    } args;
-
-    args.service = "write";
-    args.nargs = 3;
-    args.nret = 1;
-    args.ihandle = handle;
-    args.addr = ptr;
-    args.len = nb;
-    args.actual = -1;
-    prom(&args);
-    return args.actual;
-}
-
-int
-read(void *handle, void *ptr, int nb)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *ihandle;
-	void *addr;
-	int len;
-	int actual;
-    } args;
-
-    args.service = "read";
-    args.nargs = 3;
-    args.nret = 1;
-    args.ihandle = handle;
-    args.addr = ptr;
-    args.len = nb;
-    args.actual = -1;
-    (*prom)(&args);
-    return args.actual;
-}
-
-void
-exit(void)
-{
-    struct prom_args {
-	char *service;
-    } args;
-
-    for (;;) {
-	args.service = "exit";
-	(*prom)(&args);
-    }
-}
-
-void
-pause(void)
-{
-    struct prom_args {
-	char *service;
-    } args;
-
-    args.service = "enter";
-    (*prom)(&args);
-}
-
-void *
-finddevice(const char *name)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	const char *devspec;
-	void *phandle;
-    } args;
-
-    args.service = "finddevice";
-    args.nargs = 1;
-    args.nret = 1;
-    args.devspec = name;
-    args.phandle = (void *) -1;
-    (*prom)(&args);
-    return args.phandle;
-}
-
-void *
-claim(unsigned int virt, unsigned int size, unsigned int align)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	unsigned int virt;
-	unsigned int size;
-	unsigned int align;
-	void *ret;
-    } args;
-
-    args.service = "claim";
-    args.nargs = 3;
-    args.nret = 1;
-    args.virt = virt;
-    args.size = size;
-    args.align = align;
-    (*prom)(&args);
-    return args.ret;
-}
-
-int
-getprop(void *phandle, const char *name, void *buf, int buflen)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *phandle;
-	const char *name;
-	void *buf;
-	int buflen;
-	int size;
-    } args;
-
-    args.service = "getprop";
-    args.nargs = 4;
-    args.nret = 1;
-    args.phandle = phandle;
-    args.name = name;
-    args.buf = buf;
-    args.buflen = buflen;
-    args.size = -1;
-    (*prom)(&args);
-    return args.size;
-}
-
-int
 putc(int c, void *f)
 {
     char ch = c;
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/common/ofcommon.c linuxppc_2_4_devel-fb/arch/ppc/boot/common/ofcommon.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/common/ofcommon.c	Sat Aug  3 07:57:09 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/common/ofcommon.c	Fri Aug  9 10:13:16 2002
@@ -10,6 +10,7 @@
  */

 #include "zlib.h"
+#include "of1275.h"
 #include "nonstdio.h"
 #include <asm/bootinfo.h>
 #include <asm/page.h>
@@ -20,8 +21,6 @@
 extern int strcmp(const char *s1, const char *s2);
 extern char *avail_ram, *avail_high;
 extern char *end_avail;
-extern void claim(unsigned int virt, unsigned int size, unsigned int align);
-extern void pause(void);

 unsigned int heap_use, heap_max;

diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/include/of1275.h linuxppc_2_4_devel-fb/arch/ppc/boot/include/of1275.h
--- linuxppc_2_4_devel-140/arch/ppc/boot/include/of1275.h	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/include/of1275.h	Fri Aug  9 09:48:14 2002
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+typedef void *prom_handle;
+typedef void *ihandle;
+typedef void *phandle;
+typedef int (*prom_entry)(void *);
+
+#define OF_INVALID_HANDLE	((prom_handle)-1UL)
+
+extern prom_entry of_prom_entry;
+
+/* function declarations */
+void *	claim(unsigned int virt, unsigned int size, unsigned int align);
+void	enter(void);
+void	exit(void);
+phandle	finddevice(const char *name);
+int	getprop(phandle node, const char *name, void *buf, int buflen);
+void	ofinit(prom_entry entry);
+int	ofstdio(phandle *stdin, phandle *stdout, phandle *stderr);
+int	read(ihandle instance, void *buf, int buflen);
+void	release(void *virt, unsigned int size);
+int	write(ihandle instance, void *buf, int buflen);
+
+/* inlines */
+
+extern inline void pause(void)
+{
+	enter();
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/Makefile linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/Makefile
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/Makefile	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/Makefile	Thu Aug  8 20:55:32 2002
@@ -0,0 +1,10 @@
+#
+# Makefile of1275 stuff
+#
+
+L_TARGET := of1275.a
+
+obj-y := claim.o enter.o exit.o finddevice.o getprop.o ofinit.o	\
+	 ofstdio.o read.o release.o write.o
+
+include $(TOPDIR)/Rules.make
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/claim.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/claim.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/claim.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/claim.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+void *
+claim(unsigned int virt, unsigned int size, unsigned int align)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	unsigned int virt;
+	unsigned int size;
+	unsigned int align;
+	void *ret;
+    } args;
+
+    args.service = "claim";
+    args.nargs = 3;
+    args.nret = 1;
+    args.virt = virt;
+    args.size = size;
+    args.align = align;
+    (*of_prom_entry)(&args);
+    return args.ret;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/enter.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/enter.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/enter.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/enter.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+void
+enter(void)
+{
+    struct prom_args {
+	char *service;
+    } args;
+
+    args.service = "enter";
+    (*of_prom_entry)(&args);
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/exit.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/exit.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/exit.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/exit.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+void
+exit(void)
+{
+    struct prom_args {
+	char *service;
+    } args;
+
+    for (;;) {
+	args.service = "exit";
+	(*of_prom_entry)(&args);
+    }
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/finddevice.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/finddevice.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/finddevice.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/finddevice.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+phandle
+finddevice(const char *name)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	const char *devspec;
+	phandle device;
+    } args;
+
+    args.service = "finddevice";
+    args.nargs = 1;
+    args.nret = 1;
+    args.devspec = name;
+    args.device = OF_INVALID_HANDLE;
+    (*of_prom_entry)(&args);
+    return args.device;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/getprop.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/getprop.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/getprop.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/getprop.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+int
+getprop(phandle node, const char *name, void *buf, int buflen)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	phandle node;
+	const char *name;
+	void *buf;
+	int buflen;
+	int size;
+    } args;
+
+    args.service = "getprop";
+    args.nargs = 4;
+    args.nret = 1;
+    args.node = node;
+    args.name = name;
+    args.buf = buf;
+    args.buflen = buflen;
+    args.size = -1;
+    (*of_prom_entry)(&args);
+    return args.size;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/ofinit.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/ofinit.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/ofinit.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/ofinit.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+prom_entry of_prom_entry;
+
+void
+ofinit(prom_entry prom_ptr)
+{
+    of_prom_entry = prom_ptr;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/ofstdio.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/ofstdio.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/ofstdio.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/ofstdio.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+int
+ofstdio(phandle *stdin, phandle *stdout, phandle *stderr)
+{
+    phandle in, out;
+    phandle chosen;
+
+    if ((chosen = finddevice("/chosen")) == OF_INVALID_HANDLE)
+	goto err;
+    if (getprop(chosen, "stdout", &out, sizeof(out)) != 4)
+	goto err;
+    if (getprop(chosen, "stdin", &in, sizeof(in)) != 4)
+	goto err;
+
+    *stdin  = in;
+    *stdout = out;
+    *stderr = out;
+    return 0;
+err:
+    return -1;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/read.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/read.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/read.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/read.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+int
+read(ihandle instance, void *buf, int buflen)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	ihandle instance;
+	void *buf;
+	int buflen;
+	int actual;
+    } args;
+
+    args.service = "read";
+    args.nargs = 3;
+    args.nret = 1;
+    args.instance = instance;
+    args.buf = buf;
+    args.buflen = buflen;
+    args.actual = -1;
+    (*of_prom_entry)(&args);
+    return args.actual;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/release.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/release.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/release.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/release.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+void
+release(void *virt, unsigned int size)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	void *virt;
+	unsigned int size;
+    } args;
+
+    args.service = "release";
+    args.nargs = 2;
+    args.nret = 0;
+    args.virt = virt;
+    args.size = size;
+    (*of_prom_entry)(&args);
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/of1275/write.c linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/write.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/of1275/write.c	Thu Jan  1 01:00:00 1970
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/of1275/write.c	Fri Aug  9 09:51:08 2002
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "of1275.h"
+
+int
+write(ihandle instance, void *buf, int buflen)
+{
+    struct prom_args {
+	char *service;
+	int nargs;
+	int nret;
+	ihandle instance;
+	void *buf;
+	int buflen;
+	int actual;
+    } args;
+
+    args.service = "write";
+    args.nargs = 3;
+    args.nret = 1;
+    args.instance = instance;
+    args.buf = buf;
+    args.buflen = buflen;
+    args.actual = -1;
+    (*of_prom_entry)(&args);
+    return args.actual;
+}
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/pmac/Makefile linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/Makefile
--- linuxppc_2_4_devel-140/arch/ppc/boot/pmac/Makefile	Sat Aug  3 07:57:44 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/Makefile	Fri Aug  9 10:17:37 2002
@@ -15,7 +15,7 @@
 COMMONOBJS = start.o misc.o ../common/string.o ../common/ofcommon.o
 COFFOBJS = ../common/coffcrt0.o $(COMMONOBJS) coffmain.o
 CHRPOBJS = ../common/crt0.o $(COMMONOBJS) chrpmain.o
-LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a
+LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a ../of1275/of1275.a

 MKNOTE := ../utils/mknote
 SIZE := ../utils/size
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/pmac/chrpmain.c linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/chrpmain.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/pmac/chrpmain.c	Sat Aug  3 07:57:38 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/chrpmain.c	Fri Aug  9 10:20:31 2002
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include "nonstdio.h"
+#include "of1275.h"
 #include <asm/processor.h>
 #include <asm/page.h>

@@ -18,16 +19,11 @@
 extern char __ramdisk_begin[], __ramdisk_end;
 extern char _start, _end;

-extern int getprop(void *, const char *, void *, int);
 extern unsigned int heap_max;
-extern void *claim(unsigned int virt, unsigned int size, unsigned int align);
-extern void *finddevice(const char *);
 extern void flush_cache(void *start, unsigned int len);
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void make_bi_recs(unsigned long addr, char *name, unsigned int mach,
 		unsigned int progend);
-extern void pause(void);
-extern void release(void *ptr, unsigned int len);

 char *avail_ram;
 char *begin_avail, *end_avail;
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/pmac/coffmain.c linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/coffmain.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/pmac/coffmain.c	Sat Aug  3 07:55:56 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/coffmain.c	Fri Aug  9 10:20:53 2002
@@ -13,6 +13,7 @@
 #include <asm/page.h>

 #include "nonstdio.h"
+#include "of1275.h"
 #include "zlib.h"

 /* Passed from the linker */
@@ -20,17 +21,13 @@
 extern char __ramdisk_begin[], __ramdisk_end;
 extern char _start, _end;

-extern char *claim(unsigned, unsigned, unsigned);
 extern char image_data[], initrd_data[];
 extern int initrd_len, image_len;
-extern int getprop(void *, const char *, void *, int);
 extern unsigned int heap_max;
-extern void *finddevice(const char *);
 extern void flush_cache(void *start, unsigned int len);
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void make_bi_recs(unsigned long addr, char *name, unsigned int mach,
 		unsigned int progend);
-extern void pause(void);
 extern void setup_bats(unsigned long start);

 char *avail_ram;
diff -urN -X /home/leigh/.diffex linuxppc_2_4_devel-140/arch/ppc/boot/pmac/start.c linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/start.c
--- linuxppc_2_4_devel-140/arch/ppc/boot/pmac/start.c	Sat Aug  3 07:57:18 2002
+++ linuxppc_2_4_devel-fb/arch/ppc/boot/pmac/start.c	Fri Aug  9 10:16:33 2002
@@ -10,33 +10,22 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <stdarg.h>
+#include "of1275.h"

 extern int strlen(const char *s);
 extern void boot(int a1, int a2, void *prom);

-int (*prom)();
+phandle stdin;
+phandle stdout;
+phandle stderr;

-void *chosen_handle;
-void *stdin;
-void *stdout;
-void *stderr;
-
-void exit(void);
-void *finddevice(const char *name);
-int getprop(void *phandle, const char *name, void *buf, int buflen);
 void printk(char *fmt, ...);

 void
 start(int a1, int a2, void *promptr)
 {
-    prom = (int (*)()) promptr;
-    chosen_handle = finddevice("/chosen");
-    if (chosen_handle == (void *) -1)
-	exit();
-    if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
-	exit();
-    stderr = stdout;
-    if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
+    ofinit(promptr);
+    if (ofstdio(&stdin, &stdout, &stderr))
 	exit();

     boot(a1, a2, promptr);
@@ -44,30 +33,6 @@
 	exit();
 }

-int
-write(void *handle, void *ptr, int nb)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *ihandle;
-	void *addr;
-	int len;
-	int actual;
-    } args;
-
-    args.service = "write";
-    args.nargs = 3;
-    args.nret = 1;
-    args.ihandle = handle;
-    args.addr = ptr;
-    args.len = nb;
-    args.actual = -1;
-    (*prom)(&args);
-    return args.actual;
-}
-
 int writestring(void *f, char *ptr, int nb)
 {
 	int w = 0, i;
@@ -88,142 +53,6 @@
 }

 int
-read(void *handle, void *ptr, int nb)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *ihandle;
-	void *addr;
-	int len;
-	int actual;
-    } args;
-
-    args.service = "read";
-    args.nargs = 3;
-    args.nret = 1;
-    args.ihandle = handle;
-    args.addr = ptr;
-    args.len = nb;
-    args.actual = -1;
-    (*prom)(&args);
-    return args.actual;
-}
-
-void
-exit(void)
-{
-    struct prom_args {
-	char *service;
-    } args;
-
-    for (;;) {
-	args.service = "exit";
-	(*prom)(&args);
-    }
-}
-
-void
-pause(void)
-{
-    struct prom_args {
-	char *service;
-    } args;
-
-    args.service = "enter";
-    (*prom)(&args);
-}
-
-void *
-finddevice(const char *name)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	const char *devspec;
-	void *phandle;
-    } args;
-
-    args.service = "finddevice";
-    args.nargs = 1;
-    args.nret = 1;
-    args.devspec = name;
-    args.phandle = (void *) -1;
-    (*prom)(&args);
-    return args.phandle;
-}
-
-void *
-claim(unsigned int virt, unsigned int size, unsigned int align)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	unsigned int virt;
-	unsigned int size;
-	unsigned int align;
-	void *ret;
-    } args;
-
-    args.service = "claim";
-    args.nargs = 3;
-    args.nret = 1;
-    args.virt = virt;
-    args.size = size;
-    args.align = align;
-    (*prom)(&args);
-    return args.ret;
-}
-
-void
-release(void *virt, unsigned int size)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *virt;
-	unsigned int size;
-    } args;
-
-    args.service = "release";
-    args.nargs = 2;
-    args.nret = 0;
-    args.virt = virt;
-    args.size = size;
-    (*prom)(&args);
-}
-
-int
-getprop(void *phandle, const char *name, void *buf, int buflen)
-{
-    struct prom_args {
-	char *service;
-	int nargs;
-	int nret;
-	void *phandle;
-	const char *name;
-	void *buf;
-	int buflen;
-	int size;
-    } args;
-
-    args.service = "getprop";
-    args.nargs = 4;
-    args.nret = 1;
-    args.phandle = phandle;
-    args.name = name;
-    args.buf = buf;
-    args.buflen = buflen;
-    args.size = -1;
-    (*prom)(&args);
-    return args.size;
-}
-
-int
 putc(int c, void *f)
 {
     char ch = c;

------=_20020809175029_77648--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
