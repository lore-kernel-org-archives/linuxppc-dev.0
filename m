Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C3C7DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 06:57:46 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: paulus@au.ibm.com
Subject: [PATCH] Do not fail build if mkimage is not available
Date: Sun, 23 Dec 2007 20:31:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712232031.09133.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the boot image wrapper script to not fail the kernel
build if mkimage is not available.
As some distributions don't ship the mkimage program and I am not
interested in uboot images anyway, I don't want to fail the whole kernel
build process because of this unneeded dependency.

Simply drop an error message, but don't fail the build.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: wireless-2.6/arch/powerpc/boot/wrapper
===================================================================
--- wireless-2.6.orig/arch/powerpc/boot/wrapper	2007-12-23 20:10:07.000000000 +0100
+++ wireless-2.6/arch/powerpc/boot/wrapper	2007-12-23 20:22:41.000000000 +0100
@@ -195,6 +195,14 @@ if [ -n "$version" ]; then
 fi
 
 case "$platform" in
+cuboot* | uboot)
+    if ! [ -x mkimage ]; then
+        echo "mkimage not available. Can not create $platform image."
+        exit 0
+    fi
+esac
+
+case "$platform" in
 uboot)
     rm -f "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
