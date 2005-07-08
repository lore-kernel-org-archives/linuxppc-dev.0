Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C0F6067C0D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2005 07:45:07 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain
Message-Id: <1120859097.8609.15.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 08 Jul 2005 16:44:58 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David and Ben,

This patch adds support for memreserve to the DTC's notion
of the "source file".  That is, you can now say this:
        
        
        memreserve =	<
        		 0000 0001  0000 0002
        		 0000 0003  0000 0004
        		>
        
        / {
        	model = "MPC8555CDS";
        	compatible = "MPC85xxCDS";
        	#address-cells = <2>;
        	#size-cells = <2>;
        	linux,phandle = <100>;

There is minor fiddling with the -R flag that needs to be
resolved at this point.

I've included read and writing for the source and blob formats,
but don't have a clue what to do with the /proc/devices format.

I've also tinkered the Makefile to do automatic dependency
file generation and inclusion.  Yep, I got bit by out of
date dependencies during my development here. :-)

Please feel free to adjust my coding approach or argument
passing or whatever as needed.  Hope this helps!

Enjoy,
jdl

PS -- Is this the right forum to continue to post the DTC patches?


Signed-off-by: Jon Loeliger <jdl@freescale.com>



Index: Makefile
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -6,29 +6,35 @@
 OBJS = dtc.o livetree.o flattree.o data.o treesource.o fstree.o \
 	dtc-parser.tab.o lex.yy.o
 
-all: $(TARGETS)
+DEPFILES := $(OBJS:.o=.d)
+
+
+all: $(DEPFILES) $(TARGETS)
 
 dtc:	$(OBJS)
 	$(LINK.c) -o $@ $^
 
-$(OBJS): dtc.h
-
 dtc-parser.tab.c dtc-parser.tab.h dtc-parser.output: dtc-parser.y
 	$(BISON) -d -v $<
 
 lex.yy.c: dtc-lexer.l
 	$(LEX) $<
 
+dtc-lexer.l: dtc-parser.tab.h
 lex.yy.o: lex.yy.c dtc-parser.tab.h
 
-livetree.o:	flat_dt.h
 
 check: all
 	cd tests && $(MAKE) check
 
 clean:
+	rm -f ${DEPFILES}
 	rm -f *~ *.o a.out core $(TARGETS)
 	rm -f *.tab.[ch] lex.yy.c
 	rm -f *.i *.output vgcore.*
 	cd tests && $(MAKE) clean
 
+%.d : %.c
+	$(CC) -MM $< > $@
+
+-include ${DEPFILES}
Index: dtc-lexer.l
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/dtc-lexer.l  (mode:100644)
+++ uncommitted/dtc-lexer.l  (mode:100644)
@@ -87,6 +87,11 @@
 			return ']';
 		}
 
+memreserve	{
+			DPRINT("Keyword: memreserve\n");
+			return DT_MEMRESERVE;
+		}
+
 {PROPCHAR}+	{
 			DPRINT("PropName: %s\n", yytext);
 			yylval.str = strdup(yytext);
Index: dtc-parser.y
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/dtc-parser.y  (mode:100644)
+++ uncommitted/dtc-parser.y  (mode:100644)
@@ -41,6 +41,7 @@
 	int hexlen;
 }
 
+%token DT_MEMRESERVE
 %token <str> DT_PROPNAME
 %token <str> DT_NODENAME
 %token <cval> DT_CELL
@@ -66,6 +67,21 @@
 
 %%
 
+sourcefile:
+	headersection
+	devicetree
+		{
+		}
+	;
+
+headersection:
+		/* empty */
+	|	DT_MEMRESERVE  '=' '<' celllist '>' 
+		{
+			build_mem_reserve($4);
+		}
+	;
+
 devicetree:	{
 			assert(device_tree == NULL);
 		} '/' nodedef { device_tree = name_node($3, "", NULL); }
Index: dtc.c
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/dtc.c  (mode:100644)
+++ uncommitted/dtc.c  (mode:100644)
@@ -103,6 +103,7 @@
 int main(int argc, char *argv[])
 {
 	struct node *dt;
+	struct data mem_reserve_data = empty_data;
 	char *inform = "dts";
 	char *outform = "dts";
 	char *outname = "-";
@@ -151,12 +152,12 @@
 
 	if (streq(inform, "dts")) {
 		inf = dtc_open_file(arg);
-		dt = dt_from_source(inf);
+		dt = dt_from_source(inf, &mem_reserve_data);
 	} else if (streq(inform, "fs")) {
-		dt = dt_from_fs(arg);
+		dt = dt_from_fs(arg, &mem_reserve_data);
 	} else if(streq(inform, "dtb")) {
 		inf = dtc_open_file(arg);
-		dt = dt_from_blob(inf);
+		dt = dt_from_blob(inf, &mem_reserve_data);
 	} else {
 		die("Unknown input format \"%s\"\n", inform);
 	}
@@ -183,11 +184,11 @@
 	}
 
 	if (streq(outform, "dts")) {
-		write_tree_source(outf, dt, 0);
+		write_tree_source(outf, dt, &mem_reserve_data);
 	} else if (streq(outform, "dtb")) {
-		write_dt_blob(outf, dt, outversion, reservenum);
+		write_dt_blob(outf, dt, outversion, &mem_reserve_data);
 	} else if (streq(outform, "asm")) {
-		write_dt_asm(outf, dt, outversion, reservenum);
+		write_dt_asm(outf, dt, outversion, &mem_reserve_data);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
Index: dtc.h
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/dtc.h  (mode:100644)
+++ uncommitted/dtc.h  (mode:100644)
@@ -117,6 +117,9 @@
 
 int data_is_one_string(struct data d);
 
+void build_mem_reserve(struct data d);
+
+
 /* DT constraints */
 
 #define MAX_PROPNAME_LEN	31
@@ -174,20 +177,23 @@
 	FFMT_ASM,
 };
 
-void write_dt_blob(FILE *f, struct node *tree, int version, int reservenum);
-void write_dt_asm(FILE *f, struct node *tree, int version, int reservenum);
+void write_dt_blob(FILE *f, struct node *tree, int version,
+		   struct data *mem_reserve_data);
+void write_dt_asm(FILE *f, struct node *tree, int version,
+		  struct data *mem_reserve_data);
 
-struct node *dt_from_blob(FILE *f);
+struct node *dt_from_blob(FILE *f, struct data *mem_reserve_data);
 
 /* Tree source */
 
-void write_tree_source(FILE *f, struct node *tree, int level);
+void write_tree_source(FILE *f, struct node *tree,
+		       struct data *mem_reserve_data);
 
-struct node *dt_from_source(FILE *f);
+struct node *dt_from_source(FILE *f, struct data *mem_reserve_data);
 
 /* FS trees */
 
-struct node *dt_from_fs(char *dirname);
+struct node *dt_from_fs(char *dirname, struct data *mem_reserve_data);
 
 /* misc */
 
Index: flattree.c
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/flattree.c  (mode:100644)
+++ uncommitted/flattree.c  (mode:100644)
@@ -288,10 +288,12 @@
 
 static void make_bph(struct boot_param_header *bph,
 			     struct version_info *vi,
-			     int reservenum,
+			     struct data *mem_reserve_data,
 			     int dtsize, int strsize)
 {
-	int reservesize = (reservenum+1) * sizeof(struct reserve_entry);
+	int reservenum = mem_reserve_data->len / sizeof(struct reserve_entry);
+	int reservesize = (reservenum + 1) * sizeof(struct reserve_entry);
+	int pad = sizeof(struct boot_param_header) % 8;
 
 	memset(bph, 0xff, sizeof(*bph));
 
@@ -299,11 +301,11 @@
 	bph->version = vi->version;
 	bph->last_comp_version = vi->last_comp_version;
 
-	bph->off_mem_rsvmap = cpu_to_be32(vi->hdr_size);
-	bph->off_dt_struct = cpu_to_be32(vi->hdr_size + reservesize);
-	bph->off_dt_strings = cpu_to_be32(vi->hdr_size + reservesize
+	bph->off_mem_rsvmap = cpu_to_be32(vi->hdr_size + pad);
+	bph->off_dt_struct = cpu_to_be32(vi->hdr_size + pad + reservesize);
+	bph->off_dt_strings = cpu_to_be32(vi->hdr_size + pad + reservesize
 					  + dtsize);
-	bph->totalsize = cpu_to_be32(vi->hdr_size + reservesize
+	bph->totalsize = cpu_to_be32(vi->hdr_size + pad + reservesize
 				     + dtsize + strsize);
 		
 	if (vi->flags & FTF_BOOTCPUID)
@@ -312,7 +314,8 @@
 		bph->size_dt_strings = cpu_to_be32(strsize);
 }
 
-void write_dt_blob(FILE *f, struct node *tree, int version, int reservenum)
+void write_dt_blob(FILE *f, struct node *tree, int version,
+		   struct data *mem_reserve_data)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -320,6 +323,8 @@
 	struct data strbuf = empty_data;
 	struct boot_param_header bph;
 	struct reserve_entry re = {.address = 0, .size = 0};
+	int pad;
+	int pad_buf = 0;
 
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
@@ -334,11 +339,30 @@
 	flatten_tree(tree, &bin_emitter, &dtbuf, &strbuf, vi);
 	bin_emit_cell(&dtbuf, OF_DT_END);
 
-	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);
-
+	/*
+	 * Make header.
+	 */
+	make_bph(&bph, vi, mem_reserve_data, dtbuf.len, strbuf.len);
 	fwrite(&bph, vi->hdr_size, 1, f);
-	for (i = 0; i < reservenum+1; i++)
-		fwrite(&re, sizeof(re), 1, f);
+
+	/*
+	 * Allow possible trailing alignment for mem reserve map.
+	 */
+	if (((pad = sizeof(struct boot_param_header) % 8)) != 0) {
+		fwrite(&pad_buf, 1, pad, f);	
+	}
+
+	/*
+	 * Reserve map entries.
+	 * Since the blob is relocatable, the address of the map is not
+	 * determinable here, so no entry is made for the DT itself.
+	 * Each entry is an (address, size) pair of u64 values.
+	 * Always supply a zero-sized temination entry.
+	 */
+	fwrite(mem_reserve_data->val, mem_reserve_data->len, 1, f);
+	re.address = 0;
+	re.size = 0;
+	fwrite(&re, sizeof(re), 1, f);
 
 	fwrite(dtbuf.val, dtbuf.len, 1, f);
 	fwrite(strbuf.val, strbuf.len, 1, f);
@@ -364,7 +388,8 @@
 	}
 }
 
-void write_dt_asm(FILE *f, struct node *tree, int version, int reservenum)
+void write_dt_asm(FILE *f, struct node *tree, int version,
+		  struct data *mem_reserve_data)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -408,16 +433,27 @@
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
 			symprefix, symprefix);
 
+	/*
+	 * Reserve map entries.
+	 * Each entry is an (address, size) pair of u64 values.
+	 * Since the ASM file variant can relocate and compute the address
+	 * and size of the the device tree itself, and an entry for it.
+	 * Always supply a zero-sized temination entry.
+	 */
+	asm_emit_align(f, 8);
 	emit_label(f, symprefix, "reserve_map");
-	/* reserve map entry for the device tree itself */
 	fprintf(f, "\t.long\t0, _%s_blob_start\n", symprefix);
 	fprintf(f, "\t.long\t0, _%s_blob_end - _%s_blob_start\n",
 		symprefix, symprefix);
-	for (i = 0; i < reservenum+1; i++) {
-		fprintf(f, "\t.llong\t0\n");
-		fprintf(f, "\t.llong\t0\n");
+
+	if (mem_reserve_data->len > 0) {
+		fprintf(f, "/* Memory reserve map from source file */\n");
+		asm_emit_data(f, *mem_reserve_data);
 	}
 
+	fprintf(f, "\t.llong\t0\n");
+	fprintf(f, "\t.llong\t0\n");
+
 	emit_label(f, symprefix, "struct_start");
 	flatten_tree(tree, &asm_emitter, f, &strbuf, vi);
 	fprintf(f, "\t.long\tOF_DT_END\n");
@@ -518,7 +554,8 @@
 	p = inb->base + offset;
 	while (1) {
 		if (p >= inb->limit)
-			die("String offset %d overruns string table\n");
+			die("String offset %d overruns string table\n",
+			    offset);
 
 		if (*p == '\0')
 			break;
@@ -549,6 +586,43 @@
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
@@ -656,14 +730,17 @@
 	return node;
 }
 
-struct node *dt_from_blob(FILE *f)
+
+struct node *dt_from_blob(FILE *f, struct data *mem_reserve_data)
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
 	struct node *tree;
 	u32 val;
@@ -723,18 +800,21 @@
 
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
 
@@ -756,12 +836,16 @@
 		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
 	}
 
+	inbuf_init(&memresvbuf,
+		   blob + off_mem_rsvmap, blob + totalsize);
 	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
 	inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 
 	if (version >= 3)
 		strbuf.limit = strbuf.base + size_str;
 
+	*mem_reserve_data = flat_read_mem_reserve(&memresvbuf);
+
 	val = flat_read_word(&dtbuf);
 
 	if (val != OF_DT_BEGIN_NODE)
Index: fstree.c
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/fstree.c  (mode:100644)
+++ uncommitted/fstree.c  (mode:100644)
@@ -80,7 +80,7 @@
 	return tree;
 }
 
-struct node *dt_from_fs(char *dirname)
+struct node *dt_from_fs(char *dirname, struct data *mem_reserve_data)
 {
 	struct node *tree;
 
Index: treesource.c
===================================================================
--- abbe76bc79348c0896908c8548d51bdfa5f76500/treesource.c  (mode:100644)
+++ uncommitted/treesource.c  (mode:100644)
@@ -20,13 +20,30 @@
 
 #include "dtc.h"
 
-struct node *device_tree;
-
 extern FILE *yyin;
 extern int yyparse(void);
+extern void yyerror(char const *);
+
+struct node *device_tree;
+struct data *mem_reserve_data_ptr;
 
-struct node *dt_from_source(FILE *f)
+
+void build_mem_reserve(struct data d)
 {
+	/*
+	 * FIXME: Should reconcile the -R parameter here now?
+	 */
+	*mem_reserve_data_ptr = d;
+	if (d.len % 16 != 0) {
+		yyerror("Memory Reserve entries are <u64 addr, u64 size>\n");
+	}
+}
+
+
+struct node *dt_from_source(FILE *f, struct data *mem_reserve_data)
+{
+	mem_reserve_data_ptr = mem_reserve_data;
+
 	yyin = f;
 	if (yyparse() != 0)
 		return NULL;
@@ -75,7 +92,8 @@
 		
 }
 
-void write_tree_source(FILE *f, struct node *tree, int level)
+
+void write_tree_source_node(FILE *f, struct node *tree, int level)
 {
 	struct property *prop;
 	struct node *child;
@@ -133,8 +151,40 @@
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
+void write_tree_source(FILE *f, struct node *tree,
+		       struct data *mem_reserve_data)
+{
+	int i;
+	int ncells;
+	cell_t *cp;
+
+	if (mem_reserve_data->len > 0) {
+		fprintf(f, "memreserve =\t<\n");
+		cp = (cell_t *)mem_reserve_data->val;
+		ncells = mem_reserve_data->len / sizeof(cell_t);
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
+		fprintf(f, "\t\t>\n\n");
+	}
+
+	write_tree_source_node(f, tree, 0);
+}
+
