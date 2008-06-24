Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 62820DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 14:20:26 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <4ca08ab3df251d90440c962ef15ead1a72d75f05.1214276944.git.tony@bakeyournoodle.com>
In-Reply-To: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH v2] Change the default link address for pSeries zImage kernels.
Date: Tue, 24 Jun 2008 14:20:29 +1000 (EST)
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
overlapping with OF).  Move .text in a zImage from 4MB to 64MB (well past OF).

We still will not be able to load large zImage unless we also move OF,
to that end, add a note to the zImage ELF to move OF to 32Mb.  If this
is the very first kernel booted then we'll need to move OF manually by
setting real-base.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Booted on:
	3,4,5,5+,6,JS20 and JS21 (running slof 1.7.0-1)
Changes since v1:
	typo fixes in commit message and comments

 arch/powerpc/boot/addnote.c         |    2 +-
 arch/powerpc/boot/oflib.c           |   15 +++++++++++++--
 arch/powerpc/boot/wrapper           |   14 ++++++++++++--
 arch/powerpc/boot/zImage.coff.lds.S |    1 -
 arch/powerpc/boot/zImage.lds.S      |    1 -
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 8041a98..b1e5611 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -25,7 +25,7 @@ char arch[] = "PowerPC";
 #define N_DESCR	6
 unsigned int descr[N_DESCR] = {
 	0xffffffff,		/* real-mode = true */
-	0x00c00000,		/* real-base, i.e. where we expect OF to be */
+	0x02000000,		/* real-base, i.e. where we expect OF to be */
 	0xffffffff,		/* real-size */
 	0xffffffff,		/* virt-base */
 	0xffffffff,		/* virt-size */
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 95b8fd6..b0ec9cf 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -168,8 +168,19 @@ void *of_claim(unsigned long virt, unsigned long size, unsigned long align)
 
 void *of_vmlinux_alloc(unsigned long size)
 {
-	void *p = malloc(size);
-
+	unsigned long start = (unsigned long)_start, end = (unsigned long)_end;
+	void *addr;
+	void *p;
+
+	/* With some older POWER4 firmware we need to claim the area the kernel
+	 * will reside in.  Newer firmwares don't need this so we just ignore
+	 * the return value.
+	 */
+	addr = of_claim(start, end - start, 0);
+	printf("Trying to claim from 0x%lx to 0x%lx (0x%lx) got %p\r\n",
+	       start, end, end - start, addr);
+
+	p = malloc(size);
 	if (!p)
 		fatal("Can't allocate memory for kernel image!\n\r");
 
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d6c96d9..22bc26e 100755
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
+        text_start="-Ttext $link_address --defsym _start=$link_address"
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
1.5.5.4
