Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:08:32 -0500 (CDT)
Subject: [PATCH 3/15] boot: simplfy gunzip_finish
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-03.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Call gunzip_partial to calculate the remaining length and copy the
data to the user buffer.   This makes it shorter and reduces
duplication.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 

Index: work.git/arch/powerpc/boot/gunzip_util.c
===================================================================
--- work.git.orig/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:47:35.000000000 -0500
+++ work.git/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:47:39.000000000 -0500
@@ -194,13 +194,10 @@ int gunzip_finish(struct gunzip_state *s
 {
 	int len;
 
+	len = gunzip_partial(state, dst, dstlen);
+
 	if (state->s.workspace) {
-		len = gunzip_partial(state, dst, dstlen);
 		zlib_inflateEnd(&state->s);
-	} else {
-		/* uncompressed image */
-		len = min(state->s.avail_in, (unsigned)dstlen);
-		memcpy(dst, state->s.next_in, len);
 	}
 
 	return len;
