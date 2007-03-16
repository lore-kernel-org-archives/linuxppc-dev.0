Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0CCC2DE7D1
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:14 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHTBsA004489
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:29:12 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHTB8k010014
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:11 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9UNe001456
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:30 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 8E8B4AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:10 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHTAqJ029853
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:29:10 -0500
Date: Fri, 16 Mar 2007 12:29:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/17] bootwrapper: Add support for cuboot platforms.
Message-ID: <20070316172910.GN29784@ld0162-tx32.am.freescale.net>
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

Platforms beginning with "cuboot" have the bootwrapper code built in,
unlike the regular uboot platform.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/wrapper |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index a30e45b..f90fabd 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -141,6 +141,9 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+cuboot*)
+    gzip=
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -161,13 +164,17 @@ fi
 vmz="$vmz$gzip"
 
 case "$platform" in
-uboot)
-    rm -f "$ofile"
+uboot|cuboot*)
     version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
 	cut -d' ' -f3`
     if [ -n "$version" ]; then
 	version="-n Linux-$version"
     fi
+esac
+
+case "$platform" in
+uboot)
+    rm -f "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
 	$version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
@@ -216,4 +223,14 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
+cuboot*)
+    base=`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
+    entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | \
+           cut -d' ' -f3`
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
+    gzip -f -9 "$ofile".bin
+    mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+            $version -d "$ofile".bin.gz "$ofile"
+    ;;
 esac
-- 
1.5.0.3
