Return-Path: <dgibson@ozlabs.org>
Date: Wed, 25 Jun 2008 14:27:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use the same endian-conversion functions as libfdt
Message-ID: <20080625042753.GC8284@yookeroo.seuss>
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

Currently both libfdt and dtc define a set of endian conversion macros
for accessing the device tree blob which is always big-endian.  libfdt
uses names like cpu_to_fdt32() and dtc uses names like cpu_to_be32 (as
the Linux kernel).  This patch switches dtc over to using the libfdt
macros (including libfdt_env.h to supply them).  This has a couple of
small advantages:
	- Removes some code duplication
	- Will make conversion a bit easier if we ever need to produce
          little-endian device tree blobs.
	- dtc no longer needs to pull in netinet/in.h simply for the
          ntohs() and ntohl() functions

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 checks.c     |    2 -
 data.c       |    8 +++----
 dtc.h        |   17 ---------------
 flattree.c   |   66 ++++++++++++++++++++++++++---------------------------------
 livetree.c   |    2 -
 treesource.c |    2 -
 6 files changed, 38 insertions(+), 59 deletions(-)

Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-06-25 14:24:51.000000000 +1000
+++ dtc/dtc.h	2008-06-25 14:25:35.000000000 +1000
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
@@ -77,19 +75,6 @@
 
 typedef uint32_t cell_t;
 
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
 
 #define streq(a, b)	(strcmp((a), (b)) == 0)
 #define strneq(a, b, n)	(strncmp((a), (b), (n)) == 0)
Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2008-06-25 14:24:51.000000000 +1000
+++ dtc/checks.c	2008-06-25 14:25:35.000000000 +1000
@@ -363,7 +363,7 @@
 		}
 
 		phandle = get_node_phandle(dt, refnode);
-		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_be32(phandle);
+		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_fdt32(phandle);
 	}
 }
 CHECK(phandle_references, NULL, NULL, fixup_phandle_references, NULL, ERROR,
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-06-25 14:24:51.000000000 +1000
+++ dtc/flattree.c	2008-06-25 14:25:35.000000000 +1000
@@ -170,17 +170,11 @@
 
 	while ((d.len - off) >= sizeof(uint32_t)) {
 		fprintf(f, "\t.long\t0x%x\n",
-			be32_to_cpu(*((uint32_t *)(d.val+off))));
+			fdt32_to_cpu(*((uint32_t *)(d.val+off))));
 		off += sizeof(uint32_t);
 	}
 
-	if ((d.len - off) >= sizeof(uint16_t)) {
-		fprintf(f, "\t.short\t0x%hx\n",
-			be16_to_cpu(*((uint16_t *)(d.val+off))));
-		off += sizeof(uint16_t);
-	}
-
-	if ((d.len - off) >= 1) {
+	while ((d.len - off) >= 1) {
 		fprintf(f, "\t.byte\t0x%hhx\n", d.val[off]);
 		off += 1;
 	}
@@ -333,25 +327,25 @@
 
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
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version)
@@ -385,20 +379,20 @@
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
@@ -583,7 +577,7 @@
 
 	flat_read_chunk(inb, &val, sizeof(val));
 
-	return be32_to_cpu(val);
+	return fdt32_to_cpu(val);
 }
 
 static void flat_realign(struct inbuf *inb, int align)
@@ -689,8 +683,8 @@
 	p = inb->ptr;
 	while (1) {
 		flat_read_chunk(inb, &re, sizeof(re));
-		re.address  = be64_to_cpu(re.address);
-		re.size = be64_to_cpu(re.size);
+		re.address  = fdt64_to_cpu(re.address);
+		re.size = fdt64_to_cpu(re.size);
 		if (re.size == 0)
 			break;
 
@@ -810,7 +804,7 @@
 			die("Mysterious short read reading magic number\n");
 	}
 
-	magic = be32_to_cpu(magic);
+	magic = fdt32_to_cpu(magic);
 	if (magic != FDT_MAGIC)
 		die("Blob has incorrect magic number\n");
 
@@ -824,15 +818,15 @@
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
@@ -851,11 +845,11 @@
 		p += rc;
 	}
 
-	off_dt = be32_to_cpu(fdt->off_dt_struct);
-	off_str = be32_to_cpu(fdt->off_dt_strings);
-	off_mem_rsvmap = be32_to_cpu(fdt->off_mem_rsvmap);
-	version = be32_to_cpu(fdt->version);
-	boot_cpuid_phys = be32_to_cpu(fdt->boot_cpuid_phys);
+	off_dt = fdt32_to_cpu(fdt->off_dt_struct);
+	off_str = fdt32_to_cpu(fdt->off_dt_strings);
+	off_mem_rsvmap = fdt32_to_cpu(fdt->off_mem_rsvmap);
+	version = fdt32_to_cpu(fdt->version);
+	boot_cpuid_phys = fdt32_to_cpu(fdt->boot_cpuid_phys);
 
 	if (off_mem_rsvmap >= totalsize)
 		die("Mem Reserve structure offset exceeds total size\n");
@@ -867,7 +861,7 @@
 		die("String table offset exceeds total size\n");
 
 	if (version >= 3) {
-		uint32_t size_str = be32_to_cpu(fdt->size_dt_strings);
+		uint32_t size_str = fdt32_to_cpu(fdt->size_dt_strings);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
 		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
@@ -876,7 +870,7 @@
 	}
 
 	if (version >= 17) {
-		size_dt = be32_to_cpu(fdt->size_dt_struct);
+		size_dt = fdt32_to_cpu(fdt->size_dt_struct);
 		if (off_dt+size_dt > totalsize)
 			die("Structure block extends past total size\n");
 	}
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2008-06-25 14:24:51.000000000 +1000
+++ dtc/livetree.c	2008-06-25 14:25:35.000000000 +1000
@@ -204,7 +204,7 @@
 cell_t propval_cell(struct property *prop)
 {
 	assert(prop->val.len == sizeof(cell_t));
-	return be32_to_cpu(*((cell_t *)prop->val.val));
+	return fdt32_to_cpu(*((cell_t *)prop->val.val));
 }
 
 struct node *get_subnode(struct node *node, const char *nodename)
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-06-25 14:24:51.000000000 +1000
+++ dtc/treesource.c	2008-06-25 14:25:35.000000000 +1000
@@ -147,7 +147,7 @@
 			m = m->next;
 		}
 
-		fprintf(f, "0x%x", be32_to_cpu(*cp++));
+		fprintf(f, "0x%x", fdt32_to_cpu(*cp++));
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-06-25 14:25:44.000000000 +1000
+++ dtc/data.c	2008-06-25 14:26:07.000000000 +1000
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
 
 struct data data_append_addr(struct data d, uint64_t addr)
 {
-	uint64_t beaddr = cpu_to_be64(addr);
+	uint64_t beaddr = cpu_to_fdt64(addr);
 
 	return data_append_data(d, &beaddr, sizeof(beaddr));
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
