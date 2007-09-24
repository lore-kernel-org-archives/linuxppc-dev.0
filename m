Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5E8FDDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 21:37:37 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8OBaSwj030527
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 15:36:28 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8OBaR2I030524
	for linuxppc-dev@ozlabs.org; Mon, 24 Sep 2007 15:36:27 +0400
Date: Mon, 24 Sep 2007 15:36:27 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size support to
	bootwarapper
Message-ID: <20070924113627.GA30504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently zImage is linked at the 4MB base address.
Some platforms (using cuboot, treeboot) need the zImage's
entry point and base address. They place zImage exactly
at the base address it's been linked to. Sometimes 4MB left
at the start of the memory is simply not enough to unpack zImage.
This could happen with initramfs enabled, since the kernel image
packed along with initramfs.cpio could be over 5MB in size.
This patch checks vmlinux image size and links zImage at
the base address that is equal to the unpacked image size
aligned to 4MB boundary. This way zImage base address is 4MB
only if unpacked kernel image size is less then 4MB.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/wrapper      |    6 ++++--
 arch/powerpc/boot/zImage.lds.S |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/boot/wrapper linux-2.6/arch/powerpc/boot/wrapper
--- linux-2.6.orig/arch/powerpc/boot/wrapper	2007-09-22 00:48:08.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/wrapper	2007-09-22 04:03:40.000000000 +0400
@@ -215,8 +215,10 @@
 fi
 
 if [ "$platform" != "miboot" ]; then
-    ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
-	$platformo $tmp $object/wrapper.a
+    kstart=0x`${CROSS}nm "$kernel" | grep ' _start$' | cut -d' ' -f1`
+    kend=0x`${CROSS}nm "$kernel" | grep ' _end$' | cut -d' ' -f1`
+    ${CROSS}ld -m elf32ppc --defsym _kstart=$kstart --defsym _kend=$kend \
+	-T $lds -o "$ofile" $platformo $tmp $object/wrapper.a
     rm $tmp
 fi
 
diff -ruN linux-2.6.orig/arch/powerpc/boot/zImage.lds.S linux-2.6/arch/powerpc/boot/zImage.lds.S
--- linux-2.6.orig/arch/powerpc/boot/zImage.lds.S	2007-09-22 00:48:08.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/zImage.lds.S	2007-09-22 04:03:58.000000000 +0400
@@ -3,7 +3,7 @@
 EXTERN(_zimage_start)
 SECTIONS
 {
-  . = (4*1024*1024);
+  . = ALIGN((_kend - _kstart), (4*1024*1024));
   _start = .;
   .text      :
   {
