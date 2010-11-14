Return-Path: <jkenisto@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2829EB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:16:03 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE45jks026573
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:05:45 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oAE4FdT2233602
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:49 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAE4Fd7h014994
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:39 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4Fdig014982
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:39 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 5/6] nvram: Slim down zlib_deflate workspace when possible
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:39 -0800
Message-ID: <20101114041539.9457.11974.stgit@localhost.localdomain>
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of always creating a huge (268K) deflate_workspace with the
maximum compression parameters (windowBits=15, memLevel=8), allow the
caller to obtain a smaller workspace (24K in our case) by specifying
smaller parameter values -- via zlib_deflate_workspacesize2(). In our
case, a small workspace is a win because our choices are to allocate
the workspace when we need it (i.e., during an oops or panic) or
allocate it at boot time.  (We do the latter.)

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 include/linux/zlib.h            |   14 ++++++++++++--
 lib/zlib_deflate/deflate.c      |   33 ++++++++++++++++++++++++++++++++-
 lib/zlib_deflate/deflate_syms.c |    1 +
 lib/zlib_deflate/defutil.h      |   17 +++++++++++++----
 4 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/include/linux/zlib.h b/include/linux/zlib.h
index 40c49cb..3f15036 100644
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -179,11 +179,21 @@ typedef z_stream *z_streamp;
 
                         /* basic functions */
 
+extern int zlib_deflate_workspacesize2 (int windowBits, int memLevel);
+/*
+   Returns the number of bytes that needs to be allocated for a per-
+   stream workspace with the specified parameters.  A pointer to this
+   number of bytes should be returned in stream->workspace before
+   calling zlib_deflateInit2(); and the windowBits and memLevel
+   parameters passed to zlib_deflateInit2() must not exceed those
+   passed here.
+*/
+
 extern int zlib_deflate_workspacesize (void);
 /*
    Returns the number of bytes that needs to be allocated for a per-
-   stream workspace.  A pointer to this number of bytes should be
-   returned in stream->workspace before calling zlib_deflateInit().
+   stream workspace with the default (large) windowBits and memLevel
+   parameters.
 */
 
 /* 
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 46a31e5..cdb207a 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -176,6 +176,7 @@ int zlib_deflateInit2(
     deflate_state *s;
     int noheader = 0;
     deflate_workspace *mem;
+    char *next;
 
     ush *overlay;
     /* We overlay pending_buf and d_buf+l_buf. This works since the average
@@ -199,6 +200,21 @@ int zlib_deflateInit2(
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
+
+    /*
+     * Direct the workspace's pointers to the chunks that were allocated
+     * along with the deflate_workspace struct.
+     */
+    next = (char *) mem;
+    next += sizeof(*mem);
+    mem->window_memory = (Byte *) next;
+    next += zlib_deflate_window_memsize(windowBits);
+    mem->prev_memory = (Pos *) next;
+    next += zlib_deflate_prev_memsize(windowBits);
+    mem->head_memory = (Pos *) next;
+    next += zlib_deflate_head_memsize(memLevel);
+    mem->overlay_memory = next;
+
     s = (deflate_state *) &(mem->deflate_memory);
     strm->state = (struct internal_state *)s;
     s->strm = strm;
@@ -1249,5 +1265,20 @@ static block_state deflate_slow(
 
 int zlib_deflate_workspacesize(void)
 {
-    return sizeof(deflate_workspace);
+    return zlib_deflate_workspacesize2(MAX_WBITS, MAX_MEM_LEVEL);
+}
+
+int zlib_deflate_workspacesize2(int windowBits, int memLevel)
+{
+    if (windowBits < 0) /* undocumented feature: suppress zlib header */
+        windowBits = -windowBits;
+    if (memLevel < 1 || memLevel > MAX_MEM_LEVEL ||
+        windowBits < 9 || windowBits > 15)
+        return -1;
+
+    return sizeof(deflate_workspace)
+        + zlib_deflate_window_memsize(windowBits)
+        + zlib_deflate_prev_memsize(windowBits)
+        + zlib_deflate_head_memsize(memLevel)
+        + zlib_deflate_overlay_memsize(memLevel);
 }
diff --git a/lib/zlib_deflate/deflate_syms.c b/lib/zlib_deflate/deflate_syms.c
index ccfe25f..cdf1cdd 100644
--- a/lib/zlib_deflate/deflate_syms.c
+++ b/lib/zlib_deflate/deflate_syms.c
@@ -11,6 +11,7 @@
 #include <linux/zlib.h>
 
 EXPORT_SYMBOL(zlib_deflate_workspacesize);
+EXPORT_SYMBOL(zlib_deflate_workspacesize2);
 EXPORT_SYMBOL(zlib_deflate);
 EXPORT_SYMBOL(zlib_deflateInit2);
 EXPORT_SYMBOL(zlib_deflateEnd);
diff --git a/lib/zlib_deflate/defutil.h b/lib/zlib_deflate/defutil.h
index 6b15a90..b640b64 100644
--- a/lib/zlib_deflate/defutil.h
+++ b/lib/zlib_deflate/defutil.h
@@ -241,12 +241,21 @@ typedef struct deflate_state {
 typedef struct deflate_workspace {
     /* State memory for the deflator */
     deflate_state deflate_memory;
-    Byte window_memory[2 * (1 << MAX_WBITS)];
-    Pos prev_memory[1 << MAX_WBITS];
-    Pos head_memory[1 << (MAX_MEM_LEVEL + 7)];
-    char overlay_memory[(1 << (MAX_MEM_LEVEL + 6)) * (sizeof(ush)+2)];
+    Byte *window_memory;
+    Pos *prev_memory;
+    Pos *head_memory;
+    char *overlay_memory;
 } deflate_workspace;
 
+#define zlib_deflate_window_memsize(windowBits) \
+	(2 * (1 << (windowBits)) * sizeof(Byte))
+#define zlib_deflate_prev_memsize(windowBits) \
+	((1 << (windowBits)) * sizeof(Pos))
+#define zlib_deflate_head_memsize(memLevel) \
+	((1 << ((memLevel)+7)) * sizeof(Pos))
+#define zlib_deflate_overlay_memsize(memLevel) \
+	((1 << ((memLevel)+6)) * (sizeof(ush)+2))
+
 /* Output a byte on the stream.
  * IN assertion: there is enough room in pending_buf.
  */
