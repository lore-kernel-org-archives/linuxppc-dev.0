Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdVCg3s2rzDsfy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 14:29:51 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id vz6so322237pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 21:29:51 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2 4/6] powerpc/boot: remove legacy gzip wrapper
Date: Tue, 20 Sep 2016 14:29:22 +1000
Message-Id: <1474345764-28038-5-git-send-email-oohall@gmail.com>
In-Reply-To: <1474345764-28038-1-git-send-email-oohall@gmail.com>
References: <1474345764-28038-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is no longer used and can be removed.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/cuboot-c2k.c  |   1 -
 arch/powerpc/boot/gunzip_util.c | 204 ----------------------------------------
 arch/powerpc/boot/gunzip_util.h |  45 ---------
 3 files changed, 250 deletions(-)
 delete mode 100644 arch/powerpc/boot/gunzip_util.c
 delete mode 100644 arch/powerpc/boot/gunzip_util.h

diff --git a/arch/powerpc/boot/cuboot-c2k.c b/arch/powerpc/boot/cuboot-c2k.c
index e43594950ba3..9309c51f1d65 100644
--- a/arch/powerpc/boot/cuboot-c2k.c
+++ b/arch/powerpc/boot/cuboot-c2k.c
@@ -18,7 +18,6 @@
 #include "io.h"
 #include "ops.h"
 #include "elf.h"
-#include "gunzip_util.h"
 #include "mv64x60.h"
 #include "cuboot.h"
 #include "ppcboot.h"
diff --git a/arch/powerpc/boot/gunzip_util.c b/arch/powerpc/boot/gunzip_util.c
deleted file mode 100644
index 9dc52501de83..000000000000
--- a/arch/powerpc/boot/gunzip_util.c
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- * Copyright 2007 David Gibson, IBM Corporation.
- * Based on earlier work, Copyright (C) Paul Mackerras 1997.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <stddef.h>
-#include "string.h"
-#include "stdio.h"
-#include "ops.h"
-#include "gunzip_util.h"
-
-#define HEAD_CRC	2
-#define EXTRA_FIELD	4
-#define ORIG_NAME	8
-#define COMMENT		0x10
-#define RESERVED	0xe0
-
-/**
- * gunzip_start - prepare to decompress gzip data
- * @state:     decompressor state structure to be initialized
- * @src:       buffer containing gzip compressed or uncompressed data
- * @srclen:    size in bytes of the buffer at src
- *
- * If the buffer at @src contains a gzip header, this function
- * initializes zlib to decompress the data, storing the decompression
- * state in @state.  The other functions in this file can then be used
- * to decompress data from the gzipped stream.
- *
- * If the buffer at @src does not contain a gzip header, it is assumed
- * to contain uncompressed data.  The buffer information is recorded
- * in @state and the other functions in this file will simply copy
- * data from the uncompressed data stream at @src.
- *
- * Any errors, such as bad compressed data, cause an error to be
- * printed an the platform's exit() function to be called.
- */
-void gunzip_start(struct gunzip_state *state, void *src, int srclen)
-{
-	char *hdr = src;
-	int hdrlen = 0;
-
-	memset(state, 0, sizeof(*state));
-
-	/* Check for gzip magic number */
-	if ((hdr[0] == 0x1f) && (hdr[1] == 0x8b)) {
-		/* gzip data, initialize zlib parameters */
-		int r, flags;
-
-		state->s.workspace = state->scratch;
-		if (zlib_inflate_workspacesize() > sizeof(state->scratch))
-			fatal("insufficient scratch space for gunzip\n\r");
-
-		/* skip header */
-		hdrlen = 10;
-		flags = hdr[3];
-		if (hdr[2] != Z_DEFLATED || (flags & RESERVED) != 0)
-			fatal("bad gzipped data\n\r");
-		if ((flags & EXTRA_FIELD) != 0)
-			hdrlen = 12 + hdr[10] + (hdr[11] << 8);
-		if ((flags & ORIG_NAME) != 0)
-			while (hdr[hdrlen++] != 0)
-				;
-		if ((flags & COMMENT) != 0)
-			while (hdr[hdrlen++] != 0)
-				;
-		if ((flags & HEAD_CRC) != 0)
-			hdrlen += 2;
-		if (hdrlen >= srclen)
-			fatal("gunzip_start: ran out of data in header\n\r");
-
-		r = zlib_inflateInit2(&state->s, -MAX_WBITS);
-		if (r != Z_OK)
-			fatal("inflateInit2 returned %d\n\r", r);
-	}
-
-	state->s.total_in = hdrlen;
-	state->s.next_in = src + hdrlen;
-	state->s.avail_in = srclen - hdrlen;
-}
-
-/**
- * gunzip_partial - extract bytes from a gzip data stream
- * @state:     gzip state structure previously initialized by gunzip_start()
- * @dst:       buffer to store extracted data
- * @dstlen:    maximum number of bytes to extract
- *
- * This function extracts at most @dstlen bytes from the data stream
- * previously associated with @state by gunzip_start(), decompressing
- * if necessary.  Exactly @dstlen bytes are extracted unless the data
- * stream doesn't contain enough bytes, in which case the entire
- * remainder of the stream is decompressed.
- *
- * Returns the actual number of bytes extracted.  If any errors occur,
- * such as a corrupted compressed stream, an error is printed an the
- * platform's exit() function is called.
- */
-int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen)
-{
-	int len;
-
-	if (state->s.workspace) {
-		/* gunzipping */
-		int r;
-
-		state->s.next_out = dst;
-		state->s.avail_out = dstlen;
-		r = zlib_inflate(&state->s, Z_FULL_FLUSH);
-		if (r != Z_OK && r != Z_STREAM_END)
-			fatal("inflate returned %d msg: %s\n\r", r, state->s.msg);
-		len = state->s.next_out - (Byte *)dst;
-	} else {
-		/* uncompressed image */
-		len = min(state->s.avail_in, (uLong)dstlen);
-		memcpy(dst, state->s.next_in, len);
-		state->s.next_in += len;
-		state->s.avail_in -= len;
-	}
-	return len;
-}
-
-/**
- * gunzip_exactly - extract a fixed number of bytes from a gzip data stream
- * @state:     gzip state structure previously initialized by gunzip_start()
- * @dst:       buffer to store extracted data
- * @dstlen:    number of bytes to extract
- *
- * This function extracts exactly @dstlen bytes from the data stream
- * previously associated with @state by gunzip_start(), decompressing
- * if necessary.
- *
- * If there are less @dstlen bytes available in the data stream, or if
- * any other errors occur, such as a corrupted compressed stream, an
- * error is printed an the platform's exit() function is called.
- */
-void gunzip_exactly(struct gunzip_state *state, void *dst, int dstlen)
-{
-	int len;
-
-	len  = gunzip_partial(state, dst, dstlen);
-	if (len < dstlen)
-		fatal("\n\rgunzip_exactly: ran out of data!"
-				" Wanted %d, got %d.\n\r", dstlen, len);
-}
-
-/**
- * gunzip_discard - discard bytes from a gzip data stream
- * @state:     gzip state structure previously initialized by gunzip_start()
- * @len:       number of bytes to discard
- *
- * This function extracts, then discards exactly @len bytes from the
- * data stream previously associated with @state by gunzip_start().
- * Subsequent gunzip_partial(), gunzip_exactly() or gunzip_finish()
- * calls will extract the data following the discarded bytes in the
- * data stream.
- *
- * If there are less @len bytes available in the data stream, or if
- * any other errors occur, such as a corrupted compressed stream, an
- * error is printed an the platform's exit() function is called.
- */
-void gunzip_discard(struct gunzip_state *state, int len)
-{
-	static char discard_buf[128];
-
-	while (len > sizeof(discard_buf)) {
-		gunzip_exactly(state, discard_buf, sizeof(discard_buf));
-		len -= sizeof(discard_buf);
-	}
-
-	if (len > 0)
-		gunzip_exactly(state, discard_buf, len);
-}
-
-/**
- * gunzip_finish - extract all remaining bytes from a gzip data stream
- * @state:     gzip state structure previously initialized by gunzip_start()
- * @dst:       buffer to store extracted data
- * @dstlen:    maximum number of bytes to extract
- *
- * This function extracts all remaining data, or at most @dstlen
- * bytes, from the stream previously associated with @state by
- * gunzip_start().  zlib is then shut down, so it is an error to use
- * any of the functions in this file on @state until it is
- * re-initialized with another call to gunzip_start().
- *
- * If any errors occur, such as a corrupted compressed stream, an
- * error is printed an the platform's exit() function is called.
- */
-int gunzip_finish(struct gunzip_state *state, void *dst, int dstlen)
-{
-	int len;
-
-	len = gunzip_partial(state, dst, dstlen);
-
-	if (state->s.workspace) {
-		zlib_inflateEnd(&state->s);
-	}
-
-	return len;
-}
diff --git a/arch/powerpc/boot/gunzip_util.h b/arch/powerpc/boot/gunzip_util.h
deleted file mode 100644
index b3dfa6e87b3a..000000000000
--- a/arch/powerpc/boot/gunzip_util.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Decompression convenience functions
- *
- * Copyright 2007 David Gibson, IBM Corporation.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef _PPC_BOOT_GUNZIP_UTIL_H_
-#define _PPC_BOOT_GUNZIP_UTIL_H_
-
-#include "zlib.h"
-
-/*
- * These functions are designed to make life easy for decompressing
- * kernel images, initrd images or any other gzip compressed image,
- * particularly if its useful to decompress part of the image (e.g. to
- * examine headers) before decompressing the remainder.
- *
- * To use:
- *     - declare a gunzip_state structure
- *     - use gunzip_start() to initialize the state, associating it
- *       with a stream of compressed data
- *     - use gunzip_partial(), gunzip_exactly() and gunzip_discard()
- *       in any combination to extract pieces of data from the stream
- *     - Finally use gunzip_finish() to extract the tail of the
- *       compressed stream and wind up zlib
- */
-
-/* scratch space for gunzip; 46912 is from zlib_inflate_workspacesize() */
-#define GUNZIP_SCRATCH_SIZE	46912
-
-struct gunzip_state {
-	z_stream s;
-	char scratch[46912];
-};
-
-void gunzip_start(struct gunzip_state *state, void *src, int srclen);
-int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen);
-void gunzip_exactly(struct gunzip_state *state, void *dst, int len);
-void gunzip_discard(struct gunzip_state *state, int len);
-int gunzip_finish(struct gunzip_state *state, void *dst, int len);
-
-#endif /* _PPC_BOOT_GUNZIP_UTIL_H_ */
-- 
2.5.5
