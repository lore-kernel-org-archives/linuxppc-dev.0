Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7D0C067CA4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jul 2005 06:03:53 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20050712040623.GG3945@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712040623.GG3945@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1121371427.24467.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 14 Jul 2005 15:03:47 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-07-11 at 23:06, David Gibson wrote:
> On Mon, Jul 11, 2005 at 04:22:30PM -0500, Jon Loeliger wrote:
> > On Sun, 2005-07-10 at 23:55, David Gibson wrote:
> > > On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
> [snip]
> > > Biggest thing is that rather than passing the tree itself and the
> > > memreserve info about as two parameters all over the place, I'd rather
> > > create a new structure which has both (and later can have anything
> > > else that might be needed).
> > 
> > If you'd like, I'll do this work.
> 
> That would be helpful.  You'll need to rediff, though, I merged a
> couple of bugfixes from your patch that weren't directly related to
> the memreserve stuff.

David,

Here is an updated version of the patch that obsoletes
the previous one I submitted.  I have incorporated all
of your syntactic suggestions except not using the
split-64 values (ie, this still uses 'struct data').
It primarily merges in the changes that you adopted
from earlier and implements a new structure at the
base of the parse tree to hold both the device tree
and the header information.  I called that new stucuture
'struct header_tree'.  Feel free to dream up something
better. :-)

Signed-off-by: Jon Loeliger <jdl@freescale.com>

Thanks,
jdl




diff --git a/dtc-lexer.l b/dtc-lexer.l
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -87,6 +87,11 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return ']';
 		}
 
+"/memreserve/"	{
+			DPRINT("Keyword: /memreserve/\n");
+			return DT_MEMRESERVE;
+		}
+
 {PROPCHAR}+	{
 			DPRINT("PropName: %s\n", yytext);
 			yylval.str = strdup(yytext);
diff --git a/dtc-parser.y b/dtc-parser.y
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -24,8 +24,6 @@
 int yylex (void);
 void yyerror (char const *);
 
-extern struct node *device_tree;
-
 %}
 
 %union {
@@ -41,6 +39,7 @@ extern struct node *device_tree;
 	int hexlen;
 }
 
+%token DT_MEMRESERVE
 %token <str> DT_PROPNAME
 %token <str> DT_NODENAME
 %token <cval> DT_CELL
@@ -51,11 +50,13 @@ extern struct node *device_tree;
 %token <str> DT_REF
 
 %type <data> propdata
+%type <data> headersection
 %type <data> celllist
 %type <data> bytestring
 %type <prop> propdef
 %type <proplist> proplist
 
+%type <node> devicetree
 %type <node> nodedef
 %type <node> subnode
 %type <nodelist> subnodes
@@ -66,9 +67,29 @@ extern struct node *device_tree;
 
 %%
 
-devicetree:	{
-			assert(device_tree == NULL);
-		} '/' nodedef { device_tree = name_node($3, "", NULL); }
+sourcefile:
+	headersection
+	devicetree
+		{
+			build_header_tree($1, $2);
+		}
+	;
+
+headersection:
+		/* empty */
+		{
+			$$ = empty_data;
+		}
+	|	DT_MEMRESERVE  '=' '<' celllist '>' ';'
+		{
+			$$ = build_mem_reserve($4);
+		}
+	;
+
+devicetree:	'/' nodedef
+		{
+			$$ = name_node($2, "", NULL);
+		}
 	;
 
 nodedef:	'{' proplist subnodes '}' ';' {
diff --git a/dtc.c b/dtc.c
--- a/dtc.c
+++ b/dtc.c
@@ -102,7 +102,7 @@ static void usage(void)
 
 int main(int argc, char *argv[])
 {
-	struct node *dt;
+	struct header_tree *ht;
 	char *inform = "dts";
 	char *outform = "dts";
 	char *outname = "-";
@@ -151,12 +151,12 @@ int main(int argc, char *argv[])
 
 	if (streq(inform, "dts")) {
 		inf = dtc_open_file(arg);
-		dt = dt_from_source(inf);
+		ht = dt_from_source(inf);
 	} else if (streq(inform, "fs")) {
-		dt = dt_from_fs(arg);
+		ht = dt_from_fs(arg);
 	} else if(streq(inform, "dtb")) {
 		inf = dtc_open_file(arg);
-		dt = dt_from_blob(inf);
+		ht = dt_from_blob(inf);
 	} else {
 		die("Unknown input format \"%s\"\n", inform);
 	}
@@ -164,10 +164,10 @@ int main(int argc, char *argv[])
 	if (inf && (inf != stdin))
 		fclose(inf);
 
-	if (! dt)
+	if (! ht || ! ht->root)
 		die("Couldn't read input tree\n");
 
-	if (! check_device_tree(dt)) {
+	if (! check_device_tree(ht->root)) {
 		fprintf(stderr, "Input tree has errors\n");
 		if (! force)
 			exit(1);
@@ -183,11 +183,11 @@ int main(int argc, char *argv[])
 	}
 
 	if (streq(outform, "dts")) {
-		write_tree_source(outf, dt, 0);
+		write_tree_source(outf, ht);
 	} else if (streq(outform, "dtb")) {
-		write_dt_blob(outf, dt, outversion, reservenum);
+		write_dt_blob(outf, ht, outversion);
 	} else if (streq(outform, "asm")) {
-		write_dt_asm(outf, dt, outversion, reservenum);
+		write_dt_asm(outf, ht, outversion);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
diff --git a/dtc.h b/dtc.h
--- a/dtc.h
+++ b/dtc.h
@@ -118,6 +118,24 @@ struct data data_add_fixup(struct data d
 
 int data_is_one_string(struct data d);
 
+struct data build_mem_reserve(struct data d);
+
+
+/*
+ * Combined Header and Tree information.
+ */
+struct header_tree {
+	struct data mem_reserve_data;	/* mem reserve from header */
+	struct node *root;		/* root of the device tree */
+};
+
+struct header_tree *alloc_header_tree(struct data mem_reserve_data,
+				      struct node *tree);
+
+void build_header_tree(struct data mem_reserve_data,
+		       struct node *tree);
+
+
 /* DT constraints */
 
 #define MAX_PROPNAME_LEN	31
@@ -175,20 +193,19 @@ enum flat_dt_format {
 	FFMT_ASM,
 };
 
-void write_dt_blob(FILE *f, struct node *tree, int version, int reservenum);
-void write_dt_asm(FILE *f, struct node *tree, int version, int reservenum);
+void write_dt_blob(FILE *f, struct header_tree *ht, int version);
+void write_dt_asm(FILE *f, struct header_tree *ht, int version);
 
-struct node *dt_from_blob(FILE *f);
+struct header_tree *dt_from_blob(FILE *f);
 
 /* Tree source */
 
-void write_tree_source(FILE *f, struct node *tree, int level);
-
-struct node *dt_from_source(FILE *f);
+void write_tree_source(FILE *f, struct header_tree *ht);
+struct header_tree *dt_from_source(FILE *f);
 
 /* FS trees */
 
-struct node *dt_from_fs(char *dirname);
+struct header_tree *dt_from_fs(char *dirname);
 
 /* misc */
 
diff --git a/flattree.c b/flattree.c
--- a/flattree.c
+++ b/flattree.c
@@ -287,11 +287,12 @@ static void flatten_tree(struct node *tr
 }
 
 static void make_bph(struct boot_param_header *bph,
-			     struct version_info *vi,
-			     int reservenum,
-			     int dtsize, int strsize)
+		     struct version_info *vi,
+		     struct data *mem_reserve_data,
+		     int dtsize, int strsize)
 {
 	int reserve_off;
+	int reservenum = mem_reserve_data->len / sizeof(struct reserve_entry);
 	int reservesize = (reservenum+1) * sizeof(struct reserve_entry);
 
 	memset(bph, 0xff, sizeof(*bph));
@@ -316,7 +317,7 @@ static void make_bph(struct boot_param_h
 		bph->size_dt_strings = cpu_to_be32(strsize);
 }
 
-void write_dt_blob(FILE *f, struct node *tree, int version, int reservenum)
+void write_dt_blob(FILE *f, struct header_tree *ht, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -335,18 +336,31 @@ void write_dt_blob(FILE *f, struct node 
 	dtbuf = empty_data;
 	strbuf = empty_data;
 
-	flatten_tree(tree, &bin_emitter, &dtbuf, &strbuf, vi);
+	flatten_tree(ht->root, &bin_emitter, &dtbuf, &strbuf, vi);
 	bin_emit_cell(&dtbuf, OF_DT_END);
 
-	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);
+	/*
+	 * Make header.
+	 */
+	make_bph(&bph, vi, &ht->mem_reserve_data, dtbuf.len, strbuf.len);
+
+	fwrite(&bph, vi->hdr_size, 1, f);
 
 	/* Align the reserve map to an 8 byte boundary */
 	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
 		fputc(0, f);
 
-	fwrite(&bph, vi->hdr_size, 1, f);
-	for (i = 0; i < reservenum+1; i++)
-		fwrite(&re, sizeof(re), 1, f);
+	/*
+	 * Reserve map entries.
+	 * Since the blob is relocatable, the address of the map is not
+	 * determinable here, so no entry is made for the DT itself.
+	 * Each entry is an (address, size) pair of u64 values.
+	 * Always supply a zero-sized temination entry.
+	 */
+	fwrite(ht->mem_reserve_data.val, ht->mem_reserve_data.len, 1, f);
+	re.address = 0;
+	re.size = 0;
+	fwrite(&re, sizeof(re), 1, f);
 
 	fwrite(dtbuf.val, dtbuf.len, 1, f);
 	fwrite(strbuf.val, strbuf.len, 1, f);
@@ -372,7 +386,7 @@ void dump_stringtable_asm(FILE *f, struc
 	}
 }
 
-void write_dt_asm(FILE *f, struct node *tree, int version, int reservenum)
+void write_dt_asm(FILE *f, struct header_tree *ht, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -416,20 +430,30 @@ void write_dt_asm(FILE *f, struct node *
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
 			symprefix, symprefix);
 
-	/* align the reserve map to a doubleword boundary */
+	/*
+	 * Reserve map entries.
+	 * Align the reserve map to a doubleword boundary.
+	 * Each entry is an (address, size) pair of u64 values.
+	 * Since the ASM file variant can relocate and compute the address
+	 * and size of the the device tree itself, and an entry for it.
+	 * Always supply a zero-sized temination entry.
+	 */
 	asm_emit_align(f, 8);
 	emit_label(f, symprefix, "reserve_map");
-	/* reserve map entry for the device tree itself */
 	fprintf(f, "\t.long\t0, _%s_blob_start\n", symprefix);
 	fprintf(f, "\t.long\t0, _%s_blob_end - _%s_blob_start\n",
 		symprefix, symprefix);
-	for (i = 0; i < reservenum+1; i++) {
-		fprintf(f, "\t.llong\t0\n");
-		fprintf(f, "\t.llong\t0\n");
+
+	if (ht->mem_reserve_data.len > 0) {
+		fprintf(f, "/* Memory reserve map from source file */\n");
+		asm_emit_data(f, ht->mem_reserve_data);
 	}
 
+	fprintf(f, "\t.llong\t0\n");
+	fprintf(f, "\t.llong\t0\n");
+
 	emit_label(f, symprefix, "struct_start");
-	flatten_tree(tree, &asm_emitter, f, &strbuf, vi);
+	flatten_tree(ht->root, &asm_emitter, f, &strbuf, vi);
 	fprintf(f, "\t.long\tOF_DT_END\n");
 	emit_label(f, symprefix, "struct_end");
 
@@ -560,6 +584,43 @@ struct property *flat_read_property(stru
 	return build_property(name, val, NULL);
 }
 
+
+static struct data flat_read_mem_reserve(struct inbuf *inb)
+{
+	char *p;
+	int len = 0;
+	int done = 0;
+	cell_t cells[4];
+	struct data d;
+
+	d = empty_data;
+
+	/*
+	 * Each entry is a pair of u64 (addr, size) values for 4 cell_t's.
+	 * List terminates at an entry with size equal to zero.
+	 *
+	 * First pass, count entries.
+	 */
+	p = inb->ptr;
+	do {
+		flat_read_chunk(inb, &cells[0], 4 * sizeof(cell_t));
+		if (cells[2] == 0 && cells[3] == 0) {
+			done = 1;
+		} else {
+			++len;
+		}
+	} while (!done);
+
+	/*
+	 * Back up for pass two, reading the whole data value.
+	 */
+	inb->ptr = p;
+	d = flat_read_data(inb, len * 4 * sizeof(cell_t));
+
+	return d;
+}
+
+
 static char *nodename_from_path(char *ppath, char *cpath)
 {
 	char *lslash;
@@ -667,16 +728,21 @@ static struct node *unflatten_tree(struc
 	return node;
 }
 
-struct node *dt_from_blob(FILE *f)
+
+struct header_tree *dt_from_blob(FILE *f)
 {
-	u32 magic, totalsize, off_dt, off_str, version, size_str;
+	u32 magic, totalsize, version, size_str;
+	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
 	struct boot_param_header *bph;
 	char *p;
 	struct inbuf dtbuf, strbuf;
+	struct inbuf memresvbuf;
 	int sizeleft;
+	struct data mem_reserve_data;
 	struct node *tree;
+	struct header_tree *ht;
 	u32 val;
 	int flags = 0;
 
@@ -734,18 +800,21 @@ struct node *dt_from_blob(FILE *f)
 
 	off_dt = be32_to_cpu(bph->off_dt_struct);
 	off_str = be32_to_cpu(bph->off_dt_strings);
+	off_mem_rsvmap = be32_to_cpu(bph->off_mem_rsvmap);
 	version = be32_to_cpu(bph->version);
 
 	fprintf(stderr, "\tmagic:\t\t\t0x%x\n", magic);
 	fprintf(stderr, "\ttotalsize:\t\t%d\n", totalsize);
 	fprintf(stderr, "\toff_dt_struct:\t\t0x%x\n", off_dt);
 	fprintf(stderr, "\toff_dt_strings:\t\t0x%x\n", off_str);
-	fprintf(stderr, "\toff_mem_rsvmap:\t\t0x%x\n",
-		be32_to_cpu(bph->off_mem_rsvmap));
+	fprintf(stderr, "\toff_mem_rsvmap:\t\t0x%x\n", off_mem_rsvmap);
 	fprintf(stderr, "\tversion:\t\t0x%x\n", version );
 	fprintf(stderr, "\tlast_comp_version:\t0x%x\n",
 		be32_to_cpu(bph->last_comp_version));
 
+	if (off_mem_rsvmap >= totalsize)
+		die("Mem Reserve structure offset exceeds total size\n");
+
 	if (off_dt >= totalsize)
 		die("DT structure offset exceeds total size\n");
 
@@ -767,12 +836,16 @@ struct node *dt_from_blob(FILE *f)
 		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
 	}
 
+	inbuf_init(&memresvbuf,
+		   blob + off_mem_rsvmap, blob + totalsize);
 	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
 	inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 
 	if (version >= 3)
 		strbuf.limit = strbuf.base + size_str;
 
+	mem_reserve_data = flat_read_mem_reserve(&memresvbuf);
+
 	val = flat_read_word(&dtbuf);
 
 	if (val != OF_DT_BEGIN_NODE)
@@ -786,5 +859,7 @@ struct node *dt_from_blob(FILE *f)
 
 	free(blob);
 
-	return tree;
+	ht = alloc_header_tree(mem_reserve_data, tree);
+
+	return ht;
 }
diff --git a/fstree.c b/fstree.c
--- a/fstree.c
+++ b/fstree.c
@@ -80,8 +80,9 @@ static struct node *read_fstree(char *di
 	return tree;
 }
 
-struct node *dt_from_fs(char *dirname)
+struct header_tree *dt_from_fs(char *dirname)
 {
+	struct header_tree *ht;
 	struct node *tree;
 
 	tree = read_fstree(dirname);
@@ -89,6 +90,7 @@ struct node *dt_from_fs(char *dirname)
 
 	fill_fullpaths(tree, "");
 
-	return tree;
+	ht = alloc_header_tree(empty_data, tree);
+	return ht;
 }
 
diff --git a/treesource.c b/treesource.c
--- a/treesource.c
+++ b/treesource.c
@@ -20,20 +20,60 @@
 
 #include "dtc.h"
 
-struct node *device_tree;
-
 extern FILE *yyin;
 extern int yyparse(void);
+extern void yyerror(char const *);
+
+static struct header_tree *the_header_tree;
+
+
+struct header_tree *alloc_header_tree(struct data mem_reserve_data,
+				      struct node *tree)
+{
+	struct header_tree *ht;
+
+	ht = xmalloc(sizeof(*ht));
+	ht->root = tree;
+	ht->mem_reserve_data = mem_reserve_data;
+
+	return ht;
+}
+
 
-struct node *dt_from_source(FILE *f)
+void build_header_tree(struct data mem_reserve_data,
+		       struct node *tree)
 {
+	struct header_tree *ht;
+
+	ht = alloc_header_tree(mem_reserve_data, tree);
+
+	the_header_tree = ht;
+}
+
+
+struct data build_mem_reserve(struct data d)
+{
+	/*
+	 * FIXME: Should reconcile the -R parameter here now?
+	 */
+	if (d.len % 16 != 0) {
+		yyerror("Memory Reserve entries are <u64 addr, u64 size>\n");
+	}
+	return d;
+}
+
+
+struct header_tree *dt_from_source(FILE *f)
+{
+	the_header_tree = NULL;
+
 	yyin = f;
 	if (yyparse() != 0)
 		return NULL;
 
-	fill_fullpaths(device_tree, "");
+	fill_fullpaths(the_header_tree->root, "");
 
-	return device_tree;
+	return the_header_tree;
 }
 
 static void write_prefix(FILE *f, int level)
@@ -75,7 +115,8 @@ static enum proptype guess_type(struct p
 		
 }
 
-void write_tree_source(FILE *f, struct node *tree, int level)
+
+void write_tree_source_node(FILE *f, struct node *tree, int level)
 {
 	struct property *prop;
 	struct node *child;
@@ -133,8 +174,39 @@ void write_tree_source(FILE *f, struct n
 	}
 	for_each_child(tree, child) {
 		fprintf(f, "\n");
-		write_tree_source(f, child, level+1);
+		write_tree_source_node(f, child, level+1);
 	}
 	write_prefix(f, level);
 	fprintf(f, "};\n");
 }
+
+
+void write_tree_source(FILE *f, struct header_tree *ht)
+{
+	int i;
+	int ncells;
+	cell_t *cp;
+
+	if (ht->mem_reserve_data.len > 0) {
+		fprintf(f, "/memreserve/ =\t<\n");
+		cp = (cell_t *)ht->mem_reserve_data.val;
+		ncells = ht->mem_reserve_data.len / sizeof(cell_t);
+		for (i = 0; i < ncells; i++) {
+			if (i % 4 == 0) {
+				fprintf(f, "\t\t\t");
+			}
+			fprintf(f, "%x", be32_to_cpu(*cp++));
+			if (i % 4 == 1) {
+				fprintf(f, "  ");
+			} else if (i % 4 == 3) {
+				fprintf(f, "\n");
+			} else {
+				fprintf(f, " ");
+			}
+		}
+		fprintf(f, "\t\t>;\n\n");
+	}
+
+	write_tree_source_node(f, ht->root, 0);
+}
+
