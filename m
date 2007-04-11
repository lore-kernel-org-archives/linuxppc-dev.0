Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B61AADE2D2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:34:04 +1000 (EST)
Date: Wed, 11 Apr 2007 03:33:41 -0500 (CDT)
Subject: [PATCH 6/8] bootwrapper: convert flatdevtree to version 16
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-06.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kexec-tools still produces a version 2 device tree, while the
libraries in the wrapper only support version 16 and later.

Add a routine to convert a v2 flat device tree to a v16 one inplace
by inserting OF_DT_NOP and chomping full path.  Make space for new
headers by moving and then chomping the OF_DT_NOPs.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Tested on version two and version 3 device-trees.   Version 1 code
has not been tested.

Index: kernel/arch/powerpc/boot/flatdevtree_conv.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/flatdevtree_conv.c	2007-04-09 04:10:35.000000000 -0500
@@ -0,0 +1,276 @@
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
+ *
+ * Copyright (C) IBM Corporation 2007
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ */
+#include "flatdevtree.h"
+#include "stdio.h"
+#include "ops.h"
+
+#define MIN_VERSION 2
+#define OUT_VERSION 16
+#define OUT_COMPAT 16
+
+#ifdef NO_CHECK
+static int check_v123_tree(u32 *start, u32 *limit)
+{
+	return 0;
+}
+#else
+/**
+ * check_v123_tree - check integrety of a version 1, 2, or 3 tree
+ * structural checks on device_tree
+ */
+static int check_v123_tree(u32 *start, u32 *limit)
+{
+	u32 len;
+	int depth = 0;
+	u32 *dtp = start;
+
+	while (dtp < limit)
+		switch (*dtp) {
+		case OF_DT_END:
+			if (depth)
+				return -1;
+			return ++dtp - start;
+		case OF_DT_NOP:
+			dtp++;
+			break;
+		case OF_DT_END_NODE:
+			dtp++;
+			depth--;
+			break;
+		case OF_DT_BEGIN_NODE:
+			len = strlen((char *)(++dtp));
+			/* check path is suffix to previous? */
+			dtp += 1 + (len / 4);
+			depth++;
+			break;
+		case OF_DT_PROP:
+			len = dtp[1];
+			dtp += 3;
+			if ((len >= 8) && ((long)dtp & 4))
+				dtp++;
+			dtp += (len + 3) / 4;
+			break;
+		default:
+			return -1;
+		}
+	return -1;	/* no OF_DT_END */
+}
+#endif
+
+/**
+ * nop_to_v16
+ * insert %OF_DT_NOP into the dt_struct @dtp to make it v16 from v1, 2, or 3.
+ */
+static int nop_to_v16(u32 *dtp)
+{
+	int nops = 0;
+	char *p, *s;
+	int len;
+	u32 *next;
+
+	while (*dtp != OF_DT_END)
+		switch (*dtp) {
+		case OF_DT_BEGIN_NODE:
+			/* v2 & v3 names are full path, v16+ is relative */
+			p = (char *)(++dtp);
+			len = strlen(p);
+			next = dtp + 1 + len / 4;
+
+			for (s = p + len; *s != '/'; s--)
+				if (s == p)
+					fatal("name %s has no '/'", p);
+
+			len -= s++ - p;		/* not the slash but the nul */
+			memmove(p, s, len);
+			while (len % 4)
+				p[len++] = '\0';
+			dtp += len / 4;
+			while (dtp != next) {
+				*dtp++ = OF_DT_NOP;
+				nops++;
+			}
+			break;
+		case OF_DT_PROP:
+			/* convert from align_8 to align_4 via prefixing nop */
+			len = dtp[1];
+			if ((len >= 8) && !((long)dtp & 4)) {
+				memmove(dtp+1, dtp, 12);
+				*dtp++ = OF_DT_NOP;
+				nops++;
+			}
+			dtp += 3 + (len + 3)/4;
+			break;
+		default:
+			fatal("%s: unrecognised tag %d at %p\n", __FUNCTION__,
+				*dtp, dtp);
+		case OF_DT_NOP:
+			nops ++;
+			/* fall through */
+		case OF_DT_END_NODE:
+			dtp ++;
+			break;
+		}
+	return nops;
+}
+
+#if MIN_VERSION < 3 || OUT_VERSION > 16
+/**
+ * move_nops_fwd - move nops in a v16 dt_struct to the beginning
+ * @start - device tree starting address
+ * @count - number of %OF_DT_NOP cells to move
+ */
+static void move_nops_fwd(u32 *start, int count)
+{
+	u32 *dtp = start;
+	int len;
+	while (count)
+		switch (*dtp) {
+		case OF_DT_NOP:
+			memmove(start+1,start,(dtp-start) * 4);
+			*start++ = OF_DT_NOP;
+			dtp++;
+			count--;
+			break;
+		case OF_DT_END_NODE:
+			dtp++;
+			break;
+		case OF_DT_BEGIN_NODE:
+			len = strlen((char *)(++dtp));
+			dtp += 1 + len / 4;
+			break;
+		case OF_DT_PROP:
+			len = dtp[1];
+			dtp += 3 + (len + 3) / 4;
+			break;
+		case OF_DT_END:
+			fatal("Not enough nops -- need %d more\n", count);
+			return;
+		default:
+			fatal("%s: unknown tag %d at %p", __FUNCTION__, *dtp, dtp)
+		}
+}
+#endif
+
+/**
+ * conv_flattree_inplace upgrade the version of a boot_param_header
+ *
+ * converts a v1, 2, 3 device tree (of at least MIN_VERSION)
+ * in place to a v16 one, usable by flatdevtree.c
+ */
+void conv_flattree_inplace(struct boot_param_header *tree)
+{
+	u32 *dtp;
+	u32 need = 0, nops;
+	int slen;
+
+	if (tree->magic != OF_DT_HEADER)
+		fatal("%s: no magic", __FUNCTION__);
+
+	if (tree->last_comp_version > 3)
+		return;			/* don't know what to do */
+
+	if (tree->version < MIN_VERSION) {
+		printf("%s: Warning: can't handle version %d tree\n",
+				__FUNCTION__, tree->version);
+		return;
+	}
+
+	if (tree->version < 2)
+		need++;		/* boot_cpu_id */
+
+	if (tree->version < 3)
+		need++;		/* dt_string_size */
+
+	if (OUT_VERSION > 16)
+		need++;		/* dt_struct_size */
+
+	dtp = (void *)tree + tree->off_dt_struct;
+
+	slen = check_v123_tree(dtp, (void *)tree + tree->totalsize);
+	if (slen < 0)
+		fatal("device tree check failed\n");
+
+	nops = nop_to_v16(dtp);
+
+	if (need & 1)		/* keep 8 byte alignment of mem reserve */
+		need++;
+
+	if (need > nops)
+		fatal("Didn't find enough space to add new header fields\n\r"
+			"(needed %d found %d tree %p)", need, nops, tree);
+
+	/* ok now compress the dtb struct */
+	move_nops_fwd(dtp, need);
+	dtp += need;
+
+	/*
+	 * move mem_rsvmap and dt_strings if they are before dt_struct
+	 * onto our nops .  Adjust start addresses for the 3 sections.
+	 */
+	if ((tree->off_mem_rsvmap < tree->off_dt_struct) ||
+		(tree->off_dt_strings < tree->off_dt_struct)) {
+		int start, end;
+		void *ptr;
+
+		if (tree->off_mem_rsvmap < tree->off_dt_strings)
+			start = tree->off_mem_rsvmap;
+		else
+			start = tree->off_dt_strings;
+
+		end = tree->off_dt_struct;
+		ptr = (void *)tree + start;
+
+		memmove(ptr + 4 * need, ptr, end - start);
+
+		if (tree->off_mem_rsvmap < tree->off_dt_struct)
+			tree->off_mem_rsvmap += 4 * need;
+		if (tree->off_dt_strings < tree->off_dt_struct)
+			tree->off_dt_strings += 4 * need;
+	}
+	tree->off_dt_struct += 4 * need;
+
+	/* ok now we have space to extend the header. */
+	if (tree->version < 2 && MIN_VERSION < 2) {
+		tree->boot_cpuid_phys = 0;	/* default, caller can fix */
+	}
+
+	/* calculate size of dt_strings_size */
+	if (tree->version < 3 && MIN_VERSION < 3) {
+		int end = tree->totalsize;
+
+		if (tree->off_dt_strings < tree->off_mem_rsvmap)
+			end = tree->off_mem_rsvmap;
+
+		if ((tree->off_dt_strings < tree->off_dt_struct) &&
+				(end > tree->off_dt_struct))
+			end = tree->off_dt_struct;
+
+		tree->dt_strings_size = end - tree->off_dt_strings;
+	}
+
+#if OUT_VERSION > 16
+	tree->dt_struct_size = 4 * slen;
+#endif
+
+	tree->version = OUT_VERSION;
+	tree->last_comp_version = OUT_COMPAT;
+
+	return;
+}
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-09 04:10:34.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-09 04:10:35.000000000 -0500
@@ -41,7 +41,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		marshal.c memranges.c misc64.S \
+		flatdevtree_conv.c marshal.c memranges.c misc64.S \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib) kexec.c
 src-plat := of.c
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-04-09 04:10:32.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-04-09 04:10:35.000000000 -0500
@@ -76,7 +76,10 @@ struct loader_info {
 };
 extern struct loader_info loader_info;
 
+struct boot_param_header;
+
 void start(void);
+void conv_flattree_inplace(struct boot_param_header *tree);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- kernel.orig/arch/powerpc/boot/kexec.c	2007-04-09 04:10:34.000000000 -0500
+++ kernel/arch/powerpc/boot/kexec.c	2007-04-09 04:10:35.000000000 -0500
@@ -236,6 +236,7 @@ void kexec_platform_init(struct boot_par
 	move_slaves_up();
 
 	setup_initial_heap();
+	conv_flattree_inplace(dt_blob);
 	early_scan_flat_tree(dt_blob);
 
 	/* drivers can malloc and read the tree, but not realloc later
