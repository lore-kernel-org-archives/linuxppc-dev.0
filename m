Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B3112DDF8B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:04 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHS1gN004172
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:01 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHS0Gx027783
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:00 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH8JrS001315
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:08:19 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id ABD70AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:59 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHRxZn029806
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:27:59 -0500
Date: Fri, 16 Mar 2007 12:27:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/17] bootwrapper: Make compression of the kernel image
	optional.
Message-ID: <20070316172759.GD29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The --no-gzip option can be passed to the wrapper so that the kernel
image is included uncompressed into the zImage.  This is intended for
bootloaders where the zImage itself can be compressed, or where boot time
is considered more important than kernel image size.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/wrapper |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 157d8c8..f9238f5 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -29,6 +29,7 @@ initrd=
 dtb=
 dts=
 cacheit=
+gzip=.gz
 
 # cross-compilation prefix
 CROSS=
@@ -42,7 +43,7 @@ tmpdir=.
 usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
-    echo '       [-D datadir] [-W workingdir] [vmlinux]' >&2
+    echo '       [-D datadir] [-W workingdir] [--no-gzip] [vmlinux]' >&2
     exit 1
 }
 
@@ -91,6 +92,9 @@ while [ "$#" -gt 0 ]; do
 	[ "$#" -gt 0 ] || usage
 	tmpdir="$1"
 	;;
+    --no-gzip)
+        gzip=
+        ;;
     -?)
 	usage
 	;;
@@ -142,14 +146,20 @@ esac
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
 if [ -z "$cacheit" -o ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
-    gzip -f -9 "$vmz.$$"
+
+    if [ -n "$gzip" ]; then
+        gzip -f -9 "$vmz.$$"
+    fi
+
     if [ -n "$cacheit" ]; then
-	mv -f "$vmz.$$.gz" "$vmz.gz"
+	mv -f "$vmz.$$$gzip" "$vmz$gzip"
     else
 	vmz="$vmz.$$"
     fi
 fi
 
+vmz="$vmz$gzip"
+
 case "$platform" in
 uboot)
     rm -f "$ofile"
@@ -159,9 +169,9 @@ uboot)
 	version="-n Linux-$version"
     fi
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
-	$version -d "$vmz.gz" "$ofile"
+	$version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
-	rm -f $vmz.gz
+	rm -f "$vmz"
     fi
     exit 0
     ;;
@@ -173,9 +183,9 @@ addsec() {
 	--set-section-flags=$3=contents,alloc,load,readonly,data
 }
 
-addsec $tmp "$vmz.gz" $ksection $object/empty.o
+addsec $tmp "$vmz" $ksection $object/empty.o
 if [ -z "$cacheit" ]; then
-    rm -f "$vmz.gz"
+    rm -f "$vmz"
 fi
 
 if [ -n "$initrd" ]; then
-- 
1.5.0.3
