Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AF4ADDE47
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:52:20 +1100 (EST)
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Iz1Ps-0006RJ-39
	for linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 02:52:16 +0000
Subject: [PPC BOOT] Allow for bootwrapper utilities being in different
	directory to objects
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1196650164.13978.115.camel@pmac.infradead.org>
References: <1196650083.13978.113.camel@pmac.infradead.org>
	<1196650164.13978.115.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 02:52:05 +0000
Message-Id: <1196650325.13978.119.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's possible that the executables which are built as helpers for the
bootwrapper stuff might end up in a different place to the intermediate
object files. Handle that.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 31147a0..ef86a70 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -45,6 +45,7 @@ CROSS=
 
 # directory for object and other files used by this script
 object=arch/powerpc/boot
+objbin=$object
 
 # directory for working files
 tmpdir=.
@@ -95,6 +96,7 @@ while [ "$#" -gt 0 ]; do
 	shift
 	[ "$#" -gt 0 ] || usage
 	object="$1"
+	objbin="$1"
 	;;
     -W)
 	shift
@@ -246,11 +248,11 @@ fi
 # post-processing needed for some platforms
 case "$platform" in
 pseries|chrp)
-    $object/addnote "$ofile"
+    $objbin/addnote "$ofile"
     ;;
 coff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
-    $object/hack-coff "$ofile"
+    $objbin/hack-coff "$ofile"
     ;;
 cuboot*)
     gzip -f -9 "$ofile"
@@ -259,7 +261,7 @@ cuboot*)
     ;;
 treeboot*)
     mv "$ofile" "$ofile.elf"
-    $object/mktree "$ofile.elf" "$ofile" "$base" "$entry"
+    $objbin/mktree "$ofile.elf" "$ofile" "$base" "$entry"
     if [ -z "$cacheit" ]; then
 	rm -f "$ofile.elf"
     fi

-- 
dwmw2
