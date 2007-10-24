Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79103DDF9D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 02:56:22 +1000 (EST)
Date: Wed, 24 Oct 2007 11:56:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] wrapper: Revert ps3 binary flag usage, and remove .bin suffix.
Message-ID: <20071024165628.GA13863@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, geert@sonytel.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ps3 target produces two images, and the binary one is not the
"primary" image that corresponds to the -o flag; thus, it no longer
uses the generic binary flag.

On platforms which do use the binary flag, it no longer produces a
.bin suffix, so that the output file matches what was passed to the -o flag.

This should fix the zImage ln problems for the ps3 target.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/wrapper |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 39b27e5..ece6f49 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -149,7 +149,6 @@ cuboot*)
 ps3)
     platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
     lds=$object/zImage.ps3.lds
-    binary=y
     gzip=
     ext=bin
     objflags="-O binary --set-section-flags=.bss=contents,alloc,load,data"
@@ -233,7 +232,7 @@ entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
 
 if [ -n "$binary" ]; then
     mv "$ofile" "$ofile".elf
-    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
 fi
 
 # post-processing needed for some platforms
@@ -246,9 +245,9 @@ coff)
     $object/hack-coff "$ofile"
     ;;
 cuboot*)
-    gzip -f -9 "$ofile".bin
+    gzip -f -9 "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
-            $uboot_version -d "$ofile".bin.gz "$ofile"
+            $uboot_version -d "$ofile".gz "$ofile"
     ;;
 treeboot*)
     mv "$ofile" "$ofile.elf"
@@ -269,11 +268,11 @@ ps3)
     # then copied to offset 0x100.  At runtime the bootwrapper program
     # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
 
-    system_reset_overlay=0x`${CROSS}nm "$ofile".elf \
+    system_reset_overlay=0x`${CROSS}nm "$ofile" \
         | grep ' __system_reset_overlay$'       \
         | cut -d' ' -f1`
     system_reset_overlay=`printf "%d" $system_reset_overlay`
-    system_reset_kernel=0x`${CROSS}nm "$ofile".elf \
+    system_reset_kernel=0x`${CROSS}nm "$ofile" \
         | grep ' __system_reset_kernel$'       \
         | cut -d' ' -f1`
     system_reset_kernel=`printf "%d" $system_reset_kernel`
@@ -282,6 +281,8 @@ ps3)
 
     rm -f "$object/otheros.bld"
 
+    ${CROSS}objcopy -O binary "$ofile" "$ofile.bin"
+
     msg=$(dd if="$ofile.bin" of="$ofile.bin" conv=notrunc \
         skip=$overlay_dest seek=$system_reset_kernel      \
         count=$overlay_size bs=1 2>&1)
-- 
1.5.3.4
