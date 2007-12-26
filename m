Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A40EEDDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 02:57:28 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH v2] powerpc: Do not fail build if mkimage is not available
Date: Wed, 26 Dec 2007 16:55:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712261655.56432.mb@bu3sch.de>
Cc: paulus@au.ibm.com, linuxppc-dev@ozlabs.org
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
As some distributions don't ship the mkimage program and some people are not
interested in uboot images anyway, we don't want to fail the whole kernel
build process because of this unneeded dependency.

Simply drop an error message, but don't fail the build.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Josh Boyer is working on merging mkimage into the kernel tree.
Until that happened, please merge the patch below into the mainline kernel
to avoid build breakage for people without installed uboot tools.

Index: wireless-2.6/arch/powerpc/boot/wrapper
===================================================================
--- wireless-2.6.orig/arch/powerpc/boot/wrapper	2007-12-26 16:48:47.000000000 +0100
+++ wireless-2.6/arch/powerpc/boot/wrapper	2007-12-26 16:52:58.000000000 +0100
@@ -197,8 +197,11 @@ fi
 case "$platform" in
 uboot)
     rm -f "$ofile"
+    set +e
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
 	$uboot_version -d "$vmz" "$ofile"
+    [ $? -eq 0 ] || exit 0
+    set -e
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
     fi
@@ -254,8 +257,11 @@ coff)
     ;;
 cuboot*)
     gzip -f -9 "$ofile"
+    set +e
     mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
             $uboot_version -d "$ofile".gz "$ofile"
+    [ $? -eq 0 ] || exit 0
+    set -e
     ;;
 treeboot*)
     mv "$ofile" "$ofile.elf"
