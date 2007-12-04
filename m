Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 14:26:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc:  Add may const qualifications
Message-ID: <20071204032615.GK32577@localhost.localdomain>
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

This adds 'const' qualifiers to many variables and functions.  In
particular it's now used for passing names to the tree accesor
functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-12-04 11:49:54.000000000 +1100
+++ dtc/data.c	2007-12-04 14:11:35.000000000 +1100
@@ -64,7 +64,7 @@ struct data data_grow_for(struct data d,
 	return nd;
 }
 
-struct data data_copy_mem(char *mem, int len)
+struct data data_copy_mem(const char *mem, int len)
 {
 	struct data d;
 
@@ -76,7 +76,7 @@ struct data data_copy_mem(char *mem, int
 	return d;
 }
 
-static char get_oct_char(char *s, int *i)
+static char get_oct_char(const char *s, int *i)
 {
 	char x[4];
 	char *endx;
@@ -98,7 +98,7 @@ static char get_oct_char(char *s, int *i
 	return val;
 }
 
-static char get_hex_char(char *s, int *i)
+static char get_hex_char(const char *s, int *i)
 {
 	char x[3];
 	char *endx;
@@ -117,7 +117,7 @@ static char get_hex_char(char *s, int *i
 	return val;
 }
 
-struct data data_copy_escape_string(char *s, int len)
+struct data data_copy_escape_string(const char *s, int len)
 {
 	int i = 0;
 	struct data d;
@@ -194,7 +194,7 @@ struct data data_copy_file(FILE *f, size
 	return d;
 }
 
-struct data data_append_data(struct data d, void *p, int len)
+struct data data_append_data(struct data d, const void *p, int len)
 {
 	d = data_grow_for(d, len);
 	memcpy(d.val + d.len, p, len);
@@ -237,7 +237,7 @@ struct data data_append_cell(struct data
 	return data_append_data(d, &beword, sizeof(beword));
 }
 
-struct data data_append_re(struct data d, struct fdt_reserve_entry *re)
+struct data data_append_re(struct data d, const struct fdt_reserve_entry *re)
 {
 	struct fdt_reserve_entry bere;
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-12-04 11:49:55.000000000 +1100
+++ dtc/dtc.c	2007-12-04 14:16:51.000000000 +1100
@@ -30,7 +30,7 @@ int quiet;		/* Level of quietness */
 int reservenum;		/* Number of memory reservation slots */
 int minsize;		/* Minimum blob size */
 
-char *join_path(char *path, char *name)
+char *join_path(const char *path, const char *name)
 {
 	int lenp = strlen(path);
 	int lenn = strlen(name);
@@ -54,10 +54,10 @@ char *join_path(char *path, char *name)
 	return str;
 }
 
-void fill_fullpaths(struct node *tree, char *prefix)
+void fill_fullpaths(struct node *tree, const char *prefix)
 {
 	struct node *child;
-	char *unit;
+	const char *unit;
 
 	tree->fullpath = join_path(prefix, tree->name);
 
@@ -109,11 +109,11 @@ static void  __attribute__ ((noreturn)) 
 int main(int argc, char *argv[])
 {
 	struct boot_info *bi;
-	char *inform = "dts";
-	char *outform = "dts";
-	char *outname = "-";
+	const char *inform = "dts";
+	const char *outform = "dts";
+	const char *outname = "-";
 	int force = 0, check = 0;
-	char *arg;
+	const char *arg;
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-12-04 11:49:54.000000000 +1100
+++ dtc/flattree.c	2007-12-04 14:22:47.000000000 +1100
@@ -51,9 +51,9 @@ struct emitter {
 	void (*string)(void *, char *, int);
 	void (*align)(void *, int);
 	void (*data)(void *, struct data);
-	void (*beginnode)(void *, char *);
-	void (*endnode)(void *, char *);
-	void (*property)(void *, char *);
+	void (*beginnode)(void *, const char *);
+	void (*endnode)(void *, const char *);
+	void (*property)(void *, const char *);
 };
 
 static void bin_emit_cell(void *e, cell_t val)
@@ -88,17 +88,17 @@ static void bin_emit_data(void *e, struc
 	*dtbuf = data_append_data(*dtbuf, d.val, d.len);
 }
 
-static void bin_emit_beginnode(void *e, char *label)
+static void bin_emit_beginnode(void *e, const char *label)
 {
 	bin_emit_cell(e, FDT_BEGIN_NODE);
 }
 
-static void bin_emit_endnode(void *e, char *label)
+static void bin_emit_endnode(void *e, const char *label)
 {
 	bin_emit_cell(e, FDT_END_NODE);
 }
 
-static void bin_emit_property(void *e, char *label)
+static void bin_emit_property(void *e, const char *label)
 {
 	bin_emit_cell(e, FDT_PROP);
 }
@@ -113,14 +113,14 @@ static struct emitter bin_emitter = {
 	.property = bin_emit_property,
 };
 
-static void emit_label(FILE *f, char *prefix, char *label)
+static void emit_label(FILE *f, const char *prefix, const char *label)
 {
 	fprintf(f, "\t.globl\t%s_%s\n", prefix, label);
 	fprintf(f, "%s_%s:\n", prefix, label);
 	fprintf(f, "_%s_%s:\n", prefix, label);
 }
 
-static void emit_offset_label(FILE *f, char *label, int offset)
+static void emit_offset_label(FILE *f, const char *label, int offset)
 {
 	fprintf(f, "\t.globl\t%s\n", label);
 	fprintf(f, "%s\t= . + %d\n", label, offset);
@@ -191,7 +191,7 @@ static void asm_emit_data(void *e, struc
 	assert(off == d.len);
 }
 
-static void asm_emit_beginnode(void *e, char *label)
+static void asm_emit_beginnode(void *e, const char *label)
 {
 	FILE *f = e;
 
@@ -202,7 +202,7 @@ static void asm_emit_beginnode(void *e, 
 	fprintf(f, "\t.long\tFDT_BEGIN_NODE\n");
 }
 
-static void asm_emit_endnode(void *e, char *label)
+static void asm_emit_endnode(void *e, const char *label)
 {
 	FILE *f = e;
 
@@ -213,7 +213,7 @@ static void asm_emit_endnode(void *e, ch
 	}
 }
 
-static void asm_emit_property(void *e, char *label)
+static void asm_emit_property(void *e, const char *label)
 {
 	FILE *f = e;
 
@@ -234,7 +234,7 @@ static struct emitter asm_emitter = {
 	.property = asm_emit_property,
 };
 
-static int stringtable_insert(struct data *d, char *str)
+static int stringtable_insert(struct data *d, const char *str)
 {
 	int i;
 
@@ -432,7 +432,7 @@ void dt_to_blob(FILE *f, struct boot_inf
 
 static void dump_stringtable_asm(FILE *f, struct data strbuf)
 {
-	char *p;
+	const char *p;
 	int len;
 
 	p = strbuf.val;
@@ -450,7 +450,7 @@ void dt_to_asm(FILE *f, struct boot_info
 	int i;
 	struct data strbuf = empty_data;
 	struct reserve_info *re;
-	char *symprefix = "dt";
+	const char *symprefix = "dt";
 
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
@@ -594,7 +594,7 @@ static void flat_realign(struct inbuf *i
 static char *flat_read_string(struct inbuf *inb)
 {
 	int len = 0;
-	char *p = inb->ptr;
+	const char *p = inb->ptr;
 	char *str;
 
 	do {
@@ -631,7 +631,7 @@ static struct data flat_read_data(struct
 
 static char *flat_read_stringtable(struct inbuf *inb, int offset)
 {
-	char *p;
+	const char *p;
 
 	p = inb->base + offset;
 	while (1) {
@@ -673,7 +673,7 @@ static struct reserve_info *flat_read_me
 {
 	struct reserve_info *reservelist = NULL;
 	struct reserve_info *new;
-	char *p;
+	const char *p;
 	struct fdt_reserve_entry re;
 
 	/*
@@ -698,9 +698,9 @@ static struct reserve_info *flat_read_me
 }
 
 
-static char *nodename_from_path(char *ppath, char *cpath)
+static char *nodename_from_path(const char *ppath, const char *cpath)
 {
-	char *lslash;
+	const char *lslash;
 	int plen;
 
 	lslash = strrchr(cpath, '/');
@@ -724,9 +724,9 @@ static char *nodename_from_path(char *pp
 static const char PROPCHAR[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,._+*#?-";
 static const char UNITCHAR[] = "0123456789abcdef,";
 
-static int check_node_name(char *name)
+static int check_node_name(const char *name)
 {
-	char *atpos;
+	const char *atpos;
 	int basenamelen;
 
 	atpos = strrchr(name, '@');
@@ -748,7 +748,7 @@ static int check_node_name(char *name)
 
 static struct node *unflatten_tree(struct inbuf *dtbuf,
 				   struct inbuf *strbuf,
-				   char *parent_path, int flags)
+				   const char *parent_path, int flags)
 {
 	struct node *node;
 	u32 val;
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-12-04 11:49:54.000000000 +1100
+++ dtc/livetree.c	2007-12-04 14:13:56.000000000 +1100
@@ -180,7 +180,7 @@ struct boot_info *build_boot_info(struct
  * Tree accessor functions
  */
 
-char *get_unitname(struct node *node)
+const char *get_unitname(struct node *node)
 {
 	if (node->name[node->basenamelen] == '\0')
 		return "";
@@ -188,7 +188,7 @@ char *get_unitname(struct node *node)
 		return node->name + node->basenamelen + 1;
 }
 
-struct property *get_property(struct node *node, char *propname)
+struct property *get_property(struct node *node, const char *propname)
 {
 	struct property *prop;
 
@@ -205,7 +205,7 @@ cell_t propval_cell(struct property *pro
 	return be32_to_cpu(*((cell_t *)prop->val.val));
 }
 
-struct node *get_subnode(struct node *node, char *nodename)
+struct node *get_subnode(struct node *node, const char *nodename)
 {
 	struct node *child;
 
@@ -216,9 +216,9 @@ struct node *get_subnode(struct node *no
 	return NULL;
 }
 
-struct node *get_node_by_path(struct node *tree, char *path)
+struct node *get_node_by_path(struct node *tree, const char *path)
 {
-	char *p;
+	const char *p;
 	struct node *child;
 
 	if (!path || ! (*path))
@@ -275,7 +275,7 @@ struct node *get_node_by_phandle(struct 
 	return NULL;
 }
 
-struct node *get_node_by_ref(struct node *tree, char *ref)
+struct node *get_node_by_ref(struct node *tree, const char *ref)
 {
 	if (ref[0] == '/')
 		return get_node_by_path(tree, ref);
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-12-04 11:49:55.000000000 +1100
+++ dtc/dtc.h	2007-12-04 14:17:24.000000000 +1100
@@ -133,14 +133,14 @@ void data_free(struct data d);
 
 struct data data_grow_for(struct data d, int xlen);
 
-struct data data_copy_mem(char *mem, int len);
-struct data data_copy_escape_string(char *s, int len);
+struct data data_copy_mem(const char *mem, int len);
+struct data data_copy_escape_string(const char *s, int len);
 struct data data_copy_file(FILE *f, size_t len);
 
-struct data data_append_data(struct data d, void *p, int len);
+struct data data_append_data(struct data d, const void *p, int len);
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
-struct data data_append_re(struct data d, struct fdt_reserve_entry *re);
+struct data data_append_re(struct data d, const struct fdt_reserve_entry *re);
 struct data data_append_addr(struct data d, u64 addr);
 struct data data_append_byte(struct data d, uint8_t byte);
 struct data data_append_zeroes(struct data d, int len);
@@ -199,14 +199,14 @@ struct node *chain_node(struct node *fir
 void add_property(struct node *node, struct property *prop);
 void add_child(struct node *parent, struct node *child);
 
-char *get_unitname(struct node *node);
-struct property *get_property(struct node *node, char *propname);
+const char *get_unitname(struct node *node);
+struct property *get_property(struct node *node, const char *propname);
 cell_t propval_cell(struct property *prop);
-struct node *get_subnode(struct node *node, char *nodename);
-struct node *get_node_by_path(struct node *tree, char *path);
+struct node *get_subnode(struct node *node, const char *nodename);
+struct node *get_node_by_path(struct node *tree, const char *path);
 struct node *get_node_by_label(struct node *tree, const char *label);
 struct node *get_node_by_phandle(struct node *tree, cell_t phandle);
-struct node *get_node_by_ref(struct node *tree, char *ref);
+struct node *get_node_by_ref(struct node *tree, const char *ref);
 cell_t get_node_phandle(struct node *root, struct node *node);
 
 /* Boot info (tree plus memreserve information */
@@ -255,11 +255,11 @@ struct boot_info *dt_from_source(const c
 
 /* FS trees */
 
-struct boot_info *dt_from_fs(char *dirname);
+struct boot_info *dt_from_fs(const char *dirname);
 
 /* misc */
 
-char *join_path(char *path, char *name);
-void fill_fullpaths(struct node *tree, char *prefix);
+char *join_path(const char *path, const char *name);
+void fill_fullpaths(struct node *tree, const char *prefix);
 
 #endif /* _DTC_H */
Index: dtc/fstree.c
===================================================================
--- dtc.orig/fstree.c	2007-12-04 14:17:03.000000000 +1100
+++ dtc/fstree.c	2007-12-04 14:17:34.000000000 +1100
@@ -23,7 +23,7 @@
 #include <dirent.h>
 #include <sys/stat.h>
 
-static struct node *read_fstree(char *dirname)
+static struct node *read_fstree(const char *dirname)
 {
 	DIR *d;
 	struct dirent *de;
@@ -80,7 +80,7 @@ static struct node *read_fstree(char *di
 	return tree;
 }
 
-struct boot_info *dt_from_fs(char *dirname)
+struct boot_info *dt_from_fs(const char *dirname)
 {
 	struct node *tree;
 
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-12-04 14:18:20.000000000 +1100
+++ dtc/treesource.c	2007-12-04 14:18:46.000000000 +1100
@@ -58,7 +58,7 @@ int isstring(char c)
 
 static void write_propval_string(FILE *f, struct data val)
 {
-	char *str = val.val;
+	const char *str = val.val;
 	int i;
 	int newchunk = 1;
 	struct marker *m = val.markers;
@@ -161,7 +161,7 @@ static void write_propval_cells(FILE *f,
 static void write_propval_bytes(FILE *f, struct data val)
 {
 	void *propend = val.val + val.len;
-	char *bp = val.val;
+	const char *bp = val.val;
 	struct marker *m = val.markers;
 
 	fprintf(f, "[");
@@ -189,7 +189,7 @@ static void write_propval_bytes(FILE *f,
 static void write_propval(FILE *f, struct property *prop)
 {
 	int len = prop->val.len;
-	char *p = prop->val.val;
+	const char *p = prop->val.val;
 	struct marker *m = prop->val.markers;
 	int nnotstring = 0, nnul = 0;
 	int nnotstringlbl = 0, nnotcelllbl = 0;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
