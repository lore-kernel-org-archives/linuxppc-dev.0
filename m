Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <1117614390.19020.24.camel@gaston>
References: <1117614390.19020.24.camel@gaston>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 18:28:03 +1000
Message-Id: <1117614484.19020.27.camel@gaston>
Mime-Version: 1.0
Subject: Re: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the kernel patch. It applies on top of the various prom_init.c
bug fixes that I already posted today on the linuxppc-dev &
linuxppc64-dev lists (those will be in the next -mm and maybe in
2.6.12).

This patch is intended to hit upstream by 2.6.13


Index: linux-work/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2005-06-01 16:02:28.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom_init.c	2005-06-01 16:07:21.000000000 +1000
@@ -1514,7 +1514,14 @@
 	return 0;
 }
 
-static void __init scan_dt_build_strings(phandle node, unsigned long *mem_start,
+/*
+ * The Open Firmware 1275 specification states properties must be 31 bytes or
+ * less, however not all firmwares obey this. Make it 64 bytes to be safe.
+ */
+#define MAX_PROPERTY_NAME 64
+
+static void __init scan_dt_build_strings(phandle node,
+					 unsigned long *mem_start,
 					 unsigned long *mem_end)
 {
 	unsigned long offset = reloc_offset();
@@ -1527,14 +1534,19 @@
 	/* get and store all property names */
 	prev_name = RELOC("");
 	for (;;) {
-		
-		/* 32 is max len of name including nul. */
-		namep = make_room(mem_start, mem_end, 32, 1);
+		namep = make_room(mem_start, mem_end, MAX_PROPERTY_NAME, 1);
 		if (call_prom("nextprop", 3, 1, node, prev_name, namep) <= 0) {
 			/* No more nodes: unwind alloc */
 			*mem_start = (unsigned long)namep;
 			break;
 		}
+
+		/* skip "name" */
+		if (strcmp(namep, RELOC("name")) == 0) {
+			*mem_start = (unsigned long)namep;
+			prev_name = RELOC("name");
+			continue;
+		}
 		soff = dt_find_string(namep);
 		if (soff != 0) {
 			*mem_start = (unsigned long)namep;
@@ -1555,72 +1567,83 @@
 	}
 }
 
-/*
- * The Open Firmware 1275 specification states properties must be 31 bytes or
- * less, however not all firmwares obey this. Make it 64 bytes to be safe.
- */
-#define MAX_PROPERTY_NAME 64
-
 static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 					unsigned long *mem_end)
 {
-	int l, align;
 	phandle child;
-	char *namep, *prev_name, *sstart, *p, *ep;
+	char *namep, *prev_name, *sstart, *p, *ep, *lp, *path;
 	unsigned long soff;
 	unsigned char *valp;
 	unsigned long offset = reloc_offset();
-	char pname[MAX_PROPERTY_NAME];
-	char *path;
-
-	path = RELOC(prom_scratch);
+ 	static char pname[MAX_PROPERTY_NAME] __initdata;
+ 	int l;
 
 	dt_push_token(OF_DT_BEGIN_NODE, mem_start, mem_end);
 
-	/* get the node's full name */
+ 	/* get the node's full name for debugging */
+ 	path = RELOC(prom_scratch);
+ 	memset(path, 0, PROM_SCRATCH_SIZE);
+ 	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+ 	prom_debug("   %s\n", path);
+ 
+ 	/* get the node's full name for actual use */
 	namep = (char *)*mem_start;
 	l = call_prom("package-to-path", 3, 1, node,
 		      namep, *mem_end - *mem_start);
 	if (l >= 0) {
+ 		int had_fixup = 0;
+ 
 		/* Didn't fit?  Get more room. */
 		if (l+1 > *mem_end - *mem_start) {
 			namep = make_room(mem_start, mem_end, l+1, 1);
 			call_prom("package-to-path", 3, 1, node, namep, l);
 		}
-		namep[l] = '\0';
-		/* Fixup an Apple bug where they have bogus \0 chars in the
-		 * middle of the path in some properties
-		 */
-		for (p = namep, ep = namep + l; p < ep; p++)
-			if (*p == '\0') {
-				memmove(p, p+1, ep - p);
-				ep--; l--;
-			}
-		*mem_start = _ALIGN(((unsigned long) namep) + strlen(namep) + 1, 4);
+ 		ep = namep + l;
+ 		*ep = '\0';
+ 		/* now try to find the unit name in that mess */
+ 		for (p = namep, lp = NULL; p < ep; p++) {
+ 			if (*p == '/')
+ 				lp = p + 1;
+ 			/* bug fix: apple's OF has a funny bug where they have
+ 			 * a '\0' in the name/path string of some nodes.
+ 			 * We fix that up here
+ 			 */
+ 			if (*p == '\0') {
+ 				memmove(p, p+1, ep - p);
+ 				ep--; l--;
+ 				had_fixup = 1;
+ 			}
+ 		}
+ 		if (had_fixup)
+ 			prom_printf("fixed up bogus name for %s\n", namep);
+ 		if (lp != NULL)
+ 			memmove(namep, lp, strlen(lp) + 1);
+ 		*mem_start = _ALIGN(((unsigned long) namep) +
+ 				    strlen(namep) + 1, 4);
 	}
 
-	/* get it again for debugging */
-	memset(path, 0, PROM_SCRATCH_SIZE);
-	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
-
 	/* get and store all properties */
 	prev_name = RELOC("");
 	sstart = (char *)RELOC(dt_string_start);
 	for (;;) {
-		if (call_prom("nextprop", 3, 1, node, prev_name, pname) <= 0)
-			break;
-
-		/* find string offset */
-		soff = dt_find_string(pname);
+ 		if (call_prom("nextprop", 3, 1, node, prev_name,
+ 			      RELOC(pname)) <= 0)
+  			break;
+ 		if (strcmp(RELOC(pname), RELOC("name")) == 0) {
+ 			prev_name = RELOC("name");
+ 			continue;
+ 		}
+  		/* find string offset */
+ 		soff = dt_find_string(RELOC(pname));
 		if (soff == 0) {
-			prom_printf("WARNING: Can't find string index for <%s>, node %s\n",
-				    pname, path);
+ 			prom_printf("WARNING: Can't find string index "
+ 				    "for <%s>, node %s\n", RELOC(pname), path);
 			break;
 		}
 		prev_name = sstart + soff;
 
 		/* get length */
-		l = call_prom("getproplen", 2, 1, node, pname);
+ 		l = call_prom("getproplen", 2, 1, node, RELOC(pname));
 
 		/* sanity checks */
 		if (l < 0)
@@ -1629,7 +1652,7 @@
 			prom_printf("WARNING: ignoring large property ");
 			/* It seems OF doesn't null-terminate the path :-( */
 			prom_printf("[%s] ", path);
-			prom_printf("%s length 0x%x\n", pname, l);
+			prom_printf("%s length 0x%x\n", RELOC(pname), l);
 			continue;
 		}
 
@@ -1639,17 +1662,16 @@
 		dt_push_token(soff, mem_start, mem_end);
 
 		/* push property content */
-		align = (l >= 8) ? 8 : 4;
-		valp = make_room(mem_start, mem_end, l, align);
-		call_prom("getprop", 4, 1, node, pname, valp, l);
+		valp = make_room(mem_start, mem_end, l, 4);
+		call_prom("getprop", 4, 1, node, RELOC(pname), valp, l);
 		*mem_start = _ALIGN(*mem_start, 4);
 	}
 
 	/* Add a "linux,phandle" property. */
 	soff = dt_find_string(RELOC("linux,phandle"));
 	if (soff == 0)
-		prom_printf("WARNING: Can't find string index for <linux-phandle>"
-			    " node %s\n", path);
+		prom_printf("WARNING: Can't find string index for"
+			    " <linux-phandle> node %s\n", path);
 	else {
 		dt_push_token(OF_DT_PROP, mem_start, mem_end);
 		dt_push_token(4, mem_start, mem_end);
@@ -1699,7 +1721,8 @@
 
 	/* Build header and make room for mem rsv map */ 
 	mem_start = _ALIGN(mem_start, 4);
-	hdr = make_room(&mem_start, &mem_end, sizeof(struct boot_param_header), 4);
+	hdr = make_room(&mem_start, &mem_end,
+			sizeof(struct boot_param_header), 4);
 	RELOC(dt_header_start) = (unsigned long)hdr;
 	rsvmap = make_room(&mem_start, &mem_end, sizeof(mem_reserve_map), 8);
 
@@ -1712,11 +1735,11 @@
 	namep = make_room(&mem_start, &mem_end, 16, 1);
 	strcpy(namep, RELOC("linux,phandle"));
 	mem_start = (unsigned long)namep + strlen(namep) + 1;
-	RELOC(dt_string_end) = mem_start;
 
 	/* Build string array */
 	prom_printf("Building dt strings...\n"); 
 	scan_dt_build_strings(root, &mem_start, &mem_end);
+	RELOC(dt_string_end) = mem_start;
 
 	/* Build structure */
 	mem_start = PAGE_ALIGN(mem_start);
@@ -1731,9 +1754,11 @@
 	hdr->totalsize = RELOC(dt_struct_end) - RELOC(dt_header_start);
 	hdr->off_dt_struct = RELOC(dt_struct_start) - RELOC(dt_header_start);
 	hdr->off_dt_strings = RELOC(dt_string_start) - RELOC(dt_header_start);
+	hdr->dt_strings_size = RELOC(dt_string_end) - RELOC(dt_string_start);
 	hdr->off_mem_rsvmap = ((unsigned long)rsvmap) - RELOC(dt_header_start);
 	hdr->version = OF_DT_VERSION;
-	hdr->last_comp_version = 1;
+	/* Version 16 is not backward compatible */
+	hdr->last_comp_version = 0x10;
 
 	/* Reserve the whole thing and copy the reserve map in, we
 	 * also bump mem_reserve_cnt to cause further reservations to
@@ -1788,6 +1813,9 @@
 	/* does it need fixup ? */
 	if (prom_getproplen(i2c, "interrupts") > 0)
 		return;
+
+	prom_printf("fixing up bogus interrupts for u3 i2c...\n");
+
 	/* interrupt on this revision of u3 is number 0 and level */
 	interrupts[0] = 0;
 	interrupts[1] = 1;
Index: linux-work/arch/ppc64/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/setup.c	2005-06-01 16:02:28.000000000 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2005-06-01 16:07:21.000000000 +1000
@@ -10,7 +10,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/config.h>
 #include <linux/module.h>
Index: linux-work/arch/ppc64/kernel/prom.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom.c	2005-06-01 16:02:28.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom.c	2005-06-01 16:07:21.000000000 +1000
@@ -15,7 +15,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <stdarg.h>
 #include <linux/config.h>
@@ -635,26 +635,32 @@
  * unflatten the tree
  */
 static int __init scan_flat_dt(int (*it)(unsigned long node,
-					 const char *full_path, void *data),
+					 const char *uname, int depth, void *data),
 			       void *data)
 {
 	unsigned long p = ((unsigned long)initial_boot_params) +
 		initial_boot_params->off_dt_struct;
 	int rc = 0;
+	int depth = -1;
 
 	do {
 		u32 tag = *((u32 *)p);
 		char *pathp;
 		
 		p += 4;
-		if (tag == OF_DT_END_NODE)
+		if (tag == OF_DT_END_NODE) {
+			depth --;
+			continue;
+		}
+		if (tag == OF_DT_NOP)
 			continue;
 		if (tag == OF_DT_END)
 			break;
 		if (tag == OF_DT_PROP) {
 			u32 sz = *((u32 *)p);
 			p += 8;
-			p = _ALIGN(p, sz >= 8 ? 8 : 4);
+			if (initial_boot_params->version < 0x10)
+				p = _ALIGN(p, sz >= 8 ? 8 : 4);
 			p += sz;
 			p = _ALIGN(p, 4);
 			continue;
@@ -664,9 +670,18 @@
 			       " device tree !\n", tag);
 			return -EINVAL;
 		}
+		depth++;
 		pathp = (char *)p;
 		p = _ALIGN(p + strlen(pathp) + 1, 4);
-		rc = it(p, pathp, data);
+		if ((*pathp) == '/') {
+			char *lp, *np;
+			for (lp = NULL, np = pathp; *np; np++)
+				if ((*np) == '/')
+					lp = np+1;
+			if (lp != NULL)
+				pathp = lp;
+		}
+		rc = it(p, pathp, depth, data);
 		if (rc != 0)
 			break;		
 	} while(1);
@@ -689,13 +704,16 @@
 		const char *nstr;
 
 		p += 4;
+		if (tag == OF_DT_NOP)
+			continue;
 		if (tag != OF_DT_PROP)
 			return NULL;
 
 		sz = *((u32 *)p);
 		noff = *((u32 *)(p + 4));
 		p += 8;
-		p = _ALIGN(p, sz >= 8 ? 8 : 4);
+		if (initial_boot_params->version < 0x10)
+			p = _ALIGN(p, sz >= 8 ? 8 : 4);
 
 		nstr = find_flat_dt_string(noff);
 		if (nstr == NULL) {
@@ -713,7 +731,7 @@
 }
 
 static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
-					       unsigned long align)
+				       unsigned long align)
 {
 	void *res;
 
@@ -727,13 +745,16 @@
 static unsigned long __init unflatten_dt_node(unsigned long mem,
 					      unsigned long *p,
 					      struct device_node *dad,
-					      struct device_node ***allnextpp)
+					      struct device_node ***allnextpp,
+					      unsigned long fpsize)
 {
 	struct device_node *np;
 	struct property *pp, **prev_pp = NULL;
 	char *pathp;
 	u32 tag;
-	unsigned int l;
+	unsigned int l, allocl;
+	int has_name = 0;
+	int new_format = 0;
 
 	tag = *((u32 *)(*p));
 	if (tag != OF_DT_BEGIN_NODE) {
@@ -742,21 +763,62 @@
 	}
 	*p += 4;
 	pathp = (char *)*p;
-	l = strlen(pathp) + 1;
+	l = allocl = strlen(pathp) + 1;
 	*p = _ALIGN(*p + l, 4);
 
-	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + l,
+	/* version 0x10 has a more compact unit name here instead of the full
+	 * path. we accumulate the full path size using "fpsize", we'll rebuild
+	 * it later. We detect this because the first character of the name is
+	 * not '/'.
+	 */
+	if ((*pathp) != '/') {
+		new_format = 1;
+		if (fpsize == 0) {
+			/* root node: special case. fpsize accounts for path
+			 * plus terminating zero. root node only has '/', so
+			 * fpsize should be 2, but we want to avoid the first
+			 * level nodes to have two '/' so we use fpsize 1 here
+			 */
+			fpsize = 1;
+			allocl = 2;
+		} else {
+			/* account for '/' and path size minus terminal 0
+			 * already in 'l'
+			 */
+			fpsize += l;
+			allocl = fpsize;
+		}
+	}
+
+
+	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
 				__alignof__(struct device_node));
 	if (allnextpp) {
 		memset(np, 0, sizeof(*np));
 		np->full_name = ((char*)np) + sizeof(struct device_node);
-		memcpy(np->full_name, pathp, l);
+		if (new_format) {
+			char *p = np->full_name;
+			/* rebuild full path for new format */
+			if (dad && dad->parent) {
+				strcpy(p, dad->full_name);
+#ifdef DEBUG
+				if ((strlen(p) + l + 1) != allocl) {
+					DBG("%s: p: %d, l: %d, a: %d\n",
+					    pathp, strlen(p), l, allocl);
+				}
+#endif
+				p += strlen(p);
+			}
+			*(p++) = '/';
+			memcpy(p, pathp, l);
+		} else
+			memcpy(np->full_name, pathp, l);
 		prev_pp = &np->properties;
 		**allnextpp = np;
 		*allnextpp = &np->allnext;
 		if (dad != NULL) {
 			np->parent = dad;
-			/* we temporarily use the `next' field as `last_child'. */
+			/* we temporarily use the next field as `last_child'*/
 			if (dad->next == 0)
 				dad->child = np;
 			else
@@ -770,18 +832,26 @@
 		char *pname;
 
 		tag = *((u32 *)(*p));
+		if (tag == OF_DT_NOP) {
+			*p += 4;
+			continue;
+		}
 		if (tag != OF_DT_PROP)
 			break;
 		*p += 4;
 		sz = *((u32 *)(*p));
 		noff = *((u32 *)((*p) + 4));
-		*p = _ALIGN((*p) + 8, sz >= 8 ? 8 : 4);
+		*p += 8;
+		if (initial_boot_params->version < 0x10)
+			*p = _ALIGN(*p, sz >= 8 ? 8 : 4);
 
 		pname = find_flat_dt_string(noff);
 		if (pname == NULL) {
 			printk("Can't find property name in list !\n");
 			break;
 		}
+		if (strcmp(pname, "name") == 0)
+			has_name = 1;
 		l = strlen(pname) + 1;
 		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
 					__alignof__(struct property));
@@ -801,6 +871,28 @@
 		}
 		*p = _ALIGN((*p) + sz, 4);
 	}
+	/* with version 0x10 we may not have the name property, recreate
+	 * it here from the unit name if absent
+	 */
+	if (!has_name) {
+		char *pa = pathp;
+		int sz;
+
+		while (*pa && (*pa) != '@')
+			pa++;
+		sz = (pa - pathp) + 1;
+		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
+					__alignof__(struct property));
+		if (allnextpp) {
+			pp->name = "name";
+			pp->length = sz;
+			pp->value = (unsigned char *)(pp + 1);
+			*prev_pp = pp;
+			prev_pp = &pp->next;
+			memcpy(pp->value, pathp, sz - 1);
+			((char *)pp->value)[sz - 1] = 0;
+		}
+	}
 	if (allnextpp) {
 		*prev_pp = NULL;
 		np->name = get_property(np, "name", NULL);
@@ -812,7 +904,7 @@
 			np->type = "<NULL>";
 	}
 	while (tag == OF_DT_BEGIN_NODE) {
-		mem = unflatten_dt_node(mem, p, np, allnextpp);
+		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
 		tag = *((u32 *)(*p));
 	}
 	if (tag != OF_DT_END_NODE) {
@@ -842,7 +934,7 @@
 	/* First pass, scan for size */
 	start = ((unsigned long)initial_boot_params) +
 		initial_boot_params->off_dt_struct;
-	size = unflatten_dt_node(0, &start, NULL, NULL);
+	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
 
 	DBG("  size is %lx, allocating...\n", size);
 
@@ -854,7 +946,7 @@
 	/* Second pass, do actual unflattening */
 	start = ((unsigned long)initial_boot_params) +
 		initial_boot_params->off_dt_struct;
-	unflatten_dt_node(mem, &start, NULL, &allnextp);
+	unflatten_dt_node(mem, &start, NULL, &allnextp, 0);
 	if (*((u32 *)start) != OF_DT_END)
 		printk(KERN_WARNING "Weird tag at end of tree: %x\n", *((u32 *)start));
 	*allnextp = NULL;
@@ -880,7 +972,7 @@
 
 
 static int __init early_init_dt_scan_cpus(unsigned long node,
-					  const char *full_path, void *data)
+					  const char *uname, int depth, void *data)
 {
 	char *type = get_flat_dt_prop(node, "device_type", NULL);
 	u32 *prop;
@@ -933,13 +1025,15 @@
 }
 
 static int __init early_init_dt_scan_chosen(unsigned long node,
-					    const char *full_path, void *data)
+					    const char *uname, int depth, void *data)
 {
 	u32 *prop;
 	u64 *prop64;
 	extern unsigned long memory_limit, tce_alloc_start, tce_alloc_end;
 
-	if (strcmp(full_path, "/chosen") != 0)
+	DBG("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
+
+	if (depth != 1 || strcmp(uname, "chosen") != 0)
 		return 0;
 
 	/* get platform type */
@@ -989,18 +1083,20 @@
 }
 
 static int __init early_init_dt_scan_root(unsigned long node,
-					  const char *full_path, void *data)
+					  const char *uname, int depth, void *data)
 {
 	u32 *prop;
 
-	if (strcmp(full_path, "/") != 0)
+	if (depth != 0)
 		return 0;
 
 	prop = (u32 *)get_flat_dt_prop(node, "#size-cells", NULL);
 	dt_root_size_cells = (prop == NULL) ? 1 : *prop;
-		
+	DBG("dt_root_size_cells = %x\n", dt_root_size_cells);
+
 	prop = (u32 *)get_flat_dt_prop(node, "#address-cells", NULL);
 	dt_root_addr_cells = (prop == NULL) ? 2 : *prop;
+	DBG("dt_root_addr_cells = %x\n", dt_root_addr_cells);
 	
 	/* break now */
 	return 1;
@@ -1028,7 +1124,7 @@
 
 
 static int __init early_init_dt_scan_memory(unsigned long node,
-					    const char *full_path, void *data)
+					    const char *uname, int depth, void *data)
 {
 	char *type = get_flat_dt_prop(node, "device_type", NULL);
 	cell_t *reg, *endp;
@@ -1044,7 +1140,9 @@
 
 	endp = reg + (l / sizeof(cell_t));
 
-	DBG("memory scan node %s ...\n", full_path);
+	DBG("memory scan node %s ..., reg size %ld, data: %x %x %x %x, ...\n",
+	    uname, l, reg[0], reg[1], reg[2], reg[3]);
+
 	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
 		unsigned long base, size;
 
@@ -1455,10 +1553,11 @@
 	struct device_node *np = allnodes;
 
 	read_lock(&devtree_lock);
-	for (; np != 0; np = np->allnext)
+	for (; np != 0; np = np->allnext) {
 		if (np->full_name != 0 && strcasecmp(np->full_name, path) == 0
 		    && of_node_get(np))
 			break;
+	}
 	read_unlock(&devtree_lock);
 	return np;
 }
Index: linux-work/include/asm-ppc64/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc64/prom.h	2005-06-01 16:07:18.000000000 +1000
+++ linux-work/include/asm-ppc64/prom.h	2005-06-01 16:07:21.000000000 +1000
@@ -22,13 +22,15 @@
 #define RELOC(x)        (*PTRRELOC(&(x)))
 
 /* Definitions used by the flattened device tree */
-#define OF_DT_HEADER		0xd00dfeed	/* 4: version, 4: total size */
-#define OF_DT_BEGIN_NODE	0x1		/* Start node: full name */
+#define OF_DT_HEADER		0xd00dfeed	/* marker */
+#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
 #define OF_DT_END_NODE		0x2		/* End node */
-#define OF_DT_PROP		0x3		/* Property: name off, size, content */
+#define OF_DT_PROP		0x3		/* Property: name off, size,
+						 * content */
+#define OF_DT_NOP		0x4		/* nop */
 #define OF_DT_END		0x9
 
-#define OF_DT_VERSION		1
+#define OF_DT_VERSION		0x10
 
 /*
  * This is what gets passed to the kernel by prom_init or kexec
@@ -54,7 +56,9 @@
 	u32	version;		/* format version */
 	u32	last_comp_version;	/* last compatible version */
 	/* version 2 fields below */
-	u32	boot_cpuid_phys;	/* Which physical CPU id we're booting on */
+	u32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
+	/* version 3 fields below */
+	u32	dt_strings_size;	/* size of the DT strings block */
 };
 
 
