Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 7B286DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 01:40:59 +1100 (EST)
Date: Thu, 3 Jan 2008 09:40:57 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [DTC] small ftdump cleanup patch
Message-ID: <20080103144056.GB28644@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a small patch to clean up the usage info and the error returns
for ftdump -- not sure what the future holds for ftdump vs. simply using
"dtc -I dtb -O dts someblob.dtb" ...

Paul.


diff --git a/ftdump.c b/ftdump.c
index 53343d7..49bc7cf 100644
--- a/ftdump.c
+++ b/ftdump.c
@@ -8,6 +8,8 @@
 #include <ctype.h>
 #include <netinet/in.h>
 #include <byteswap.h>
+#include <errno.h>
+#include <libgen.h>
 
 #include <fdt.h>
 
@@ -165,21 +167,22 @@ int main(int argc, char *argv[])
 	char buf[16384];	/* 16k max */
 	int size;
 
-	if (argc < 2) {
-		fprintf(stderr, "supply input filename\n");
-		return 5;
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s filename.dtb\n", basename(argv[0]));
+		fprintf(stderr, "\t-dump binary device tree blob contents.\n");
+		return EINVAL;
 	}
 
 	fp = fopen(argv[1], "rb");
 	if (fp == NULL) {
 		fprintf(stderr, "unable to open %s\n", argv[1]);
-		return 10;
+		return errno;
 	}
 
 	size = fread(buf, 1, sizeof(buf), fp);
 	if (size == sizeof(buf)) {	/* too large */
 		fprintf(stderr, "file too large\n");
-		return 10;
+		return EFBIG;
 	}
 
 	dump_blob(buf);
