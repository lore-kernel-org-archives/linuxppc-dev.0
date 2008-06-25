Return-Path: <dgibson@ozlabs.org>
Date: Wed, 25 Jun 2008 13:53:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use stdint.h types throughout dtc
Message-ID: <20080625035307.GB8284@yookeroo.seuss>
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

Currently, dtc defines Linux-like names for various fixed-size integer
types.  There's no good reason to do this; even Linux itself doesn't
use these names for externally visible things any more.  This patch
replaces these with the C99 standardized type names from stdint.h.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-06-25 13:47:29.000000000 +1000
+++ dtc/dtc.h	2008-06-25 13:48:03.000000000 +1000
@@ -75,11 +75,7 @@
 	return new;
 }
 
-typedef uint8_t u8;
-typedef uint16_t u16;
-typedef uint32_t u32;
-typedef uint64_t u64;
-typedef u32 cell_t;
+typedef uint32_t cell_t;
 
 #define cpu_to_be16(x)	htons(x)
 #define be16_to_cpu(x)	ntohs(x)
@@ -144,7 +140,7 @@
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
 struct data data_append_re(struct data d, const struct fdt_reserve_entry *re);
-struct data data_append_addr(struct data d, u64 addr);
+struct data data_append_addr(struct data d, uint64_t addr);
 struct data data_append_byte(struct data d, uint8_t byte);
 struct data data_append_zeroes(struct data d, int len);
 struct data data_append_align(struct data d, int align);
@@ -222,7 +218,7 @@
 	char *label;
 };
 
-struct reserve_info *build_reserve_entry(u64 start, u64 len, char *label);
+struct reserve_info *build_reserve_entry(uint64_t start, uint64_t len, char *label);
 struct reserve_info *chain_reserve_entry(struct reserve_info *first,
 					 struct reserve_info *list);
 struct reserve_info *add_reserve_entry(struct reserve_info *list,
@@ -232,11 +228,11 @@
 struct boot_info {
 	struct reserve_info *reservelist;
 	struct node *dt;		/* the device tree */
-	u32 boot_cpuid_phys;
+	uint32_t boot_cpuid_phys;
 };
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree, u32 boot_cpuid_phys);
+				  struct node *tree, uint32_t boot_cpuid_phys);
 
 /* Checks */
 
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-06-25 13:48:12.000000000 +1000
+++ dtc/data.c	2008-06-25 13:48:18.000000000 +1000
@@ -262,9 +262,9 @@
 	return data_append_data(d, &bere, sizeof(bere));
 }
 
-struct data data_append_addr(struct data d, u64 addr)
+struct data data_append_addr(struct data d, uint64_t addr)
 {
-	u64 beaddr = cpu_to_be64(addr);
+	uint64_t beaddr = cpu_to_be64(addr);
 
 	return data_append_data(d, &beaddr, sizeof(beaddr));
 }
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2008-06-25 13:49:51.000000000 +1000
+++ dtc/dtc-parser.y	2008-06-25 13:50:13.000000000 +1000
@@ -39,10 +39,10 @@
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
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-06-25 13:48:25.000000000 +1000
+++ dtc/flattree.c	2008-06-25 13:49:39.000000000 +1000
@@ -168,16 +168,16 @@
 	for_each_marker_of_type(m, LABEL)
 		emit_offset_label(f, m->ref, m->offset);
 
-	while ((d.len - off) >= sizeof(u32)) {
+	while ((d.len - off) >= sizeof(uint32_t)) {
 		fprintf(f, "\t.long\t0x%x\n",
-			be32_to_cpu(*((u32 *)(d.val+off))));
-		off += sizeof(u32);
+			be32_to_cpu(*((uint32_t *)(d.val+off))));
+		off += sizeof(uint32_t);
 	}
 
-	if ((d.len - off) >= sizeof(u16)) {
+	if ((d.len - off) >= sizeof(uint16_t)) {
 		fprintf(f, "\t.short\t0x%hx\n",
-			be16_to_cpu(*((u16 *)(d.val+off))));
-		off += sizeof(u16);
+			be16_to_cpu(*((uint16_t *)(d.val+off))));
+		off += sizeof(uint16_t);
 	}
 
 	if ((d.len - off) >= 1) {
@@ -575,9 +575,9 @@
 	inb->ptr += len;
 }
 
-static u32 flat_read_word(struct inbuf *inb)
+static uint32_t flat_read_word(struct inbuf *inb)
 {
-	u32 val;
+	uint32_t val;
 
 	assert(((inb->ptr - inb->base) % sizeof(val)) == 0);
 
@@ -611,7 +611,7 @@
 
 	inb->ptr += len;
 
-	flat_realign(inb, sizeof(u32));
+	flat_realign(inb, sizeof(uint32_t));
 
 	return str;
 }
@@ -628,7 +628,7 @@
 
 	flat_read_chunk(inb, d.val, len);
 
-	flat_realign(inb, sizeof(u32));
+	flat_realign(inb, sizeof(uint32_t));
 
 	return d;
 }
@@ -655,7 +655,7 @@
 static struct property *flat_read_property(struct inbuf *dtbuf,
 					   struct inbuf *strbuf, int flags)
 {
-	u32 proplen, stroff;
+	uint32_t proplen, stroff;
 	char *name;
 	struct data val;
 
@@ -725,7 +725,7 @@
 {
 	struct node *node;
 	char *flatname;
-	u32 val;
+	uint32_t val;
 
 	node = build_node(NULL, NULL);
 
@@ -783,8 +783,8 @@
 struct boot_info *dt_from_blob(const char *fname)
 {
 	struct dtc_file *dtcf;
-	u32 magic, totalsize, version, size_dt, boot_cpuid_phys;
-	u32 off_dt, off_str, off_mem_rsvmap;
+	uint32_t magic, totalsize, version, size_dt, boot_cpuid_phys;
+	uint32_t off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
 	struct fdt_header *fdt;
@@ -794,7 +794,7 @@
 	int sizeleft;
 	struct reserve_info *reservelist;
 	struct node *tree;
-	u32 val;
+	uint32_t val;
 	int flags = 0;
 
 	dtcf = dtc_open_file(fname, NULL);
@@ -867,7 +867,7 @@
 		die("String table offset exceeds total size\n");
 
 	if (version >= 3) {
-		u32 size_str = be32_to_cpu(fdt->size_dt_strings);
+		uint32_t size_str = be32_to_cpu(fdt->size_dt_strings);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
 		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2008-06-25 13:48:48.000000000 +1000
+++ dtc/livetree.c	2008-06-25 13:49:17.000000000 +1000
@@ -123,7 +123,8 @@
 	*p = child;
 }
 
-struct reserve_info *build_reserve_entry(u64 address, u64 size, char *label)
+struct reserve_info *build_reserve_entry(uint64_t address, uint64_t size,
+					 char *label)
 {
 	struct reserve_info *new = xmalloc(sizeof(*new));
 
@@ -165,7 +166,7 @@
 }
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree, u32 boot_cpuid_phys)
+				  struct node *tree, uint32_t boot_cpuid_phys)
 {
 	struct boot_info *bi;
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
