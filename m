Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 16:32:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Add documentation for the zImage's gunzip convenience functions
Message-ID: <20070314053217.GG25514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds documenting comments to the gunzip convenience
functions added in commit ad9d2716cfc1cda5a7e0d7bc0db45e3af8a4adbb.
It also removes a stray newline, and an unused global variable.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Paulus, at least two people have asked for more documentation on these
functions.  Please apply.

Index: working-2.6/arch/powerpc/boot/gunzip_util.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/gunzip_util.c	2007-03-14 16:21:23.000000000 +1100
+++ working-2.6/arch/powerpc/boot/gunzip_util.c	2007-03-14 16:23:06.000000000 +1100
@@ -14,14 +14,31 @@
 #include "ops.h"
 #include "gunzip_util.h"
 
-struct gunzip_state state;
-
 #define HEAD_CRC	2
 #define EXTRA_FIELD	4
 #define ORIG_NAME	8
 #define COMMENT		0x10
 #define RESERVED	0xe0
 
+/**
+ * gunzip_start - prepare to decompress gzip data
+ * @state:     decompressor state structure to be initialized
+ * @src:       buffer containing gzip compressed or uncompressed data
+ * @srclen:    size in bytes of the buffer at src
+ *
+ * If the buffer at @src contains a gzip header, this function
+ * initializes zlib to decompress the data, storing the decompression
+ * state in @state.  The other functions in this file can then be used
+ * to decompress data from the gzipped stream.
+ *
+ * If the buffer at @src does not contain a gzip header, it is assumed
+ * to contain uncompressed data.  The buffer information is recorded
+ * in @state and the other functions in this file will simply copy
+ * data from the uncompressed data stream at @src.
+ *
+ * Any errors, such as bad compressed data, cause an error to be
+ * printed an the platform's exit() function to be called.
+ */
 void gunzip_start(struct gunzip_state *state, void *src, int srclen)
 {
 	char *hdr = src;
@@ -73,6 +90,22 @@ void gunzip_start(struct gunzip_state *s
 	state->s.avail_in = srclen - hdrlen;
 }
 
+/**
+ * gunzip_partial - extract bytes from a gzip data stream
+ * @state:     gzip state structure previously initialized by gunzip_start()
+ * @dst:       buffer to store extracted data
+ * @dstlen:    maximum number of bytes to extract
+ *
+ * This function extracts at most @dstlen bytes from the data stream
+ * previously associated with @state by gunzip_start(), decompressing
+ * if necessary.  Exactly @dstlen bytes are extracted unless the data
+ * stream doesn't contain enough bytes, in which case the entire
+ * remainder of the stream is decompressed.
+ *
+ * Returns the actual number of bytes extracted.  If any errors occur,
+ * such as a corrupted compressed stream, an error is printed an the
+ * platform's exit() function is called.
+ */
 int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen)
 {
 	int len;
@@ -99,6 +132,20 @@ int gunzip_partial(struct gunzip_state *
 	return len;
 }
 
+/**
+ * gunzip_exactly - extract a fixed number of bytes from a gzip data stream
+ * @state:     gzip state structure previously initialized by gunzip_start()
+ * @dst:       buffer to store extracted data
+ * @dstlen:    number of bytes to extract
+ *
+ * This function extracts exactly @dstlen bytes from the data stream
+ * previously associated with @state by gunzip_start(), decompressing
+ * if necessary.
+ *
+ * If there are less @dstlen bytes available in the data stream, or if
+ * any other errors occur, such as a corrupted compressed stream, an
+ * error is printed an the platform's exit() function is called.
+ */
 void gunzip_exactly(struct gunzip_state *state, void *dst, int dstlen)
 {
 	int len;
@@ -110,6 +157,21 @@ void gunzip_exactly(struct gunzip_state 
 	}
 }
 
+/**
+ * gunzip_discard - discard bytes from a gzip data stream
+ * @state:     gzip state structure previously initialized by gunzip_start()
+ * @len:       number of bytes to discard
+ *
+ * This function extracts, then discards exactly @len bytes from the
+ * data stream previously associated with @state by gunzip_start().
+ * Subsequent gunzip_partial(), gunzip_exactly() or gunzip_finish()
+ * calls will extract the data following the discarded bytes in the
+ * data stream.
+ *
+ * If there are less @len bytes available in the data stream, or if
+ * any other errors occur, such as a corrupted compressed stream, an
+ * error is printed an the platform's exit() function is called.
+ */
 void gunzip_discard(struct gunzip_state *state, int len)
 {
 	static char discard_buf[128];
@@ -123,6 +185,21 @@ void gunzip_discard(struct gunzip_state 
 		gunzip_exactly(state, discard_buf, len);
 }
 
+/**
+ * gunzip_finish - extract all remaining bytes from a gzip data stream
+ * @state:     gzip state structure previously initialized by gunzip_start()
+ * @dst:       buffer to store extracted data
+ * @dstlen:    maximum number of bytes to extract
+ *
+ * This function extracts all remaining data, or at most @dstlen
+ * bytes, from the stream previously associated with @state by
+ * gunzip_start().  zlib is then shut down, so it is an error to use
+ * any of the functions in this file on @state until it is
+ * re-initialized with another call to gunzip_start().
+ *
+ * If any errors occur, such as a corrupted compressed stream, an
+ * error is printed an the platform's exit() function is called.
+ */
 int gunzip_finish(struct gunzip_state *state, void *dst, int dstlen)
 {
 	int len;
Index: working-2.6/arch/powerpc/boot/gunzip_util.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/gunzip_util.h	2007-03-14 16:23:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/gunzip_util.h	2007-03-14 16:23:49.000000000 +1100
@@ -12,6 +12,22 @@
 
 #include "zlib.h"
 
+/*
+ * These functions are designed to make life easy for decompressing
+ * kernel images, initrd images or any other gzip compressed image,
+ * particularly if its useful to decompress part of the image (e.g. to
+ * examine headers) before decompressing the remainder.
+ *
+ * To use:
+ *     - declare a gunzip_state structure
+ *     - use gunzip_start() to initialize the state, associating it
+ *       with a stream of compressed data
+ *     - use gunzip_partial(), gunzip_exactly() and gunzip_discard()
+ *       in any combination to extract pieces of data from the stream
+ *     - Finally use gunzip_finish() to extract the tail of the
+ *       compressed stream and wind up zlib
+ */
+
 /* scratch space for gunzip; 46912 is from zlib_inflate_workspacesize() */
 #define GUNZIP_SCRATCH_SIZE	46912
 
@@ -27,4 +43,3 @@ void gunzip_discard(struct gunzip_state 
 int gunzip_finish(struct gunzip_state *state, void *dst, int len);
 
 #endif /* _PPC_BOOT_GUNZIP_UTIL_H_ */
-

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
