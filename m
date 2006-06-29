Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F30B67B2C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:45:04 +1000 (EST)
Date: Thu, 29 Jun 2006 08:25:58 -0500 (CDT)
Message-Id: <200606291325.k5TDPwkx098174@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [2/5][POWERPC] boot: Add kexec callable zImage wrapper
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This code creates a 32 bit zImage wrapper for a 32 or 64 bit PowerPC
Linux kernel.   It does not support initrd at present.  What it does
give you is a compressed kernel image that is expanded when used.

Limitations:

The memory node off the root with a name starting with "memory" must
contain enough free memory (not in the reserved ranges) in the first
reg range to uncompress the the kenrel with padding.

The claim allocator does not record its handouts.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/kexec.c	2006-06-29 03:47:06.865856735 -0500
@@ -0,0 +1,476 @@
+/*
+ * Copyright (C) 1997 Paul Mackerras 1997.
+ * Copyright (C) 2006 Milton Miller, IBM Corportation.
+ * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corportation.
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
+#include "page.h"
+#include "dt.h"
+#include "stringify.h"
+
+#define BUG_ON(x) if (x) { printf("zImage BUG %s\n\r", __stringify(x)); exit();}
+
+extern unsigned int gohere;	/* slaves poll and branch when told */
+
+int (*prom)(void *);
+phandle chosen_handle;
+ihandle stdout;
+
+#define MAX_MEM 0x80000000
+static unsigned int memsize;
+static unsigned int na=2, ns=1;
+
+
+static struct boot_param_header *initial_boot_params;
+
+static int (*rtas)(void *, void *);
+static void *rtas_data;
+static int rtas_put_term_char;
+static int rtas_display_char;
+
+int call_rtas(int token, int nargs, int nret, ...)
+{
+	int i;
+	struct rtas_args {
+		int token;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	if (!rtas || !token)
+		return -1;	/* Hardware error */
+	if (nargs + nret > 12)
+		return -1;	/* Hardware error */
+
+	args.token = token;
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
+	rtas(&args, rtas_data);
+
+	return args.args[nargs];
+}
+
+
+int write(void *handle, void *ptr, int nb)
+{
+	int i=0;
+	int err;
+	char *p;
+
+	p = ptr;
+	err = 0;
+
+	if (rtas_put_term_char)
+		for (; i < nb && !err; i++)
+			err = call_rtas(rtas_put_term_char, 1, 1, p[i]);
+#if 0
+	/* not tested, doesn't check line limits, do we care? */
+	else if (rtas_display_char)
+		for (; i < nb && !err; i++)
+			err = call_rtas(rtas_put_term_char, 1, 1, p[i]);
+#endif
+
+	return i-1;
+}
+
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
+
+/* return -1 on fail, address on success */
+void *claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+
+	unsigned long al = align ? align : 1;
+	unsigned long try = _ALIGN_UP(virt, al);
+	unsigned int *r;
+
+#if 0 /* Debug */
+
+	printf("claim: request %lx size %lx align %lx, aligned %p ",
+			virt, size, align,  (void *)try);
+
+
+#define BUSY(s) printf("%s\n\r", s), ((void *)(-1))
+#define RANGE_PRINT printf("range %08x %08x ",r[1], r[3]);
+#define RANGE_CLEAR printf("is clear\n\r");
+#else
+#define BUSY(s) ((void *)(-1))
+#define RANGE_PRINT do {} while(0)
+#define RANGE_CLEAR do {} while(0)
+#endif
+
+
+	if (try + size < try)
+		return BUSY("wraps");
+
+	if (memsize && try + size > memsize)
+		return BUSY("overflows");
+
+	for (r = (unsigned int *)(((unsigned long)initial_boot_params)
+				+ initial_boot_params->off_mem_rsvmap);
+				r[2] || r[3]; r += 4) {
+
+		if (r[0] || r[1] > try + size)
+			continue;		/* starts after */
+		if (r[2] || r[1]+r[3] < r[1])
+			return BUSY("BEYOND");	/* extends beyond */
+		if (r[1] + r[3] < try)
+			continue;		/* contained before */
+
+		RANGE_PRINT;
+		return BUSY("overlaps");		/* overlaps */
+	}
+
+	/*
+	 * XXX: Fixme: we should keep track here and not hand out the
+	 * same address again.
+	 */
+
+	RANGE_CLEAR;
+	return (void *)(try);
+}
+
+
+
+/* code lifted from arch/powerpc/kernel/prom.c */
+
+static inline char *find_flat_dt_string(u32 offset)
+{
+	return ((char *)initial_boot_params) +
+		initial_boot_params->off_dt_strings + offset;
+}
+
+/**
+ * This function is used to scan the flattened device-tree, it is
+ * used to extract the memory informations at boot before we can
+ * unflatten the tree
+ */
+int of_scan_flat_dt(int (*it)(unsigned long node,
+				     const char *uname, int depth,
+				     void *data),
+			   void *data)
+{
+	unsigned long p = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+	int rc = 0;
+	int depth = -1;
+
+	do {
+		u32 tag = *((u32 *)p);
+		char *pathp;
+
+		p += 4;
+		if (tag == OF_DT_END_NODE) {
+			depth --;
+			continue;
+		}
+		if (tag == OF_DT_NOP)
+			continue;
+		if (tag == OF_DT_END)
+			break;
+		if (tag == OF_DT_PROP) {
+			u32 sz = *((u32 *)p);
+			p += 8;
+			if (initial_boot_params->version < 0x10)
+				p = _ALIGN(p, sz >= 8 ? 8 : 4);
+			p += sz;
+			p = _ALIGN(p, 4);
+			continue;
+		}
+		if (tag != OF_DT_BEGIN_NODE) {
+			printf("Invalid tag %x scanning flattened"
+			       " device tree !\n\r", tag);
+			return -1;
+		}
+		depth++;
+		pathp = (char *)p;
+		p = _ALIGN(p + strlen(pathp) + 1, 4);
+		if ((*pathp) == '/') {
+			char *lp, *np;
+			for (lp = NULL, np = pathp; *np; np++)
+				if ((*np) == '/')
+					lp = np+1;
+			if (lp != NULL)
+				pathp = lp;
+		}
+		rc = it(p, pathp, depth, data);
+		if (rc != 0)
+			break;
+	} while(1);
+
+	return rc;
+}
+
+unsigned long of_get_flat_dt_root(void)
+{
+	unsigned long p = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+
+	while(*((u32 *)p) == OF_DT_NOP)
+		p += 4;
+	BUG_ON (*((u32 *)p) != OF_DT_BEGIN_NODE);
+	p += 4;
+	return _ALIGN(p + strlen((char *)p) + 1, 4);
+}
+
+/**
+ * This  function can be used within scan_flattened_dt callback to get
+ * access to properties
+ */
+void* of_get_flat_dt_prop(unsigned long node, const char *name,
+				 unsigned long *size)
+{
+	unsigned long p = node;
+
+	do {
+		u32 tag = *((u32 *)p);
+		u32 sz, noff;
+		const char *nstr;
+
+		p += 4;
+		if (tag == OF_DT_NOP)
+			continue;
+		if (tag != OF_DT_PROP)
+			return NULL;
+
+		sz = *((u32 *)p);
+		noff = *((u32 *)(p + 4));
+		p += 8;
+		if (initial_boot_params->version < 0x10)
+			p = _ALIGN(p, sz >= 8 ? 8 : 4);
+
+		nstr = find_flat_dt_string(noff);
+		if (nstr == NULL) {
+			printf("Can't find property index"
+			       " name !\n\r");
+			return NULL;
+		}
+		if (strcmp(name, nstr) == 0) {
+			if (size)
+				*size = sz;
+			return (void *)p;
+		}
+		p += sz;
+		p = _ALIGN(p, 4);
+	} while(1);
+}
+
+/* end code lifted from arch/powerpc/kernel/prom.c */
+
+
+/* This only handles device nodes directly off of the root node
+ * and will return on any partial name match
+ */
+static int match_device_node(unsigned long node, const char *uname,
+				int depth, void *data)
+{
+	if (depth == 1 && string_match(uname, data))
+		return node;
+	return 0;
+}
+
+/* Find Real Memory (offset) region.   The first reg, size pair of the
+ * memory node defines the memory that is accessable in real mode on
+ * PPC64 LPAR systems.  Assume that will be enough everywhere.
+ */
+static int find_rmo(unsigned long node, const char *uname, int depth,
+		     void *data)
+{
+	if (match_device_node(node, uname, depth, data)) {
+		unsigned long size;
+		unsigned int *reg;
+		int i;
+
+		reg = of_get_flat_dt_prop(node, "reg", &size);
+		if (!reg || (size < (na + ns)*4)) {
+			printf("Warning: Can't parse reg property on %s\n\r",
+					uname);
+			return 0;
+		}
+
+		/* ignore if not address 0 */
+		for (i=0; i < na; i++)
+			if (reg[i])
+				return 0;
+
+		/* if more than 1 cell then MAX_MEM */
+		for (i=0; i < ns-1; i++)
+			if (reg[na+i])
+				return MAX_MEM;
+
+		/* else return size of first reg */
+		return reg[na+i];
+	}
+
+	return 0;
+}
+
+/* dummy prom that recognises the services used by elsewhere */
+int call_prom(const char *service, int nargs, int nret, ...)
+{
+	va_list list;
+
+	if (string_match(service, "finddevice")) {
+		char *path;
+
+		if ((nargs != 1) || (nret != 1)) {
+			printf("finddevice: unexpected arg counts %d %d\n\r",
+					nargs, nret);
+			return -1;
+		}
+		va_start(list, nret);
+		path = (void *)va_arg(list, unsigned int);
+		va_end(list);
+
+		if (path[0] == '/')
+			path++;
+
+		return (int) of_scan_flat_dt(match_device_node, path);
+
+	} else if (string_match(service, "getprop")) {
+		unsigned long node;
+		char *prop;
+		char *buf;
+		unsigned int len;
+		va_list list;
+		char *ret;
+		unsigned long size;
+
+		if ((nargs != 4) || (nret != 1)) {
+			printf("getprop: unexpected arg counts %d %d\n\r",
+					nargs, nret);
+			return -1;
+		}
+
+		va_start(list, nret);
+		node = va_arg(list, unsigned int);
+		prop = (void *)va_arg(list, unsigned int);
+		buf = (void *)va_arg(list, unsigned int);
+		len = va_arg(list, unsigned int);
+		va_end(list);
+
+		ret = of_get_flat_dt_prop(node, prop, &size);
+		if  (ret) {
+			memcpy(buf, ret, len < size ? len : size);
+		}
+		return size;
+	} else if (!string_match(service, "exit")) {
+		printf("Unimplemented prom service %s(%d, %d) called\n\r",
+			service, nargs, nret);
+		/* fall through */
+	}
+	for(;;)
+		;	/* Forever */
+}
+
+void init_prom(unsigned long a1, unsigned long a2, void *p)
+{
+	unsigned long node;
+
+	if (p)		/* this version doesn't support a prom interface */
+		exit();
+
+	initial_boot_params = (void *) a1;
+
+	BUG_ON(initial_boot_params->magic != OF_DT_HEADER);
+	BUG_ON(initial_boot_params->last_comp_version > 0x10);
+
+	chosen_handle = finddevice("/chosen");
+	if (chosen_handle == (void *) -1)
+		exit();
+
+	node = of_scan_flat_dt(match_device_node, "rtas");
+
+	if (node) {
+		unsigned int *p;
+		p = of_get_flat_dt_prop(node,
+				"linux,rtas-base", NULL);
+		if (p)
+			rtas_data = (void *)*p;
+		p = of_get_flat_dt_prop(node,
+				"linux,rtas-entry", NULL);
+		if (p)
+			rtas = (void *)*p;
+		p = of_get_flat_dt_prop(node,
+				"put-term-char", NULL);
+		if (p)
+			rtas_put_term_char = *p;
+		p = of_get_flat_dt_prop(node,
+				"display-character", NULL);
+		if (p)
+			rtas_display_char = *p;
+	}
+
+	node = of_get_flat_dt_root();
+	if (node) {
+		unsigned long tmp;
+		void *p;
+
+		p = of_get_flat_dt_prop(node, "#addr-cells", &tmp);
+		if (tmp == 4)
+			na = *(int *)p;
+		else
+			printf("Warning, could't find or parse #addr-cells\n\r");
+		p = of_get_flat_dt_prop(node, "#size-cells", &tmp);
+		if (tmp == 4)
+			ns = *(int *)p;
+		else
+			printf("Warning, could't find or parse #size-cells\n\r");
+	}
+
+	memsize = of_scan_flat_dt(find_rmo, "memory");
+
+	if (!memsize)
+		BUG_ON("Couldn't find RMO memory size\n\r");
+
+	if (memsize > MAX_MEM)
+		memsize = MAX_MEM;
+
+	printf("Can use %x bytes of memory in RMO\n\r", memsize);
+
+	ram_end = memsize;
+}
+
+/*
+ * Kexec smp hook:
+ * copy 0x100 bytes from the kernel entry point down to address zero,
+ * flush, then tell any slaves to branch down to address 0x60.
+ */
+void prom_smp_hook(unsigned long kernel_start)
+{
+	char *kern = (char *)kernel_start;
+	char *zero = (char *)0;
+
+	memcpy(zero, kern, 0x100);
+	flush_cache(zero, 0x100);
+
+	gohere = 0x60;
+}
Index: kernel/arch/powerpc/boot/crt0_kexec.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/crt0_kexec.S	2006-06-29 03:47:06.868856261 -0500
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) 1997 Paul Mackerras.
+ * Copyright (C) 2006 Milton Miller, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * NOTE: This code runs in 32 bit mode and is linked as ELF32.
+ * It will switch from 64 to 32 bit mode with some assumptions.
+ */
+
+#include "ppc_asm.h"
+
+	.text
+	/* This is the actual "entry" point as mentioned in the headers.
+	 * It is this code that should be copied down to zero.
+	 * This code must be loaded above 0x100 or the slaves will
+	 * crash when we copy the kernels entry point down.
+	 */
+	.globl	master
+master:
+	/* Work out the offset between the address we were linked at
+	 * and the address where we're running.
+	 * Set 32 bit mode while we are at it.
+	 */
+	bl	set32
+1:	mflr	r0
+	lis	r9,1b@ha
+	addi	r9,r9,1b@l
+	subf.	r0,r9,r0
+	beq	3f		/* if running at same address as linked */
+
+	/* The .got2 section contains a list of addresses, so add
+	   the address offset onto each entry. */
+	lis	r9,__got2_start@ha
+	addi	r9,r9,__got2_start@l
+	lis	r8,__got2_end@ha
+	addi	r8,r8,__got2_end@l
+	subf.	r8,r9,r8
+	beq	3f
+	srwi.	r8,r8,2
+	mtctr	r8
+	add	r9,r0,r9
+2:	lwz	r8,0(r9)
+	add	r8,r8,r0
+	stw	r8,0(r9)
+	addi	r9,r9,4
+	bdnz	2b
+3:
+	b	3f
+
+
+
+
+	/* the slaves may be in 32 or 64 bit mode, we don't care */
+	.org	master+0x60
+	.globl	slave
+slave:
+	li	4,gohere-master			/* read 0-relative */
+waiting:
+99:	lwz	r6,0(r4)
+	cmpwi	0,r6,0
+	beq	99b
+	mtctr	r6
+	addi	r4,r6,gohere-waiting		/* read from gohere in image */
+	bctr
+
+	.global gohere
+gohere:	.long	0	# when set the slave moves
+
+
+
+flushit:
+	/* Do a cache flush for our text, in case OF didn't */
+3:	lis	r9,_start@ha
+	addi	r9,r9,_start@l
+	add	r9,r0,r9
+	lis	r8,_etext@ha
+	addi	r8,r8,_etext@l
+	add	r8,r0,r8
+4:	dcbf	r0,r9
+	icbi	r0,r9
+	addi	r9,r9,0x20
+	cmplw	cr0,r9,r8
+	blt	4b
+	sync
+	isync
+
+	/* fill out a stack for c code */
+	lis	r1,__stack_end@ha
+	addi	r1,r1,__stack_end@l
+	add	r1,r1,r0
+	stwu	r5,-16(r1)	/* r5 should be 0 */
+
+	/* tell slave to come to our copy */
+	lis	r8,waiting@ha
+	addi	r8,r8,waiting@l
+	add	r8,r8,r0
+	stw	r8,gohere-master(0)
+
+	mr	r6,r1
+	b	start
+
+
+	/*
+	 * Check if the processor is running in 32 bit mode, using
+	 * only 32 bit instructions which should be safe on 32 and
+	 * 64 bit processors.
+	 *
+	 * The caller is assuming that the lr is used to return.
+	 */
+set32:	mfmsr	r0		/* grab whole msr		*/
+	rlwinm	r6,r0,0,0,31	/* extract bottom word		*/
+	subf.	r6,r6,r0	/* subtract, same?		*/
+	beqlr			/* yes: we are 32 bit mode	*/
+
+	/* Since the compare found other bits, we must be in 64 bit mode
+	 * on a 64 bit processor.  Since MSR[SF] is in the bits we masked
+	 * off the compare will always fail in 64 bit mode, and will alway
+	 * be equal in 32 bit mode (the size of the implicit compare).
+	 *
+	 * This program must run in 32 bit mode, so switch now.
+	 * Assume we are actually running in low 32 bits of memory space,
+	 * so we can just turn off MSR[SF] which is bit 0.
+	 */
+	.machine push
+	.machine "ppc64"
+	rldicl	r0,r0,0,1
+	sync
+	mtmsrd	r0
+	isync
+	.machine pop
+	blr
+
+	.org	master+0x100		/* make sure we don't go backwards */
+
+
+	/* this code needs a stack allocated in the image */
+	.section .stack,"aw",@nobits
+	.space 	4096
+
+	.data
+
+	/* a procedure descriptor used when pretending to be elf64_powerpc */
+	.balign	8
+	.global	_master64
+_master64:
+	.long	0, master	/* big endian, supported reloc ppc32 */
+	.quad	0, 0, 0
+
+	/* a procedure descriptor used when booting this as a COFF file */
+	.global	_master_opd
+_master_opd:
+	.long	master, 0, 0, 0
Index: kernel/arch/powerpc/boot/dt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/dt.h	2006-06-29 03:47:06.870855944 -0500
@@ -0,0 +1,46 @@
+#ifndef _PPC_BOOT_DT_H_
+#define _PPC_BOOT_DT_H_
+
+typedef unsigned int u32;
+
+/* Definitions used by the flattened device tree */
+#define OF_DT_HEADER		0xd00dfeed	/* marker */
+#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
+#define OF_DT_END_NODE		0x2		/* End node */
+#define OF_DT_PROP		0x3		/* Property: name off, size,
+						 * content */
+#define OF_DT_NOP		0x4		/* nop */
+#define OF_DT_END		0x9
+
+#define OF_DT_VERSION		0x10
+
+/*
+ * This is what gets passed to the kernel by prom_init or kexec
+ *
+ * The dt struct contains the device tree structure, full pathes and
+ * property contents. The dt strings contain a separate block with just
+ * the strings for the property names, and is fully page aligned and
+ * self contained in a page, so that it can be kept around by the kernel,
+ * each property name appears only once in this page (cheap compression)
+ *
+ * the mem_rsvmap contains a map of reserved ranges of physical memory,
+ * passing it here instead of in the device-tree itself greatly simplifies
+ * the job of everybody. It's just a list of u64 pairs (base/size) that
+ * ends when size is 0
+ */
+struct boot_param_header
+{
+	u32	magic;			/* magic word OF_DT_HEADER */
+	u32	totalsize;		/* total size of DT block */
+	u32	off_dt_struct;		/* offset to structure */
+	u32	off_dt_strings;		/* offset to strings */
+	u32	off_mem_rsvmap;		/* offset to memory reserve map */
+	u32	version;		/* format version */
+	u32	last_comp_version;	/* last compatible version */
+	/* version 2 fields below */
+	u32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
+	/* version 3 fields below */
+	u32	dt_strings_size;	/* size of the DT strings block */
+};
+
+#endif				/* _PPC_BOOT_DT_H_ */
