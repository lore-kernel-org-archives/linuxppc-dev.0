Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 Jan 2008 15:48:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: Outstanding DTC patches?
Message-ID: <20080103044843.GD25357@localhost.localdomain>
References: <1199298062.7345.25.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199298062.7345.25.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 12:21:02PM -0600, Jon Loeliger wrote:
> Folks,
> 
> I'd like to release a DTC 1.1 Real Soon Now!
> 
> However, I've been back-logged due to the holidays.
> If you have any outstanding DTC or libfdt patches
> that I have not yet applied and that you would like
> in that release, please remind me by reposting it
> and CC:'ing jdl@jdl.com!

I posted this one a while back, but I guess it dropped through the
cracks.  There's also the patch I sent you quite a long time ago that
adds a clarifying readme about the licensing situation - that might be
an idea for v1.1, too.

dtc: Remove header information dumping

Currently, when used in -Idtb mode, dtc will dump information about
the input blob's header fields to stderr.  This is kind of ugly, and
can get in the way of dtc's real output.

This patch, therefore, removes this.  So that there's still a way of
getting this information for debugging purposes, it places something
similar to the removed code into ftdump, replacing the couple of
header fields it currently prints with a complete header dump.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-12-08 12:06:11.000000000 +1100
+++ dtc/flattree.c	2007-12-08 12:13:15.000000000 +1100
@@ -898,15 +898,6 @@
 	off_mem_rsvmap = be32_to_cpu(fdt->off_mem_rsvmap);
 	version = be32_to_cpu(fdt->version);
 
-	fprintf(stderr, "\tmagic:\t\t\t0x%x\n", magic);
-	fprintf(stderr, "\ttotalsize:\t\t%d\n", totalsize);
-	fprintf(stderr, "\toff_dt_struct:\t\t0x%x\n", off_dt);
-	fprintf(stderr, "\toff_dt_strings:\t\t0x%x\n", off_str);
-	fprintf(stderr, "\toff_mem_rsvmap:\t\t0x%x\n", off_mem_rsvmap);
-	fprintf(stderr, "\tversion:\t\t0x%x\n", version );
-	fprintf(stderr, "\tlast_comp_version:\t0x%x\n",
-		be32_to_cpu(fdt->last_comp_version));
-
 	if (off_mem_rsvmap >= totalsize)
 		die("Mem Reserve structure offset exceeds total size\n");
 
@@ -916,21 +907,15 @@
 	if (off_str > totalsize)
 		die("String table offset exceeds total size\n");
 
-	if (version >= 2)
-		fprintf(stderr, "\tboot_cpuid_phys:\t0x%x\n",
-			be32_to_cpu(fdt->boot_cpuid_phys));
-
 	size_str = -1;
 	if (version >= 3) {
 		size_str = be32_to_cpu(fdt->size_dt_strings);
-		fprintf(stderr, "\tsize_dt_strings:\t%d\n", size_str);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
 	}
 
 	if (version >= 17) {
 		size_dt = be32_to_cpu(fdt->size_dt_struct);
-		fprintf(stderr, "\tsize_dt_struct:\t\t%d\n", size_dt);
 		if (off_dt+size_dt > totalsize)
 			die("Structure block extends past total size\n");
 	}
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2007-12-08 12:06:23.000000000 +1100
+++ dtc/ftdump.c	2007-12-08 12:15:09.000000000 +1100
@@ -81,11 +81,13 @@
 static void dump_blob(void *blob)
 {
 	struct fdt_header *bph = blob;
+	uint32_t off_mem_rsvmap = be32_to_cpu(bph->off_mem_rsvmap);
+	uint32_t off_dt = be32_to_cpu(bph->off_dt_struct);
+	uint32_t off_str = be32_to_cpu(bph->off_dt_strings);
 	struct fdt_reserve_entry *p_rsvmap =
-		(struct fdt_reserve_entry *)(blob
-					     + be32_to_cpu(bph->off_mem_rsvmap));
-	char *p_struct = blob + be32_to_cpu(bph->off_dt_struct);
-	char *p_strings = blob + be32_to_cpu(bph->off_dt_strings);
+		(struct fdt_reserve_entry *)(blob + off_mem_rsvmap);
+	char *p_struct = blob + off_dt;
+	char *p_strings = blob + off_str;
 	uint32_t version = be32_to_cpu(bph->version);
 	uint32_t totalsize = be32_to_cpu(bph->totalsize);
 	uint32_t tag;
@@ -98,8 +100,26 @@
 	depth = 0;
 	shift = 4;
 
-	printf("// Version 0x%x tree\n", version);
-	printf("// Totalsize 0x%x(%d)\n", totalsize, totalsize);
+	printf("// magic:\t\t0x%x\n", be32_to_cpu(bph->magic));
+	printf("// totalsize:\t\t0x%x (%d)\n", totalsize, totalsize);
+	printf("// off_dt_struct:\t0x%x\n", off_dt);
+	printf("// off_dt_strings:\t0x%x\n", off_str);
+	printf("// off_mem_rsvmap:\t0x%x\n", off_mem_rsvmap);
+	printf("// version:\t\t%d\n", version);
+	printf("// last_comp_version:\t%d\n",
+	       be32_to_cpu(bph->last_comp_version));
+	if (version >= 2)
+		printf("// boot_cpuid_phys:\t0x%x\n",
+		       be32_to_cpu(bph->boot_cpuid_phys));
+
+	if (version >= 3)
+		printf("// size_dt_strings:\t0x%x\n",
+		       be32_to_cpu(bph->size_dt_strings));
+	if (version >= 17)
+		printf("// size_dt_struct:\t0x%x\n",
+		       be32_to_cpu(bph->size_dt_struct));
+	printf("\n");
+
 	for (i = 0; ; i++) {
 		addr = be64_to_cpu(p_rsvmap[i].address);
 		size = be64_to_cpu(p_rsvmap[i].size);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
