Return-Path: <dgibson@ozlabs.org>
Date: Thu, 7 Aug 2008 12:24:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Update in-kernel dtc and libfdt to version 1.2.0
Message-ID: <20080807022417.GC24443@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some time ago, a copies of the upstream dtc and libfdt sources were
included in the kernel tree to avoid having these as external
dependencies for building the kernel.  Since then development on the
upstream dtc and libfdt has continued.  So this patch updates the
in-kernel versions to match the recently released upstream dtc version
1.2.0.  This includes a number of bugfixes, many cleanups and a few
new features.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Probably should have gotten this ready for the last merge window, but
I didn't, so I guess it's 2.6.28 material.

Index: working-2.6/arch/powerpc/boot/dtc-src/Makefile.dtc
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/Makefile.dtc	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/Makefile.dtc	2008-08-07 12:06:18.000000000 +1000
@@ -5,21 +5,5 @@
 #
 DTC_SRCS = dtc.c flattree.c fstree.c data.c livetree.c treesource.c srcpos.c \
 	checks.c
-DTC_EXTRA = dtc.h srcpos.h
-DTC_LEXFILES = dtc-lexer.l
-DTC_BISONFILES = dtc-parser.y
-
-DTC_LEX_SRCS = $(DTC_LEXFILES:%.l=%.lex.c)
-DTC_BISON_SRCS = $(DTC_BISONFILES:%.y=%.tab.c)
-DTC_BISON_INCLUDES = $(DTC_BISONFILES:%.y=%.tab.h)
-
-DTC_GEN_SRCS = $(DTC_LEX_SRCS) $(DTC_BISON_SRCS)
-DTC_GEN_ALL = $(DTC_GEN_SRCS) $(DTC_BISON_INCLUDES)
+DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
 DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
-
-DTC_CLEANFILES = $(DTC_GEN_ALL)
-
-# We assume the containing Makefile system can do auto-dependencies for most
-# things, but we supply the dependencies on generated header files explicitly
-
-$(addprefix $(DTC_objdir)/,$(DTC_GEN_SRCS:%.c=%.o)): $(addprefix $(DTC_objdir)/,$(DTC_BISON_INCLUDES))
Index: working-2.6/arch/powerpc/boot/dtc-src/checks.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/checks.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/checks.c	2008-08-07 12:06:18.000000000 +1000
@@ -242,6 +242,42 @@
 }
 NODE_CHECK(duplicate_property_names, NULL, ERROR);
 
+#define LOWERCASE	"abcdefghijklmnopqrstuvwxyz"
+#define UPPERCASE	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define DIGITS		"0123456789"
+#define PROPNODECHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
+
+static void check_node_name_chars(struct check *c, struct node *dt,
+				  struct node *node)
+{
+	int n = strspn(node->name, c->data);
+
+	if (n < strlen(node->name))
+		FAIL(c, "Bad character '%c' in node %s",
+		     node->name[n], node->fullpath);
+}
+NODE_CHECK(node_name_chars, PROPNODECHARS "@", ERROR);
+
+static void check_node_name_format(struct check *c, struct node *dt,
+				   struct node *node)
+{
+	if (strchr(get_unitname(node), '@'))
+		FAIL(c, "Node %s has multiple '@' characters in name",
+		     node->fullpath);
+}
+NODE_CHECK(node_name_format, NULL, ERROR, &node_name_chars);
+
+static void check_property_name_chars(struct check *c, struct node *dt,
+				      struct node *node, struct property *prop)
+{
+	int n = strspn(prop->name, c->data);
+
+	if (n < strlen(prop->name))
+		FAIL(c, "Bad character '%c' in property name \"%s\", node %s",
+		     prop->name[n], prop->name, node->fullpath);
+}
+PROP_CHECK(property_name_chars, PROPNODECHARS, ERROR);
+
 static void check_explicit_phandles(struct check *c, struct node *root,
 					  struct node *node)
 {
@@ -280,16 +316,29 @@
 static void check_name_properties(struct check *c, struct node *root,
 				  struct node *node)
 {
-	struct property *prop;
+	struct property **pp, *prop = NULL;
+
+	for (pp = &node->proplist; *pp; pp = &((*pp)->next))
+		if (streq((*pp)->name, "name")) {
+			prop = *pp;
+			break;
+		}
 
-	prop = get_property(node, "name");
 	if (!prop)
 		return; /* No name property, that's fine */
 
 	if ((prop->val.len != node->basenamelen+1)
-	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0))
+	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0)) {
 		FAIL(c, "\"name\" property in %s is incorrect (\"%s\" instead"
 		     " of base node name)", node->fullpath, prop->val.val);
+	} else {
+		/* The name property is correct, and therefore redundant.
+		 * Delete it */
+		*pp = prop->next;
+		free(prop->name);
+		data_free(prop->val);
+		free(prop);
+	}
 }
 CHECK_IS_STRING(name_is_string, "name", ERROR);
 NODE_CHECK(name_properties, NULL, ERROR, &name_is_string);
@@ -301,23 +350,23 @@
 static void fixup_phandle_references(struct check *c, struct node *dt,
 				     struct node *node, struct property *prop)
 {
-      struct marker *m = prop->val.markers;
-      struct node *refnode;
-      cell_t phandle;
-
-      for_each_marker_of_type(m, REF_PHANDLE) {
-	      assert(m->offset + sizeof(cell_t) <= prop->val.len);
-
-	      refnode = get_node_by_ref(dt, m->ref);
-	      if (! refnode) {
-		      FAIL(c, "Reference to non-existent node or label \"%s\"\n",
-			   m->ref);
-		      continue;
-	      }
-
-	      phandle = get_node_phandle(dt, refnode);
-	      *((cell_t *)(prop->val.val + m->offset)) = cpu_to_be32(phandle);
-      }
+	struct marker *m = prop->val.markers;
+	struct node *refnode;
+	cell_t phandle;
+
+	for_each_marker_of_type(m, REF_PHANDLE) {
+		assert(m->offset + sizeof(cell_t) <= prop->val.len);
+
+		refnode = get_node_by_ref(dt, m->ref);
+		if (! refnode) {
+			FAIL(c, "Reference to non-existent node or label \"%s\"\n",
+			     m->ref);
+			continue;
+		}
+
+		phandle = get_node_phandle(dt, refnode);
+		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
+	}
 }
 CHECK(phandle_references, NULL, NULL, fixup_phandle_references, NULL, ERROR,
       &duplicate_node_names, &explicit_phandles);
@@ -498,6 +547,7 @@
 
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
+	&node_name_chars, &node_name_format, &property_name_chars,
 	&name_is_string, &name_properties,
 	&explicit_phandles,
 	&phandle_references, &path_references,
@@ -511,10 +561,7 @@
 	&obsolete_chosen_interrupt_controller,
 };
 
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
-
-void process_checks(int force, struct boot_info *bi,
-		    int checkflag, int outversion, int boot_cpuid_phys)
+void process_checks(int force, struct boot_info *bi)
 {
 	struct node *dt = bi->dt;
 	int i;
@@ -537,214 +584,4 @@
 				"output forced\n");
 		}
 	}
-
-	if (checkflag) {
-		if (error) {
-			fprintf(stderr, "Warning: Skipping semantic checks due to structural errors\n");
-		} else {
-			if (!check_semantics(bi->dt, outversion,
-					     boot_cpuid_phys))
-				fprintf(stderr, "Warning: Input tree has semantic errors\n");
-		}
-	}
-}
-
-/*
- * Semantic check functions
- */
-
-#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
-#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
-
-#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
-
-#define CHECK_HAVE(node, propname) \
-	do { \
-		if (! (prop = get_property((node), (propname)))) \
-			DO_ERR("Missing \"%s\" property in %s\n", (propname), \
-				(node)->fullpath); \
-	} while (0);
-
-#define CHECK_HAVE_WARN(node, propname) \
-	do { \
-		if (! (prop  = get_property((node), (propname)))) \
-			WARNMSG("%s has no \"%s\" property\n", \
-				(node)->fullpath, (propname)); \
-	} while (0)
-
-#define CHECK_HAVE_STRING(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-#define CHECK_HAVE_STREQ(node, propname, value) \
-	do { \
-		CHECK_HAVE_STRING((node), (propname)); \
-		if (prop && !streq(prop->val.val, (value))) \
-			DO_ERR("%s has wrong %s, %s (should be %s\n", \
-				(node)->fullpath, (propname), \
-				prop->val.val, (value)); \
-	} while (0)
-
-#define CHECK_HAVE_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_PHANDLE(xnode, propname, root) \
-	do { \
-		struct node *ref; \
-		CHECK_HAVE_WARN_ONECELL((xnode), (propname)); \
-		if (prop) {\
-			cell_t phandle = propval_cell(prop); \
-			if ((phandle == 0) || (phandle == -1)) { \
-				DO_ERR("\"%s\" property in %s contains an invalid phandle %x\n", (propname), (xnode)->fullpath, phandle); \
-			} else { \
-				ref = get_node_by_phandle((root), propval_cell(prop)); \
-				if (! ref) \
-					DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
-			} \
-		} \
-	} while (0)
-
-#define CHECK_HAVE_WARN_STRING(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-static int check_root(struct node *root)
-{
-	struct property *prop;
-	int ok = 1;
-
-	CHECK_HAVE_STRING(root, "model");
-	CHECK_HAVE_WARN(root, "compatible");
-
-	return ok;
-}
-
-static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
-{
-	struct node *cpus, *cpu;
-	struct property *prop;
-	struct node *bootcpu = NULL;
-	int ok = 1;
-
-	cpus = get_subnode(root, "cpus");
-	if (! cpus) {
-		ERRMSG("Missing /cpus node\n");
-		return 0;
-	}
-
-	if (cpus->addr_cells != 1)
-		DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
-		       cpus->fullpath, cpus->addr_cells);
-	if (cpus->size_cells != 0)
-		DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
-		       cpus->fullpath, cpus->size_cells);
-
-	for_each_child(cpus, cpu) {
-		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
-
-		CHECK_HAVE_ONECELL(cpu, "reg");
-		if (prop) {
-			cell_t unitnum;
-			char *eptr;
-
-			unitnum = strtol(get_unitname(cpu), &eptr, 16);
-			if (*eptr) {
-				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
-					cpu->fullpath, get_unitname(cpu));
-			} else if (unitnum != propval_cell(prop)) {
-				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
-				       cpu->fullpath, get_unitname(cpu),
-				       propval_cell(prop));
-			}
-		}
-
-/* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
-/* 		CHECK_HAVE_ONECELL(cpu, "i-cache-line-size"); */
-		CHECK_HAVE_ONECELL(cpu, "d-cache-size");
-		CHECK_HAVE_ONECELL(cpu, "i-cache-size");
-
-		CHECK_HAVE_WARN_ONECELL(cpu, "clock-frequency");
-		CHECK_HAVE_WARN_ONECELL(cpu, "timebase-frequency");
-
-		prop = get_property(cpu, "linux,boot-cpu");
-		if (prop) {
-			if (prop->val.len)
-				WARNMSG("\"linux,boot-cpu\" property in %s is non-empty\n",
-					cpu->fullpath);
-			if (bootcpu)
-				DO_ERR("Multiple boot cpus (%s and %s)\n",
-				       bootcpu->fullpath, cpu->fullpath);
-			else
-				bootcpu = cpu;
-		}
-	}
-
-	if (outversion < 2) {
-		if (! bootcpu)
-			WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
-	} else {
-		if (bootcpu)
-			WARNMSG("\"linux,boot-cpu\" property is deprecated in blob version 2 or higher\n");
-		if (boot_cpuid_phys == 0xfeedbeef)
-			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
-	}
-
-	return ok;
-}
-
-static int check_memory(struct node *root)
-{
-	struct node *mem;
-	struct property *prop;
-	int nnodes = 0;
-	int ok = 1;
-
-	for_each_child(root, mem) {
-		if (! strneq(mem->name, "memory", mem->basenamelen))
-			continue;
-
-		nnodes++;
-
-		CHECK_HAVE_STREQ(mem, "device_type", "memory");
-		CHECK_HAVE(mem, "reg");
-	}
-
-	if (nnodes == 0) {
-		ERRMSG("No memory nodes\n");
-		return 0;
-	}
-
-	return ok;
-}
-
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
-{
-	int ok = 1;
-
-	ok = ok && check_root(dt);
-	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
-	ok = ok && check_memory(dt);
-	if (! ok)
-		return 0;
-
-	return 1;
 }
Index: working-2.6/arch/powerpc/boot/dtc-src/data.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/data.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/data.c	2008-08-07 12:06:18.000000000 +1000
@@ -32,8 +32,6 @@
 		m = nm;
 	}
 
-	assert(!d.val || d.asize);
-
 	if (d.val)
 		free(d.val);
 }
@@ -43,9 +41,6 @@
 	struct data nd;
 	int newsize;
 
-	/* we must start with an allocated datum */
-	assert(!d.val || d.asize);
-
 	if (xlen == 0)
 		return d;
 
@@ -56,11 +51,8 @@
 	while ((d.len + xlen) > newsize)
 		newsize *= 2;
 
-	nd.asize = newsize;
 	nd.val = xrealloc(d.val, newsize);
 
-	assert(nd.asize >= (d.len + xlen));
-
 	return nd;
 }
 
@@ -83,16 +75,11 @@
 	long val;
 
 	x[3] = '\0';
-	x[0] = s[(*i)];
-	if (x[0]) {
-		x[1] = s[(*i)+1];
-		if (x[1])
-			x[2] = s[(*i)+2];
-	}
+	strncpy(x, s + *i, 3);
 
 	val = strtol(x, &endx, 8);
-	if ((endx - x) == 0)
-		fprintf(stderr, "Empty \\nnn escape\n");
+
+	assert(endx > x);
 
 	(*i) += endx - x;
 	return val;
@@ -105,13 +92,11 @@
 	long val;
 
 	x[2] = '\0';
-	x[0] = s[(*i)];
-	if (x[0])
-		x[1] = s[(*i)+1];
+	strncpy(x, s + *i, 2);
 
 	val = strtol(x, &endx, 16);
-	if ((endx - x) == 0)
-		fprintf(stderr, "Empty \\x escape\n");
+	if (!(endx  > x))
+		die("\\x used with no following hex digits\n");
 
 	(*i) += endx - x;
 	return val;
@@ -182,14 +167,29 @@
 	return d;
 }
 
-struct data data_copy_file(FILE *f, size_t len)
+struct data data_copy_file(FILE *f, size_t maxlen)
 {
-	struct data d;
+	struct data d = empty_data;
 
-	d = data_grow_for(empty_data, len);
+	while (!feof(f) && (d.len < maxlen)) {
+		size_t chunksize, ret;
 
-	d.len = len;
-	fread(d.val, len, 1, f);
+		if (maxlen == -1)
+			chunksize = 4096;
+		else
+			chunksize = maxlen - d.len;
+
+		d = data_grow_for(d, chunksize);
+		ret = fread(d.val + d.len, 1, chunksize, f);
+
+		if (ferror(f))
+			die("Error reading file into data: %s", strerror(errno));
+
+		if (d.len + ret < d.len)
+			die("Overflow reading file into data\n");
+
+		d.len += ret;
+	}
 
 	return d;
 }
@@ -247,7 +247,7 @@
 
 struct data data_append_cell(struct data d, cell_t word)
 {
-	cell_t beword = cpu_to_be32(word);
+	cell_t beword = cpu_to_fdt32(word);
 
 	return data_append_data(d, &beword, sizeof(beword));
 }
@@ -256,15 +256,15 @@
 {
 	struct fdt_reserve_entry bere;
 
-	bere.address = cpu_to_be64(re->address);
-	bere.size = cpu_to_be64(re->size);
+	bere.address = cpu_to_fdt64(re->address);
+	bere.size = cpu_to_fdt64(re->size);
 
 	return data_append_data(d, &bere, sizeof(bere));
 }
 
-struct data data_append_addr(struct data d, u64 addr)
+struct data data_append_addr(struct data d, uint64_t addr)
 {
-	u64 beaddr = cpu_to_be64(addr);
+	uint64_t beaddr = cpu_to_fdt64(addr);
 
 	return data_append_data(d, &beaddr, sizeof(beaddr));
 }
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc-lexer.l
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc-lexer.l	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc-lexer.l	2008-08-07 12:06:18.000000000 +1000
@@ -28,6 +28,10 @@
 PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
 PATHCHAR	({PROPNODECHAR}|[/])
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
+STRING		\"([^\\"]|\\.)*\"
+WS		[[:space:]]
+COMMENT		"/*"([^*]|\*+[^*/])*\*+"/"
+LINECOMMENT	"//".*\n
 
 %{
 #include "dtc.h"
@@ -52,29 +56,26 @@
 				DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 			}
+
+static void push_input_file(const char *filename);
+static int pop_input_file(void);
 %}
 
 %%
-<*>"/include/"		BEGIN(INCLUDE);
-
-<INCLUDE>\"[^"\n]*\"	{
-			yytext[strlen(yytext) - 1] = 0;
-			if (!push_input_file(yytext + 1)) {
-				/* Some unrecoverable error.*/
-				exit(1);
-			}
-			BEGIN_DEFAULT();
+<*>"/include/"{WS}*{STRING} {
+			char *name = strchr(yytext, '\"') + 1;
+			yytext[yyleng-1] = '\0';
+			push_input_file(name);
 		}
 
-
 <*><<EOF>>		{
 			if (!pop_input_file()) {
 				yyterminate();
 			}
 		}
 
-<*>\"([^\\"]|\\.)*\"	{
-			yylloc.filenum = srcpos_filenum;
+<*>{STRING}	{
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
 			yylval.data = data_copy_escape_string(yytext+1,
@@ -84,7 +85,7 @@
 		}
 
 <*>"/dts-v1/"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /dts-v1/\n");
 			dts_version = 1;
@@ -93,7 +94,7 @@
 		}
 
 <*>"/memreserve/"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
 			BEGIN_DEFAULT();
@@ -101,7 +102,7 @@
 		}
 
 <*>{LABEL}:	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
 			yylval.labelref = strdup(yytext);
@@ -110,7 +111,7 @@
 		}
 
 <INITIAL>[bodh]# {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
 				yylval.cbase = 2;
@@ -125,7 +126,7 @@
 		}
 
 <INITIAL>[0-9a-fA-F]+	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
@@ -133,7 +134,7 @@
 		}
 
 <V1>[0-9]+|0[xX][0-9a-fA-F]+      {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
@@ -141,7 +142,7 @@
 		}
 
 \&{LABEL}	{	/* label reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
@@ -149,7 +150,7 @@
 		}
 
 "&{/"{PATHCHAR}+\}	{	/* new-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yytext[yyleng-1] = '\0';
 			DPRINT("Ref: %s\n", yytext+2);
@@ -158,7 +159,7 @@
 		}
 
 <INITIAL>"&/"{PATHCHAR}+ {	/* old-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
@@ -166,7 +167,7 @@
 		}
 
 <BYTESTRING>[0-9a-fA-F]{2} {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.byte = strtol(yytext, NULL, 16);
 			DPRINT("Byte: %02x\n", (int)yylval.byte);
@@ -174,7 +175,7 @@
 		}
 
 <BYTESTRING>"]"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
 			BEGIN_DEFAULT();
@@ -182,7 +183,7 @@
 		}
 
 <PROPNODENAME>{PROPNODECHAR}+ {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("PropNodeName: %s\n", yytext);
 			yylval.propnodename = strdup(yytext);
@@ -190,20 +191,19 @@
 			return DT_PROPNODENAME;
 		}
 
-
-<*>[[:space:]]+	/* eat whitespace */
-
-<*>"/*"([^*]|\*+[^*/])*\*+"/"	{
-			yylloc.filenum = srcpos_filenum;
+"/incbin/"	{
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
-			DPRINT("Comment: %s\n", yytext);
-			/* eat comments */
+			DPRINT("Binary Include\n");
+			return DT_INCBIN;
 		}
 
-<*>"//".*\n	/* eat line comments */
+<*>{WS}+	/* eat whitespace */
+<*>{COMMENT}+	/* eat C-style comments */
+<*>{LINECOMMENT}+ /* eat C++-style comments */
 
 <*>.		{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
 				(unsigned)yytext[0]);
@@ -227,14 +227,13 @@
  */
 
 struct incl_file {
-	int filenum;
-	FILE *file;
+	struct dtc_file *file;
 	YY_BUFFER_STATE yy_prev_buf;
 	int yy_prev_lineno;
 	struct incl_file *prev;
 };
 
-struct incl_file *incl_file_stack;
+static struct incl_file *incl_file_stack;
 
 
 /*
@@ -245,36 +244,34 @@
 static int incl_depth = 0;
 
 
-int push_input_file(const char *filename)
+static void push_input_file(const char *filename)
 {
-	FILE *f;
 	struct incl_file *incl_file;
+	struct dtc_file *newfile;
+	struct search_path search, *searchptr = NULL;
 
-	if (!filename) {
-		yyerror("No include file name given.");
-		return 0;
-	}
+	assert(filename);
 
-	if (incl_depth++ >= MAX_INCLUDE_DEPTH) {
-		yyerror("Includes nested too deeply");
-		return 0;
+	if (incl_depth++ >= MAX_INCLUDE_DEPTH)
+		die("Includes nested too deeply");
+
+	if (srcpos_file) {
+		search.dir = srcpos_file->dir;
+		search.next = NULL;
+		search.prev = NULL;
+		searchptr = &search;
 	}
 
-	f = dtc_open_file(filename);
+	newfile = dtc_open_file(filename, searchptr);
 
-	incl_file = malloc(sizeof(struct incl_file));
-	if (!incl_file) {
-		yyerror("Can not allocate include file space.");
-		return 0;
-	}
+	incl_file = xmalloc(sizeof(struct incl_file));
 
 	/*
 	 * Save current context.
 	 */
 	incl_file->yy_prev_buf = YY_CURRENT_BUFFER;
 	incl_file->yy_prev_lineno = yylineno;
-	incl_file->filenum = srcpos_filenum;
-	incl_file->file = yyin;
+	incl_file->file = srcpos_file;
 	incl_file->prev = incl_file_stack;
 
 	incl_file_stack = incl_file;
@@ -282,23 +279,21 @@
 	/*
 	 * Establish new context.
 	 */
-	srcpos_filenum = lookup_file_name(filename, 0);
+	srcpos_file = newfile;
 	yylineno = 1;
-	yyin = f;
+	yyin = newfile->file;
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
-
-	return 1;
 }
 
 
-int pop_input_file(void)
+static int pop_input_file(void)
 {
 	struct incl_file *incl_file;
 
 	if (incl_file_stack == 0)
 		return 0;
 
-	fclose(yyin);
+	dtc_close_file(srcpos_file);
 
 	/*
 	 * Pop.
@@ -313,16 +308,13 @@
 	yy_delete_buffer(YY_CURRENT_BUFFER);
 	yy_switch_to_buffer(incl_file->yy_prev_buf);
 	yylineno = incl_file->yy_prev_lineno;
-	srcpos_filenum = incl_file->filenum;
-	yyin = incl_file->file;
+	srcpos_file = incl_file->file;
+	yyin = incl_file->file ? incl_file->file->file : NULL;
 
 	/*
 	 * Free old state.
 	 */
 	free(incl_file);
 
-	if (YY_CURRENT_BUFFER == 0)
-		return 0;
-
 	return 1;
 }
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped	2008-08-07 12:06:18.000000000 +1000
@@ -9,7 +9,7 @@
 #define FLEX_SCANNER
 #define YY_FLEX_MAJOR_VERSION 2
 #define YY_FLEX_MINOR_VERSION 5
-#define YY_FLEX_SUBMINOR_VERSION 33
+#define YY_FLEX_SUBMINOR_VERSION 34
 #if YY_FLEX_SUBMINOR_VERSION > 0
 #define FLEX_BETA
 #endif
@@ -31,7 +31,7 @@
 
 /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
 
-#if __STDC_VERSION__ >= 199901L
+#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
 
 /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
  * if you want the limit (max/min) macros for int types. 
@@ -94,11 +94,12 @@
 
 #else	/* ! __cplusplus */
 
-#if __STDC__
+/* C99 requires __STDC__ to be defined as 1. */
+#if defined (__STDC__)
 
 #define YY_USE_CONST
 
-#endif	/* __STDC__ */
+#endif	/* defined (__STDC__) */
 #endif	/* ! __cplusplus */
 
 #ifdef YY_USE_CONST
@@ -194,11 +195,13 @@
 /* The following is because we cannot portably get our hands on size_t
  * (without autoconf's help, which isn't available because we want
  * flex-generated scanners to compile on their own).
+ * Given that the standard has decreed that size_t exists since 1989,
+ * I guess we can afford to depend on it. Manoj.
  */
 
 #ifndef YY_TYPEDEF_YY_SIZE_T
 #define YY_TYPEDEF_YY_SIZE_T
-typedef unsigned int yy_size_t;
+typedef size_t yy_size_t;
 #endif
 
 #ifndef YY_STRUCT_YY_BUFFER_STATE
@@ -349,7 +352,7 @@
 
 /* Begin user sect3 */
 
-#define yywrap() 1
+#define yywrap(n) 1
 #define YY_SKIP_YYWRAP
 
 typedef unsigned char YY_CHAR;
@@ -389,19 +392,20 @@
 	flex_int32_t yy_verify;
 	flex_int32_t yy_nxt;
 	};
-static yyconst flex_int16_t yy_accept[94] =
+static yyconst flex_int16_t yy_accept[104] =
     {   0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-       21,   19,   16,   16,   19,   19,   19,    8,    8,   19,
-        8,   19,   19,   19,   19,   14,   15,   15,   19,    9,
-        9,   16,    0,    3,    0,    0,   10,    0,    0,    0,
-        0,    0,    0,    8,    8,    6,    0,    7,    0,    2,
-        0,   13,   13,   15,   15,    9,    0,   12,   10,    0,
-        0,    0,    0,   18,    0,    0,    0,    2,    9,    0,
-       17,    0,    0,    0,   11,    0,    0,    0,    0,    0,
-        0,    0,    0,    0,    4,    0,    0,    1,    0,    0,
-        0,    5,    0
+       21,   19,   16,   16,   19,   19,   19,    7,    7,   19,
+        7,   19,   19,   19,   19,   13,   14,   14,   19,    8,
+        8,   16,    0,    2,    0,    0,    9,    0,    0,    0,
+        0,    0,    0,    7,    7,    5,    0,    6,    0,   12,
+       12,   14,   14,    8,    0,   11,    9,    0,    0,    0,
+        0,   18,    0,    0,    0,    0,    8,    0,   17,    0,
+        0,    0,    0,    0,   10,    0,    0,    0,    0,    0,
+        0,    0,    0,    0,    0,    0,    0,    0,    3,   15,
+        0,    0,    0,    0,    0,    0,    0,    0,    1,    0,
 
+        0,    4,    0
     } ;
 
 static yyconst flex_int32_t yy_ec[256] =
@@ -444,122 +448,126 @@
         7,    7,    7,    8,    1
     } ;
 
-static yyconst flex_int16_t yy_base[107] =
+static yyconst flex_int16_t yy_base[117] =
     {   0,
-        0,    0,   32,    0,   53,    0,   76,    0,  108,  111,
-      280,  288,   37,   39,   33,   36,  106,    0,  123,  146,
-      255,  251,   45,    0,  159,  288,    0,   53,  108,  172,
-      114,  127,  158,  288,  245,    0,    0,  234,  235,  236,
-      197,  195,  199,    0,    0,  288,    0,  288,  160,  288,
-      183,  288,    0,    0,  183,  182,    0,    0,    0,    0,
-      204,  189,  207,  288,  179,  187,  180,  194,    0,  171,
-      288,  196,  178,  174,  288,  169,  169,  177,  165,  153,
-      143,  155,  137,  118,  288,  122,   42,  288,   36,   36,
-       40,  288,  288,  212,  218,  223,  229,  234,  239,  245,
+        0,    0,   30,    0,   44,    0,   67,    0,   97,  105,
+      302,  303,   35,   44,   40,   94,  112,    0,  129,  152,
+      296,  295,  159,    0,  176,  303,    0,  116,   95,  165,
+       49,   46,  102,  303,  296,    0,    0,  288,  290,  293,
+      264,  266,  270,    0,    0,  303,    0,  303,  264,  303,
+        0,    0,  195,  101,    0,    0,    0,    0,  284,  125,
+      277,  265,  225,  230,  216,  218,    0,  202,  224,  221,
+      217,  107,  196,  188,  303,  206,  179,  186,  178,  185,
+      183,  162,  161,  150,  169,  160,  145,  125,  303,  303,
+      137,  109,  190,  103,  203,  167,  108,  197,  303,  123,
 
-      251,  255,  262,  270,  275,  280
+       29,  303,  303,  215,  221,  226,  229,  234,  240,  246,
+      250,  257,  265,  270,  275,  282
     } ;
 
-static yyconst flex_int16_t yy_def[107] =
+static yyconst flex_int16_t yy_def[117] =
     {   0,
-       93,    1,    1,    3,    3,    5,   93,    7,    3,    3,
-       93,   93,   93,   93,   94,   95,   93,   96,   93,   19,
-       19,   20,   97,   98,   20,   93,   99,  100,   95,   93,
-       93,   93,   94,   93,   94,  101,  102,   93,  103,  104,
-       93,   93,   93,   96,   19,   93,   20,   93,   97,   93,
-       97,   93,   20,   99,  100,   93,  105,  101,  102,  106,
-      103,  103,  104,   93,   93,   93,   93,   94,  105,  106,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,    0,   93,   93,   93,   93,   93,   93,   93,
+      103,    1,    1,    3,    3,    5,  103,    7,    3,    3,
+      103,  103,  103,  103,  104,  105,  103,  106,  103,   19,
+       19,   20,  103,  107,   20,  103,  108,  109,  105,  103,
+      103,  103,  104,  103,  104,  110,  111,  103,  112,  113,
+      103,  103,  103,  106,   19,  103,   20,  103,  103,  103,
+       20,  108,  109,  103,  114,  110,  111,  115,  112,  112,
+      113,  103,  103,  103,  103,  103,  114,  115,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  116,  103,  116,  103,  116,
 
-       93,   93,   93,   93,   93,   93
+      103,  103,    0,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103
     } ;
 
-static yyconst flex_int16_t yy_nxt[324] =
+static yyconst flex_int16_t yy_nxt[339] =
     {   0,
        12,   13,   14,   15,   12,   16,   12,   12,   12,   17,
        18,   18,   18,   12,   19,   20,   20,   12,   12,   21,
        19,   21,   19,   22,   20,   20,   20,   20,   20,   20,
-       20,   20,   20,   12,   12,   23,   34,   12,   32,   32,
-       32,   32,   12,   12,   12,   36,   20,   33,   50,   92,
-       35,   20,   20,   20,   20,   20,   15,   54,   91,   54,
-       54,   54,   51,   24,   24,   24,   46,   25,   90,   38,
-       89,   26,   25,   25,   25,   25,   12,   13,   14,   15,
-       27,   12,   27,   27,   27,   17,   27,   27,   27,   12,
-       28,   28,   28,   12,   12,   28,   28,   28,   28,   28,
-
-       28,   28,   28,   28,   28,   28,   28,   28,   28,   12,
-       12,   15,   39,   29,   15,   40,   29,   93,   30,   31,
-       31,   30,   31,   31,   56,   56,   56,   41,   32,   32,
-       42,   88,   43,   45,   45,   45,   46,   45,   47,   47,
-       87,   38,   45,   45,   45,   45,   47,   47,   47,   47,
-       47,   47,   47,   47,   47,   47,   47,   47,   47,   86,
-       47,   34,   33,   50,   85,   47,   47,   47,   47,   53,
-       53,   53,   84,   53,   83,   35,   82,   51,   53,   53,
-       53,   53,   56,   56,   56,   93,   68,   54,   57,   54,
-       54,   54,   56,   56,   56,   62,   46,   34,   71,   81,
-
-       80,   79,   78,   77,   76,   75,   74,   73,   72,   64,
-       62,   35,   33,   33,   33,   33,   33,   33,   33,   33,
-       37,   67,   66,   37,   37,   37,   44,   65,   44,   49,
-       49,   49,   49,   49,   49,   49,   49,   52,   64,   52,
-       54,   62,   54,   60,   54,   54,   55,   93,   55,   55,
-       55,   55,   58,   58,   58,   48,   58,   58,   59,   48,
-       59,   59,   61,   61,   61,   61,   61,   61,   61,   61,
-       63,   63,   63,   63,   63,   63,   63,   63,   69,   93,
-       69,   70,   70,   70,   93,   70,   70,   11,   93,   93,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,   93
+       20,   20,   20,   12,   12,   12,   32,   32,  102,   23,
+       12,   12,   12,   34,   20,   32,   32,   32,   32,   20,
+       20,   20,   20,   20,   24,   24,   24,   35,   25,   54,
+       54,   54,   26,   25,   25,   25,   25,   12,   13,   14,
+       15,   27,   12,   27,   27,   27,   23,   27,   27,   27,
+       12,   28,   28,   28,   12,   12,   28,   28,   28,   28,
+       28,   28,   28,   28,   28,   28,   28,   28,   28,   28,
+
+       12,   12,   29,   36,  103,   34,   17,   30,   31,   31,
+       29,   54,   54,   54,   17,   30,   31,   31,   39,   35,
+       52,   40,   52,   52,   52,  103,   78,   38,   38,   46,
+      101,   60,   79,   41,   69,   97,   42,   94,   43,   45,
+       45,   45,   46,   45,   47,   47,   93,   92,   45,   45,
+       45,   45,   47,   47,   47,   47,   47,   47,   47,   47,
+       47,   47,   47,   47,   47,   39,   47,   91,   40,   90,
+       99,   47,   47,   47,   47,   54,   54,   54,   89,   88,
+       41,   55,   87,   49,  100,   43,   51,   51,   51,   86,
+       51,   95,   95,   96,   85,   51,   51,   51,   51,   52,
+
+       99,   52,   52,   52,   95,   95,   96,   84,   46,   83,
+       82,   81,   39,   79,  100,   33,   33,   33,   33,   33,
+       33,   33,   33,   37,   80,   77,   37,   37,   37,   44,
+       40,   44,   50,   76,   50,   52,   75,   52,   74,   52,
+       52,   53,   73,   53,   53,   53,   53,   56,   56,   56,
+       72,   56,   56,   57,   71,   57,   57,   59,   59,   59,
+       59,   59,   59,   59,   59,   61,   61,   61,   61,   61,
+       61,   61,   61,   67,   70,   67,   68,   68,   68,   62,
+       68,   68,   98,   98,   98,   98,   98,   98,   98,   98,
+       60,   66,   65,   64,   63,   62,   60,   58,  103,   48,
+
+       48,  103,   11,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103
     } ;
 
-static yyconst flex_int16_t yy_chk[324] =
+static yyconst flex_int16_t yy_chk[339] =
     {   0,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    3,   15,    3,   13,   13,
-       14,   14,    3,    3,    3,   16,    3,   23,   23,   91,
-       15,    3,    3,    3,    3,    3,    5,   28,   90,   28,
-       28,   28,   23,    5,    5,    5,   28,    5,   89,   16,
-       87,    5,    5,    5,    5,    5,    7,    7,    7,    7,
+        1,    1,    1,    1,    1,    3,   13,   13,  101,    3,
+        3,    3,    3,   15,    3,   14,   14,   32,   32,    3,
+        3,    3,    3,    3,    5,    5,    5,   15,    5,   31,
+       31,   31,    5,    5,    5,    5,    5,    7,    7,    7,
         7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
         7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
-
         7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
-        7,    9,   17,    9,   10,   17,   10,   29,    9,    9,
-        9,   10,   10,   10,   31,   31,   31,   17,   32,   32,
-       17,   86,   17,   19,   19,   19,   19,   19,   19,   19,
-       84,   29,   19,   19,   19,   19,   19,   19,   19,   19,
-       19,   19,   19,   19,   19,   19,   20,   20,   20,   83,
-       20,   33,   49,   49,   82,   20,   20,   20,   20,   25,
-       25,   25,   81,   25,   80,   33,   79,   49,   25,   25,
-       25,   25,   30,   30,   30,   51,   51,   55,   30,   55,
-       55,   55,   56,   56,   56,   62,   55,   68,   62,   78,
-
-       77,   76,   74,   73,   72,   70,   67,   66,   65,   63,
-       61,   68,   94,   94,   94,   94,   94,   94,   94,   94,
-       95,   43,   42,   95,   95,   95,   96,   41,   96,   97,
-       97,   97,   97,   97,   97,   97,   97,   98,   40,   98,
-       99,   39,   99,   38,   99,   99,  100,   35,  100,  100,
-      100,  100,  101,  101,  101,   22,  101,  101,  102,   21,
-      102,  102,  103,  103,  103,  103,  103,  103,  103,  103,
-      104,  104,  104,  104,  104,  104,  104,  104,  105,   11,
-      105,  106,  106,  106,    0,  106,  106,   93,   93,   93,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
-       93,   93,   93
+
+        7,    7,    9,   16,   29,   33,    9,    9,    9,    9,
+       10,   54,   54,   54,   10,   10,   10,   10,   17,   33,
+       28,   17,   28,   28,   28,  100,   72,   16,   29,   28,
+       97,   60,   72,   17,   60,   94,   17,   92,   17,   19,
+       19,   19,   19,   19,   19,   19,   91,   88,   19,   19,
+       19,   19,   19,   19,   19,   19,   19,   19,   19,   19,
+       19,   19,   20,   20,   20,   23,   20,   87,   23,   86,
+       96,   20,   20,   20,   20,   30,   30,   30,   85,   84,
+       23,   30,   83,   23,   96,   23,   25,   25,   25,   82,
+       25,   93,   93,   93,   81,   25,   25,   25,   25,   53,
+
+       98,   53,   53,   53,   95,   95,   95,   80,   53,   79,
+       78,   77,   76,   74,   98,  104,  104,  104,  104,  104,
+      104,  104,  104,  105,   73,   71,  105,  105,  105,  106,
+       70,  106,  107,   69,  107,  108,   68,  108,   66,  108,
+      108,  109,   65,  109,  109,  109,  109,  110,  110,  110,
+       64,  110,  110,  111,   63,  111,  111,  112,  112,  112,
+      112,  112,  112,  112,  112,  113,  113,  113,  113,  113,
+      113,  113,  113,  114,   62,  114,  115,  115,  115,   61,
+      115,  115,  116,  116,  116,  116,  116,  116,  116,  116,
+       59,   49,   43,   42,   41,   40,   39,   38,   35,   22,
+
+       21,   11,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
+      103,  103,  103,  103,  103,  103,  103,  103
     } ;
 
 /* Table of booleans, true if rule could match eol. */
 static yyconst flex_int32_t yy_rule_can_match_eol[21] =
     {   0,
-0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 
+1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 
     0,     };
 
 static yy_state_type yy_last_accepting_state;
@@ -600,7 +608,7 @@
 
 
 
-#line 33 "dtc-lexer.l"
+#line 37 "dtc-lexer.l"
 #include "dtc.h"
 #include "srcpos.h"
 #include "dtc-parser.tab.h"
@@ -623,7 +631,10 @@
 				DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 			}
-#line 627 "dtc-lexer.lex.c"
+
+static void push_input_file(const char *filename);
+static int pop_input_file(void);
+#line 638 "dtc-lexer.lex.c"
 
 #define INITIAL 0
 #define INCLUDE 1
@@ -685,7 +696,7 @@
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO (void) fwrite( yytext, yyleng, 1, yyout )
+#define ECHO fwrite( yytext, yyleng, 1, yyout )
 #endif
 
 /* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
@@ -696,7 +707,7 @@
 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
 		{ \
 		int c = '*'; \
-		size_t n; \
+		int n; \
 		for ( n = 0; n < max_size && \
 			     (c = getc( yyin )) != EOF && c != '\n'; ++n ) \
 			buf[n] = (char) c; \
@@ -778,9 +789,9 @@
 	register char *yy_cp, *yy_bp;
 	register int yy_act;
     
-#line 57 "dtc-lexer.l"
+#line 64 "dtc-lexer.l"
 
-#line 784 "dtc-lexer.lex.c"
+#line 795 "dtc-lexer.lex.c"
 
 	if ( !(yy_init) )
 		{
@@ -833,13 +844,13 @@
 			while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
 				{
 				yy_current_state = (int) yy_def[yy_current_state];
-				if ( yy_current_state >= 94 )
+				if ( yy_current_state >= 104 )
 					yy_c = yy_meta[(unsigned int) yy_c];
 				}
 			yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
 			++yy_cp;
 			}
-		while ( yy_base[yy_current_state] != 288 );
+		while ( yy_base[yy_current_state] != 303 );
 
 yy_find_action:
 		yy_act = yy_accept[yy_current_state];
@@ -874,20 +885,13 @@
 			goto yy_find_action;
 
 case 1:
+/* rule 1 can match eol */
 YY_RULE_SETUP
-#line 58 "dtc-lexer.l"
-BEGIN(INCLUDE);
-	YY_BREAK
-case 2:
-YY_RULE_SETUP
-#line 60 "dtc-lexer.l"
+#line 65 "dtc-lexer.l"
 {
-			yytext[strlen(yytext) - 1] = 0;
-			if (!push_input_file(yytext + 1)) {
-				/* Some unrecoverable error.*/
-				exit(1);
-			}
-			BEGIN_DEFAULT();
+			char *name = strchr(yytext, '\"') + 1;
+			yytext[yyleng-1] = '\0';
+			push_input_file(name);
 		}
 	YY_BREAK
 case YY_STATE_EOF(INITIAL):
@@ -895,19 +899,19 @@
 case YY_STATE_EOF(BYTESTRING):
 case YY_STATE_EOF(PROPNODENAME):
 case YY_STATE_EOF(V1):
-#line 70 "dtc-lexer.l"
+#line 71 "dtc-lexer.l"
 {
 			if (!pop_input_file()) {
 				yyterminate();
 			}
 		}
 	YY_BREAK
-case 3:
-/* rule 3 can match eol */
+case 2:
+/* rule 2 can match eol */
 YY_RULE_SETUP
-#line 76 "dtc-lexer.l"
+#line 77 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
 			yylval.data = data_copy_escape_string(yytext+1,
@@ -916,11 +920,11 @@
 			return DT_STRING;
 		}
 	YY_BREAK
-case 4:
+case 3:
 YY_RULE_SETUP
-#line 86 "dtc-lexer.l"
+#line 87 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /dts-v1/\n");
 			dts_version = 1;
@@ -928,22 +932,22 @@
 			return DT_V1;
 		}
 	YY_BREAK
-case 5:
+case 4:
 YY_RULE_SETUP
-#line 95 "dtc-lexer.l"
+#line 96 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
 			BEGIN_DEFAULT();
 			return DT_MEMRESERVE;
 		}
 	YY_BREAK
-case 6:
+case 5:
 YY_RULE_SETUP
-#line 103 "dtc-lexer.l"
+#line 104 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
 			yylval.labelref = strdup(yytext);
@@ -951,11 +955,11 @@
 			return DT_LABEL;
 		}
 	YY_BREAK
-case 7:
+case 6:
 YY_RULE_SETUP
-#line 112 "dtc-lexer.l"
+#line 113 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
 				yylval.cbase = 2;
@@ -969,44 +973,44 @@
 			return DT_BASE;
 		}
 	YY_BREAK
-case 8:
+case 7:
 YY_RULE_SETUP
-#line 127 "dtc-lexer.l"
+#line 128 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
 			return DT_LEGACYLITERAL;
 		}
 	YY_BREAK
-case 9:
+case 8:
 YY_RULE_SETUP
-#line 135 "dtc-lexer.l"
+#line 136 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
 			return DT_LITERAL;
 		}
 	YY_BREAK
-case 10:
+case 9:
 YY_RULE_SETUP
-#line 143 "dtc-lexer.l"
+#line 144 "dtc-lexer.l"
 {	/* label reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
 			return DT_REF;
 		}
 	YY_BREAK
-case 11:
+case 10:
 YY_RULE_SETUP
-#line 151 "dtc-lexer.l"
+#line 152 "dtc-lexer.l"
 {	/* new-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yytext[yyleng-1] = '\0';
 			DPRINT("Ref: %s\n", yytext+2);
@@ -1014,44 +1018,44 @@
 			return DT_REF;
 		}
 	YY_BREAK
-case 12:
+case 11:
 YY_RULE_SETUP
-#line 160 "dtc-lexer.l"
+#line 161 "dtc-lexer.l"
 {	/* old-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
 			return DT_REF;
 		}
 	YY_BREAK
-case 13:
+case 12:
 YY_RULE_SETUP
-#line 168 "dtc-lexer.l"
+#line 169 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.byte = strtol(yytext, NULL, 16);
 			DPRINT("Byte: %02x\n", (int)yylval.byte);
 			return DT_BYTE;
 		}
 	YY_BREAK
-case 14:
+case 13:
 YY_RULE_SETUP
-#line 176 "dtc-lexer.l"
+#line 177 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
 			BEGIN_DEFAULT();
 			return ']';
 		}
 	YY_BREAK
-case 15:
+case 14:
 YY_RULE_SETUP
-#line 184 "dtc-lexer.l"
+#line 185 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("PropNodeName: %s\n", yytext);
 			yylval.propnodename = strdup(yytext);
@@ -1059,34 +1063,39 @@
 			return DT_PROPNODENAME;
 		}
 	YY_BREAK
+case 15:
+YY_RULE_SETUP
+#line 194 "dtc-lexer.l"
+{
+			yylloc.file = srcpos_file;
+			yylloc.first_line = yylineno;
+			DPRINT("Binary Include\n");
+			return DT_INCBIN;
+		}
+	YY_BREAK
 case 16:
 /* rule 16 can match eol */
 YY_RULE_SETUP
-#line 194 "dtc-lexer.l"
+#line 201 "dtc-lexer.l"
 /* eat whitespace */
 	YY_BREAK
 case 17:
 /* rule 17 can match eol */
 YY_RULE_SETUP
-#line 196 "dtc-lexer.l"
-{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			DPRINT("Comment: %s\n", yytext);
-			/* eat comments */
-		}
+#line 202 "dtc-lexer.l"
+/* eat C-style comments */
 	YY_BREAK
 case 18:
 /* rule 18 can match eol */
 YY_RULE_SETUP
 #line 203 "dtc-lexer.l"
-/* eat line comments */
+/* eat C++-style comments */
 	YY_BREAK
 case 19:
 YY_RULE_SETUP
 #line 205 "dtc-lexer.l"
 {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
 				(unsigned)yytext[0]);
@@ -1107,7 +1116,7 @@
 #line 222 "dtc-lexer.l"
 ECHO;
 	YY_BREAK
-#line 1111 "dtc-lexer.lex.c"
+#line 1120 "dtc-lexer.lex.c"
 
 	case YY_END_OF_BUFFER:
 		{
@@ -1360,6 +1369,14 @@
 	else
 		ret_val = EOB_ACT_CONTINUE_SCAN;
 
+	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
+		/* Extend the array by 50%, plus the number we really need. */
+		yy_size_t new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >> 1);
+		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) yyrealloc((void *) YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
+		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
+			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
+	}
+
 	(yy_n_chars) += number_to_move;
 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] = YY_END_OF_BUFFER_CHAR;
 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] = YY_END_OF_BUFFER_CHAR;
@@ -1389,7 +1406,7 @@
 		while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
 			{
 			yy_current_state = (int) yy_def[yy_current_state];
-			if ( yy_current_state >= 94 )
+			if ( yy_current_state >= 104 )
 				yy_c = yy_meta[(unsigned int) yy_c];
 			}
 		yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
@@ -1417,11 +1434,11 @@
 	while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
 		{
 		yy_current_state = (int) yy_def[yy_current_state];
-		if ( yy_current_state >= 94 )
+		if ( yy_current_state >= 104 )
 			yy_c = yy_meta[(unsigned int) yy_c];
 		}
 	yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
-	yy_is_jam = (yy_current_state == 93);
+	yy_is_jam = (yy_current_state == 103);
 
 	return yy_is_jam ? 0 : yy_current_state;
 }
@@ -1743,7 +1760,9 @@
 		(yy_buffer_stack) = (struct yy_buffer_state**)yyalloc
 								(num_to_alloc * sizeof(struct yy_buffer_state*)
 								);
-		
+		if ( ! (yy_buffer_stack) )
+			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
+								  
 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_state*));
 				
 		(yy_buffer_stack_max) = num_to_alloc;
@@ -1761,6 +1780,8 @@
 								((yy_buffer_stack),
 								num_to_alloc * sizeof(struct yy_buffer_state*)
 								);
+		if ( ! (yy_buffer_stack) )
+			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
 
 		/* zero only the new slots.*/
 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * sizeof(struct yy_buffer_state*));
@@ -2072,14 +2093,13 @@
  */
 
 struct incl_file {
-	int filenum;
-	FILE *file;
+	struct dtc_file *file;
 	YY_BUFFER_STATE yy_prev_buf;
 	int yy_prev_lineno;
 	struct incl_file *prev;
 };
 
-struct incl_file *incl_file_stack;
+static struct incl_file *incl_file_stack;
 
 
 /*
@@ -2090,36 +2110,34 @@
 static int incl_depth = 0;
 
 
-int push_input_file(const char *filename)
+static void push_input_file(const char *filename)
 {
-	FILE *f;
 	struct incl_file *incl_file;
+	struct dtc_file *newfile;
+	struct search_path search, *searchptr = NULL;
 
-	if (!filename) {
-		yyerror("No include file name given.");
-		return 0;
-	}
+	assert(filename);
 
-	if (incl_depth++ >= MAX_INCLUDE_DEPTH) {
-		yyerror("Includes nested too deeply");
-		return 0;
+	if (incl_depth++ >= MAX_INCLUDE_DEPTH)
+		die("Includes nested too deeply");
+
+	if (srcpos_file) {
+		search.dir = srcpos_file->dir;
+		search.next = NULL;
+		search.prev = NULL;
+		searchptr = &search;
 	}
 
-	f = dtc_open_file(filename);
+	newfile = dtc_open_file(filename, searchptr);
 
-	incl_file = malloc(sizeof(struct incl_file));
-	if (!incl_file) {
-		yyerror("Can not allocate include file space.");
-		return 0;
-	}
+	incl_file = xmalloc(sizeof(struct incl_file));
 
 	/*
 	 * Save current context.
 	 */
 	incl_file->yy_prev_buf = YY_CURRENT_BUFFER;
 	incl_file->yy_prev_lineno = yylineno;
-	incl_file->filenum = srcpos_filenum;
-	incl_file->file = yyin;
+	incl_file->file = srcpos_file;
 	incl_file->prev = incl_file_stack;
 
 	incl_file_stack = incl_file;
@@ -2127,23 +2145,21 @@
 	/*
 	 * Establish new context.
 	 */
-	srcpos_filenum = lookup_file_name(filename, 0);
+	srcpos_file = newfile;
 	yylineno = 1;
-	yyin = f;
+	yyin = newfile->file;
 	yy_switch_to_buffer(yy_create_buffer(yyin,YY_BUF_SIZE));
-
-	return 1;
 }
 
 
-int pop_input_file(void)
+static int pop_input_file(void)
 {
 	struct incl_file *incl_file;
 
 	if (incl_file_stack == 0)
 		return 0;
 
-	fclose(yyin);
+	dtc_close_file(srcpos_file);
 
 	/*
 	 * Pop.
@@ -2158,17 +2174,14 @@
 	yy_delete_buffer(YY_CURRENT_BUFFER);
 	yy_switch_to_buffer(incl_file->yy_prev_buf);
 	yylineno = incl_file->yy_prev_lineno;
-	srcpos_filenum = incl_file->filenum;
-	yyin = incl_file->file;
+	srcpos_file = incl_file->file;
+	yyin = incl_file->file ? incl_file->file->file : NULL;
 
 	/*
 	 * Free old state.
 	 */
 	free(incl_file);
 
-	if (YY_CURRENT_BUFFER == 0)
-		return 0;
-
 	return 1;
 }
 
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped	2008-08-07 12:06:18.000000000 +1000
@@ -75,7 +75,8 @@
      DT_BYTE = 264,
      DT_STRING = 265,
      DT_LABEL = 266,
-     DT_REF = 267
+     DT_REF = 267,
+     DT_INCBIN = 268
    };
 #endif
 /* Tokens.  */
@@ -89,6 +90,7 @@
 #define DT_STRING 265
 #define DT_LABEL 266
 #define DT_REF 267
+#define DT_INCBIN 268
 
 
 
@@ -96,14 +98,17 @@
 /* Copy the first part of user declarations.  */
 #line 23 "dtc-parser.y"
 
+#include <stdio.h>
+
 #include "dtc.h"
 #include "srcpos.h"
 
-int yylex(void);
-unsigned long long eval_literal(const char *s, int base, int bits);
+extern int yylex(void);
 
 extern struct boot_info *the_boot_info;
+extern int treesource_error;
 
+static unsigned long long eval_literal(const char *s, int base, int bits);
 
 
 /* Enabling traces.  */
@@ -126,16 +131,16 @@
 
 #if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
 typedef union YYSTYPE
-#line 34 "dtc-parser.y"
+#line 37 "dtc-parser.y"
 {
 	char *propnodename;
 	char *literal;
 	char *labelref;
 	unsigned int cbase;
-	u8 byte;
+	uint8_t byte;
 	struct data data;
 
-	u64 addr;
+	uint64_t addr;
 	cell_t cell;
 	struct property *prop;
 	struct property *proplist;
@@ -144,7 +149,7 @@
 	struct reserve_info *re;
 }
 /* Line 187 of yacc.c.  */
-#line 148 "dtc-parser.tab.c"
+#line 153 "dtc-parser.tab.c"
 	YYSTYPE;
 # define yystype YYSTYPE /* obsolescent; will be withdrawn */
 # define YYSTYPE_IS_DECLARED 1
@@ -169,7 +174,7 @@
 
 
 /* Line 216 of yacc.c.  */
-#line 173 "dtc-parser.tab.c"
+#line 178 "dtc-parser.tab.c"
 
 #ifdef short
 # undef short
@@ -386,20 +391,20 @@
 /* YYFINAL -- State number of the termination state.  */
 #define YYFINAL  9
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   60
+#define YYLAST   73
 
 /* YYNTOKENS -- Number of terminals.  */
-#define YYNTOKENS  24
+#define YYNTOKENS  27
 /* YYNNTS -- Number of nonterminals.  */
 #define YYNNTS  20
 /* YYNRULES -- Number of rules.  */
-#define YYNRULES  43
+#define YYNRULES  45
 /* YYNRULES -- Number of states.  */
-#define YYNSTATES  67
+#define YYNSTATES  76
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   267
+#define YYMAXUTOK   268
 
 #define YYTRANSLATE(YYX)						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
@@ -411,15 +416,15 @@
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,    23,    14,     2,    15,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,    13,
-      19,    18,    20,     2,     2,     2,     2,     2,     2,     2,
+      24,    26,     2,     2,    25,    15,     2,    16,     2,     2,
+       2,     2,     2,     2,     2,     2,     2,     2,     2,    14,
+      20,    19,    21,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,    21,     2,    22,     2,     2,     2,     2,     2,     2,
+       2,    22,     2,    23,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,    16,     2,    17,     2,     2,     2,     2,
+       2,     2,     2,    17,     2,    18,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
@@ -433,7 +438,7 @@
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
        2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
-       5,     6,     7,     8,     9,    10,    11,    12
+       5,     6,     7,     8,     9,    10,    11,    12,    13
 };
 
 #if YYDEBUG
@@ -443,37 +448,39 @@
 {
        0,     0,     3,     8,    11,    12,    15,    21,    22,    25,
       27,    34,    36,    38,    41,    47,    48,    51,    57,    61,
-      64,    69,    74,    77,    80,    81,    84,    87,    88,    91,
-      94,    97,    98,   100,   102,   105,   106,   109,   112,   113,
-     116,   119,   123,   124
+      64,    69,    74,    77,    87,    93,    96,    97,   100,   103,
+     104,   107,   110,   113,   114,   116,   118,   121,   122,   125,
+     128,   129,   132,   135,   139,   140
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS.  */
 static const yytype_int8 yyrhs[] =
 {
-      25,     0,    -1,     3,    13,    26,    31,    -1,    28,    31,
-      -1,    -1,    27,    26,    -1,    43,     4,    30,    30,    13,
-      -1,    -1,    29,    28,    -1,    27,    -1,    43,     4,    30,
-      14,    30,    13,    -1,     6,    -1,     7,    -1,    15,    32,
-      -1,    16,    33,    41,    17,    13,    -1,    -1,    33,    34,
-      -1,    43,     5,    18,    35,    13,    -1,    43,     5,    13,
-      -1,    36,    10,    -1,    36,    19,    37,    20,    -1,    36,
-      21,    40,    22,    -1,    36,    12,    -1,    35,    11,    -1,
-      -1,    35,    23,    -1,    36,    11,    -1,    -1,    37,    39,
-      -1,    37,    12,    -1,    37,    11,    -1,    -1,     8,    -1,
-       6,    -1,    38,     7,    -1,    -1,    40,     9,    -1,    40,
-      11,    -1,    -1,    42,    41,    -1,    42,    34,    -1,    43,
-       5,    32,    -1,    -1,    11,    -1
+      28,     0,    -1,     3,    14,    29,    34,    -1,    31,    34,
+      -1,    -1,    30,    29,    -1,    46,     4,    33,    33,    14,
+      -1,    -1,    32,    31,    -1,    30,    -1,    46,     4,    33,
+      15,    33,    14,    -1,     6,    -1,     7,    -1,    16,    35,
+      -1,    17,    36,    44,    18,    14,    -1,    -1,    36,    37,
+      -1,    46,     5,    19,    38,    14,    -1,    46,     5,    14,
+      -1,    39,    10,    -1,    39,    20,    40,    21,    -1,    39,
+      22,    43,    23,    -1,    39,    12,    -1,    39,    13,    24,
+      10,    25,    33,    25,    33,    26,    -1,    39,    13,    24,
+      10,    26,    -1,    38,    11,    -1,    -1,    38,    25,    -1,
+      39,    11,    -1,    -1,    40,    42,    -1,    40,    12,    -1,
+      40,    11,    -1,    -1,     8,    -1,     6,    -1,    41,     7,
+      -1,    -1,    43,     9,    -1,    43,    11,    -1,    -1,    45,
+      44,    -1,    45,    37,    -1,    46,     5,    35,    -1,    -1,
+      11,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const yytype_uint16 yyrline[] =
 {
-       0,    85,    85,    89,    97,   100,   107,   115,   118,   125,
-     129,   136,   140,   147,   154,   162,   165,   172,   176,   183,
-     187,   191,   195,   199,   207,   210,   214,   222,   225,   229,
-     234,   242,   245,   249,   253,   261,   264,   268,   276,   279,
-     283,   291,   299,   302
+       0,    89,    89,    93,   101,   104,   111,   119,   122,   129,
+     133,   140,   144,   151,   158,   166,   169,   176,   180,   187,
+     191,   195,   199,   203,   220,   231,   239,   242,   246,   254,
+     257,   261,   266,   274,   277,   281,   285,   293,   296,   300,
+     308,   311,   315,   323,   331,   334
 };
 #endif
 
@@ -484,12 +491,12 @@
 {
   "$end", "error", "$undefined", "DT_V1", "DT_MEMRESERVE",
   "DT_PROPNODENAME", "DT_LITERAL", "DT_LEGACYLITERAL", "DT_BASE",
-  "DT_BYTE", "DT_STRING", "DT_LABEL", "DT_REF", "';'", "'-'", "'/'", "'{'",
-  "'}'", "'='", "'<'", "'>'", "'['", "']'", "','", "$accept", "sourcefile",
-  "memreserves", "memreserve", "v0_memreserves", "v0_memreserve", "addr",
-  "devicetree", "nodedef", "proplist", "propdef", "propdata",
-  "propdataprefix", "celllist", "cellbase", "cellval", "bytestring",
-  "subnodes", "subnode", "label", 0
+  "DT_BYTE", "DT_STRING", "DT_LABEL", "DT_REF", "DT_INCBIN", "';'", "'-'",
+  "'/'", "'{'", "'}'", "'='", "'<'", "'>'", "'['", "']'", "'('", "','",
+  "')'", "$accept", "sourcefile", "memreserves", "memreserve",
+  "v0_memreserves", "v0_memreserve", "addr", "devicetree", "nodedef",
+  "proplist", "propdef", "propdata", "propdataprefix", "celllist",
+  "cellbase", "cellval", "bytestring", "subnodes", "subnode", "label", 0
 };
 #endif
 
@@ -499,19 +506,19 @@
 static const yytype_uint16 yytoknum[] =
 {
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
-     265,   266,   267,    59,    45,    47,   123,   125,    61,    60,
-      62,    91,    93,    44
+     265,   266,   267,   268,    59,    45,    47,   123,   125,    61,
+      60,    62,    91,    93,    40,    44,    41
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const yytype_uint8 yyr1[] =
 {
-       0,    24,    25,    25,    26,    26,    27,    28,    28,    29,
-      29,    30,    30,    31,    32,    33,    33,    34,    34,    35,
-      35,    35,    35,    35,    36,    36,    36,    37,    37,    37,
-      37,    38,    38,    39,    39,    40,    40,    40,    41,    41,
-      41,    42,    43,    43
+       0,    27,    28,    28,    29,    29,    30,    31,    31,    32,
+      32,    33,    33,    34,    35,    36,    36,    37,    37,    38,
+      38,    38,    38,    38,    38,    38,    39,    39,    39,    40,
+      40,    40,    40,    41,    41,    42,    42,    43,    43,    43,
+      44,    44,    44,    45,    46,    46
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
@@ -519,9 +526,9 @@
 {
        0,     2,     4,     2,     0,     2,     5,     0,     2,     1,
        6,     1,     1,     2,     5,     0,     2,     5,     3,     2,
-       4,     4,     2,     2,     0,     2,     2,     0,     2,     2,
-       2,     0,     1,     1,     2,     0,     2,     2,     0,     2,
-       2,     3,     0,     1
+       4,     4,     2,     9,     5,     2,     0,     2,     2,     0,
+       2,     2,     2,     0,     1,     1,     2,     0,     2,     2,
+       0,     2,     2,     3,     0,     1
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -529,81 +536,86 @@
    means the default is an error.  */
 static const yytype_uint8 yydefact[] =
 {
-       7,     0,    43,     0,     9,     0,     7,     0,     4,     1,
+       7,     0,    45,     0,     9,     0,     7,     0,     4,     1,
        0,     3,     8,     0,     0,     4,     0,    15,    13,    11,
-      12,     0,     2,     5,     0,    38,     0,     0,     0,    16,
-       0,    38,     0,     0,     6,     0,    40,    39,     0,    10,
-      14,    18,    24,    41,     0,     0,    23,    17,    25,    19,
-      26,    22,    27,    35,    31,     0,    33,    32,    30,    29,
-      20,     0,    28,    36,    37,    21,    34
+      12,     0,     2,     5,     0,    40,     0,     0,     0,    16,
+       0,    40,     0,     0,     6,     0,    42,    41,     0,    10,
+      14,    18,    26,    43,     0,     0,    25,    17,    27,    19,
+      28,    22,     0,    29,    37,     0,    33,     0,     0,    35,
+      34,    32,    31,    20,     0,    30,    38,    39,    21,     0,
+      24,    36,     0,     0,     0,    23
 };
 
 /* YYDEFGOTO[NTERM-NUM].  */
 static const yytype_int8 yydefgoto[] =
 {
       -1,     3,    14,     4,     5,     6,    27,    11,    18,    25,
-      29,    44,    45,    54,    61,    62,    55,    30,    31,     7
+      29,    44,    45,    56,    64,    65,    57,    30,    31,     7
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -13
+#define YYPACT_NINF -14
 static const yytype_int8 yypact[] =
 {
-      23,    11,   -13,    37,   -13,    -4,    18,    39,    18,   -13,
-      28,   -13,   -13,    34,    -4,    18,    41,   -13,   -13,   -13,
-     -13,    25,   -13,   -13,    34,    -3,    34,    33,    34,   -13,
-      30,    -3,    43,    36,   -13,    38,   -13,   -13,    20,   -13,
-     -13,   -13,   -13,   -13,     2,     9,   -13,   -13,   -13,   -13,
-     -13,   -13,   -13,   -13,    -2,    -6,   -13,   -13,   -13,   -13,
-     -13,    45,   -13,   -13,   -13,   -13,   -13
+      30,   -11,   -14,     7,   -14,    -1,    27,    13,    27,   -14,
+       8,   -14,   -14,    40,    -1,    27,    35,   -14,   -14,   -14,
+     -14,    21,   -14,   -14,    40,    24,    40,    28,    40,   -14,
+      32,    24,    46,    38,   -14,    39,   -14,   -14,    26,   -14,
+     -14,   -14,   -14,   -14,    -9,    10,   -14,   -14,   -14,   -14,
+     -14,   -14,    31,   -14,   -14,    44,    -2,     3,    23,   -14,
+     -14,   -14,   -14,   -14,    50,   -14,   -14,   -14,   -14,    40,
+     -14,   -14,    33,    40,    36,   -14
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const yytype_int8 yypgoto[] =
 {
-     -13,   -13,    35,    27,    47,   -13,   -12,    40,    17,   -13,
-      26,   -13,   -13,   -13,   -13,   -13,   -13,    29,   -13,    -8
+     -14,   -14,    48,    29,    53,   -14,   -13,    47,    34,   -14,
+      37,   -14,   -14,   -14,   -14,   -14,   -14,    42,   -14,    -7
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
-#define YYTABLE_NINF -43
+#define YYTABLE_NINF -45
 static const yytype_int8 yytable[] =
 {
-      16,    21,   -42,    63,    56,    64,    57,    16,     2,    58,
-      59,    10,    28,    46,    33,    47,    65,    32,    60,    49,
-      50,    51,   -42,    32,     8,    48,     1,   -42,    52,     2,
-      53,    19,    20,    41,     2,    15,    17,     9,    42,    26,
-      19,    20,    15,    13,    17,    24,    34,    35,    38,    39,
-      23,    40,    66,    12,    22,    43,     0,    36,     0,     0,
-      37
+      21,    16,    46,     8,    59,    47,    60,     9,    16,    61,
+      62,    28,    66,    33,    67,    10,    48,    13,    32,    63,
+      49,    50,    51,    52,    32,    17,    68,    19,    20,   -44,
+      53,   -44,    54,     1,   -44,     2,    26,    15,     2,    24,
+      41,     2,    34,    17,    15,    42,    19,    20,    69,    70,
+      35,    38,    39,    40,    58,    55,    72,    71,    73,    12,
+      74,    22,    75,    23,     0,     0,     0,     0,    36,     0,
+       0,     0,    43,    37
 };
 
 static const yytype_int8 yycheck[] =
 {
-       8,    13,     5,     9,     6,    11,     8,    15,    11,    11,
-      12,    15,    24,    11,    26,    13,    22,    25,    20,    10,
-      11,    12,     4,    31,    13,    23,     3,     4,    19,    11,
-      21,     6,     7,    13,    11,     8,    16,     0,    18,    14,
-       6,     7,    15,     4,    16,     4,    13,    17,     5,    13,
-      15,    13,     7,     6,    14,    38,    -1,    31,    -1,    -1,
-      31
+      13,     8,    11,    14,     6,    14,     8,     0,    15,    11,
+      12,    24,     9,    26,    11,    16,    25,     4,    25,    21,
+      10,    11,    12,    13,    31,    17,    23,     6,     7,     5,
+      20,     4,    22,     3,     4,    11,    15,     8,    11,     4,
+      14,    11,    14,    17,    15,    19,     6,     7,    25,    26,
+      18,     5,    14,    14,    10,    24,    69,     7,    25,     6,
+      73,    14,    26,    15,    -1,    -1,    -1,    -1,    31,    -1,
+      -1,    -1,    38,    31
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const yytype_uint8 yystos[] =
 {
-       0,     3,    11,    25,    27,    28,    29,    43,    13,     0,
-      15,    31,    28,     4,    26,    27,    43,    16,    32,     6,
-       7,    30,    31,    26,     4,    33,    14,    30,    30,    34,
-      41,    42,    43,    30,    13,    17,    34,    41,     5,    13,
-      13,    13,    18,    32,    35,    36,    11,    13,    23,    10,
-      11,    12,    19,    21,    37,    40,     6,     8,    11,    12,
-      20,    38,    39,     9,    11,    22,     7
+       0,     3,    11,    28,    30,    31,    32,    46,    14,     0,
+      16,    34,    31,     4,    29,    30,    46,    17,    35,     6,
+       7,    33,    34,    29,     4,    36,    15,    33,    33,    37,
+      44,    45,    46,    33,    14,    18,    37,    44,     5,    14,
+      14,    14,    19,    35,    38,    39,    11,    14,    25,    10,
+      11,    12,    13,    20,    22,    24,    40,    43,    10,     6,
+       8,    11,    12,    21,    41,    42,     9,    11,    23,    25,
+      26,     7,    33,    25,    33,    26
 };
 
 #define yyerrok		(yyerrstatus = 0)
@@ -1440,289 +1452,323 @@
   switch (yyn)
     {
         case 2:
-#line 86 "dtc-parser.y"
+#line 90 "dtc-parser.y"
     {
-			the_boot_info = build_boot_info((yyvsp[(3) - (4)].re), (yyvsp[(4) - (4)].node));
+			the_boot_info = build_boot_info((yyvsp[(3) - (4)].re), (yyvsp[(4) - (4)].node), 0);
 		;}
     break;
 
   case 3:
-#line 90 "dtc-parser.y"
+#line 94 "dtc-parser.y"
     {
-			the_boot_info = build_boot_info((yyvsp[(1) - (2)].re), (yyvsp[(2) - (2)].node));
+			the_boot_info = build_boot_info((yyvsp[(1) - (2)].re), (yyvsp[(2) - (2)].node), 0);
 		;}
     break;
 
   case 4:
-#line 97 "dtc-parser.y"
+#line 101 "dtc-parser.y"
     {
 			(yyval.re) = NULL;
 		;}
     break;
 
   case 5:
-#line 101 "dtc-parser.y"
+#line 105 "dtc-parser.y"
     {
 			(yyval.re) = chain_reserve_entry((yyvsp[(1) - (2)].re), (yyvsp[(2) - (2)].re));
 		;}
     break;
 
   case 6:
-#line 108 "dtc-parser.y"
+#line 112 "dtc-parser.y"
     {
 			(yyval.re) = build_reserve_entry((yyvsp[(3) - (5)].addr), (yyvsp[(4) - (5)].addr), (yyvsp[(1) - (5)].labelref));
 		;}
     break;
 
   case 7:
-#line 115 "dtc-parser.y"
+#line 119 "dtc-parser.y"
     {
 			(yyval.re) = NULL;
 		;}
     break;
 
   case 8:
-#line 119 "dtc-parser.y"
+#line 123 "dtc-parser.y"
     {
 			(yyval.re) = chain_reserve_entry((yyvsp[(1) - (2)].re), (yyvsp[(2) - (2)].re));
 		;}
     break;
 
   case 9:
-#line 126 "dtc-parser.y"
+#line 130 "dtc-parser.y"
     {
 			(yyval.re) = (yyvsp[(1) - (1)].re);
 		;}
     break;
 
   case 10:
-#line 130 "dtc-parser.y"
+#line 134 "dtc-parser.y"
     {
 			(yyval.re) = build_reserve_entry((yyvsp[(3) - (6)].addr), (yyvsp[(5) - (6)].addr) - (yyvsp[(3) - (6)].addr) + 1, (yyvsp[(1) - (6)].labelref));
 		;}
     break;
 
   case 11:
-#line 137 "dtc-parser.y"
+#line 141 "dtc-parser.y"
     {
 			(yyval.addr) = eval_literal((yyvsp[(1) - (1)].literal), 0, 64);
 		;}
     break;
 
   case 12:
-#line 141 "dtc-parser.y"
+#line 145 "dtc-parser.y"
     {
 			(yyval.addr) = eval_literal((yyvsp[(1) - (1)].literal), 16, 64);
 		;}
     break;
 
   case 13:
-#line 148 "dtc-parser.y"
+#line 152 "dtc-parser.y"
     {
 			(yyval.node) = name_node((yyvsp[(2) - (2)].node), "", NULL);
 		;}
     break;
 
   case 14:
-#line 155 "dtc-parser.y"
+#line 159 "dtc-parser.y"
     {
 			(yyval.node) = build_node((yyvsp[(2) - (5)].proplist), (yyvsp[(3) - (5)].nodelist));
 		;}
     break;
 
   case 15:
-#line 162 "dtc-parser.y"
+#line 166 "dtc-parser.y"
     {
 			(yyval.proplist) = NULL;
 		;}
     break;
 
   case 16:
-#line 166 "dtc-parser.y"
+#line 170 "dtc-parser.y"
     {
 			(yyval.proplist) = chain_property((yyvsp[(2) - (2)].prop), (yyvsp[(1) - (2)].proplist));
 		;}
     break;
 
   case 17:
-#line 173 "dtc-parser.y"
+#line 177 "dtc-parser.y"
     {
 			(yyval.prop) = build_property((yyvsp[(2) - (5)].propnodename), (yyvsp[(4) - (5)].data), (yyvsp[(1) - (5)].labelref));
 		;}
     break;
 
   case 18:
-#line 177 "dtc-parser.y"
+#line 181 "dtc-parser.y"
     {
 			(yyval.prop) = build_property((yyvsp[(2) - (3)].propnodename), empty_data, (yyvsp[(1) - (3)].labelref));
 		;}
     break;
 
   case 19:
-#line 184 "dtc-parser.y"
+#line 188 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].data));
 		;}
     break;
 
   case 20:
-#line 188 "dtc-parser.y"
+#line 192 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (4)].data), (yyvsp[(3) - (4)].data));
 		;}
     break;
 
   case 21:
-#line 192 "dtc-parser.y"
+#line 196 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (4)].data), (yyvsp[(3) - (4)].data));
 		;}
     break;
 
   case 22:
-#line 196 "dtc-parser.y"
+#line 200 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), REF_PATH, (yyvsp[(2) - (2)].labelref));
 		;}
     break;
 
   case 23:
-#line 200 "dtc-parser.y"
+#line 204 "dtc-parser.y"
     {
-			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file((yyvsp[(4) - (9)].data).val, &path);
+			struct data d = empty_data;
+
+			if ((yyvsp[(6) - (9)].addr) != 0)
+				if (fseek(file->file, (yyvsp[(6) - (9)].addr), SEEK_SET) != 0)
+					yyerrorf("Couldn't seek to offset %llu in \"%s\": %s",
+						 (unsigned long long)(yyvsp[(6) - (9)].addr),
+						 (yyvsp[(4) - (9)].data).val, strerror(errno));
+
+			d = data_copy_file(file->file, (yyvsp[(8) - (9)].addr));
+
+			(yyval.data) = data_merge((yyvsp[(1) - (9)].data), d);
+			dtc_close_file(file);
 		;}
     break;
 
   case 24:
-#line 207 "dtc-parser.y"
+#line 221 "dtc-parser.y"
     {
-			(yyval.data) = empty_data;
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file((yyvsp[(4) - (5)].data).val, &path);
+			struct data d = empty_data;
+
+			d = data_copy_file(file->file, -1);
+
+			(yyval.data) = data_merge((yyvsp[(1) - (5)].data), d);
+			dtc_close_file(file);
 		;}
     break;
 
   case 25:
-#line 211 "dtc-parser.y"
+#line 232 "dtc-parser.y"
     {
-			(yyval.data) = (yyvsp[(1) - (2)].data);
+			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		;}
     break;
 
   case 26:
-#line 215 "dtc-parser.y"
+#line 239 "dtc-parser.y"
     {
-			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
+			(yyval.data) = empty_data;
 		;}
     break;
 
   case 27:
-#line 222 "dtc-parser.y"
+#line 243 "dtc-parser.y"
     {
-			(yyval.data) = empty_data;
+			(yyval.data) = (yyvsp[(1) - (2)].data);
 		;}
     break;
 
   case 28:
-#line 226 "dtc-parser.y"
+#line 247 "dtc-parser.y"
     {
-			(yyval.data) = data_append_cell((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].cell));
+			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		;}
     break;
 
   case 29:
-#line 230 "dtc-parser.y"
+#line 254 "dtc-parser.y"
+    {
+			(yyval.data) = empty_data;
+		;}
+    break;
+
+  case 30:
+#line 258 "dtc-parser.y"
+    {
+			(yyval.data) = data_append_cell((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].cell));
+		;}
+    break;
+
+  case 31:
+#line 262 "dtc-parser.y"
     {
 			(yyval.data) = data_append_cell(data_add_marker((yyvsp[(1) - (2)].data), REF_PHANDLE,
 							      (yyvsp[(2) - (2)].labelref)), -1);
 		;}
     break;
 
-  case 30:
-#line 235 "dtc-parser.y"
+  case 32:
+#line 267 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		;}
     break;
 
-  case 31:
-#line 242 "dtc-parser.y"
+  case 33:
+#line 274 "dtc-parser.y"
     {
 			(yyval.cbase) = 16;
 		;}
     break;
 
-  case 33:
-#line 250 "dtc-parser.y"
+  case 35:
+#line 282 "dtc-parser.y"
     {
 			(yyval.cell) = eval_literal((yyvsp[(1) - (1)].literal), 0, 32);
 		;}
     break;
 
-  case 34:
-#line 254 "dtc-parser.y"
+  case 36:
+#line 286 "dtc-parser.y"
     {
 			(yyval.cell) = eval_literal((yyvsp[(2) - (2)].literal), (yyvsp[(1) - (2)].cbase), 32);
 		;}
     break;
 
-  case 35:
-#line 261 "dtc-parser.y"
+  case 37:
+#line 293 "dtc-parser.y"
     {
 			(yyval.data) = empty_data;
 		;}
     break;
 
-  case 36:
-#line 265 "dtc-parser.y"
+  case 38:
+#line 297 "dtc-parser.y"
     {
 			(yyval.data) = data_append_byte((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].byte));
 		;}
     break;
 
-  case 37:
-#line 269 "dtc-parser.y"
+  case 39:
+#line 301 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		;}
     break;
 
-  case 38:
-#line 276 "dtc-parser.y"
+  case 40:
+#line 308 "dtc-parser.y"
     {
 			(yyval.nodelist) = NULL;
 		;}
     break;
 
-  case 39:
-#line 280 "dtc-parser.y"
+  case 41:
+#line 312 "dtc-parser.y"
     {
 			(yyval.nodelist) = chain_node((yyvsp[(1) - (2)].node), (yyvsp[(2) - (2)].nodelist));
 		;}
     break;
 
-  case 40:
-#line 284 "dtc-parser.y"
+  case 42:
+#line 316 "dtc-parser.y"
     {
-			yyerror("syntax error: properties must precede subnodes\n");
+			yyerror("syntax error: properties must precede subnodes");
 			YYERROR;
 		;}
     break;
 
-  case 41:
-#line 292 "dtc-parser.y"
+  case 43:
+#line 324 "dtc-parser.y"
     {
 			(yyval.node) = name_node((yyvsp[(3) - (3)].node), (yyvsp[(2) - (3)].propnodename), (yyvsp[(1) - (3)].labelref));
 		;}
     break;
 
-  case 42:
-#line 299 "dtc-parser.y"
+  case 44:
+#line 331 "dtc-parser.y"
     {
 			(yyval.labelref) = NULL;
 		;}
     break;
 
-  case 43:
-#line 303 "dtc-parser.y"
+  case 45:
+#line 335 "dtc-parser.y"
     {
 			(yyval.labelref) = (yyvsp[(1) - (1)].labelref);
 		;}
@@ -1730,7 +1776,7 @@
 
 
 /* Line 1267 of yacc.c.  */
-#line 1734 "dtc-parser.tab.c"
+#line 1780 "dtc-parser.tab.c"
       default: break;
     }
   YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
@@ -1950,21 +1996,32 @@
 }
 
 
-#line 308 "dtc-parser.y"
+#line 340 "dtc-parser.y"
 
 
-void yyerror (char const *s)
+void yyerrorf(char const *s, ...)
 {
-	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+	const char *fname = srcpos_file ? srcpos_file->name : "<no-file>";
+	va_list va;
+	va_start(va, s);
 
 	if (strcmp(fname, "-") == 0)
 		fname = "stdin";
 
-	fprintf(stderr, "%s:%d %s\n",
-		fname, yylloc.first_line, s);
+	fprintf(stderr, "%s:%d ", fname, yylloc.first_line);
+	vfprintf(stderr, s, va);
+	fprintf(stderr, "\n");
+
+	treesource_error = 1;
+	va_end(va);
+}
+
+void yyerror (char const *s)
+{
+	yyerrorf("%s", s);
 }
 
-unsigned long long eval_literal(const char *s, int base, int bits)
+static unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
 	char *e;
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped	2008-08-07 12:06:18.000000000 +1000
@@ -48,7 +48,8 @@
      DT_BYTE = 264,
      DT_STRING = 265,
      DT_LABEL = 266,
-     DT_REF = 267
+     DT_REF = 267,
+     DT_INCBIN = 268
    };
 #endif
 /* Tokens.  */
@@ -62,22 +63,23 @@
 #define DT_STRING 265
 #define DT_LABEL 266
 #define DT_REF 267
+#define DT_INCBIN 268
 
 
 
 
 #if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
 typedef union YYSTYPE
-#line 34 "dtc-parser.y"
+#line 37 "dtc-parser.y"
 {
 	char *propnodename;
 	char *literal;
 	char *labelref;
 	unsigned int cbase;
-	u8 byte;
+	uint8_t byte;
 	struct data data;
 
-	u64 addr;
+	uint64_t addr;
 	cell_t cell;
 	struct property *prop;
 	struct property *proplist;
@@ -86,7 +88,7 @@
 	struct reserve_info *re;
 }
 /* Line 1489 of yacc.c.  */
-#line 90 "dtc-parser.tab.h"
+#line 92 "dtc-parser.tab.h"
 	YYSTYPE;
 # define yystype YYSTYPE /* obsolescent; will be withdrawn */
 # define YYSTYPE_IS_DECLARED 1
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.y
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc-parser.y	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc-parser.y	2008-08-07 12:06:18.000000000 +1000
@@ -21,14 +21,17 @@
 %locations
 
 %{
+#include <stdio.h>
+
 #include "dtc.h"
 #include "srcpos.h"
 
-int yylex(void);
-unsigned long long eval_literal(const char *s, int base, int bits);
+extern int yylex(void);
 
 extern struct boot_info *the_boot_info;
+extern int treesource_error;
 
+static unsigned long long eval_literal(const char *s, int base, int bits);
 %}
 
 %union {
@@ -36,10 +39,10 @@
 	char *literal;
 	char *labelref;
 	unsigned int cbase;
-	u8 byte;
+	uint8_t byte;
 	struct data data;
 
-	u64 addr;
+	uint64_t addr;
 	cell_t cell;
 	struct property *prop;
 	struct property *proplist;
@@ -58,6 +61,7 @@
 %token <data> DT_STRING
 %token <labelref> DT_LABEL
 %token <labelref> DT_REF
+%token DT_INCBIN
 
 %type <data> propdata
 %type <data> propdataprefix
@@ -84,11 +88,11 @@
 sourcefile:
 	  DT_V1 ';' memreserves devicetree
 		{
-			the_boot_info = build_boot_info($3, $4);
+			the_boot_info = build_boot_info($3, $4, 0);
 		}
 	| v0_memreserves devicetree
 		{
-			the_boot_info = build_boot_info($1, $2);
+			the_boot_info = build_boot_info($1, $2, 0);
 		}
 	;
 
@@ -196,6 +200,34 @@
 		{
 			$$ = data_add_marker($1, REF_PATH, $2);
 		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ',' addr ',' addr ')'
+		{
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file($4.val, &path);
+			struct data d = empty_data;
+
+			if ($6 != 0)
+				if (fseek(file->file, $6, SEEK_SET) != 0)
+					yyerrorf("Couldn't seek to offset %llu in \"%s\": %s",
+						 (unsigned long long)$6,
+						 $4.val, strerror(errno));
+
+			d = data_copy_file(file->file, $8);
+
+			$$ = data_merge($1, d);
+			dtc_close_file(file);
+		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ')'
+		{
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file($4.val, &path);
+			struct data d = empty_data;
+
+			d = data_copy_file(file->file, -1);
+
+			$$ = data_merge($1, d);
+			dtc_close_file(file);
+		}
 	| propdata DT_LABEL
 		{
 			$$ = data_add_marker($1, LABEL, $2);
@@ -282,7 +314,7 @@
 		}
 	| subnode propdef
 		{
-			yyerror("syntax error: properties must precede subnodes\n");
+			yyerror("syntax error: properties must precede subnodes");
 			YYERROR;
 		}
 	;
@@ -307,18 +339,29 @@
 
 %%
 
-void yyerror (char const *s)
+void yyerrorf(char const *s, ...)
 {
-	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+	const char *fname = srcpos_file ? srcpos_file->name : "<no-file>";
+	va_list va;
+	va_start(va, s);
 
 	if (strcmp(fname, "-") == 0)
 		fname = "stdin";
 
-	fprintf(stderr, "%s:%d %s\n",
-		fname, yylloc.first_line, s);
+	fprintf(stderr, "%s:%d ", fname, yylloc.first_line);
+	vfprintf(stderr, s, va);
+	fprintf(stderr, "\n");
+
+	treesource_error = 1;
+	va_end(va);
+}
+
+void yyerror (char const *s)
+{
+	yyerrorf("%s", s);
 }
 
-unsigned long long eval_literal(const char *s, int base, int bits)
+static unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
 	char *e;
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc.c	2008-08-07 12:06:18.000000000 +1000
@@ -55,7 +55,7 @@
 	return str;
 }
 
-void fill_fullpaths(struct node *tree, const char *prefix)
+static void fill_fullpaths(struct node *tree, const char *prefix)
 {
 	struct node *child;
 	const char *unit;
@@ -106,7 +106,7 @@
 	fprintf(stderr, "\t\tForce - try to produce output even if the input tree has errors\n");
 	fprintf(stderr, "\t-v\n");
 	fprintf(stderr, "\t\tPrint DTC version and exit\n");
-	exit(2);
+	exit(3);
 }
 
 int main(int argc, char *argv[])
@@ -118,10 +118,9 @@
 	int force = 0, check = 0;
 	const char *arg;
 	int opt;
-	FILE *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
-	int boot_cpuid_phys = 0xfeedbeef;
+	long long cmdline_boot_cpuid = -1;
 
 	quiet      = 0;
 	reservenum = 0;
@@ -161,11 +160,11 @@
 			quiet++;
 			break;
 		case 'b':
-			boot_cpuid_phys = strtol(optarg, NULL, 0);
+			cmdline_boot_cpuid = strtoll(optarg, NULL, 0);
 			break;
 		case 'v':
-		    printf("Version: %s\n", DTC_VERSION);
-		    exit(0);
+			printf("Version: %s\n", DTC_VERSION);
+			exit(0);
 		case 'h':
 		default:
 			usage();
@@ -180,31 +179,27 @@
 		arg = argv[optind];
 
 	/* minsize and padsize are mutually exclusive */
-	if ((minsize) && (padsize)) {
+	if (minsize && padsize)
 		die("Can't set both -p and -S\n");
-	}
 
 	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
 		inform, outform, arg);
 
-	if (streq(inform, "dts")) {
+	if (streq(inform, "dts"))
 		bi = dt_from_source(arg);
-	} else if (streq(inform, "fs")) {
+	else if (streq(inform, "fs"))
 		bi = dt_from_fs(arg);
-	} else if(streq(inform, "dtb")) {
-		inf = dtc_open_file(arg);
-		bi = dt_from_blob(inf);
-	} else {
+	else if(streq(inform, "dtb"))
+		bi = dt_from_blob(arg);
+	else
 		die("Unknown input format \"%s\"\n", inform);
-	}
 
-	if (inf && (inf != stdin))
-		fclose(inf);
+	if (cmdline_boot_cpuid != -1)
+		bi->boot_cpuid_phys = cmdline_boot_cpuid;
 
-	if (! bi || ! bi->dt)
-		die("Couldn't read input tree\n");
+	fill_fullpaths(bi->dt, "");
+	process_checks(force, bi);
 
-	process_checks(force, bi, check, outversion, boot_cpuid_phys);
 
 	if (streq(outname, "-")) {
 		outf = stdout;
@@ -218,9 +213,9 @@
 	if (streq(outform, "dts")) {
 		dt_to_source(outf, bi);
 	} else if (streq(outform, "dtb")) {
-		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
+		dt_to_blob(outf, bi, outversion);
 	} else if (streq(outform, "asm")) {
-		dt_to_asm(outf, bi, outversion, boot_cpuid_phys);
+		dt_to_asm(outf, bi, outversion);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
Index: working-2.6/arch/powerpc/boot/dtc-src/dtc.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/dtc.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/dtc.h	2008-08-07 12:06:18.000000000 +1000
@@ -30,10 +30,8 @@
 #include <ctype.h>
 #include <errno.h>
 #include <unistd.h>
-#include <netinet/in.h>
-#include <endian.h>
-#include <byteswap.h>
 
+#include <libfdt_env.h>
 #include <fdt.h>
 
 #define DEFAULT_FDT_VERSION	17
@@ -75,25 +73,8 @@
 	return new;
 }
 
-typedef uint8_t u8;
-typedef uint16_t u16;
-typedef uint32_t u32;
-typedef uint64_t u64;
-typedef u32 cell_t;
-
-#define cpu_to_be16(x)	htons(x)
-#define be16_to_cpu(x)	ntohs(x)
-
-#define cpu_to_be32(x)	htonl(x)
-#define be32_to_cpu(x)	ntohl(x)
-
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define cpu_to_be64(x)	(x)
-#define be64_to_cpu(x)	(x)
-#else
-#define cpu_to_be64(x)	bswap_64(x)
-#define be64_to_cpu(x)	bswap_64(x)
-#endif
+typedef uint32_t cell_t;
+
 
 #define streq(a, b)	(strcmp((a), (b)) == 0)
 #define strneq(a, b, n)	(strncmp((a), (b), (n)) == 0)
@@ -118,7 +99,6 @@
 struct data {
 	int len;
 	char *val;
-	int asize;
 	struct marker *markers;
 };
 
@@ -145,7 +125,7 @@
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
 struct data data_append_re(struct data d, const struct fdt_reserve_entry *re);
-struct data data_append_addr(struct data d, u64 addr);
+struct data data_append_addr(struct data d, uint64_t addr);
 struct data data_append_byte(struct data d, uint8_t byte);
 struct data data_append_zeroes(struct data d, int len);
 struct data data_append_align(struct data d, int align);
@@ -223,7 +203,7 @@
 	char *label;
 };
 
-struct reserve_info *build_reserve_entry(u64 start, u64 len, char *label);
+struct reserve_info *build_reserve_entry(uint64_t start, uint64_t len, char *label);
 struct reserve_info *chain_reserve_entry(struct reserve_info *first,
 					 struct reserve_info *list);
 struct reserve_info *add_reserve_entry(struct reserve_info *list,
@@ -233,24 +213,22 @@
 struct boot_info {
 	struct reserve_info *reservelist;
 	struct node *dt;		/* the device tree */
+	uint32_t boot_cpuid_phys;
 };
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree);
+				  struct node *tree, uint32_t boot_cpuid_phys);
 
 /* Checks */
 
-void process_checks(int force, struct boot_info *bi,
-		    int checkflag, int outversion, int boot_cpuid_phys);
+void process_checks(int force, struct boot_info *bi);
 
 /* Flattened trees */
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version,
-		int boot_cpuid_phys);
-void dt_to_asm(FILE *f, struct boot_info *bi, int version,
-	       int boot_cpuid_phys);
+void dt_to_blob(FILE *f, struct boot_info *bi, int version);
+void dt_to_asm(FILE *f, struct boot_info *bi, int version);
 
-struct boot_info *dt_from_blob(FILE *f);
+struct boot_info *dt_from_blob(const char *fname);
 
 /* Tree source */
 
@@ -264,6 +242,5 @@
 /* misc */
 
 char *join_path(const char *path, const char *name);
-void fill_fullpaths(struct node *tree, const char *prefix);
 
 #endif /* _DTC_H */
Index: working-2.6/arch/powerpc/boot/dtc-src/flattree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/flattree.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/flattree.c	2008-08-07 12:06:18.000000000 +1000
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 #define FTF_FULLPATH	0x1
 #define FTF_VARALIGN	0x2
@@ -162,28 +163,18 @@
 {
 	FILE *f = e;
 	int off = 0;
-	struct marker *m;
+	struct marker *m = d.markers;
 
-	m = d.markers;
-	while (m) {
-		if (m->type == LABEL)
-			emit_offset_label(f, m->ref, m->offset);
-		m = m->next;
-	}
+	for_each_marker_of_type(m, LABEL)
+		emit_offset_label(f, m->ref, m->offset);
 
-	while ((d.len - off) >= sizeof(u32)) {
+	while ((d.len - off) >= sizeof(uint32_t)) {
 		fprintf(f, "\t.long\t0x%x\n",
-			be32_to_cpu(*((u32 *)(d.val+off))));
-		off += sizeof(u32);
-	}
-
-	if ((d.len - off) >= sizeof(u16)) {
-		fprintf(f, "\t.short\t0x%hx\n",
-			be16_to_cpu(*((u16 *)(d.val+off))));
-		off += sizeof(u16);
+			fdt32_to_cpu(*((uint32_t *)(d.val+off))));
+		off += sizeof(uint32_t);
 	}
 
-	if ((d.len - off) >= 1) {
+	while ((d.len - off) >= 1) {
 		fprintf(f, "\t.byte\t0x%hhx\n", d.val[off]);
 		off += 1;
 	}
@@ -336,29 +327,28 @@
 
 	memset(fdt, 0xff, sizeof(*fdt));
 
-	fdt->magic = cpu_to_be32(FDT_MAGIC);
-	fdt->version = cpu_to_be32(vi->version);
-	fdt->last_comp_version = cpu_to_be32(vi->last_comp_version);
+	fdt->magic = cpu_to_fdt32(FDT_MAGIC);
+	fdt->version = cpu_to_fdt32(vi->version);
+	fdt->last_comp_version = cpu_to_fdt32(vi->last_comp_version);
 
 	/* Reserve map should be doubleword aligned */
 	reserve_off = ALIGN(vi->hdr_size, 8);
 
-	fdt->off_mem_rsvmap = cpu_to_be32(reserve_off);
-	fdt->off_dt_struct = cpu_to_be32(reserve_off + reservesize);
-	fdt->off_dt_strings = cpu_to_be32(reserve_off + reservesize
+	fdt->off_mem_rsvmap = cpu_to_fdt32(reserve_off);
+	fdt->off_dt_struct = cpu_to_fdt32(reserve_off + reservesize);
+	fdt->off_dt_strings = cpu_to_fdt32(reserve_off + reservesize
 					  + dtsize);
-	fdt->totalsize = cpu_to_be32(reserve_off + reservesize + dtsize + strsize);
+	fdt->totalsize = cpu_to_fdt32(reserve_off + reservesize + dtsize + strsize);
 
 	if (vi->flags & FTF_BOOTCPUID)
-		fdt->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
+		fdt->boot_cpuid_phys = cpu_to_fdt32(boot_cpuid_phys);
 	if (vi->flags & FTF_STRTABSIZE)
-		fdt->size_dt_strings = cpu_to_be32(strsize);
+		fdt->size_dt_strings = cpu_to_fdt32(strsize);
 	if (vi->flags & FTF_STRUCTSIZE)
-		fdt->size_dt_struct = cpu_to_be32(dtsize);
+		fdt->size_dt_struct = cpu_to_fdt32(dtsize);
 }
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version,
-		int boot_cpuid_phys)
+void dt_to_blob(FILE *f, struct boot_info *bi, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -383,26 +373,26 @@
 
 	/* Make header */
 	make_fdt_header(&fdt, vi, reservebuf.len, dtbuf.len, strbuf.len,
-			boot_cpuid_phys);
+			bi->boot_cpuid_phys);
 
 	/*
 	 * If the user asked for more space than is used, adjust the totalsize.
 	 */
 	if (minsize > 0) {
-		padlen = minsize - be32_to_cpu(fdt.totalsize);
+		padlen = minsize - fdt32_to_cpu(fdt.totalsize);
 		if ((padlen < 0) && (quiet < 1))
 			fprintf(stderr,
 				"Warning: blob size %d >= minimum size %d\n",
-				be32_to_cpu(fdt.totalsize), minsize);
+				fdt32_to_cpu(fdt.totalsize), minsize);
 	}
 
 	if (padsize > 0)
 		padlen = padsize;
 
 	if (padlen > 0) {
-		int tsize = be32_to_cpu(fdt.totalsize);
+		int tsize = fdt32_to_cpu(fdt.totalsize);
 		tsize += padlen;
-		fdt.totalsize = cpu_to_be32(tsize);
+		fdt.totalsize = cpu_to_fdt32(tsize);
 	}
 
 	/*
@@ -410,7 +400,7 @@
 	 * the reserve buffer, add the reserve map terminating zeroes,
 	 * the device tree itself, and finally the strings.
 	 */
-	blob = data_append_data(blob, &fdt, sizeof(fdt));
+	blob = data_append_data(blob, &fdt, vi->hdr_size);
 	blob = data_append_align(blob, 8);
 	blob = data_merge(blob, reservebuf);
 	blob = data_append_zeroes(blob, sizeof(struct fdt_reserve_entry));
@@ -449,7 +439,7 @@
 	}
 }
 
-void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
+void dt_to_asm(FILE *f, struct boot_info *bi, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -489,7 +479,7 @@
 
 	if (vi->flags & FTF_BOOTCPUID)
 		fprintf(f, "\t.long\t%i\t\t\t\t\t/* boot_cpuid_phys */\n",
-			boot_cpuid_phys);
+			bi->boot_cpuid_phys);
 
 	if (vi->flags & FTF_STRTABSIZE)
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
@@ -579,15 +569,15 @@
 	inb->ptr += len;
 }
 
-static u32 flat_read_word(struct inbuf *inb)
+static uint32_t flat_read_word(struct inbuf *inb)
 {
-	u32 val;
+	uint32_t val;
 
 	assert(((inb->ptr - inb->base) % sizeof(val)) == 0);
 
 	flat_read_chunk(inb, &val, sizeof(val));
 
-	return be32_to_cpu(val);
+	return fdt32_to_cpu(val);
 }
 
 static void flat_realign(struct inbuf *inb, int align)
@@ -615,7 +605,7 @@
 
 	inb->ptr += len;
 
-	flat_realign(inb, sizeof(u32));
+	flat_realign(inb, sizeof(uint32_t));
 
 	return str;
 }
@@ -632,7 +622,7 @@
 
 	flat_read_chunk(inb, d.val, len);
 
-	flat_realign(inb, sizeof(u32));
+	flat_realign(inb, sizeof(uint32_t));
 
 	return d;
 }
@@ -659,7 +649,7 @@
 static struct property *flat_read_property(struct inbuf *dtbuf,
 					   struct inbuf *strbuf, int flags)
 {
-	u32 proplen, stroff;
+	uint32_t proplen, stroff;
 	char *name;
 	struct data val;
 
@@ -693,8 +683,8 @@
 	p = inb->ptr;
 	while (1) {
 		flat_read_chunk(inb, &re, sizeof(re));
-		re.address  = be64_to_cpu(re.address);
-		re.size = be64_to_cpu(re.size);
+		re.address  = fdt64_to_cpu(re.address);
+		re.size = fdt64_to_cpu(re.size);
 		if (re.size == 0)
 			break;
 
@@ -708,77 +698,37 @@
 
 static char *nodename_from_path(const char *ppath, const char *cpath)
 {
-	const char *lslash;
 	int plen;
 
-	lslash = strrchr(cpath, '/');
-	if (! lslash)
-		return NULL;
-
-	plen = lslash - cpath;
-
-	if (streq(cpath, "/") && streq(ppath, ""))
-		return "";
-
-	if ((plen == 0) && streq(ppath, "/"))
-		return strdup(lslash+1);
-
-	if (! strneq(ppath, cpath, plen))
-		return NULL;
-
-	return strdup(lslash+1);
-}
-
-static const char PROPCHAR[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,._+*#?-";
-static const char UNITCHAR[] = "0123456789abcdef,";
-
-static int check_node_name(const char *name)
-{
-	const char *atpos;
-	int basenamelen;
-
-	atpos = strrchr(name, '@');
-
-	if (atpos)
-		basenamelen = atpos - name;
-	else
-		basenamelen = strlen(name);
+	plen = strlen(ppath);
 
-	if (strspn(name, PROPCHAR) < basenamelen)
-		return -1;
+	if (!strneq(ppath, cpath, plen))
+		die("Path \"%s\" is not valid as a child of \"%s\"\n",
+		    cpath, ppath);
 
-	if (atpos
-	    && ((basenamelen + 1 + strspn(atpos+1, UNITCHAR)) < strlen(name)))
-		return -1;
+	/* root node is a special case */
+	if (!streq(ppath, "/"))
+		plen++;
 
-	return basenamelen;
+	return strdup(cpath + plen);
 }
 
 static struct node *unflatten_tree(struct inbuf *dtbuf,
 				   struct inbuf *strbuf,
-				   const char *parent_path, int flags)
+				   const char *parent_flatname, int flags)
 {
 	struct node *node;
-	u32 val;
+	char *flatname;
+	uint32_t val;
 
 	node = build_node(NULL, NULL);
 
-	if (flags & FTF_FULLPATH) {
-		node->fullpath = flat_read_string(dtbuf);
-		node->name = nodename_from_path(parent_path, node->fullpath);
-
-		if (! node->name)
-			die("Path \"%s\" is not valid as a child of \"%s\"\n",
-			    node->fullpath, parent_path);
-	} else {
-		node->name = flat_read_string(dtbuf);
-		node->fullpath = join_path(parent_path, node->name);
-	}
+	flatname = flat_read_string(dtbuf);
 
-	node->basenamelen = check_node_name(node->name);
-	if (node->basenamelen < 0) {
-		fprintf(stderr, "Warning \"%s\" has incorrect format\n", node->name);
-	}
+	if (flags & FTF_FULLPATH)
+		node->name = nodename_from_path(parent_flatname, flatname);
+	else
+		node->name = flatname;
 
 	do {
 		struct property *prop;
@@ -795,8 +745,7 @@
 			break;
 
 		case FDT_BEGIN_NODE:
-			child = unflatten_tree(dtbuf,strbuf, node->fullpath,
-					       flags);
+			child = unflatten_tree(dtbuf,strbuf, flatname, flags);
 			add_child(node, child);
 			break;
 
@@ -825,10 +774,11 @@
 }
 
 
-struct boot_info *dt_from_blob(FILE *f)
+struct boot_info *dt_from_blob(const char *fname)
 {
-	u32 magic, totalsize, version, size_str, size_dt;
-	u32 off_dt, off_str, off_mem_rsvmap;
+	struct dtc_file *dtcf;
+	uint32_t magic, totalsize, version, size_dt, boot_cpuid_phys;
+	uint32_t off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
 	struct fdt_header *fdt;
@@ -838,54 +788,56 @@
 	int sizeleft;
 	struct reserve_info *reservelist;
 	struct node *tree;
-	u32 val;
+	uint32_t val;
 	int flags = 0;
 
-	rc = fread(&magic, sizeof(magic), 1, f);
-	if (ferror(f))
+	dtcf = dtc_open_file(fname, NULL);
+
+	rc = fread(&magic, sizeof(magic), 1, dtcf->file);
+	if (ferror(dtcf->file))
 		die("Error reading DT blob magic number: %s\n",
 		    strerror(errno));
 	if (rc < 1) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF reading DT blob magic number\n");
 		else
 			die("Mysterious short read reading magic number\n");
 	}
 
-	magic = be32_to_cpu(magic);
+	magic = fdt32_to_cpu(magic);
 	if (magic != FDT_MAGIC)
 		die("Blob has incorrect magic number\n");
 
-	rc = fread(&totalsize, sizeof(totalsize), 1, f);
-	if (ferror(f))
+	rc = fread(&totalsize, sizeof(totalsize), 1, dtcf->file);
+	if (ferror(dtcf->file))
 		die("Error reading DT blob size: %s\n", strerror(errno));
 	if (rc < 1) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF reading DT blob size\n");
 		else
 			die("Mysterious short read reading blob size\n");
 	}
 
-	totalsize = be32_to_cpu(totalsize);
+	totalsize = fdt32_to_cpu(totalsize);
 	if (totalsize < FDT_V1_SIZE)
 		die("DT blob size (%d) is too small\n", totalsize);
 
 	blob = xmalloc(totalsize);
 
 	fdt = (struct fdt_header *)blob;
-	fdt->magic = cpu_to_be32(magic);
-	fdt->totalsize = cpu_to_be32(totalsize);
+	fdt->magic = cpu_to_fdt32(magic);
+	fdt->totalsize = cpu_to_fdt32(totalsize);
 
 	sizeleft = totalsize - sizeof(magic) - sizeof(totalsize);
 	p = blob + sizeof(magic)  + sizeof(totalsize);
 
 	while (sizeleft) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF before reading %d bytes of DT blob\n",
 			    totalsize);
 
-		rc = fread(p, 1, sizeleft, f);
-		if (ferror(f))
+		rc = fread(p, 1, sizeleft, dtcf->file);
+		if (ferror(dtcf->file))
 			die("Error reading DT blob: %s\n",
 			    strerror(errno));
 
@@ -893,19 +845,11 @@
 		p += rc;
 	}
 
-	off_dt = be32_to_cpu(fdt->off_dt_struct);
-	off_str = be32_to_cpu(fdt->off_dt_strings);
-	off_mem_rsvmap = be32_to_cpu(fdt->off_mem_rsvmap);
-	version = be32_to_cpu(fdt->version);
-
-	fprintf(stderr, "\tmagic:\t\t\t0x%x\n", magic);
-	fprintf(stderr, "\ttotalsize:\t\t%d\n", totalsize);
-	fprintf(stderr, "\toff_dt_struct:\t\t0x%x\n", off_dt);
-	fprintf(stderr, "\toff_dt_strings:\t\t0x%x\n", off_str);
-	fprintf(stderr, "\toff_mem_rsvmap:\t\t0x%x\n", off_mem_rsvmap);
-	fprintf(stderr, "\tversion:\t\t0x%x\n", version );
-	fprintf(stderr, "\tlast_comp_version:\t0x%x\n",
-		be32_to_cpu(fdt->last_comp_version));
+	off_dt = fdt32_to_cpu(fdt->off_dt_struct);
+	off_str = fdt32_to_cpu(fdt->off_dt_strings);
+	off_mem_rsvmap = fdt32_to_cpu(fdt->off_mem_rsvmap);
+	version = fdt32_to_cpu(fdt->version);
+	boot_cpuid_phys = fdt32_to_cpu(fdt->boot_cpuid_phys);
 
 	if (off_mem_rsvmap >= totalsize)
 		die("Mem Reserve structure offset exceeds total size\n");
@@ -916,21 +860,17 @@
 	if (off_str > totalsize)
 		die("String table offset exceeds total size\n");
 
-	if (version >= 2)
-		fprintf(stderr, "\tboot_cpuid_phys:\t0x%x\n",
-			be32_to_cpu(fdt->boot_cpuid_phys));
-
-	size_str = -1;
 	if (version >= 3) {
-		size_str = be32_to_cpu(fdt->size_dt_strings);
-		fprintf(stderr, "\tsize_dt_strings:\t%d\n", size_str);
+		uint32_t size_str = fdt32_to_cpu(fdt->size_dt_strings);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
+		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
+	} else {
+		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 	}
 
 	if (version >= 17) {
-		size_dt = be32_to_cpu(fdt->size_dt_struct);
-		fprintf(stderr, "\tsize_dt_struct:\t\t%d\n", size_dt);
+		size_dt = fdt32_to_cpu(fdt->size_dt_struct);
 		if (off_dt+size_dt > totalsize)
 			die("Structure block extends past total size\n");
 	}
@@ -944,10 +884,6 @@
 	inbuf_init(&memresvbuf,
 		   blob + off_mem_rsvmap, blob + totalsize);
 	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
-	if (size_str >= 0)
-		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
-	else
-		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 
 	reservelist = flat_read_mem_reserve(&memresvbuf);
 
@@ -964,5 +900,7 @@
 
 	free(blob);
 
-	return build_boot_info(reservelist, tree);
+	dtc_close_file(dtcf);
+
+	return build_boot_info(reservelist, tree, boot_cpuid_phys);
 }
Index: working-2.6/arch/powerpc/boot/dtc-src/fstree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/fstree.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/fstree.c	2008-08-07 12:06:18.000000000 +1000
@@ -31,8 +31,8 @@
 	struct node *tree;
 
 	d = opendir(dirname);
-	if (! d)
-		die("opendir(): %s\n", strerror(errno));
+	if (!d)
+		die("Couldn't opendir() \"%s\": %s\n", dirname, strerror(errno));
 
 	tree = build_node(NULL, NULL);
 
@@ -87,8 +87,6 @@
 	tree = read_fstree(dirname);
 	tree = name_node(tree, "", NULL);
 
-	fill_fullpaths(tree, "");
-
-	return build_boot_info(NULL, tree);
+	return build_boot_info(NULL, tree, 0);
 }
 
Index: working-2.6/arch/powerpc/boot/dtc-src/livetree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/livetree.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/livetree.c	2008-08-07 12:06:18.000000000 +1000
@@ -115,6 +115,7 @@
 	struct node **p;
 
 	child->next_sibling = NULL;
+	child->parent = parent;
 
 	p = &parent->children;
 	while (*p)
@@ -123,7 +124,8 @@
 	*p = child;
 }
 
-struct reserve_info *build_reserve_entry(u64 address, u64 size, char *label)
+struct reserve_info *build_reserve_entry(uint64_t address, uint64_t size,
+					 char *label)
 {
 	struct reserve_info *new = xmalloc(sizeof(*new));
 
@@ -165,13 +167,14 @@
 }
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree)
+				  struct node *tree, uint32_t boot_cpuid_phys)
 {
 	struct boot_info *bi;
 
 	bi = xmalloc(sizeof(*bi));
 	bi->reservelist = reservelist;
 	bi->dt = tree;
+	bi->boot_cpuid_phys = boot_cpuid_phys;
 
 	return bi;
 }
@@ -202,7 +205,7 @@
 cell_t propval_cell(struct property *prop)
 {
 	assert(prop->val.len == sizeof(cell_t));
-	return be32_to_cpu(*((cell_t *)prop->val.val));
+	return fdt32_to_cpu(*((cell_t *)prop->val.val));
 }
 
 struct node *get_subnode(struct node *node, const char *nodename)
Index: working-2.6/arch/powerpc/boot/dtc-src/srcpos.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/srcpos.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/srcpos.c	2008-08-07 12:06:18.000000000 +1000
@@ -20,86 +20,97 @@
 #include "dtc.h"
 #include "srcpos.h"
 
-
-/*
- * Record the complete unique set of opened file names.
- * Primarily used to cache source position file names.
- */
-#define MAX_N_FILE_NAMES	(100)
-
-const char *file_names[MAX_N_FILE_NAMES];
-static int n_file_names = 0;
-
 /*
  * Like yylineno, this is the current open file pos.
  */
 
-int srcpos_filenum = -1;
-
+struct dtc_file *srcpos_file;
 
-
-FILE *dtc_open_file(const char *fname)
+static int dtc_open_one(struct dtc_file *file,
+                        const char *search,
+                        const char *fname)
 {
-	FILE *f;
+	char *fullname;
 
-	if (lookup_file_name(fname, 1) < 0)
-		die("Too many files opened\n");
+	if (search) {
+		fullname = xmalloc(strlen(search) + strlen(fname) + 2);
 
-	if (streq(fname, "-"))
-		f = stdin;
-	else
-		f = fopen(fname, "r");
+		strcpy(fullname, search);
+		strcat(fullname, "/");
+		strcat(fullname, fname);
+	} else {
+		fullname = strdup(fname);
+	}
 
-	if (! f)
-		die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
+	file->file = fopen(fullname, "r");
+	if (!file->file) {
+		free(fullname);
+		return 0;
+	}
 
-	return f;
+	file->name = fullname;
+	return 1;
 }
 
 
+struct dtc_file *dtc_open_file(const char *fname,
+                               const struct search_path *search)
+{
+	static const struct search_path default_search = { NULL, NULL, NULL };
 
-/*
- * Locate and optionally add filename fname in the file_names[] array.
- *
- * If the filename is currently not in the array and the boolean
- * add_it is non-zero, an attempt to add the filename will be made.
- *
- * Returns;
- *    Index [0..MAX_N_FILE_NAMES) where the filename is kept
- *    -1 if the name can not be recorded
- */
+	struct dtc_file *file;
+	const char *slash;
 
-int lookup_file_name(const char *fname, int add_it)
-{
-	int i;
+	file = xmalloc(sizeof(struct dtc_file));
 
-	for (i = 0; i < n_file_names; i++) {
-		if (strcmp(file_names[i], fname) == 0)
-			return i;
+	slash = strrchr(fname, '/');
+	if (slash) {
+		char *dir = xmalloc(slash - fname + 1);
+
+		memcpy(dir, fname, slash - fname);
+		dir[slash - fname] = 0;
+		file->dir = dir;
+	} else {
+		file->dir = NULL;
 	}
 
-	if (add_it) {
-		if (n_file_names < MAX_N_FILE_NAMES) {
-			file_names[n_file_names] = strdup(fname);
-			return n_file_names++;
-		}
+	if (streq(fname, "-")) {
+		file->name = "stdin";
+		file->file = stdin;
+		return file;
 	}
 
-	return -1;
-}
+	if (fname[0] == '/') {
+		file->file = fopen(fname, "r");
+		if (!file->file)
+			goto fail;
 
+		file->name = strdup(fname);
+		return file;
+	}
 
-const char *srcpos_filename_for_num(int filenum)
-{
-	if (0 <= filenum && filenum < n_file_names) {
-		return file_names[filenum];
+	if (!search)
+		search = &default_search;
+
+	while (search) {
+		if (dtc_open_one(file, search->dir, fname))
+			return file;
+
+		if (errno != ENOENT)
+			goto fail;
+
+		search = search->next;
 	}
 
-	return 0;
+fail:
+	die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
 }
 
-
-const char *srcpos_get_filename(void)
+void dtc_close_file(struct dtc_file *file)
 {
-	return srcpos_filename_for_num(srcpos_filenum);
+	if (fclose(file->file))
+		die("Error closing \"%s\": %s\n", file->name, strerror(errno));
+
+	free(file->dir);
+	free(file);
 }
Index: working-2.6/arch/powerpc/boot/dtc-src/srcpos.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/srcpos.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/srcpos.h	2008-08-07 12:06:18.000000000 +1000
@@ -22,13 +22,21 @@
  * array of all opened filenames.
  */
 
+#include <stdio.h>
+
+struct dtc_file {
+	char *dir;
+	const char *name;
+	FILE *file;
+};
+
 #if ! defined(YYLTYPE) && ! defined(YYLTYPE_IS_DECLARED)
 typedef struct YYLTYPE {
     int first_line;
     int first_column;
     int last_line;
     int last_column;
-    int filenum;
+    struct dtc_file *file;
 } YYLTYPE;
 
 #define YYLTYPE_IS_DECLARED	1
@@ -48,7 +56,7 @@
 	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
 	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
 	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
-	  (Current).filenum      = YYRHSLOC (Rhs, N).filenum;		\
+	  (Current).file         = YYRHSLOC (Rhs, N).file;		\
 	}								\
       else								\
 	{								\
@@ -56,20 +64,22 @@
 	    YYRHSLOC (Rhs, 0).last_line;				\
 	  (Current).first_column = (Current).last_column =		\
 	    YYRHSLOC (Rhs, 0).last_column;				\
-	  (Current).filenum      = YYRHSLOC (Rhs, 0).filenum;		\
+	  (Current).file         = YYRHSLOC (Rhs, 0).file;		\
 	}								\
     while (YYID (0))
 
 
 
 extern void yyerror(char const *);
+extern void yyerrorf(char const *, ...) __attribute__((format(printf, 1, 2)));
 
-extern int srcpos_filenum;
-
-extern int push_input_file(const char *filename);
-extern int pop_input_file(void);
+extern struct dtc_file *srcpos_file;
 
-extern FILE *dtc_open_file(const char *fname);
-extern int lookup_file_name(const char *fname, int add_it);
-extern const char *srcpos_filename_for_num(int filenum);
-const char *srcpos_get_filename(void);
+struct search_path {
+	const char *dir; /* NULL for current directory */
+	struct search_path *prev, *next;
+};
+
+extern struct dtc_file *dtc_open_file(const char *fname,
+                                      const struct search_path *search);
+extern void dtc_close_file(struct dtc_file *file);
Index: working-2.6/arch/powerpc/boot/dtc-src/treesource.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/treesource.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/treesource.c	2008-08-07 12:06:18.000000000 +1000
@@ -23,20 +23,23 @@
 
 extern FILE *yyin;
 extern int yyparse(void);
-extern void yyerror(char const *);
 
 struct boot_info *the_boot_info;
+int treesource_error;
 
 struct boot_info *dt_from_source(const char *fname)
 {
 	the_boot_info = NULL;
+	treesource_error = 0;
 
-	push_input_file(fname);
+	srcpos_file = dtc_open_file(fname, NULL);
+	yyin = srcpos_file->file;
 
 	if (yyparse() != 0)
-		return NULL;
+		die("Unable to parse input tree\n");
 
-	fill_fullpaths(the_boot_info->dt, "");
+	if (treesource_error)
+		die("Syntax error parsing input tree\n");
 
 	return the_boot_info;
 }
@@ -144,7 +147,7 @@
 			m = m->next;
 		}
 
-		fprintf(f, "0x%x", be32_to_cpu(*cp++));
+		fprintf(f, "0x%x", fdt32_to_cpu(*cp++));
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
@@ -173,7 +176,7 @@
 		}
 
 		fprintf(f, "%02hhx", *bp++);
-		if ((void *)bp >= propend)
+		if ((const void *)bp >= propend)
 			break;
 		fprintf(f, " ");
 	}
Index: working-2.6/arch/powerpc/boot/dtc-src/version_gen.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dtc-src/version_gen.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dtc-src/version_gen.h	2008-08-07 12:06:18.000000000 +1000
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.0.0-gd6f9b62f"
+#define DTC_VERSION "DTC 1.2.0"
Index: working-2.6/arch/powerpc/boot/libfdt/Makefile.libfdt
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/Makefile.libfdt	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/Makefile.libfdt	2008-08-07 12:06:18.000000000 +1000
@@ -3,12 +3,6 @@
 # This is not a complete Makefile of itself.  Instead, it is designed to
 # be easily embeddable into other systems of Makefiles.
 #
-LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_INCLUDES = fdt.h libfdt.h
-LIBFDT_EXTRA = libfdt_internal.h
-LIBFDT_LIB = libfdt/libfdt.a
-
+LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
-
-$(LIBFDT_objdir)/$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
-
Index: working-2.6/arch/powerpc/boot/libfdt/fdt.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt.c	2008-08-07 12:06:18.000000000 +1000
@@ -63,7 +63,7 @@
 			return -FDT_ERR_BADVERSION;
 		if (fdt_last_comp_version(fdt) > FDT_LAST_SUPPORTED_VERSION)
 			return -FDT_ERR_BADVERSION;
-	} else if (fdt_magic(fdt) == SW_MAGIC) {
+	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
 		/* Unfinished sequential-write blob */
 		if (fdt_size_dt_struct(fdt) == 0)
 			return -FDT_ERR_BADSTATE;
@@ -76,7 +76,7 @@
 
 const void *fdt_offset_ptr(const void *fdt, int offset, int len)
 {
-	const void *p;
+	const char *p;
 
 	if (fdt_version(fdt) >= 0x11)
 		if (((offset + len) < offset)
@@ -124,11 +124,59 @@
 	}
 
 	if (nextoffset)
-		*nextoffset = ALIGN(offset, FDT_TAGSIZE);
+		*nextoffset = FDT_TAGALIGN(offset);
 
 	return tag;
 }
 
+int _fdt_check_node_offset(const void *fdt, int offset)
+{
+	if ((offset < 0) || (offset % FDT_TAGSIZE)
+	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
+		return -FDT_ERR_BADOFFSET;
+
+	return offset;
+}
+
+int fdt_next_node(const void *fdt, int offset, int *depth)
+{
+	int nextoffset = 0;
+	uint32_t tag;
+
+	if (offset >= 0)
+		if ((nextoffset = _fdt_check_node_offset(fdt, offset)) < 0)
+			return nextoffset;
+
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_PROP:
+		case FDT_NOP:
+			break;
+
+		case FDT_BEGIN_NODE:
+			if (depth)
+				(*depth)++;
+			break;
+
+		case FDT_END_NODE:
+			if (depth)
+				(*depth)--;
+			break;
+
+		case FDT_END:
+			return -FDT_ERR_NOTFOUND;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	} while (tag != FDT_BEGIN_NODE);
+
+	return offset;
+}
+
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s)
 {
 	int len = strlen(s) + 1;
@@ -136,17 +184,14 @@
 	const char *p;
 
 	for (p = strtab; p <= last; p++)
-		if (memeq(p, s, len))
+		if (memcmp(p, s, len) == 0)
 			return p;
 	return NULL;
 }
 
 int fdt_move(const void *fdt, void *buf, int bufsize)
 {
-	int err = fdt_check_header(fdt);
-
-	if (err)
-		return err;
+	FDT_CHECK_HEADER(fdt);
 
 	if (fdt_totalsize(fdt) > bufsize)
 		return -FDT_ERR_NOSPACE;
Index: working-2.6/arch/powerpc/boot/libfdt/fdt_ro.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_ro.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_ro.c	2008-08-07 12:06:18.000000000 +1000
@@ -55,17 +55,10 @@
 
 #include "libfdt_internal.h"
 
-#define CHECK_HEADER(fdt) \
-	{ \
-		int err; \
-		if ((err = fdt_check_header(fdt)) != 0) \
-			return err; \
-	}
-
-static int nodename_eq(const void *fdt, int offset,
-		       const char *s, int len)
+static int _fdt_nodename_eq(const void *fdt, int offset,
+			    const char *s, int len)
 {
-	const char *p = fdt_offset_ptr(fdt, offset, len+1);
+	const char *p = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, len+1);
 
 	if (! p)
 		/* short match */
@@ -84,12 +77,12 @@
 
 const char *fdt_string(const void *fdt, int stroffset)
 {
-	return (char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
+	return (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
 
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 {
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 	*address = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->address);
 	*size = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->size);
 	return 0;
@@ -104,50 +97,24 @@
 	return i;
 }
 
-int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
+int fdt_subnode_offset_namelen(const void *fdt, int offset,
 			       const char *name, int namelen)
 {
-	int level = 0;
-	uint32_t tag;
-	int offset, nextoffset;
-
-	CHECK_HEADER(fdt);
-
-	tag = fdt_next_tag(fdt, parentoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADOFFSET;
-
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_TRUNCATED;
-
-		case FDT_BEGIN_NODE:
-			level++;
-			if (level != 1)
-				continue;
-			if (nodename_eq(fdt, offset+FDT_TAGSIZE, name, namelen))
-				/* Found it! */
-				return offset;
-			break;
-
-		case FDT_END_NODE:
-			level--;
-			break;
+	int depth;
 
-		case FDT_PROP:
-		case FDT_NOP:
-			break;
+	FDT_CHECK_HEADER(fdt);
 
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (level >= 0);
+	for (depth = 0;
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		if (depth < 0)
+			return -FDT_ERR_NOTFOUND;
+		else if ((depth == 1)
+			 && _fdt_nodename_eq(fdt, offset, name, namelen))
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error */
 }
 
 int fdt_subnode_offset(const void *fdt, int parentoffset,
@@ -162,7 +129,7 @@
 	const char *p = path;
 	int offset = 0;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (*path != '/')
 		return -FDT_ERR_BADPATH;
@@ -190,16 +157,12 @@
 
 const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 {
-	const struct fdt_node_header *nh;
+	const struct fdt_node_header *nh = _fdt_offset_ptr(fdt, nodeoffset);
 	int err;
 
-	if ((err = fdt_check_header(fdt)) != 0)
-		goto fail;
-
-	err = -FDT_ERR_BADOFFSET;
-	nh = fdt_offset_ptr(fdt, nodeoffset, sizeof(*nh));
-	if (!nh || (fdt32_to_cpu(nh->tag) != FDT_BEGIN_NODE))
-		goto fail;
+	if (((err = fdt_check_header(fdt)) != 0)
+	    || ((err = _fdt_check_node_offset(fdt, nodeoffset)) < 0))
+			goto fail;
 
 	if (len)
 		*len = strlen(nh->name);
@@ -222,17 +185,11 @@
 	int offset, nextoffset;
 	int err;
 
-	if ((err = fdt_check_header(fdt)) != 0)
-		goto fail;
-
-	err = -FDT_ERR_BADOFFSET;
-	if (nodeoffset % FDT_TAGSIZE)
-		goto fail;
-
-	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		goto fail;
+	if (((err = fdt_check_header(fdt)) != 0)
+	    || ((err = _fdt_check_node_offset(fdt, nodeoffset)) < 0))
+			goto fail;
 
+	nextoffset = err;
 	do {
 		offset = nextoffset;
 
@@ -253,7 +210,7 @@
 			if (! prop)
 				goto fail;
 			namestroff = fdt32_to_cpu(prop->nameoff);
-			if (streq(fdt_string(fdt, namestroff), name)) {
+			if (strcmp(fdt_string(fdt, namestroff), name) == 0) {
 				/* Found it! */
 				int len = fdt32_to_cpu(prop->len);
 				prop = fdt_offset_ptr(fdt, offset,
@@ -307,115 +264,91 @@
 
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
 {
-	uint32_t tag;
-	int p = 0, overflow = 0;
-	int offset, nextoffset, namelen;
+	int pdepth = 0, p = 0;
+	int offset, depth, namelen;
 	const char *name;
 
-	CHECK_HEADER(fdt);
-
-	tag = fdt_next_tag(fdt, 0, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADSTRUCTURE;
+	FDT_CHECK_HEADER(fdt);
 
 	if (buflen < 2)
 		return -FDT_ERR_NOSPACE;
-	buf[0] = '/';
-	p = 1;
 
-	while (nextoffset <= nodeoffset) {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_BADOFFSET;
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		if (pdepth < depth)
+			continue; /* overflowed buffer */
 
-		case FDT_BEGIN_NODE:
-			name = fdt_get_name(fdt, offset, &namelen);
-			if (!name)
-				return namelen;
-			if (overflow || ((p + namelen + 1) > buflen)) {
-				overflow++;
-				break;
-			}
+		while (pdepth > depth) {
+			do {
+				p--;
+			} while (buf[p-1] != '/');
+			pdepth--;
+		}
+
+		name = fdt_get_name(fdt, offset, &namelen);
+		if (!name)
+			return namelen;
+		if ((p + namelen + 1) <= buflen) {
 			memcpy(buf + p, name, namelen);
 			p += namelen;
 			buf[p++] = '/';
-			break;
-
-		case FDT_END_NODE:
-			if (overflow) {
-				overflow--;
-				break;
-			}
-			do {
-				p--;
-			} while  (buf[p-1] != '/');
-			break;
+			pdepth++;
+		}
 
-		case FDT_PROP:
-		case FDT_NOP:
-			break;
+		if (offset == nodeoffset) {
+			if (pdepth < (depth + 1))
+				return -FDT_ERR_NOSPACE;
 
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
+			if (p > 1) /* special case so that root path is "/", not "" */
+				p--;
+			buf[p] = '\0';
+			return p;
 		}
 	}
 
-	if (overflow)
-		return -FDT_ERR_NOSPACE;
+	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+		return -FDT_ERR_BADOFFSET;
+	else if (offset == -FDT_ERR_BADOFFSET)
+		return -FDT_ERR_BADSTRUCTURE;
 
-	if (p > 1) /* special case so that root path is "/", not "" */
-		p--;
-	buf[p] = '\0';
-	return p;
+	return offset; /* error from fdt_next_node() */
 }
 
 int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
 				 int supernodedepth, int *nodedepth)
 {
-	int level = -1;
-	uint32_t tag;
-	int offset, nextoffset = 0;
+	int offset, depth;
 	int supernodeoffset = -FDT_ERR_INTERNAL;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (supernodedepth < 0)
 		return -FDT_ERR_NOTFOUND;
 
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_BADOFFSET;
-
-		case FDT_BEGIN_NODE:
-			level++;
-			if (level == supernodedepth)
-				supernodeoffset = offset;
-			break;
-
-		case FDT_END_NODE:
-			level--;
-			break;
-
-		case FDT_PROP:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		if (depth == supernodedepth)
+			supernodeoffset = offset;
+
+		if (offset == nodeoffset) {
+			if (nodedepth)
+				*nodedepth = depth;
+
+			if (supernodedepth > depth)
+				return -FDT_ERR_NOTFOUND;
+			else
+				return supernodeoffset;
 		}
-	} while (offset < nodeoffset);
+	}
 
-	if (nodedepth)
-		*nodedepth = level;
+	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+		return -FDT_ERR_BADOFFSET;
+	else if (offset == -FDT_ERR_BADOFFSET)
+		return -FDT_ERR_BADSTRUCTURE;
 
-	if (supernodedepth > level)
-		return -FDT_ERR_NOTFOUND;
-	return supernodeoffset;
+	return offset; /* error from fdt_next_node() */
 }
 
 int fdt_node_depth(const void *fdt, int nodeoffset)
@@ -443,51 +376,27 @@
 				  const char *propname,
 				  const void *propval, int proplen)
 {
-	uint32_t tag;
-	int offset, nextoffset;
+	int offset;
 	const void *val;
 	int len;
 
-	CHECK_HEADER(fdt);
-
-	if (startoffset >= 0) {
-		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
-		if (tag != FDT_BEGIN_NODE)
-			return -FDT_ERR_BADOFFSET;
-	} else {
-		nextoffset = 0;
-	}
+	FDT_CHECK_HEADER(fdt);
 
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_getprop(), then if that didn't
 	 * find what we want, we scan over them again making our way
 	 * to the next node.  Still it's the easiest to implement
 	 * approach; performance can come later. */
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_BEGIN_NODE:
-			val = fdt_getprop(fdt, offset, propname, &len);
-			if (val
-			    && (len == proplen)
-			    && (memcmp(val, propval, len) == 0))
-				return offset;
-			break;
-
-		case FDT_PROP:
-		case FDT_END:
-		case FDT_END_NODE:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (tag != FDT_END);
+	for (offset = fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		val = fdt_getprop(fdt, offset, propname, &len);
+		if (val && (len == proplen)
+		    && (memcmp(val, propval, len) == 0))
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error from fdt_next_node() */
 }
 
 int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle)
@@ -499,10 +408,10 @@
 					     &phandle, sizeof(phandle));
 }
 
-int _stringlist_contains(const void *strlist, int listlen, const char *str)
+int _stringlist_contains(const char *strlist, int listlen, const char *str)
 {
 	int len = strlen(str);
-	const void *p;
+	const char *p;
 
 	while (listlen >= len) {
 		if (memcmp(str, strlist, len+1) == 0)
@@ -534,50 +443,24 @@
 int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 				  const char *compatible)
 {
-	uint32_t tag;
-	int offset, nextoffset;
-	int err;
+	int offset, err;
 
-	CHECK_HEADER(fdt);
-
-	if (startoffset >= 0) {
-		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
-		if (tag != FDT_BEGIN_NODE)
-			return -FDT_ERR_BADOFFSET;
-	} else {
-		nextoffset = 0;
-	}
+	FDT_CHECK_HEADER(fdt);
 
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_node_check_compatible(), then if
 	 * that didn't find what we want, we scan over them again
 	 * making our way to the next node.  Still it's the easiest to
 	 * implement approach; performance can come later. */
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_BEGIN_NODE:
-			err = fdt_node_check_compatible(fdt, offset,
-							compatible);
-			if ((err < 0)
-			    && (err != -FDT_ERR_NOTFOUND))
-				return err;
-			else if (err == 0)
-				return offset;
-			break;
-
-		case FDT_PROP:
-		case FDT_END:
-		case FDT_END_NODE:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (tag != FDT_END);
+	for (offset = fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		err = fdt_node_check_compatible(fdt, offset, compatible);
+		if ((err < 0) && (err != -FDT_ERR_NOTFOUND))
+			return err;
+		else if (err == 0)
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error from fdt_next_node() */
 }
Index: working-2.6/arch/powerpc/boot/libfdt/fdt_rw.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_rw.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_rw.c	2008-08-07 12:06:18.000000000 +1000
@@ -55,10 +55,10 @@
 
 #include "libfdt_internal.h"
 
-static int _blocks_misordered(const void *fdt,
+static int _fdt_blocks_misordered(const void *fdt,
 			      int mem_rsv_size, int struct_size)
 {
-	return (fdt_off_mem_rsvmap(fdt) < ALIGN(sizeof(struct fdt_header), 8))
+	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header), 8))
 		|| (fdt_off_dt_struct(fdt) <
 		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
 		|| (fdt_off_dt_strings(fdt) <
@@ -67,16 +67,14 @@
 		    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)));
 }
 
-static int rw_check_header(void *fdt)
+static int _fdt_rw_check_header(void *fdt)
 {
-	int err;
+	FDT_CHECK_HEADER(fdt);
 
-	if ((err = fdt_check_header(fdt)))
-		return err;
 	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
-	if (_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
-			       fdt_size_dt_struct(fdt)))
+	if (_fdt_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
+				   fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
 	if (fdt_version(fdt) > 17)
 		fdt_set_version(fdt, 17);
@@ -84,36 +82,37 @@
 	return 0;
 }
 
-#define RW_CHECK_HEADER(fdt) \
+#define FDT_RW_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-		if ((err = rw_check_header(fdt)) != 0) \
+		if ((err = _fdt_rw_check_header(fdt)) != 0) \
 			return err; \
 	}
 
-static inline int _blob_data_size(void *fdt)
+static inline int _fdt_data_size(void *fdt)
 {
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
 
-static int _blob_splice(void *fdt, void *p, int oldlen, int newlen)
+static int _fdt_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
-	void *end = fdt + _blob_data_size(fdt);
+	char *p = splicepoint;
+	char *end = (char *)fdt + _fdt_data_size(fdt);
 
 	if (((p + oldlen) < p) || ((p + oldlen) > end))
 		return -FDT_ERR_BADOFFSET;
-	if ((end - oldlen + newlen) > (fdt + fdt_totalsize(fdt)))
+	if ((end - oldlen + newlen) > ((char *)fdt + fdt_totalsize(fdt)))
 		return -FDT_ERR_NOSPACE;
 	memmove(p + newlen, p + oldlen, end - p - oldlen);
 	return 0;
 }
 
-static int _blob_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
-				int oldn, int newn)
+static int _fdt_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
+			       int oldn, int newn)
 {
 	int delta = (newn - oldn) * sizeof(*p);
 	int err;
-	err = _blob_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
+	err = _fdt_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
 	if (err)
 		return err;
 	fdt_set_off_dt_struct(fdt, fdt_off_dt_struct(fdt) + delta);
@@ -121,13 +120,13 @@
 	return 0;
 }
 
-static int _blob_splice_struct(void *fdt, void *p,
-			       int oldlen, int newlen)
+static int _fdt_splice_struct(void *fdt, void *p,
+			      int oldlen, int newlen)
 {
 	int delta = newlen - oldlen;
 	int err;
 
-	if ((err = _blob_splice(fdt, p, oldlen, newlen)))
+	if ((err = _fdt_splice(fdt, p, oldlen, newlen)))
 		return err;
 
 	fdt_set_size_dt_struct(fdt, fdt_size_dt_struct(fdt) + delta);
@@ -135,19 +134,20 @@
 	return 0;
 }
 
-static int _blob_splice_string(void *fdt, int newlen)
+static int _fdt_splice_string(void *fdt, int newlen)
 {
-	void *p = fdt + fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
+	void *p = (char *)fdt
+		+ fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 	int err;
 
-	if ((err = _blob_splice(fdt, p, 0, newlen)))
+	if ((err = _fdt_splice(fdt, p, 0, newlen)))
 		return err;
 
 	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) + newlen);
 	return 0;
 }
 
-static int _find_add_string(void *fdt, const char *s)
+static int _fdt_find_add_string(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
 	const char *p;
@@ -161,7 +161,7 @@
 		return (p - strtab);
 
 	new = strtab + fdt_size_dt_strings(fdt);
-	err = _blob_splice_string(fdt, len);
+	err = _fdt_splice_string(fdt, len);
 	if (err)
 		return err;
 
@@ -174,11 +174,10 @@
 	struct fdt_reserve_entry *re;
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	FDT_RW_CHECK_HEADER(fdt);
 
 	re = _fdt_mem_rsv_w(fdt, fdt_num_mem_rsv(fdt));
-	err = _blob_splice_mem_rsv(fdt, re, 0, 1);
+	err = _fdt_splice_mem_rsv(fdt, re, 0, 1);
 	if (err)
 		return err;
 
@@ -192,19 +191,19 @@
 	struct fdt_reserve_entry *re = _fdt_mem_rsv_w(fdt, n);
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	FDT_RW_CHECK_HEADER(fdt);
+
 	if (n >= fdt_num_mem_rsv(fdt))
 		return -FDT_ERR_NOTFOUND;
 
-	err = _blob_splice_mem_rsv(fdt, re, 1, 0);
+	err = _fdt_splice_mem_rsv(fdt, re, 1, 0);
 	if (err)
 		return err;
 	return 0;
 }
 
-static int _resize_property(void *fdt, int nodeoffset, const char *name, int len,
-			    struct fdt_property **prop)
+static int _fdt_resize_property(void *fdt, int nodeoffset, const char *name,
+				int len, struct fdt_property **prop)
 {
 	int oldlen;
 	int err;
@@ -213,36 +212,33 @@
 	if (! (*prop))
 		return oldlen;
 
-	if ((err = _blob_splice_struct(fdt, (*prop)->data,
-				       ALIGN(oldlen, FDT_TAGSIZE),
-				       ALIGN(len, FDT_TAGSIZE))))
+	if ((err = _fdt_splice_struct(fdt, (*prop)->data, FDT_TAGALIGN(oldlen),
+				      FDT_TAGALIGN(len))))
 		return err;
 
 	(*prop)->len = cpu_to_fdt32(len);
 	return 0;
 }
 
-static int _add_property(void *fdt, int nodeoffset, const char *name, int len,
-			 struct fdt_property **prop)
+static int _fdt_add_property(void *fdt, int nodeoffset, const char *name,
+			     int len, struct fdt_property **prop)
 {
-	uint32_t tag;
 	int proplen;
 	int nextoffset;
 	int namestroff;
 	int err;
 
-	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADOFFSET;
+	if ((nextoffset = _fdt_check_node_offset(fdt, nodeoffset)) < 0)
+		return nextoffset;
 
-	namestroff = _find_add_string(fdt, name);
+	namestroff = _fdt_find_add_string(fdt, name);
 	if (namestroff < 0)
 		return namestroff;
 
 	*prop = _fdt_offset_ptr_w(fdt, nextoffset);
-	proplen = sizeof(**prop) + ALIGN(len, FDT_TAGSIZE);
+	proplen = sizeof(**prop) + FDT_TAGALIGN(len);
 
-	err = _blob_splice_struct(fdt, *prop, 0, proplen);
+	err = _fdt_splice_struct(fdt, *prop, 0, proplen);
 	if (err)
 		return err;
 
@@ -252,18 +248,40 @@
 	return 0;
 }
 
+int fdt_set_name(void *fdt, int nodeoffset, const char *name)
+{
+	char *namep;
+	int oldlen, newlen;
+	int err;
+
+	FDT_RW_CHECK_HEADER(fdt);
+
+	namep = (char *)(uintptr_t)fdt_get_name(fdt, nodeoffset, &oldlen);
+	if (!namep)
+		return oldlen;
+
+	newlen = strlen(name);
+
+	err = _fdt_splice_struct(fdt, namep, FDT_TAGALIGN(oldlen+1),
+				 FDT_TAGALIGN(newlen+1));
+	if (err)
+		return err;
+
+	memcpy(namep, name, newlen+1);
+	return 0;
+}
+
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len)
 {
 	struct fdt_property *prop;
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	FDT_RW_CHECK_HEADER(fdt);
 
-	err = _resize_property(fdt, nodeoffset, name, len, &prop);
+	err = _fdt_resize_property(fdt, nodeoffset, name, len, &prop);
 	if (err == -FDT_ERR_NOTFOUND)
-		err = _add_property(fdt, nodeoffset, name, len, &prop);
+		err = _fdt_add_property(fdt, nodeoffset, name, len, &prop);
 	if (err)
 		return err;
 
@@ -276,14 +294,14 @@
 	struct fdt_property *prop;
 	int len, proplen;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	prop = fdt_get_property_w(fdt, nodeoffset, name, &len);
 	if (! prop)
 		return len;
 
-	proplen = sizeof(*prop) + ALIGN(len, FDT_TAGSIZE);
-	return _blob_splice_struct(fdt, prop, proplen, 0);
+	proplen = sizeof(*prop) + FDT_TAGALIGN(len);
+	return _fdt_splice_struct(fdt, prop, proplen, 0);
 }
 
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
@@ -296,7 +314,7 @@
 	uint32_t tag;
 	uint32_t *endtag;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	offset = fdt_subnode_offset_namelen(fdt, parentoffset, name, namelen);
 	if (offset >= 0)
@@ -309,19 +327,19 @@
 	do {
 		offset = nextoffset;
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
-	} while (tag == FDT_PROP);
+	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
 
 	nh = _fdt_offset_ptr_w(fdt, offset);
-	nodelen = sizeof(*nh) + ALIGN(namelen+1, FDT_TAGSIZE) + FDT_TAGSIZE;
+	nodelen = sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;
 
-	err = _blob_splice_struct(fdt, nh, 0, nodelen);
+	err = _fdt_splice_struct(fdt, nh, 0, nodelen);
 	if (err)
 		return err;
 
 	nh->tag = cpu_to_fdt32(FDT_BEGIN_NODE);
-	memset(nh->name, 0, ALIGN(namelen+1, FDT_TAGSIZE));
+	memset(nh->name, 0, FDT_TAGALIGN(namelen+1));
 	memcpy(nh->name, name, namelen);
-	endtag = (uint32_t *)((void *)nh + nodelen - FDT_TAGSIZE);
+	endtag = (uint32_t *)((char *)nh + nodelen - FDT_TAGSIZE);
 	*endtag = cpu_to_fdt32(FDT_END_NODE);
 
 	return offset;
@@ -336,36 +354,36 @@
 {
 	int endoffset;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	endoffset = _fdt_node_end_offset(fdt, nodeoffset);
 	if (endoffset < 0)
 		return endoffset;
 
-	return _blob_splice_struct(fdt, _fdt_offset_ptr_w(fdt, nodeoffset),
-				   endoffset - nodeoffset, 0);
+	return _fdt_splice_struct(fdt, _fdt_offset_ptr_w(fdt, nodeoffset),
+				  endoffset - nodeoffset, 0);
 }
 
-static void _packblocks(const void *fdt, void *buf,
-		       int mem_rsv_size, int struct_size)
+static void _fdt_packblocks(const char *old, char *new,
+			    int mem_rsv_size, int struct_size)
 {
 	int mem_rsv_off, struct_off, strings_off;
 
-	mem_rsv_off = ALIGN(sizeof(struct fdt_header), 8);
+	mem_rsv_off = FDT_ALIGN(sizeof(struct fdt_header), 8);
 	struct_off = mem_rsv_off + mem_rsv_size;
 	strings_off = struct_off + struct_size;
 
-	memmove(buf + mem_rsv_off, fdt + fdt_off_mem_rsvmap(fdt), mem_rsv_size);
-	fdt_set_off_mem_rsvmap(buf, mem_rsv_off);
+	memmove(new + mem_rsv_off, old + fdt_off_mem_rsvmap(old), mem_rsv_size);
+	fdt_set_off_mem_rsvmap(new, mem_rsv_off);
 
-	memmove(buf + struct_off, fdt + fdt_off_dt_struct(fdt), struct_size);
-	fdt_set_off_dt_struct(buf, struct_off);
-	fdt_set_size_dt_struct(buf, struct_size);
-
-	memmove(buf + strings_off, fdt + fdt_off_dt_strings(fdt),
-		fdt_size_dt_strings(fdt));
-	fdt_set_off_dt_strings(buf, strings_off);
-	fdt_set_size_dt_strings(buf, fdt_size_dt_strings(fdt));
+	memmove(new + struct_off, old + fdt_off_dt_struct(old), struct_size);
+	fdt_set_off_dt_struct(new, struct_off);
+	fdt_set_size_dt_struct(new, struct_size);
+
+	memmove(new + strings_off, old + fdt_off_dt_strings(old),
+		fdt_size_dt_strings(old));
+	fdt_set_off_dt_strings(new, strings_off);
+	fdt_set_size_dt_strings(new, fdt_size_dt_strings(old));
 }
 
 int fdt_open_into(const void *fdt, void *buf, int bufsize)
@@ -373,11 +391,11 @@
 	int err;
 	int mem_rsv_size, struct_size;
 	int newsize;
-	void *tmp;
+	const char *fdtstart = fdt;
+	const char *fdtend = fdtstart + fdt_totalsize(fdt);
+	char *tmp;
 
-	err = fdt_check_header(fdt);
-	if (err)
-		return err;
+	FDT_CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
@@ -390,7 +408,7 @@
 			;
 	}
 
-	if (!_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
+	if (!_fdt_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
 		if (err)
@@ -402,22 +420,23 @@
 	}
 
 	/* Need to reorder */
-	newsize = ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
+	newsize = FDT_ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
 		+ struct_size + fdt_size_dt_strings(fdt);
 
 	if (bufsize < newsize)
 		return -FDT_ERR_NOSPACE;
 
-	if (((buf + newsize) <= fdt)
-	    || (buf >= (fdt + fdt_totalsize(fdt)))) {
-		tmp = buf;
-	} else {
-		tmp = (void *)fdt + fdt_totalsize(fdt);
-		if ((tmp + newsize) > (buf + bufsize))
+	/* First attempt to build converted tree at beginning of buffer */
+	tmp = buf;
+	/* But if that overlaps with the old tree... */
+	if (((tmp + newsize) > fdtstart) && (tmp < fdtend)) {
+		/* Try right after the old tree instead */
+		tmp = (char *)(uintptr_t)fdtend;
+		if ((tmp + newsize) > ((char *)buf + bufsize))
 			return -FDT_ERR_NOSPACE;
 	}
 
-	_packblocks(fdt, tmp, mem_rsv_size, struct_size);
+	_fdt_packblocks(fdt, tmp, mem_rsv_size, struct_size);
 	memmove(buf, tmp, newsize);
 
 	fdt_set_magic(buf, FDT_MAGIC);
@@ -432,16 +451,13 @@
 int fdt_pack(void *fdt)
 {
 	int mem_rsv_size;
-	int err;
 
-	err = rw_check_header(fdt);
-	if (err)
-		return err;
+	FDT_RW_CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
-	_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
-	fdt_set_totalsize(fdt, _blob_data_size(fdt));
+	_fdt_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
+	fdt_set_totalsize(fdt, _fdt_data_size(fdt));
 
 	return 0;
 }
Index: working-2.6/arch/powerpc/boot/libfdt/fdt_strerror.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_strerror.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_strerror.c	2008-08-07 12:06:18.000000000 +1000
@@ -55,29 +55,29 @@
 
 #include "libfdt_internal.h"
 
-struct errtabent {
+struct fdt_errtabent {
 	const char *str;
 };
 
-#define ERRTABENT(val) \
+#define FDT_ERRTABENT(val) \
 	[(val)] = { .str = #val, }
 
-static struct errtabent errtable[] = {
-	ERRTABENT(FDT_ERR_NOTFOUND),
-	ERRTABENT(FDT_ERR_EXISTS),
-	ERRTABENT(FDT_ERR_NOSPACE),
-
-	ERRTABENT(FDT_ERR_BADOFFSET),
-	ERRTABENT(FDT_ERR_BADPATH),
-	ERRTABENT(FDT_ERR_BADSTATE),
-
-	ERRTABENT(FDT_ERR_TRUNCATED),
-	ERRTABENT(FDT_ERR_BADMAGIC),
-	ERRTABENT(FDT_ERR_BADVERSION),
-	ERRTABENT(FDT_ERR_BADSTRUCTURE),
-	ERRTABENT(FDT_ERR_BADLAYOUT),
+static struct fdt_errtabent fdt_errtable[] = {
+	FDT_ERRTABENT(FDT_ERR_NOTFOUND),
+	FDT_ERRTABENT(FDT_ERR_EXISTS),
+	FDT_ERRTABENT(FDT_ERR_NOSPACE),
+
+	FDT_ERRTABENT(FDT_ERR_BADOFFSET),
+	FDT_ERRTABENT(FDT_ERR_BADPATH),
+	FDT_ERRTABENT(FDT_ERR_BADSTATE),
+
+	FDT_ERRTABENT(FDT_ERR_TRUNCATED),
+	FDT_ERRTABENT(FDT_ERR_BADMAGIC),
+	FDT_ERRTABENT(FDT_ERR_BADVERSION),
+	FDT_ERRTABENT(FDT_ERR_BADSTRUCTURE),
+	FDT_ERRTABENT(FDT_ERR_BADLAYOUT),
 };
-#define ERRTABSIZE	(sizeof(errtable) / sizeof(errtable[0]))
+#define FDT_ERRTABSIZE	(sizeof(fdt_errtable) / sizeof(fdt_errtable[0]))
 
 const char *fdt_strerror(int errval)
 {
@@ -85,8 +85,8 @@
 		return "<valid offset/length>";
 	else if (errval == 0)
 		return "<no error>";
-	else if (errval > -ERRTABSIZE) {
-		const char *s = errtable[-errval].str;
+	else if (errval > -FDT_ERRTABSIZE) {
+		const char *s = fdt_errtable[-errval].str;
 
 		if (s)
 			return s;
Index: working-2.6/arch/powerpc/boot/libfdt/fdt_sw.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_sw.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_sw.c	2008-08-07 12:06:18.000000000 +1000
@@ -55,14 +55,22 @@
 
 #include "libfdt_internal.h"
 
-static int check_header_sw(void *fdt)
+static int _fdt_sw_check_header(void *fdt)
 {
-	if (fdt_magic(fdt) != SW_MAGIC)
+	if (fdt_magic(fdt) != FDT_SW_MAGIC)
 		return -FDT_ERR_BADMAGIC;
+	/* FIXME: should check more details about the header state */
 	return 0;
 }
 
-static void *grab_space(void *fdt, int len)
+#define FDT_SW_CHECK_HEADER(fdt) \
+	{ \
+		int err; \
+		if ((err = _fdt_sw_check_header(fdt)) != 0) \
+			return err; \
+	}
+
+static void *_fdt_grab_space(void *fdt, int len)
 {
 	int offset = fdt_size_dt_struct(fdt);
 	int spaceleft;
@@ -86,13 +94,13 @@
 
 	memset(buf, 0, bufsize);
 
-	fdt_set_magic(fdt, SW_MAGIC);
+	fdt_set_magic(fdt, FDT_SW_MAGIC);
 	fdt_set_version(fdt, FDT_LAST_SUPPORTED_VERSION);
 	fdt_set_last_comp_version(fdt, FDT_FIRST_SUPPORTED_VERSION);
 	fdt_set_totalsize(fdt,  bufsize);
 
-	fdt_set_off_mem_rsvmap(fdt, ALIGN(sizeof(struct fdt_header),
-					  sizeof(struct fdt_reserve_entry)));
+	fdt_set_off_mem_rsvmap(fdt, FDT_ALIGN(sizeof(struct fdt_header),
+					      sizeof(struct fdt_reserve_entry)));
 	fdt_set_off_dt_struct(fdt, fdt_off_mem_rsvmap(fdt));
 	fdt_set_off_dt_strings(fdt, bufsize);
 
@@ -102,11 +110,10 @@
 int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size)
 {
 	struct fdt_reserve_entry *re;
-	int err = check_header_sw(fdt);
 	int offset;
 
-	if (err)
-		return err;
+	FDT_SW_CHECK_HEADER(fdt);
+
 	if (fdt_size_dt_struct(fdt))
 		return -FDT_ERR_BADSTATE;
 
@@ -114,7 +121,7 @@
 	if ((offset + sizeof(*re)) > fdt_totalsize(fdt))
 		return -FDT_ERR_NOSPACE;
 
-	re = (struct fdt_reserve_entry *)(fdt + offset);
+	re = (struct fdt_reserve_entry *)((char *)fdt + offset);
 	re->address = cpu_to_fdt64(addr);
 	re->size = cpu_to_fdt64(size);
 
@@ -131,13 +138,11 @@
 int fdt_begin_node(void *fdt, const char *name)
 {
 	struct fdt_node_header *nh;
-	int err = check_header_sw(fdt);
 	int namelen = strlen(name) + 1;
 
-	if (err)
-		return err;
+	FDT_SW_CHECK_HEADER(fdt);
 
-	nh = grab_space(fdt, sizeof(*nh) + ALIGN(namelen, FDT_TAGSIZE));
+	nh = _fdt_grab_space(fdt, sizeof(*nh) + FDT_TAGALIGN(namelen));
 	if (! nh)
 		return -FDT_ERR_NOSPACE;
 
@@ -149,12 +154,10 @@
 int fdt_end_node(void *fdt)
 {
 	uint32_t *en;
-	int err = check_header_sw(fdt);
 
-	if (err)
-		return err;
+	FDT_SW_CHECK_HEADER(fdt);
 
-	en = grab_space(fdt, FDT_TAGSIZE);
+	en = _fdt_grab_space(fdt, FDT_TAGSIZE);
 	if (! en)
 		return -FDT_ERR_NOSPACE;
 
@@ -162,7 +165,7 @@
 	return 0;
 }
 
-static int find_add_string(void *fdt, const char *s)
+static int _fdt_find_add_string(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_totalsize(fdt);
 	const char *p;
@@ -188,17 +191,15 @@
 int fdt_property(void *fdt, const char *name, const void *val, int len)
 {
 	struct fdt_property *prop;
-	int err = check_header_sw(fdt);
 	int nameoff;
 
-	if (err)
-		return err;
+	FDT_SW_CHECK_HEADER(fdt);
 
-	nameoff = find_add_string(fdt, name);
+	nameoff = _fdt_find_add_string(fdt, name);
 	if (nameoff == 0)
 		return -FDT_ERR_NOSPACE;
 
-	prop = grab_space(fdt, sizeof(*prop) + ALIGN(len, FDT_TAGSIZE));
+	prop = _fdt_grab_space(fdt, sizeof(*prop) + FDT_TAGALIGN(len));
 	if (! prop)
 		return -FDT_ERR_NOSPACE;
 
@@ -211,18 +212,16 @@
 
 int fdt_finish(void *fdt)
 {
-	int err = check_header_sw(fdt);
 	char *p = (char *)fdt;
 	uint32_t *end;
 	int oldstroffset, newstroffset;
 	uint32_t tag;
 	int offset, nextoffset;
 
-	if (err)
-		return err;
+	FDT_SW_CHECK_HEADER(fdt);
 
 	/* Add terminator */
-	end = grab_space(fdt, sizeof(*end));
+	end = _fdt_grab_space(fdt, sizeof(*end));
 	if (! end)
 		return -FDT_ERR_NOSPACE;
 	*end = cpu_to_fdt32(FDT_END);
Index: working-2.6/arch/powerpc/boot/libfdt/fdt_wip.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_wip.c	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_wip.c	2008-08-07 12:06:18.000000000 +1000
@@ -72,11 +72,11 @@
 	return 0;
 }
 
-static void nop_region(void *start, int len)
+static void _fdt_nop_region(void *start, int len)
 {
 	uint32_t *p;
 
-	for (p = start; (void *)p < (start + len); p++)
+	for (p = start; (char *)p < ((char *)start + len); p++)
 		*p = cpu_to_fdt32(FDT_NOP);
 }
 
@@ -89,7 +89,7 @@
 	if (! prop)
 		return len;
 
-	nop_region(prop, len + sizeof(*prop));
+	_fdt_nop_region(prop, len + sizeof(*prop));
 
 	return 0;
 }
@@ -139,6 +139,7 @@
 	if (endoffset < 0)
 		return endoffset;
 
-	nop_region(fdt_offset_ptr_w(fdt, nodeoffset, 0), endoffset - nodeoffset);
+	_fdt_nop_region(fdt_offset_ptr_w(fdt, nodeoffset, 0),
+			endoffset - nodeoffset);
 	return 0;
 }
Index: working-2.6/arch/powerpc/boot/libfdt/libfdt.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/libfdt.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/libfdt.h	2008-08-07 12:06:18.000000000 +1000
@@ -125,12 +125,18 @@
 const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
 static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
 {
-	return (void *)fdt_offset_ptr(fdt, offset, checklen);
+	return (void *)(uintptr_t)fdt_offset_ptr(fdt, offset, checklen);
 }
 
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
 /**********************************************************************/
+/* Traversal functions                                                */
+/**********************************************************************/
+
+int fdt_next_node(const void *fdt, int offset, int *depth);
+
+/**********************************************************************/
 /* General functions                                                  */
 /**********************************************************************/
 
@@ -207,7 +213,7 @@
 /**********************************************************************/
 
 /**
- * fdt_string - retreive a string from the strings block of a device tree
+ * fdt_string - retrieve a string from the strings block of a device tree
  * @fdt: pointer to the device tree blob
  * @stroffset: offset of the string within the strings block (native endian)
  *
@@ -221,7 +227,7 @@
 const char *fdt_string(const void *fdt, int stroffset);
 
 /**
- * fdt_num_mem_rsv - retreive the number of memory reserve map entries
+ * fdt_num_mem_rsv - retrieve the number of memory reserve map entries
  * @fdt: pointer to the device tree blob
  *
  * Returns the number of entries in the device tree blob's memory
@@ -234,7 +240,7 @@
 int fdt_num_mem_rsv(const void *fdt);
 
 /**
- * fdt_get_mem_rsv - retreive one memory reserve map entry
+ * fdt_get_mem_rsv - retrieve one memory reserve map entry
  * @fdt: pointer to the device tree blob
  * @address, @size: pointers to 64-bit variables
  *
@@ -314,7 +320,7 @@
 int fdt_path_offset(const void *fdt, const char *path);
 
 /**
- * fdt_get_name - retreive the name of a given node
+ * fdt_get_name - retrieve the name of a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: structure block offset of the starting node
  * @lenp: pointer to an integer variable (will be overwritten) or NULL
@@ -346,7 +352,7 @@
  * fdt_get_property() retrieves a pointer to the fdt_property
  * structure within the device tree blob corresponding to the property
  * named 'name' of the node at offset nodeoffset.  If lenp is
- * non-NULL, the length of the property value also returned, in the
+ * non-NULL, the length of the property value is also returned, in the
  * integer pointed to by lenp.
  *
  * returns:
@@ -369,8 +375,8 @@
 						      const char *name,
 						      int *lenp)
 {
-	return (struct fdt_property *)fdt_get_property(fdt, nodeoffset,
-						       name, lenp);
+	return (struct fdt_property *)(uintptr_t)
+		fdt_get_property(fdt, nodeoffset, name, lenp);
 }
 
 /**
@@ -383,7 +389,7 @@
  * fdt_getprop() retrieves a pointer to the value of the property
  * named 'name' of the node at offset nodeoffset (this will be a
  * pointer to within the device blob itself, not a copy of the value).
- * If lenp is non-NULL, the length of the property value also
+ * If lenp is non-NULL, the length of the property value is also
  * returned, in the integer pointed to by lenp.
  *
  * returns:
@@ -405,11 +411,11 @@
 static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
 				  const char *name, int *lenp)
 {
-	return (void *)fdt_getprop(fdt, nodeoffset, name, lenp);
+	return (void *)(uintptr_t)fdt_getprop(fdt, nodeoffset, name, lenp);
 }
 
 /**
- * fdt_get_phandle - retreive the phandle of a given node
+ * fdt_get_phandle - retrieve the phandle of a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: structure block offset of the node
  *
@@ -417,7 +423,7 @@
  * structure block offset nodeoffset.
  *
  * returns:
- *	the phandle of the node at nodeoffset, on succes (!= 0, != -1)
+ *	the phandle of the node at nodeoffset, on success (!= 0, != -1)
  *	0, if the node has no phandle, or another error occurs
  */
 uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
@@ -516,7 +522,7 @@
  * structure from the start to nodeoffset, *twice*.
  *
  * returns:
- *	stucture block offset of the parent of the node at nodeoffset
+ *	structure block offset of the parent of the node at nodeoffset
  *		(>=0), on success
  * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
  *	-FDT_ERR_BADMAGIC,
@@ -573,7 +579,7 @@
  * @fdt: pointer to the device tree blob
  * @phandle: phandle value
  *
- * fdt_node_offset_by_prop_value() returns the offset of the node
+ * fdt_node_offset_by_phandle() returns the offset of the node
  * which has the given phandle value.  If there is more than one node
  * in the tree with the given phandle (an invalid tree), results are
  * undefined.
@@ -655,8 +661,65 @@
 /* Write-in-place functions                                           */
 /**********************************************************************/
 
+/**
+ * fdt_setprop_inplace - change a property's value, but not its size
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to replace the property value with
+ * @len: length of the property value
+ *
+ * fdt_setprop_inplace() replaces the value of a given property with
+ * the data in val, of length len.  This function cannot change the
+ * size of a property, and so will only work if len is equal to the
+ * current length of the property.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if len is not equal to the property's current length
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
+
+/**
+ * fdt_setprop_inplace_cell - change the value of a single-cell property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: cell (32-bit integer) value to replace the property with
+ *
+ * fdt_setprop_inplace_cell() replaces the value of a given property
+ * with the 32-bit integer cell value in val, converting val to
+ * big-endian if necessary.  This function cannot change the size of a
+ * property, and so will only work if the property already exists and
+ * has length 4.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if the property's length is not equal to 4
+  *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
 					   const char *name, uint32_t val)
 {
@@ -664,7 +727,54 @@
 	return fdt_setprop_inplace(fdt, nodeoffset, name, &val, sizeof(val));
 }
 
+/**
+ * fdt_nop_property - replace a property with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_nop_property() will replace a given property's representation
+ * in the blob with FDT_NOP tags, effectively removing it from the
+ * tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the property, and will not alter or move any other part of the
+ * tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_nop_node - replace a node (subtree) with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_nop_node() will replace a given node's representation in the
+ * blob, including all its subnodes, if any, with FDT_NOP tags,
+ * effectively removing it from the tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the node and its properties and subnodes, and will not alter or
+ * move any other part of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_nop_node(void *fdt, int nodeoffset);
 
 /**********************************************************************/
@@ -693,23 +803,268 @@
 int fdt_open_into(const void *fdt, void *buf, int bufsize);
 int fdt_pack(void *fdt);
 
+/**
+ * fdt_add_mem_rsv - add one memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @address, @size: 64-bit values (native endian)
+ *
+ * Adds a reserve map entry to the given blob reserving a region at
+ * address address of length size.
+ *
+ * This function will insert data into the reserve map and will
+ * therefore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new reservation entry
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
+
+/**
+ * fdt_del_mem_rsv - remove a memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @n: entry to remove
+ *
+ * fdt_del_mem_rsv() removes the n-th memory reserve map entry from
+ * the blob.
+ *
+ * This function will delete data from the reservation table and will
+ * therefore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, there is no entry of the given index (i.e. there
+ *		are less than n+1 reserve map entries)
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_del_mem_rsv(void *fdt, int n);
 
+/**
+ * fdt_set_name - change the name of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of a node
+ * @name: name to give the node
+ *
+ * fdt_set_name() replaces the name (including unit address, if any)
+ * of the given node with the given string.  NOTE: this function can't
+ * efficiently check if the new name is unique amongst the given
+ * node's siblings; results are undefined if this function is invoked
+ * with a name equal to one of the given node's siblings.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob
+ *		to contain the new name
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_set_name(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_setprop - create or change a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to set the property value to
+ * @len: length of the property value
+ *
+ * fdt_setprop() sets the value of the named property in the given
+ * node to the given value and length, creating the property if it
+ * does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
+
+/**
+ * fdt_setprop_cell - set a property to a single cell value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value for the property (native endian)
+ *
+ * fdt_setprop_cell() sets the value of the named property in the
+ * given node to the given cell value (converting to big-endian if
+ * necessary), or creates a new property with that value if it does
+ * not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
 				   uint32_t val)
 {
 	val = cpu_to_fdt32(val);
 	return fdt_setprop(fdt, nodeoffset, name, &val, sizeof(val));
 }
+
+/**
+ * fdt_setprop_string - set a property to a string value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @str: string value for the property
+ *
+ * fdt_setprop_string() sets the value of the named property in the
+ * given node to the given string value (using the length of the
+ * string to determine the new length of the property), or creates a
+ * new property with that value if it does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 #define fdt_setprop_string(fdt, nodeoffset, name, str) \
 	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
+
+/**
+ * fdt_delprop - delete a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_del_property() will delete the given property.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_delprop(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_add_subnode_namelen - creates a new node based on substring
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_add_subnode(), but use only the first namelen
+ * characters of name as the name of the new node.  This is useful for
+ * creating subnodes based on a portion of a larger string, such as a
+ * full path.
+ */
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 			    const char *name, int namelen);
+
+/**
+ * fdt_add_subnode - creates a new node
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ *
+ * fdt_add_subnode() creates a new node as a subnode of the node at
+ * structure block offset parentoffset, with the given name (which
+ * should include the unit address, if any).
+ *
+ * This function will insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+
+ * returns:
+ *	structure block offset of the created nodeequested subnode (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
+ *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE tag
+ *	-FDT_ERR_EXISTS, if the node at parentoffset already has a subnode of
+ *		the given name
+ *	-FDT_ERR_NOSPACE, if there is insufficient free space in the
+ *		blob to contain the new node
+ *	-FDT_ERR_NOSPACE
+ *	-FDT_ERR_BADLAYOUT
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
 int fdt_add_subnode(void *fdt, int parentoffset, const char *name);
+
+/**
+ * fdt_del_node - delete a node (subtree)
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_del_node() will remove the given node, including all its
+ * subnodes if any, from the blob.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_del_node(void *fdt, int nodeoffset);
 
 /**********************************************************************/
Index: working-2.6/arch/powerpc/boot/libfdt/libfdt_internal.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/libfdt_internal.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt/libfdt_internal.h	2008-08-07 12:06:18.000000000 +1000
@@ -52,38 +52,44 @@
  */
 #include <fdt.h>
 
-#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
-#define PALIGN(p, a)	((void *)ALIGN((unsigned long)(p), (a)))
+#define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
 
-#define memeq(p, q, n)	(memcmp((p), (q), (n)) == 0)
-#define streq(p, q)	(strcmp((p), (q)) == 0)
+#define FDT_CHECK_HEADER(fdt) \
+	{ \
+		int err; \
+		if ((err = fdt_check_header(fdt)) != 0) \
+			return err; \
+	}
 
 uint32_t _fdt_next_tag(const void *fdt, int startoffset, int *nextoffset);
+int _fdt_check_node_offset(const void *fdt, int offset);
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s);
 int _fdt_node_end_offset(void *fdt, int nodeoffset);
 
 static inline const void *_fdt_offset_ptr(const void *fdt, int offset)
 {
-	return fdt + fdt_off_dt_struct(fdt) + offset;
+	return (const char *)fdt + fdt_off_dt_struct(fdt) + offset;
 }
 
 static inline void *_fdt_offset_ptr_w(void *fdt, int offset)
 {
-	return (void *)_fdt_offset_ptr(fdt, offset);
+	return (void *)(uintptr_t)_fdt_offset_ptr(fdt, offset);
 }
 
 static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int n)
 {
 	const struct fdt_reserve_entry *rsv_table =
-		fdt + fdt_off_mem_rsvmap(fdt);
+		(const struct fdt_reserve_entry *)
+		((const char *)fdt + fdt_off_mem_rsvmap(fdt));
 
 	return rsv_table + n;
 }
 static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
 {
-	return (void *)_fdt_mem_rsv(fdt, n);
+	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
 }
 
-#define SW_MAGIC		(~FDT_MAGIC)
+#define FDT_SW_MAGIC		(~FDT_MAGIC)
 
 #endif /* _LIBFDT_INTERNAL_H */
Index: working-2.6/arch/powerpc/boot/dtc-src/libfdt_env.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/dtc-src/libfdt_env.h	2008-08-07 12:06:18.000000000 +1000
@@ -0,0 +1,23 @@
+#ifndef _LIBFDT_ENV_H
+#define _LIBFDT_ENV_H
+
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
+static inline uint32_t fdt32_to_cpu(uint32_t x)
+{
+	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
+}
+#define cpu_to_fdt32(x) fdt32_to_cpu(x)
+
+static inline uint64_t fdt64_to_cpu(uint64_t x)
+{
+	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
+		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
+}
+#define cpu_to_fdt64(x) fdt64_to_cpu(x)
+#undef _B
+
+#endif /* _LIBFDT_ENV_H */
Index: working-2.6/arch/powerpc/boot/libfdt_env.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt_env.h	2008-06-25 10:08:36.000000000 +1000
+++ working-2.6/arch/powerpc/boot/libfdt_env.h	2008-08-07 12:06:18.000000000 +1000
@@ -6,6 +6,7 @@
 
 typedef u32 uint32_t;
 typedef u64 uint64_t;
+typedef unsigned long uintptr_t;
 
 #define fdt16_to_cpu(x)		(x)
 #define cpu_to_fdt16(x)		(x)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
