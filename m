Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 15796DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 15:39:42 +1000 (EST)
Date: Fri, 25 Apr 2008 15:39:41 +1000
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Change the default link address for pSeries zImage kernels.
Message-ID: <20080425053941.GT20457@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we set the start of the .text section to be 4Mb for pSeries.
In situations where the zImage is > 8Mb we'll fail to boot (due to
overlapping with OF).  Move .text in a pSeries zImage from 4MB to 64MB
(well past OF).

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 - Compile tested for *_defconfig with only pSeries chaning it's link
   address.
 - Boot tested on POWER6

 arch/powerpc/boot/wrapper           |   14 ++++++++++++--
 arch/powerpc/boot/zImage.coff.lds.S |    1 -
 arch/powerpc/boot/zImage.lds.S      |    1 -
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d6c96d9..b5dfc1f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -138,14 +138,20 @@ objflags=-S
 tmp=$tmpdir/zImage.$$.o
 ksection=.kernel:vmlinux.strip
 isection=.kernel:initrd
+link_address='0x400000'
 
 case "$platform" in
-pmac|pseries|chrp)
+pseries)
+    platformo=$object/of.o
+    link_address='0x4000000'
+    ;;
+pmac|chrp)
     platformo=$object/of.o
     ;;
 coff)
     platformo=$object/of.o
     lds=$object/zImage.coff.lds
+    link_address='0x500000'
     ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
@@ -190,6 +196,7 @@ ps3)
     objflags="-O binary --set-section-flags=.bss=contents,alloc,load,data"
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
+    link_address=''
     ;;
 ep88xc|ep405|ep8248e)
     platformo="$object/fixed-head.o $object/$platform.o"
@@ -268,7 +275,10 @@ if [ -n "$dtb" ]; then
 fi
 
 if [ "$platform" != "miboot" ]; then
-    ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
+    if [ -n "$link_address" ] ; then
+        text_start="-Ttext $link_address"
+    fi
+    ${CROSS}ld -m elf32ppc -T $lds $text_start -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
diff --git a/arch/powerpc/boot/zImage.coff.lds.S b/arch/powerpc/boot/zImage.coff.lds.S
index fe87a90..856dc78 100644
--- a/arch/powerpc/boot/zImage.coff.lds.S
+++ b/arch/powerpc/boot/zImage.coff.lds.S
@@ -3,7 +3,6 @@ ENTRY(_zimage_start_opd)
 EXTERN(_zimage_start_opd)
 SECTIONS
 {
-  . = (5*1024*1024);
   _start = .;
   .text      :
   {
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index f6e380f..0962d62 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -3,7 +3,6 @@ ENTRY(_zimage_start)
 EXTERN(_zimage_start)
 SECTIONS
 {
-  . = (4*1024*1024);
   _start = .;
   .text      :
   {
-- 
1.5.5.1


Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
