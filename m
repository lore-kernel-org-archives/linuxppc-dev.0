Return-Path: <vanbaren@cideas.com>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [204.127.192.82])
	by ozlabs.org (Postfix) with ESMTP id D75D3DDE02
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Apr 2007 12:38:53 +1000 (EST)
Date: Sat, 14 Apr 2007 22:29:14 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: [PATCH dtc take 2] Fix reserve map output for asm format.
Message-ID: <20070415022914.GA5628@dellserver.lan>
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

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon, David,

Here is a patch that fixes the asm output without the (unnecessary)
calloc change.

Best regards,
gvb

 flattree.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

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
