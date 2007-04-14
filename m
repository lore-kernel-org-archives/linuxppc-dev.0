Return-Path: <vanbaren@cideas.com>
Received: from alnrmhc13.comcast.net (alnrmhc13.comcast.net [204.127.225.93])
	by ozlabs.org (Postfix) with ESMTP id E4E9DDDE29
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Apr 2007 08:20:33 +1000 (EST)
Date: Sat, 14 Apr 2007 18:15:27 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: [PATCH dtc] Fix reserve map output for asm format.
Message-ID: <20070414221526.GA23870@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add extra reserve map slots output for asm format (previously done for dtb
  output).
Use cmalloc to pre-zero memory (for dtb input) and handle dtb (binary)
  input being shorter than the total blob length (result of putting
  extra space in the blob).

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon:

Some simple fixes for handling extra reserve slots and extra space in
the blob.

Best regards,
gvb

 dtc.h      |    4 ++--
 flattree.c |   14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/dtc.h b/dtc.h
index 8cfe1a1..e77f9d1 100644
--- a/dtc.h
+++ b/dtc.h
@@ -55,10 +55,10 @@ static inline void die(char * str, ...)
 
 static inline void *xmalloc(size_t len)
 {
-	void *new = malloc(len);
+	void *new = calloc(len, 1);
 
 	if (! new)
-		die("malloc() failed\n");
+		die("calloc() failed\n");
 
 	return new;
 }
diff --git a/flattree.c b/flattree.c
index 151d16e..6f0c9b7 100644
--- a/flattree.c
+++ b/flattree.c
@@ -21,6 +21,9 @@
 #include "dtc.h"
 #include "flat_dt.h"
 
+#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
+
+
 #define FTF_FULLPATH	0x1
 #define FTF_VARALIGN	0x2
 #define FTF_NAMEPROPS	0x4
@@ -490,6 +493,9 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 			(unsigned int)(re->re.size >> 32),
 			(unsigned int)(re->re.size & 0xffffffff));
 	}
+	for (i = 0; i < reservenum; i++) {
+		fprintf(f, "\t.long\t0, 0\n\t.long\t0, 0\n");
+	}
 
 	fprintf(f, "\t.long\t0, 0\n\t.long\t0, 0\n");
 
@@ -818,9 +824,11 @@ struct boot_info *dt_from_blob(FILE *f)
 	p = blob + sizeof(magic)  + sizeof(totalsize);
 
 	while (sizeleft) {
-		if (feof(f))
-			die("EOF before reading %d bytes of DT blob\n",
-			    totalsize);
+		if (feof(f)) {
+			WARNMSG("EOF after reading %d of %d bytes of DT blob, assuming there is extra space in the blob.\n",
+			    totalsize - sizeleft, totalsize);
+			break;
+		}
 
 		rc = fread(p, 1, sizeleft, f);
 		if (ferror(f))
-- 
1.4.4.4
