Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DEC36B7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:36:45 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE4Jw4Z026889
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:19:58 -0500
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4af7j358204
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:36:41 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAE4eixC026375
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:40:44 -0700
Received: from [9.47.28.66] (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4ei5C026371
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:40:44 -0700
Subject: Re: [RFC PATCH 0/6] nvram: Capture oops/panic reports in NVRAM
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Nov 2010 20:36:40 -0800
Message-ID: <1289709400.3160.10.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-11-13 at 20:15 -0800, Jim Keniston wrote:
> This patch series enables p Series systems to capture oops and panic
> reports from the printk buffer into NVRAM, where they can be examined
> after reboot using the nvram command.
> 

Here's a patch to the nvram command to add --unzip and --ascii options,
for examination of oops/panic reports captured in ibm,oops-log or
ibm,rtas-log.

The nvram command is part of powerpc-utils --
git://powerpc-utils.git.sourceforge.net/gitroot/powerpc-utils/powerpc-utils

You can build it using
cc nvram.c -ldl -lz -o nvram

BTW, as far as I can tell, the zlib_deflate code in the kernel can't
produce the header that the gunzip command wants -- hence the reliance
on libz in the nvram command.

Jim
---

 src/nvram.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/src/nvram.c b/src/nvram.c
index d25e073..e00ae12 100644
--- a/src/nvram.c
+++ b/src/nvram.c
@@ -43,6 +43,7 @@
 #include <glob.h>
 #include <getopt.h>
 #include <inttypes.h>
+#include <zlib.h>
 
 #include "nvram.h"
 
@@ -62,6 +63,8 @@ static struct option long_options[] = {
     {"print-event-scan", 	no_argument, 	   NULL, 'E'},
     {"partitions", 		no_argument, 	   NULL, 'P'},
     {"dump", 			required_argument, NULL, 'd'},
+    {"ascii",			required_argument, NULL, 'a'},
+    {"unzip", 			required_argument, NULL, 'z'},
     {"nvram-file", 		required_argument, NULL, 'n'},
     {"nvram-size", 		required_argument, NULL, 's'},
     {"update-config",		required_argument, NULL, 'u'},
@@ -99,6 +102,10 @@ help(void)
     "          print NVRAM paritition header info\n"
     "  --dump <name>\n"
     "          raw dump of partition (use --partitions to see names)\n"
+    "  --ascii <name>\n"
+    "          print partition contents as ASCII text\n"
+    "  --unzip <name>\n"
+    "          decompress and print compressed data from partition\n"
     "  --nvram-file <path>\n"
     "          specify alternate nvram data file (default is /dev/nvram)\n"
     "  --nvram-size\n"
@@ -1189,6 +1196,121 @@ dump_raw_partition(struct nvram *nvram, char *name)
 }
 
 /**
+ * dump_ascii_partition
+ * @brief ASCII data dump of a partition, excluding header
+ *
+ * @param nvram nvram struct containing partition
+ * @param name name of partition to dump
+ * @return 0 on success, !0 otherwise
+ *
+ * Partition subheaders, if any, are dumped along with the rest of the data.
+ * We substitute periods for unprintable characters.
+ */
+int
+dump_ascii_partition(struct nvram *nvram, char *name)
+{
+    struct partition_header *phead;
+    char *start, *end, *c;
+
+    phead = nvram_find_partition(nvram, 0, name, NULL);
+    if (!phead) {
+	err_msg("there is no %s partition!\n", name);
+	return -1;
+    }
+    
+    start = (char*) phead;
+    end = start + phead->length * NVRAM_BLOCK_SIZE;
+    start += sizeof(*phead);	/* Skip partition header. */
+    for (c = start; c < end; c++) {
+	if (isprint(*c) || isspace(*c))
+	    putchar(*c);
+	else
+	    putchar('.');
+    }
+    /* Always end with a newline.*/
+    putchar('\n');
+    return 0;
+}
+
+int
+dump_zipped_text(char *zipped_text, unsigned int zipped_length)
+{
+    z_stream strm;
+    int result;
+    char unzipped_text[4096];
+
+    strm.zalloc = Z_NULL;
+    strm.zfree = Z_NULL;
+    strm.opaque = Z_NULL;
+    strm.avail_in = zipped_length;
+    strm.next_in = zipped_text;
+    result = inflateInit(&strm);
+    if (result != Z_OK) {
+    	err_msg("can't decompress text: inflateInit() returned %d\n", result);
+	return -1;
+    }
+
+    do {
+	strm.avail_out = 4096;
+	strm.next_out = unzipped_text;
+    	result = inflate(&strm, Z_NO_FLUSH);
+	switch (result) {
+	case Z_STREAM_ERROR:
+	case Z_NEED_DICT:
+	case Z_DATA_ERROR:
+	case Z_MEM_ERROR:
+	    err_msg("can't decompress text: inflate() returned %d\n", result);
+	    (void) inflateEnd(&strm);
+	    return -1;
+	}
+	if (fwrite(unzipped_text, 4096 - strm.avail_out, 1, stdout) != 1) {
+	    err_msg("can't decompress text: fwrite() failed\n");
+	    (void) inflateEnd(&strm);
+	    return -1;
+	}
+    } while (strm.avail_out == 0);
+
+    (void) inflateEnd(&strm);
+    return 0;
+}
+
+/**
+ * unzip_partition
+ * @brief Uncompress and print compressed data from a partition.
+ *
+ * @param nvram nvram struct containing partition
+ * @param name name of partition to dump
+ * @return 0 on success, !0 otherwise
+ */
+int
+unzip_partition(struct nvram *nvram, char *name)
+{
+    struct partition_header *phead;
+    char *start, *next;
+    unsigned short zipped_length;
+
+    phead = nvram_find_partition(nvram, 0, name, NULL);
+    if (!phead) {
+	err_msg("there is no %s partition!\n", name);
+	return -1;
+    }
+    
+    start = (char*) phead;
+    next = start + sizeof(*phead);	/* Skip partition header. */
+    next += sizeof(struct err_log_info);	/* Skip sub-header. */
+    zipped_length = *((unsigned short*) next);
+    next += sizeof(unsigned short);		/* Skip compressed length. */
+
+    if ((next-start) + zipped_length > phead->length * NVRAM_BLOCK_SIZE) {
+    	err_msg("bogus size for compressed data in partition %s: %u\n", name,
+	    zipped_length);
+	return -1;
+    }
+
+    return dump_zipped_text(next, zipped_length);
+}
+
+/**
  * print_of_config_part
  * @brief Print the name/value pairs of a partition
  *
@@ -1476,6 +1598,8 @@ main (int argc, char *argv[])
     int print_event_scan = 0;
     int	print_config_var = 0;
     char *dump_name = NULL;
+    char *ascii_name = NULL;
+    char *zip_name = NULL;
     char *update_config_var = NULL;
     char *config_pname = "common";
 
@@ -1504,6 +1628,12 @@ main (int argc, char *argv[])
 	    case 'd':	/* dump */
 		dump_name = optarg;
 		break;
+	    case 'a':	/* ASCII dump */
+	    	ascii_name = optarg;
+		break;
+	    case 'z':	/* dump compressed data */
+		zip_name = optarg;
+		break;
 	    case 'n':	/* nvram-file */
 		nvram.filename = optarg;
 		break;
@@ -1641,6 +1771,12 @@ main (int argc, char *argv[])
     if (dump_name)
 	if (dump_raw_partition(&nvram, dump_name) != 0)
 	    ret = -1;
+    if (ascii_name)
+	if (dump_ascii_partition(&nvram, ascii_name) != 0)
+	    ret = -1;
+    if (zip_name)
+	if (unzip_partition(&nvram, zip_name) != 0)
+	    ret = -1;
    
 err_exit:   
    if (nvram.data)
