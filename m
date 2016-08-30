Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNh6p0bfmzDrmy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 18:11:14 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so786708pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 01:11:13 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 5/6] powerpc/boot: add xz support to the wrapper script
Date: Tue, 30 Aug 2016 18:10:35 +1000
Message-Id: <1472544636-7837-6-git-send-email-oohall@gmail.com>
In-Reply-To: <1472544636-7837-1-git-send-email-oohall@gmail.com>
References: <1472544636-7837-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This modifies the script so that the -Z option takes an argument to
specify the compression type. It can either be 'gz', 'xz' or 'none'.
The legazy --no-gzip and -z options are still supported and will set
the compression to none and gzip respectively, but they are not
documented.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/Makefile |  7 ++++--
 arch/powerpc/boot/wrapper  | 61 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 3fdd74ac2fae..482bac2af1ff 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -212,10 +212,13 @@ CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
 endif
 
+compressor-$(CONFIG_KERNEL_GZIP) := gz
+
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
-      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
-		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
+      cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -Z $(compressor-y) -c -o $@ -p $2 \
+		$(CROSSWRAP) $(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) \
+		vmlinux
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_POWERNV)		+= zImage.pseries
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 6681ec3625c9..cf7631be5007 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -20,6 +20,8 @@
 # -D dir	specify directory containing data files used by script
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
+# -z		use gzip (legacy)
+# -Z zsuffix    compression to use (gz, xz or none)
 
 # Stop execution if any command fails
 set -e
@@ -38,7 +40,7 @@ dtb=
 dts=
 cacheit=
 binary=
-gzip=.gz
+compression=.gz
 pie=
 format=
 
@@ -59,7 +61,8 @@ tmpdir=.
 usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
-    echo '       [-D datadir] [-W workingdir] [--no-gzip] [vmlinux]' >&2
+    echo '       [-D datadir] [-W workingdir] [-Z (gz|xz|none)]' >&2
+    echo '       [--no-compression] [vmlinux]' >&2
     exit 1
 }
 
@@ -126,8 +129,24 @@ while [ "$#" -gt 0 ]; do
 	[ "$#" -gt 0 ] || usage
 	tmpdir="$1"
 	;;
+    -z)
+	compression=.gz
+	;;
+    -Z)
+	shift
+	[ "$#" -gt 0 ] || usage
+        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "none" ] || usage
+
+	compression=".$1"
+
+        if [ $compression = ".none" ]; then
+                compression=
+        fi
+	;;
     --no-gzip)
-        gzip=
+        # a "feature" of the the wrapper script is that it can be used outside
+        # the kernel tree. So keeping this around for backwards compatibility.
+        compression=
         ;;
     -?)
 	usage
@@ -140,6 +159,7 @@ while [ "$#" -gt 0 ]; do
     shift
 done
 
+
 if [ -n "$dts" ]; then
     if [ ! -r "$dts" -a -r "$object/dts/$dts" ]; then
 	dts="$object/dts/$dts"
@@ -212,7 +232,7 @@ miboot|uboot*)
     ;;
 cuboot*)
     binary=y
-    gzip=
+    compression=
     case "$platform" in
     *-mpc866ads|*-mpc885ads|*-adder875*|*-ep88xc)
         platformo=$object/cuboot-8xx.o
@@ -243,7 +263,7 @@ cuboot*)
 ps3)
     platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
     lds=$object/zImage.ps3.lds
-    gzip=
+    compression=
     ext=bin
     objflags="-O binary --set-section-flags=.bss=contents,alloc,load,data"
     ksection=.kernel:vmlinux.bin
@@ -310,27 +330,37 @@ mvme7100)
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
-    ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
 
-    strip_size=$(stat -c %s $vmz.$$)
+# Calculate the vmlinux.strip size
+${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
+strip_size=$(stat -c %s $vmz.$$)
 
-    if [ -n "$gzip" ]; then
+if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel" ]; then
+    # recompress the image if we need to
+    case $compression in
+    .xz)
+        xz --check=crc32 -f -9 "$vmz.$$"
+        ;;
+    .gz)
         gzip -n -f -9 "$vmz.$$"
-    fi
+        ;;
+    *)
+        # drop the compression suffix so the stripped vmlinux is used
+        compression=
+    	;;
+    esac
 
     if [ -n "$cacheit" ]; then
-	mv -f "$vmz.$$$gzip" "$vmz$gzip"
+	mv -f "$vmz.$$$compression" "$vmz$compression"
     else
 	vmz="$vmz.$$"
     fi
 else
-    # Calculate the vmlinux.strip size
-    ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
-    strip_size=$(stat -c %s $vmz.$$)
     rm -f $vmz.$$
 fi
 
+vmz="$vmz$compression"
+
 if [ "$make_space" = "y" ]; then
 	# Round the size to next higher MB limit
 	round_size=$(((strip_size + 0xfffff) & 0xfff00000))
@@ -346,8 +376,6 @@ if [ "$make_space" = "y" ]; then
 	fi
 fi
 
-vmz="$vmz$gzip"
-
 # Extract kernel version information, some platforms want to include
 # it in the image header
 version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
@@ -417,6 +445,7 @@ if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
         text_start="-Ttext $link_address"
     fi
+#link everything
     ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
-- 
2.5.5
