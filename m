Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC389B7BB0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 08:06:40 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Use scripts/mkuboot.sh instead of 'mkimage'
Date: Wed, 18 Nov 2009 14:57:12 -0600
Message-Id: <1258577834-26006-2-git-send-email-ptyser@xes-inc.com>
In-Reply-To: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
References: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mkuboot.sh provides a basic wrapper for the 'mkimage' utility.  Using
mkuboot.sh provides clearer error reporting and allows a toolchain to
use its own 'mkimage' executable specified by ${CROSS_COMPILE}mkimage.
Additionally, this brings PowerPC in line with other architectures
which already call mkimage via mkuboot.sh.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
 arch/powerpc/boot/wrapper |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ac9e9a5..1ee9448 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -43,6 +43,9 @@ gzip=.gz
 # cross-compilation prefix
 CROSS=
 
+# mkimage wrapper script
+MKIMAGE=$srctree/scripts/mkuboot.sh
+
 # directory for object and other files used by this script
 object=arch/powerpc/boot
 objbin=$object
@@ -263,7 +266,7 @@ membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    mkimage -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
+    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
@@ -323,7 +326,7 @@ coff)
     ;;
 cuboot*)
     gzip -f -9 "$ofile"
-    mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
             $uboot_version -d "$ofile".gz "$ofile"
     ;;
 treeboot*)
-- 
1.6.2.1
