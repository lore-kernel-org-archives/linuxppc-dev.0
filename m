Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9jNw3f0nzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 21:30:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [RFC PATCH] powerpc/Makefile: Add option to build with gold
Date: Fri, 12 Aug 2016 21:30:21 +1000
Message-Id: <1471001421-9845-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a Kconfig option which can be turned on to enable use of the
gold linker. It depends on DEBUG_KERNEL to hopefully hide it from users
who don't really care about it, and also !COMPILE_TEST so that it will
be turned off for allyes/modconfig builds.

In the wrapper script we currently always use ${CROSS}ld, so instead
make that the default if ${LD} isn't already set. When we're called as
part of a normal build ${LD} will be set, but if the wrapper is called
separately we will fall back to ${CROSS}ld as before.

With this enabled I have successfully built a ppc64[le]_defconfig using
a toolchain which only has ld.gold.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug | 7 +++++++
 arch/powerpc/Makefile      | 4 ++++
 arch/powerpc/boot/wrapper  | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 63292f64b25a..c63ec2bb08ae 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -19,6 +19,13 @@ config PPC_WERROR
 	depends on !PPC_DISABLE_WERROR
 	default y
 
+config PPC_USE_GOLD
+	bool "Build with the gold linker"
+	depends on DEBUG_KERNEL && !COMPILE_TEST
+	default n
+	  Build the kernel with the ld.gold linker, rather than ld.bfd.
+	  If you don't know what this means say N.
+
 config PRINT_STACK_DEPTH
 	int "Stack depth to print" if DEBUG_KERNEL
 	default 64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1934707bf321..005c63fd8be1 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -65,6 +65,10 @@ endif
 
 UTS_MACHINE := $(OLDARCH)
 
+ifdef CONFIG_PPC_USE_GOLD
+LD := $(LD).gold
+endif
+
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 override LD	+= -EL
 override CROSS32AS += -mlittle-endian
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 6681ec3625c9..00f13d18fd6f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -140,6 +140,8 @@ while [ "$#" -gt 0 ]; do
     shift
 done
 
+LD=${LD:-${CROSS}ld}
+
 if [ -n "$dts" ]; then
     if [ ! -r "$dts" -a -r "$object/dts/$dts" ]; then
 	dts="$object/dts/$dts"
@@ -417,7 +419,7 @@ if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
         text_start="-Ttext $link_address"
     fi
-    ${CROSS}ld -m $format -T $lds $text_start $pie -o "$ofile" \
+    ${LD} -m $format -T $lds $text_start $pie -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
-- 
2.7.4
