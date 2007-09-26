Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Sep 2007 13:11:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use libfdt/fdt.h instead of flat_dt.h
Message-ID: <20070926031105.GA26512@localhost.localdomain>
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

In the dtc tree, both flat_dt.h and libfdt/fdt.h have structures and
constants relating to the flattened device tree format derived from
asm-powerpc/prom.h in the kernel.  The former is used in dtc, the
latter in libfdt.

libfdt/fdt.h is the more recent, revised version, so use that
throughout, removing flat_dt.h.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flat_dt.h
===================================================================
--- dtc.orig/flat_dt.h	2007-09-26 12:41:39.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,51 +0,0 @@
-#ifndef _FLAT_DT_H_
-#define _FLAT_DT_H_
-
-
-#define OF_DEFAULT_VERSION	17
-
-#define OF_DT_HEADER            0xd00dfeed      /* 4: version, 4: total size */
-
-#define OF_DT_BEGIN_NODE	0x1             /* Start node: full name */
-#define OF_DT_END_NODE		0x2             /* End node */
-#define OF_DT_PROP		0x3             /* Property: name off,
-						   size, content */
-#define OF_DT_NOP		0x4		/* nop */
-#define OF_DT_END               0x9
-
-struct boot_param_header {
-	uint32_t magic;                  /* magic word OF_DT_HEADER */
-	uint32_t totalsize;              /* total size of DT block */
-	uint32_t off_dt_struct;          /* offset to structure */
-	uint32_t off_dt_strings;         /* offset to strings */
-	uint32_t off_mem_rsvmap;         /* offset to memory reserve map */
-	uint32_t version;                /* format version */
-	uint32_t last_comp_version;      /* last compatible version */
-
-        /* version 2 fields below */
-	uint32_t boot_cpuid_phys;        /* Which physical CPU id we're
-					    booting on */
-	/* version 3 fields below */
-        uint32_t size_dt_strings;        /* size of the strings block */
-
-	/* version 17 fields below */
-	uint32_t size_dt_struct;         /* size of the DT structure block */
-};
-
-#define BPH_V1_SIZE	(7*sizeof(uint32_t))
-#define BPH_V2_SIZE	(BPH_V1_SIZE + sizeof(uint32_t))
-#define BPH_V3_SIZE	(BPH_V2_SIZE + sizeof(uint32_t))
-#define BPH_V17_SIZE	(BPH_V3_SIZE + sizeof(uint32_t))
-
-struct reserve_entry {
-	uint64_t address;
-	uint64_t size;
-};
-
-struct flat_dt_property {
-	uint32_t len;
-	uint32_t nameoff;
-	char data[0];
-};
-
-#endif /* _FLAT_DT_H_ */
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-09-26 12:42:04.000000000 +1000
+++ dtc/dtc.h	2007-09-26 12:44:39.000000000 +1000
@@ -34,8 +34,9 @@
 #include <endian.h>
 #include <byteswap.h>
 
-#include "flat_dt.h"
+#include <fdt.h>
 
+#define DEFAULT_FDT_VERSION	17
 /*
  * Command line options
  */
@@ -128,7 +129,7 @@ struct data data_copy_file(FILE *f, size
 struct data data_append_data(struct data d, void *p, int len);
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
-struct data data_append_re(struct data d, struct reserve_entry *re);
+struct data data_append_re(struct data d, struct fdt_reserve_entry *re);
 struct data data_append_addr(struct data d, u64 addr);
 struct data data_append_byte(struct data d, uint8_t byte);
 struct data data_append_zeroes(struct data d, int len);
@@ -192,7 +193,7 @@ int check_device_tree(struct node *dt, i
 /* Boot info (tree plus memreserve information */
 
 struct reserve_info {
-	struct reserve_entry re;
+	struct fdt_reserve_entry re;
 
 	struct reserve_info *next;
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-09-26 12:44:44.000000000 +1000
+++ dtc/dtc.c	2007-09-26 12:45:11.000000000 +1000
@@ -92,7 +92,7 @@ static void  __attribute__ ((noreturn)) 
 	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
 	fprintf(stderr, "\t-V <output version>\n");
-	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", OF_DEFAULT_VERSION);
+	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", DEFAULT_FDT_VERSION);
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-S <bytes>\n");
@@ -117,7 +117,7 @@ int main(int argc, char *argv[])
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
-	int outversion = OF_DEFAULT_VERSION;
+	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
 
 	quiet      = 0;
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2007-09-26 12:45:20.000000000 +1000
+++ dtc/ftdump.c	2007-09-26 12:47:11.000000000 +1000
@@ -9,7 +9,7 @@
 #include <netinet/in.h>
 #include <byteswap.h>
 
-#include "flat_dt.h"
+#include <fdt.h>
 
 #define cpu_to_be16(x)	htons(x)
 #define be16_to_cpu(x)	ntohs(x)
@@ -80,10 +80,10 @@ static void print_data(const void *data,
 
 static void dump_blob(void *blob)
 {
-	struct boot_param_header *bph = blob;
-	struct reserve_entry *p_rsvmap =
-		(struct reserve_entry *)(blob
-					 + be32_to_cpu(bph->off_mem_rsvmap));
+	struct fdt_header *bph = blob;
+	struct fdt_reserve_entry *p_rsvmap =
+		(struct fdt_reserve_entry *)(blob
+					     + be32_to_cpu(bph->off_mem_rsvmap));
 	char *p_struct = blob + be32_to_cpu(bph->off_dt_struct);
 	char *p_strings = blob + be32_to_cpu(bph->off_dt_strings);
 	uint32_t version = be32_to_cpu(bph->version);
@@ -109,11 +109,11 @@ static void dump_blob(void *blob)
 	}
 
 	p = p_struct;
-	while ((tag = be32_to_cpu(GET_CELL(p))) != OF_DT_END) {
+	while ((tag = be32_to_cpu(GET_CELL(p))) != FDT_END) {
 
 		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */
 
-		if (tag == OF_DT_BEGIN_NODE) {
+		if (tag == FDT_BEGIN_NODE) {
 			s = p;
 			p = PALIGN(p + strlen(s) + 1, 4);
 
@@ -126,19 +126,19 @@ static void dump_blob(void *blob)
 			continue;
 		}
 
-		if (tag == OF_DT_END_NODE) {
+		if (tag == FDT_END_NODE) {
 			depth--;
 
 			printf("%*s};\n", depth * shift, "");
 			continue;
 		}
 
-		if (tag == OF_DT_NOP) {
+		if (tag == FDT_NOP) {
 			printf("%*s// [NOP]\n", depth * shift, "");
 			continue;
 		}
 
-		if (tag != OF_DT_PROP) {
+		if (tag != FDT_PROP) {
 			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n", depth * shift, "", tag);
 			break;
 		}
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-09-26 12:48:42.000000000 +1000
+++ dtc/flattree.c	2007-09-26 12:54:38.000000000 +1000
@@ -19,7 +19,6 @@
  */
 
 #include "dtc.h"
-#include "flat_dt.h"
 
 #define FTF_FULLPATH	0x1
 #define FTF_VARALIGN	0x2
@@ -35,15 +34,15 @@ static struct version_info {
 	int hdr_size;
 	int flags;
 } version_table[] = {
-	{1, 1, BPH_V1_SIZE,
+	{1, 1, FDT_V1_SIZE,
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS},
-	{2, 1, BPH_V2_SIZE,
+	{2, 1, FDT_V2_SIZE,
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID},
-	{3, 1, BPH_V3_SIZE,
+	{3, 1, FDT_V3_SIZE,
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID|FTF_STRTABSIZE},
-	{16, 16, BPH_V3_SIZE,
+	{16, 16, FDT_V3_SIZE,
 	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_NOPS},
-	{17, 16, BPH_V17_SIZE,
+	{17, 16, FDT_V17_SIZE,
 	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_STRUCTSIZE|FTF_NOPS},
 };
 
@@ -91,17 +90,17 @@ static void bin_emit_data(void *e, struc
 
 static void bin_emit_beginnode(void *e, char *label)
 {
-	bin_emit_cell(e, OF_DT_BEGIN_NODE);
+	bin_emit_cell(e, FDT_BEGIN_NODE);
 }
 
 static void bin_emit_endnode(void *e, char *label)
 {
-	bin_emit_cell(e, OF_DT_END_NODE);
+	bin_emit_cell(e, FDT_END_NODE);
 }
 
 static void bin_emit_property(void *e, char *label)
 {
-	bin_emit_cell(e, OF_DT_PROP);
+	bin_emit_cell(e, FDT_PROP);
 }
 
 static struct emitter bin_emitter = {
@@ -199,14 +198,14 @@ static void asm_emit_beginnode(void *e, 
 		fprintf(f, "\t.globl\t%s\n", label);
 		fprintf(f, "%s:\n", label);
 	}
-	fprintf(f, "\t.long\tOF_DT_BEGIN_NODE\n");
+	fprintf(f, "\t.long\tFDT_BEGIN_NODE\n");
 }
 
 static void asm_emit_endnode(void *e, char *label)
 {
 	FILE *f = e;
 
-	fprintf(f, "\t.long\tOF_DT_END_NODE\n");
+	fprintf(f, "\t.long\tFDT_END_NODE\n");
 	if (label) {
 		fprintf(f, "\t.globl\t%s_end\n", label);
 		fprintf(f, "%s_end:\n", label);
@@ -221,7 +220,7 @@ static void asm_emit_property(void *e, c
 		fprintf(f, "\t.globl\t%s\n", label);
 		fprintf(f, "%s:\n", label);
 	}
-	fprintf(f, "\t.long\tOF_DT_PROP\n");
+	fprintf(f, "\t.long\tFDT_PROP\n");
 }
 
 static struct emitter asm_emitter = {
@@ -309,7 +308,7 @@ static struct data flatten_reserve_list(
 {
 	struct reserve_info *re;
 	struct data d = empty_data;
-	static struct reserve_entry null_re = {0,0};
+	static struct fdt_reserve_entry null_re = {0,0};
 	int    j;
 
 	for (re = reservelist; re; re = re->next) {
@@ -325,36 +324,36 @@ static struct data flatten_reserve_list(
 	return d;
 }
 
-static void make_bph(struct boot_param_header *bph,
-		     struct version_info *vi,
-		     int reservesize, int dtsize, int strsize,
-		     int boot_cpuid_phys)
+static void make_fdt_header(struct fdt_header *fdt,
+			    struct version_info *vi,
+			    int reservesize, int dtsize, int strsize,
+			    int boot_cpuid_phys)
 {
 	int reserve_off;
 
-	reservesize += sizeof(struct reserve_entry);
+	reservesize += sizeof(struct fdt_reserve_entry);
 
-	memset(bph, 0xff, sizeof(*bph));
+	memset(fdt, 0xff, sizeof(*fdt));
 
-	bph->magic = cpu_to_be32(OF_DT_HEADER);
-	bph->version = cpu_to_be32(vi->version);
-	bph->last_comp_version = cpu_to_be32(vi->last_comp_version);
+	fdt->magic = cpu_to_be32(FDT_MAGIC);
+	fdt->version = cpu_to_be32(vi->version);
+	fdt->last_comp_version = cpu_to_be32(vi->last_comp_version);
 
 	/* Reserve map should be doubleword aligned */
 	reserve_off = ALIGN(vi->hdr_size, 8);
 
-	bph->off_mem_rsvmap = cpu_to_be32(reserve_off);
-	bph->off_dt_struct = cpu_to_be32(reserve_off + reservesize);
-	bph->off_dt_strings = cpu_to_be32(reserve_off + reservesize
+	fdt->off_mem_rsvmap = cpu_to_be32(reserve_off);
+	fdt->off_dt_struct = cpu_to_be32(reserve_off + reservesize);
+	fdt->off_dt_strings = cpu_to_be32(reserve_off + reservesize
 					  + dtsize);
-	bph->totalsize = cpu_to_be32(reserve_off + reservesize + dtsize + strsize);
+	fdt->totalsize = cpu_to_be32(reserve_off + reservesize + dtsize + strsize);
 
 	if (vi->flags & FTF_BOOTCPUID)
-		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
+		fdt->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
 	if (vi->flags & FTF_STRTABSIZE)
-		bph->size_dt_strings = cpu_to_be32(strsize);
+		fdt->size_dt_strings = cpu_to_be32(strsize);
 	if (vi->flags & FTF_STRUCTSIZE)
-		bph->size_dt_struct = cpu_to_be32(dtsize);
+		fdt->size_dt_struct = cpu_to_be32(dtsize);
 }
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version,
@@ -366,7 +365,7 @@ void dt_to_blob(FILE *f, struct boot_inf
 	struct data reservebuf = empty_data;
 	struct data dtbuf      = empty_data;
 	struct data strbuf     = empty_data;
-	struct boot_param_header bph;
+	struct fdt_header fdt;
 	int padlen;
 
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
@@ -377,25 +376,25 @@ void dt_to_blob(FILE *f, struct boot_inf
 		die("Unknown device tree blob version %d\n", version);
 
 	flatten_tree(bi->dt, &bin_emitter, &dtbuf, &strbuf, vi);
-	bin_emit_cell(&dtbuf, OF_DT_END);
+	bin_emit_cell(&dtbuf, FDT_END);
 
 	reservebuf = flatten_reserve_list(bi->reservelist, vi);
 
 	/* Make header */
-	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len,
-		 boot_cpuid_phys);
+	make_fdt_header(&fdt, vi, reservebuf.len, dtbuf.len, strbuf.len,
+			boot_cpuid_phys);
 
 	/*
 	 * If the user asked for more space than is used, adjust the totalsize.
 	 */
-	padlen = minsize - be32_to_cpu(bph.totalsize);
+	padlen = minsize - be32_to_cpu(fdt.totalsize);
 	if (padlen > 0) {
-		bph.totalsize = cpu_to_be32(minsize);
+		fdt.totalsize = cpu_to_be32(minsize);
 	} else {
 		if ((minsize > 0) && (quiet < 1))
 			fprintf(stderr,
 				"Warning: blob size %d >= minimum size %d\n",
-				be32_to_cpu(bph.totalsize), minsize);
+				be32_to_cpu(fdt.totalsize), minsize);
 	}
 
 	/*
@@ -403,10 +402,10 @@ void dt_to_blob(FILE *f, struct boot_inf
 	 * the reserve buffer, add the reserve map terminating zeroes,
 	 * the device tree itself, and finally the strings.
 	 */
-	blob = data_append_data(blob, &bph, sizeof(bph));
+	blob = data_append_data(blob, &fdt, sizeof(fdt));
 	blob = data_append_align(blob, 8);
 	blob = data_merge(blob, reservebuf);
-	blob = data_append_zeroes(blob, sizeof(struct reserve_entry));
+	blob = data_append_zeroes(blob, sizeof(struct fdt_reserve_entry));
 	blob = data_merge(blob, dtbuf);
 	blob = data_merge(blob, strbuf);
 
@@ -415,7 +414,7 @@ void dt_to_blob(FILE *f, struct boot_inf
 	 */
 	if (padlen > 0) {
 		blob = data_append_zeroes(blob, padlen);
-		bph.totalsize = cpu_to_be32(minsize);
+		fdt.totalsize = cpu_to_be32(minsize);
 	}
 
 	fwrite(blob.val, blob.len, 1, f);
@@ -460,16 +459,16 @@ void dt_to_asm(FILE *f, struct boot_info
 		die("Unknown device tree blob version %d\n", version);
 
 	fprintf(f, "/* autogenerated by dtc, do not edit */\n\n");
-	fprintf(f, "#define OF_DT_HEADER 0x%x\n", OF_DT_HEADER);
-	fprintf(f, "#define OF_DT_BEGIN_NODE 0x%x\n", OF_DT_BEGIN_NODE);
-	fprintf(f, "#define OF_DT_END_NODE 0x%x\n", OF_DT_END_NODE);
-	fprintf(f, "#define OF_DT_PROP 0x%x\n", OF_DT_PROP);
-	fprintf(f, "#define OF_DT_END 0x%x\n", OF_DT_END);
+	fprintf(f, "#define FDT_MAGIC 0x%x\n", FDT_MAGIC);
+	fprintf(f, "#define FDT_BEGIN_NODE 0x%x\n", FDT_BEGIN_NODE);
+	fprintf(f, "#define FDT_END_NODE 0x%x\n", FDT_END_NODE);
+	fprintf(f, "#define FDT_PROP 0x%x\n", FDT_PROP);
+	fprintf(f, "#define FDT_END 0x%x\n", FDT_END);
 	fprintf(f, "\n");
 
 	emit_label(f, symprefix, "blob_start");
 	emit_label(f, symprefix, "header");
-	fprintf(f, "\t.long\tOF_DT_HEADER\t\t\t\t/* magic */\n");
+	fprintf(f, "\t.long\tFDT_MAGIC\t\t\t\t/* magic */\n");
 	fprintf(f, "\t.long\t_%s_blob_abs_end - _%s_blob_start\t/* totalsize */\n",
 		symprefix, symprefix);
 	fprintf(f, "\t.long\t_%s_struct_start - _%s_blob_start\t/* off_dt_struct */\n",
@@ -529,7 +528,7 @@ void dt_to_asm(FILE *f, struct boot_info
 
 	emit_label(f, symprefix, "struct_start");
 	flatten_tree(bi->dt, &asm_emitter, f, &strbuf, vi);
-	fprintf(f, "\t.long\tOF_DT_END\n");
+	fprintf(f, "\t.long\tFDT_END\n");
 	emit_label(f, symprefix, "struct_end");
 
 	emit_label(f, symprefix, "strings_start");
@@ -674,7 +673,7 @@ static struct reserve_info *flat_read_me
 	struct reserve_info *reservelist = NULL;
 	struct reserve_info *new;
 	char *p;
-	struct reserve_entry re;
+	struct fdt_reserve_entry re;
 
 	/*
 	 * Each entry is a pair of u64 (addr, size) values for 4 cell_t's.
@@ -778,7 +777,7 @@ static struct node *unflatten_tree(struc
 
 		val = flat_read_word(dtbuf);
 		switch (val) {
-		case OF_DT_PROP:
+		case FDT_PROP:
 			if (node->children)
 				fprintf(stderr, "Warning: Flat tree input has "
 					"subnodes preceding a property.\n");
@@ -786,20 +785,20 @@ static struct node *unflatten_tree(struc
 			add_property(node, prop);
 			break;
 
-		case OF_DT_BEGIN_NODE:
+		case FDT_BEGIN_NODE:
 			child = unflatten_tree(dtbuf,strbuf, node->fullpath,
 					       flags);
 			add_child(node, child);
 			break;
 
-		case OF_DT_END_NODE:
+		case FDT_END_NODE:
 			break;
 
-		case OF_DT_END:
-			die("Premature OF_DT_END in device tree blob\n");
+		case FDT_END:
+			die("Premature FDT_END in device tree blob\n");
 			break;
 
-		case OF_DT_NOP:
+		case FDT_NOP:
 			if (!(flags & FTF_NOPS))
 				fprintf(stderr, "Warning: NOP tag found in flat tree"
 					" version <16\n");
@@ -811,7 +810,7 @@ static struct node *unflatten_tree(struc
 			die("Invalid opcode word %08x in device tree blob\n",
 			    val);
 		}
-	} while (val != OF_DT_END_NODE);
+	} while (val != FDT_END_NODE);
 
 	return node;
 }
@@ -823,7 +822,7 @@ struct boot_info *dt_from_blob(FILE *f)
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
-	struct boot_param_header *bph;
+	struct fdt_header *fdt;
 	char *p;
 	struct inbuf dtbuf, strbuf;
 	struct inbuf memresvbuf;
@@ -845,7 +844,7 @@ struct boot_info *dt_from_blob(FILE *f)
 	}
 
 	magic = be32_to_cpu(magic);
-	if (magic != OF_DT_HEADER)
+	if (magic != FDT_MAGIC)
 		die("Blob has incorrect magic number\n");
 
 	rc = fread(&totalsize, sizeof(totalsize), 1, f);
@@ -859,14 +858,14 @@ struct boot_info *dt_from_blob(FILE *f)
 	}
 
 	totalsize = be32_to_cpu(totalsize);
-	if (totalsize < BPH_V1_SIZE)
+	if (totalsize < FDT_V1_SIZE)
 		die("DT blob size (%d) is too small\n", totalsize);
 
 	blob = xmalloc(totalsize);
 
-	bph = (struct boot_param_header *)blob;
-	bph->magic = cpu_to_be32(magic);
-	bph->totalsize = cpu_to_be32(totalsize);
+	fdt = (struct fdt_header *)blob;
+	fdt->magic = cpu_to_be32(magic);
+	fdt->totalsize = cpu_to_be32(totalsize);
 
 	sizeleft = totalsize - sizeof(magic) - sizeof(totalsize);
 	p = blob + sizeof(magic)  + sizeof(totalsize);
@@ -885,10 +884,10 @@ struct boot_info *dt_from_blob(FILE *f)
 		p += rc;
 	}
 
-	off_dt = be32_to_cpu(bph->off_dt_struct);
-	off_str = be32_to_cpu(bph->off_dt_strings);
-	off_mem_rsvmap = be32_to_cpu(bph->off_mem_rsvmap);
-	version = be32_to_cpu(bph->version);
+	off_dt = be32_to_cpu(fdt->off_dt_struct);
+	off_str = be32_to_cpu(fdt->off_dt_strings);
+	off_mem_rsvmap = be32_to_cpu(fdt->off_mem_rsvmap);
+	version = be32_to_cpu(fdt->version);
 
 	fprintf(stderr, "\tmagic:\t\t\t0x%x\n", magic);
 	fprintf(stderr, "\ttotalsize:\t\t%d\n", totalsize);
@@ -897,7 +896,7 @@ struct boot_info *dt_from_blob(FILE *f)
 	fprintf(stderr, "\toff_mem_rsvmap:\t\t0x%x\n", off_mem_rsvmap);
 	fprintf(stderr, "\tversion:\t\t0x%x\n", version );
 	fprintf(stderr, "\tlast_comp_version:\t0x%x\n",
-		be32_to_cpu(bph->last_comp_version));
+		be32_to_cpu(fdt->last_comp_version));
 
 	if (off_mem_rsvmap >= totalsize)
 		die("Mem Reserve structure offset exceeds total size\n");
@@ -910,18 +909,18 @@ struct boot_info *dt_from_blob(FILE *f)
 
 	if (version >= 2)
 		fprintf(stderr, "\tboot_cpuid_phys:\t0x%x\n",
-			be32_to_cpu(bph->boot_cpuid_phys));
+			be32_to_cpu(fdt->boot_cpuid_phys));
 
 	size_str = -1;
 	if (version >= 3) {
-		size_str = be32_to_cpu(bph->size_dt_strings);
+		size_str = be32_to_cpu(fdt->size_dt_strings);
 		fprintf(stderr, "\tsize_dt_strings:\t%d\n", size_str);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
 	}
 
 	if (version >= 17) {
-		size_dt = be32_to_cpu(bph->size_dt_struct);
+		size_dt = be32_to_cpu(fdt->size_dt_struct);
 		fprintf(stderr, "\tsize_dt_struct:\t\t%d\n", size_dt);
 		if (off_dt+size_dt > totalsize)
 			die("Structure block extends past total size\n");
@@ -945,14 +944,14 @@ struct boot_info *dt_from_blob(FILE *f)
 
 	val = flat_read_word(&dtbuf);
 
-	if (val != OF_DT_BEGIN_NODE)
-		die("Device tree blob doesn't begin with OF_DT_BEGIN_NODE (begins with 0x%08x)\n", val);
+	if (val != FDT_BEGIN_NODE)
+		die("Device tree blob doesn't begin with FDT_BEGIN_NODE (begins with 0x%08x)\n", val);
 
 	tree = unflatten_tree(&dtbuf, &strbuf, "", flags);
 
 	val = flat_read_word(&dtbuf);
-	if (val != OF_DT_END)
-		die("Device tree blob doesn't end with OF_DT_END\n");
+	if (val != FDT_END)
+		die("Device tree blob doesn't end with FDT_END\n");
 
 	free(blob);
 
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-09-26 12:50:49.000000000 +1000
+++ dtc/data.c	2007-09-26 12:51:03.000000000 +1000
@@ -246,9 +246,9 @@ struct data data_append_cell(struct data
 	return data_append_data(d, &beword, sizeof(beword));
 }
 
-struct data data_append_re(struct data d, struct reserve_entry *re)
+struct data data_append_re(struct data d, struct fdt_reserve_entry *re)
 {
-	struct reserve_entry bere;
+	struct fdt_reserve_entry bere;
 
 	bere.address = cpu_to_be64(re->address);
 	bere.size = cpu_to_be64(re->size);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
