Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 11:06:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Get rid of libdt.c
Message-ID: <20070314000623.GE25514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

libdt.c was an attempt at creating a device tree handling library
within the dtc codebase.  However, it was never even close to
completion, and is entirely obsoleted by it's spiritual descendent,
libfdt (currently a separate package).  This patch, therefore, removes
libdt.c entirely, along with its only reference in the Makefile, an
unused variable.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-03-14 11:03:32.000000000 +1100
+++ dtc/Makefile	2007-03-14 11:03:35.000000000 +1100
@@ -6,8 +6,6 @@ BISON = bison
 DTC_OBJS = dtc.o livetree.o flattree.o data.o treesource.o fstree.o \
 		dtc-parser.tab.o lex.yy.o
 
-OBJS = $(DTC_OBJS) libdt.o ftdump.o
-
 DEPFILES = $(DTC_OBJS:.o=.d)
 
 all: $(TARGETS)
Index: dtc/libdt.c
===================================================================
--- dtc.orig/libdt.c	2007-03-14 11:03:19.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,230 +0,0 @@
-/*
- * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
- *
- * 
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
- */
-
-#include <stdint.h>
-#include <string.h>
-
-#include "flat_dt.h"
-
-#define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
-#define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))
-#define GET_CELL(p)	(p += 4, *((uint32_t *)(p-4)))
-
-static char *skip_name(char *p)
-{
-	while (*p != '\0')
-		p++;
-
-	return PALIGN(p, sizeof(uint32_t));
-}
-
-static char *skip_prop(void *blob, char *p)
-{
-	struct boot_param_header *bph = blob;
-	uint32_t len, nameoff;
-
-	len = GET_CELL(p);
-	nameoff = GET_CELL(p);
-	if ((bph->version < 0x10) && (len >= sizeof(uint64_t)))
-		p = PALIGN(p, sizeof(uint64_t));
-	return PALIGN(p + len, sizeof(uint32_t));
-}
-
-static char *get_unit(char *dtpath)
-{
-	char *p;
-
-	if (dtpath[0] != '/')
-		return dtpath;
-
-	p = dtpath + strlen(dtpath);
-	while (*p != '/')
-		p--;
-
-	return p+1;
-}
-
-static int first_seg_len(char *dtpath)
-{
-	int len = 0;
-
-	while ((dtpath[len] != '/') && (dtpath[len] != '\0'))
-		len++;
-
-	return len;
-}
-
-char *flat_dt_get_string(void *blob, uint32_t offset)
-{
-	struct boot_param_header *bph = blob;
-
-	return (char *)blob + bph->off_dt_strings + offset;
-}
-
-void *flat_dt_get_subnode(void *blob, void *node, char *uname, int unamelen)
-{
-	struct boot_param_header *bph = blob;
-	char *p = node;
-	uint32_t tag;
-	int depth = 0;
-	char *nuname;
-
-	if (! unamelen)
-		unamelen = strlen(uname);
-
-	do {
-		tag = GET_CELL(p);
-
-		switch (tag) {
-		case OF_DT_PROP:
-			p = skip_prop(blob, p);
-			break;
-
-		case OF_DT_BEGIN_NODE:
-			if (depth == 0) {
-				nuname = p;
-
-				if (bph->version < 0x10)
-					nuname = get_unit(nuname);
-
-				p = skip_name(p);
-
-				if (strncmp(nuname, uname, unamelen) == 0)
-					return p;
-			}
-			depth++;
-			break;
-
-		case OF_DT_END_NODE:
-			depth--;
-			break;
-
-		case OF_DT_END:
-			/* looks like a malformed tree */
-			return NULL;
-			break;
-
-		default:
-			/* FIXME: throw some sort of error */
-			return NULL;
-		}
-	} while (depth >= 0);
-
-	return NULL;
-}
-
-void *flat_dt_get_node(void *blob, char *path)
-{
-	struct boot_param_header *bph = blob;
-	char *node;
-	int seglen;
-
-	node = blob + bph->off_dt_struct;
-	node += sizeof(uint32_t); /* skip initial OF_DT_BEGIN_NODE */
-	node = skip_name(node);	/* skip root node name */
-
-	while (node && (*path)) {
-		if (path[0] == '/')
-			path++;
-
-		seglen = first_seg_len(path);
-
-		node = flat_dt_get_subnode(blob, node, path, seglen);
-
-		path += seglen;
-	}
-
-	return node;
-}
-
-void flat_dt_traverse(void *blob,
-		      int (*fn)(void *blob, void *node, void *priv),
-		      void *private)
-{
-	struct boot_param_header *bph = blob;
-	char *p;
-	uint32_t tag;
-	int depth = 0;
-	char *uname;
-
-	p = (char *)blob + bph->off_dt_struct;
-
-	tag = GET_CELL(p);
-	while (tag != OF_DT_END) {
-		switch (tag) {
-		case OF_DT_BEGIN_NODE:
-			uname = p;
-
-			if (bph->version < 0x10)
-				uname = get_unit(uname);
-
-			p = skip_name(p);
-
-			(*fn)(blob, p, private);
-			depth++;
-			break;
-
-		case OF_DT_END_NODE:
-			depth--;
-			break;
-
-		case OF_DT_PROP:
-			p = skip_prop(blob, p);
-			break;
-
-		default:
-			/* FIXME: badly formed tree */
-			return;
-		}
-	}
-}
-
-void *flat_dt_get_prop(void *blob, void *node, char *name, uint32_t *len)
-{
-	struct boot_param_header *bph = blob;
-	char *p = node;
-
-	do {
-		uint32_t tag = GET_CELL(p);
-		uint32_t sz, noff;
-		const char *nstr;
-
-		if (tag != OF_DT_PROP)
-			return NULL;
-
-		sz = GET_CELL(p);
-		noff = GET_CELL(p);
-
-		/* Old versions have variable alignment of the
-		 * property value */
-		if ((bph->version < 0x10) && (sz >= 8))
-		    p = PALIGN(p, 8);
-
-		nstr = flat_dt_get_string(blob, noff);
-
-		if (strcmp(name, nstr) == 0) {
-			if (len)
-				*len = sz;
-			return (void *)p;
-		}
-
-		p = PALIGN(p + sz, sizeof(uint32_t));
-	} while(1);
-}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
