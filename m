Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F7F9DDF70
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 03:59:05 +1100 (EST)
Date: Fri, 7 Mar 2008 10:55:51 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] bootwrapper: Allow specifying of image physical
	offset
Message-ID: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Normally we assume kernel images will be loaded at offset 0. However
there are situations, like when the kernel itself is running at a non-zero
physical address, that we don't want to load it at 0.

Allow the wrapper to take an offset.  We use this when building u-boot images.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile |    7 +++++++
 arch/powerpc/boot/wrapper  |   12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f43dd6e..1b4bfc6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -35,6 +35,12 @@ endif

 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/libfdt

+ifdef CONFIG_MEMORY_START
+MEMBASE=$(CONFIG_MEMORY_START)
+else
+MEMBASE=0x00000000
+endif
+
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
@@ -181,6 +187,7 @@ endif
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+		-m $(MEMBASE) \
 		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux

 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 6655a90..4f2b2d0 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -50,8 +50,11 @@ objbin=$object
 # directory for working files
 tmpdir=.

+# physical offset of kernel image
+membase=0x00000000
+
 usage() {
-    echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
+    echo 'Usage: wrapper [-o output] [-p platform] [-i initrd] [-m membase]' >&2
     echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
     echo '       [-D datadir] [-W workingdir] [--no-gzip] [vmlinux]' >&2
     exit 1
@@ -84,6 +87,11 @@ while [ "$#" -gt 0 ]; do
 	[ "$#" -gt 0 ] || usage
 	dts="$1"
 	;;
+    -m)
+	shift
+	[ "$#" -gt 0 ] || usage
+	membase="$1"
+	;;
     -c)
 	cacheit=y
 	;;
@@ -225,7 +233,7 @@ fi
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
+    mkimage -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
-- 
1.5.4.1
