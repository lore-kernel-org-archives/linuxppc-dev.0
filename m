Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF00ADE108
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:03:57 +1000 (EST)
Date: Fri, 21 Sep 2007 18:03:52 -0500 (CDT)
Subject: [PATCH 3/15] boot: simplfy gunzip_finish
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-03.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
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
data to the user buffer.  This makes it shorter and reduces
duplication.

Signed-off-by: Milton Miller <miltonm@bga.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
--- 
identical content to 12170, removed extra space in change log

Index: kernel/arch/powerpc/boot/gunzip_util.c
===================================================================
--- kernel.orig/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:39:07.000000000 -0500
+++ kernel/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:39:07.000000000 -0500
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
