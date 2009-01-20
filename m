Return-Path: <snakebyte@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 77046DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 03:47:26 +1100 (EST)
Date: Tue, 20 Jan 2009 17:47:14 +0100
From: Eric Sesterhenn <snakebyte@gmx.de>
To: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [Patch] NULL pointer deref with corrupted squashfs image
Message-ID: <20090120163957.GA21339@alice>
References: <20090113124027.GB16333@alice> <20090116174525.GA31869@alice>
	<20090116190725.GA19453@logfs.org>
	<20090116230700.GP6710@smtp.west.cox.net>
	<20090117134916.GA29641@logfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090117134916.GA29641@logfs.org>
Cc: Tom Rini <trini@kernel.crashing.org>, chris@zankel.net,
	phillip@lougher.demon.co.uk, linuxppc-dev@ozlabs.org,
	rpurdie@rpsys.net, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* J=C3=B6rn Engel (joern@logfs.org) wrote:
> On Fri, 16 January 2009 16:07:00 -0700, Tom Rini wrote:
> >=20
> > Sounds like a plan to me, except maybe zlib_inflate_unsafe() and a
> > comment above the wrapper saying what/why is going on?
>=20
> Eric, will you do the honors?  Since you did all the hard work before,
> you derserve the fame as well. :)

Since I am not sure either about xtensa I added chris to the cc list.


Some callees of zlib_inflate() might accidentally pass a NULL
pointer in strm->next_out which zlib_inflate() should catch.
Others like the powerpc gunzip_partial expect to be able
to extract a zImage to memory location 0. This introduces
zlib_inflate_usafe() for those and adds a check for the rest

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux/arch/powerpc/boot/gunzip_util.c.orig	2009-01-20 10:23:11.00000000=
0 +0100
+++ linux/arch/powerpc/boot/gunzip_util.c	2009-01-20 10:23:31.000000000 +01=
00
@@ -109,7 +109,7 @@ int gunzip_partial(struct gunzip_state *
=20
 		state->s.next_out =3D dst;
 		state->s.avail_out =3D dstlen;
-		r =3D zlib_inflate(&state->s, Z_FULL_FLUSH);
+		r =3D zlib_inflate_unsafe(&state->s, Z_FULL_FLUSH);
 		if (r !=3D Z_OK && r !=3D Z_STREAM_END)
 			fatal("inflate returned %d msg: %s\n\r", r, state->s.msg);
 		len =3D state->s.next_out - (unsigned char *)dst;
--- linux/include/linux/zlib.h.orig	2009-01-20 10:11:33.000000000 +0100
+++ linux/include/linux/zlib.h	2009-01-20 10:19:56.000000000 +0100
@@ -329,7 +329,23 @@ extern int zlib_inflateInit (z_streamp s
 */
=20
=20
-extern int zlib_inflate (z_streamp strm, int flush);
+extern int __zlib_inflate (z_streamp strm, int flush, int check_out);
+/*
+    These two wrappers decide wheter strm->next_out gets checked for NULL.
+    The zlib_inflate_unsafe() version got added because the PPC zImage
+    gets extracted to memory address 0 and therefore
+    we avoid this check for zlib_inflate_unsafe()
+*/
+static inline int zlib_inflate(z_streamp strm, int flush)
+{
+	return __zlib_inflate(strm, flush, 1);
+}
+
+static inline int zlib_inflate_unsafe(z_streamp strm, int flush)
+{
+	return __zlib_inflate(strm, flush, 0);
+}
+
 /*
     inflate decompresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may introduce
--- linux/lib/zlib_inflate/inflate_syms.c.orig	2009-01-20 10:22:21.00000000=
0 +0100
+++ linux/lib/zlib_inflate/inflate_syms.c	2009-01-20 10:22:32.000000000 +01=
00
@@ -11,7 +11,7 @@
 #include <linux/zlib.h>
=20
 EXPORT_SYMBOL(zlib_inflate_workspacesize);
-EXPORT_SYMBOL(zlib_inflate);
+EXPORT_SYMBOL(__zlib_inflate);
 EXPORT_SYMBOL(zlib_inflateInit2);
 EXPORT_SYMBOL(zlib_inflateEnd);
 EXPORT_SYMBOL(zlib_inflateReset);
--- linux/lib/zlib_inflate/inflate.c.orig	2009-01-20 10:20:14.000000000 +01=
00
+++ linux/lib/zlib_inflate/inflate.c	2009-01-20 10:22:03.000000000 +0100
@@ -329,7 +329,7 @@ static int zlib_inflateSyncPacket(z_stre
    will return Z_BUF_ERROR if it has not reached the end of the stream.
  */
=20
-int zlib_inflate(z_streamp strm, int flush)
+int __zlib_inflate(z_streamp strm, int flush, int check_out)
 {
     struct inflate_state *state;
     const unsigned char *next;  /* next input */
@@ -347,8 +347,10 @@ int zlib_inflate(z_streamp strm, int flu
     static const unsigned short order[19] =3D /* permutation of code lengt=
hs */
         {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
=20
-    /* Do not check for strm->next_out =3D=3D NULL here as ppc zImage
-       inflates to strm->next_out =3D 0 */
+    /* We only check strm->next_out if the callee requests it,
+       since ppc extracts the ppc zImage to 0 */
+    if (check_out && !strm->next_out)
+        return Z_STREAM_ERROR;
=20
     if (strm =3D=3D NULL || strm->state =3D=3D NULL ||
         (strm->next_in =3D=3D NULL && strm->avail_in !=3D 0))
