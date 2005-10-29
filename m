Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lCb5030078@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:41 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 27/43] ppc64 boot: move gunzip function before use
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Move the gunzip function up.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/main.c |  115 ++++++++++++++++++++++++-------------------------
 1 files changed, 57 insertions(+), 58 deletions(-)

diff -puN arch/ppc64/boot/main.c~ppc64-boot-move-gunzip-function-before-use arch/ppc64/boot/main.c
--- devel/arch/ppc64/boot/main.c~ppc64-boot-move-gunzip-function-before-use	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/main.c	2005-10-28 17:45:22.000000000 -0700
@@ -17,7 +17,6 @@
 #include "prom.h"
 #include "zlib.h"
 
-static void gunzip(void *, int, unsigned char *, int *);
 extern void flush_cache(void *, unsigned long);
 
 
@@ -56,6 +55,63 @@ typedef void (*kernel_entry_t)( unsigned
 
 static unsigned long claim_base;
 
+#define HEAD_CRC	2
+#define EXTRA_FIELD	4
+#define ORIG_NAME	8
+#define COMMENT		0x10
+#define RESERVED	0xe0
+
+static void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
+{
+	z_stream s;
+	int r, i, flags;
+
+	/* skip header */
+	i = 10;
+	flags = src[3];
+	if (src[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
+		printf("bad gzipped data\n\r");
+		exit();
+	}
+	if ((flags & EXTRA_FIELD) != 0)
+		i = 12 + src[10] + (src[11] << 8);
+	if ((flags & ORIG_NAME) != 0)
+		while (src[i++] != 0)
+			;
+	if ((flags & COMMENT) != 0)
+		while (src[i++] != 0)
+			;
+	if ((flags & HEAD_CRC) != 0)
+		i += 2;
+	if (i >= *lenp) {
+		printf("gunzip: ran out of data in header\n\r");
+		exit();
+	}
+
+	if (zlib_inflate_workspacesize() > sizeof(scratch)) {
+		printf("gunzip needs more mem\n");
+		exit();
+	}
+	memset(&s, 0, sizeof(s));
+	s.workspace = scratch;
+	r = zlib_inflateInit2(&s, -MAX_WBITS);
+	if (r != Z_OK) {
+		printf("inflateInit2 returned %d\n\r", r);
+		exit();
+	}
+	s.next_in = src + i;
+	s.avail_in = *lenp - i;
+	s.next_out = dst;
+	s.avail_out = dstlen;
+	r = zlib_inflate(&s, Z_FULL_FLUSH);
+	if (r != Z_OK && r != Z_STREAM_END) {
+		printf("inflate returned %d msg: %s\n\r", r, s.msg);
+		exit();
+	}
+	*lenp = s.next_out - (unsigned char *) dst;
+	zlib_inflateEnd(&s);
+}
+
 static unsigned long try_claim(unsigned long size)
 {
 	unsigned long addr = 0;
@@ -213,60 +269,3 @@ void start(unsigned long a1, unsigned lo
 	exit();
 }
 
-#define HEAD_CRC	2
-#define EXTRA_FIELD	4
-#define ORIG_NAME	8
-#define COMMENT		0x10
-#define RESERVED	0xe0
-
-static void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
-{
-	z_stream s;
-	int r, i, flags;
-
-	/* skip header */
-	i = 10;
-	flags = src[3];
-	if (src[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
-		printf("bad gzipped data\n\r");
-		exit();
-	}
-	if ((flags & EXTRA_FIELD) != 0)
-		i = 12 + src[10] + (src[11] << 8);
-	if ((flags & ORIG_NAME) != 0)
-		while (src[i++] != 0)
-			;
-	if ((flags & COMMENT) != 0)
-		while (src[i++] != 0)
-			;
-	if ((flags & HEAD_CRC) != 0)
-		i += 2;
-	if (i >= *lenp) {
-		printf("gunzip: ran out of data in header\n\r");
-		exit();
-	}
-
-	if (zlib_inflate_workspacesize() > sizeof(scratch)) {
-		printf("gunzip needs more mem\n");
-		exit();
-	}
-	memset(&s, 0, sizeof(s));
-	s.workspace = scratch;
-	r = zlib_inflateInit2(&s, -MAX_WBITS);
-	if (r != Z_OK) {
-		printf("inflateInit2 returned %d\n\r", r);
-		exit();
-	}
-	s.next_in = src + i;
-	s.avail_in = *lenp - i;
-	s.next_out = dst;
-	s.avail_out = dstlen;
-	r = zlib_inflate(&s, Z_FULL_FLUSH);
-	if (r != Z_OK && r != Z_STREAM_END) {
-		printf("inflate returned %d msg: %s\n\r", r, s.msg);
-		exit();
-	}
-	*lenp = s.next_out - (unsigned char *) dst;
-	zlib_inflateEnd(&s);
-}
-
_
