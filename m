Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jun 2008 10:43:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use libfdt endian conversion functions in libfdt
Message-ID: <20080626004306.GG308@yookeroo.seuss>
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

Following on from the last patch, which made dtc use the same endian
conversion functions as libfdt, this patch makes ftdump use these
functions as well.  This brings us down to a single set of endian
handling functions in all of dtc and libfdt, so just one place to fix
things.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 ftdump.c |   47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2008-06-25 16:59:25.000000000 +1000
+++ dtc/ftdump.c	2008-06-25 16:59:27.000000000 +1000
@@ -6,24 +6,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
-#include <netinet/in.h>
-#include <byteswap.h>
 
 #include <fdt.h>
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
+#include <libfdt_env.h>
 
 #define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
 #define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))
@@ -81,15 +66,15 @@
 static void dump_blob(void *blob)
 {
 	struct fdt_header *bph = blob;
-	uint32_t off_mem_rsvmap = be32_to_cpu(bph->off_mem_rsvmap);
-	uint32_t off_dt = be32_to_cpu(bph->off_dt_struct);
-	uint32_t off_str = be32_to_cpu(bph->off_dt_strings);
+	uint32_t off_mem_rsvmap = fdt32_to_cpu(bph->off_mem_rsvmap);
+	uint32_t off_dt = fdt32_to_cpu(bph->off_dt_struct);
+	uint32_t off_str = fdt32_to_cpu(bph->off_dt_strings);
 	struct fdt_reserve_entry *p_rsvmap =
 		(struct fdt_reserve_entry *)(blob + off_mem_rsvmap);
 	char *p_struct = blob + off_dt;
 	char *p_strings = blob + off_str;
-	uint32_t version = be32_to_cpu(bph->version);
-	uint32_t totalsize = be32_to_cpu(bph->totalsize);
+	uint32_t version = fdt32_to_cpu(bph->version);
+	uint32_t totalsize = fdt32_to_cpu(bph->totalsize);
 	uint32_t tag;
 	char *p;
 	char *s, *t;
@@ -100,29 +85,29 @@
 	depth = 0;
 	shift = 4;
 
-	printf("// magic:\t\t0x%x\n", be32_to_cpu(bph->magic));
+	printf("// magic:\t\t0x%x\n", fdt32_to_cpu(bph->magic));
 	printf("// totalsize:\t\t0x%x (%d)\n", totalsize, totalsize);
 	printf("// off_dt_struct:\t0x%x\n", off_dt);
 	printf("// off_dt_strings:\t0x%x\n", off_str);
 	printf("// off_mem_rsvmap:\t0x%x\n", off_mem_rsvmap);
 	printf("// version:\t\t%d\n", version);
 	printf("// last_comp_version:\t%d\n",
-	       be32_to_cpu(bph->last_comp_version));
+	       fdt32_to_cpu(bph->last_comp_version));
 	if (version >= 2)
 		printf("// boot_cpuid_phys:\t0x%x\n",
-		       be32_to_cpu(bph->boot_cpuid_phys));
+		       fdt32_to_cpu(bph->boot_cpuid_phys));
 
 	if (version >= 3)
 		printf("// size_dt_strings:\t0x%x\n",
-		       be32_to_cpu(bph->size_dt_strings));
+		       fdt32_to_cpu(bph->size_dt_strings));
 	if (version >= 17)
 		printf("// size_dt_struct:\t0x%x\n",
-		       be32_to_cpu(bph->size_dt_struct));
+		       fdt32_to_cpu(bph->size_dt_struct));
 	printf("\n");
 
 	for (i = 0; ; i++) {
-		addr = be64_to_cpu(p_rsvmap[i].address);
-		size = be64_to_cpu(p_rsvmap[i].size);
+		addr = fdt64_to_cpu(p_rsvmap[i].address);
+		size = fdt64_to_cpu(p_rsvmap[i].size);
 		if (addr == 0 && size == 0)
 			break;
 
@@ -131,7 +116,7 @@
 	}
 
 	p = p_struct;
-	while ((tag = be32_to_cpu(GET_CELL(p))) != FDT_END) {
+	while ((tag = fdt32_to_cpu(GET_CELL(p))) != FDT_END) {
 
 		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */
 
@@ -164,8 +149,8 @@
 			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n", depth * shift, "", tag);
 			break;
 		}
-		sz = be32_to_cpu(GET_CELL(p));
-		s = p_strings + be32_to_cpu(GET_CELL(p));
+		sz = fdt32_to_cpu(GET_CELL(p));
+		s = p_strings + fdt32_to_cpu(GET_CELL(p));
 		if (version < 16 && sz >= 8)
 			p = PALIGN(p, 8);
 		t = p;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
