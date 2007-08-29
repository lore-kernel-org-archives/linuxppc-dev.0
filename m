Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E13EDDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 02:47:53 +1000 (EST)
Date: Wed, 29 Aug 2007 11:47:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 6/9] bootwrapper: Add a zImage.bin.<platform> target.
Message-ID: <20070829164741.GD31640@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This target produces a flat binary rather than an ELF file,
and fixes the entry point at the beginning of the image.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile     |    8 ++++++--
 arch/powerpc/boot/fixed-head.S |    4 ++++
 arch/powerpc/boot/wrapper      |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/fixed-head.S

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 02f0fe0..27f5772 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -48,7 +48,8 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		cpm-serial.c stdlib.c planetcore.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c cuboot-pq2.c
+		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
+		cuboot-8xx.c cuboot-pq2.c fixed-head.S
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -124,7 +125,7 @@ endif
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
-		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
+		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) $6 vmlinux
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
@@ -178,6 +179,9 @@ endif
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
 
+$(obj)/zImage.bin.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts),,,--binary --fixed-entry)
+
 $(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts))
 
diff --git a/arch/powerpc/boot/fixed-head.S b/arch/powerpc/boot/fixed-head.S
new file mode 100644
index 0000000..8e14cd9
--- /dev/null
+++ b/arch/powerpc/boot/fixed-head.S
@@ -0,0 +1,4 @@
+	.text
+	.global _zimage_start
+_zimage_start:
+	b	_zimage_start_lib
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 65f6854..4d549cc 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -30,6 +30,8 @@ dtb=
 dts=
 cacheit=
 gzip=.gz
+binary=
+fixedentry=
 
 # cross-compilation prefix
 CROSS=
@@ -44,6 +46,7 @@ usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
     echo '       [-D datadir] [-W workingdir] [--no-gzip] [vmlinux]' >&2
+    echo '       [--binary] [--fixed-entry]' >&2
     exit 1
 }
 
@@ -95,6 +98,12 @@ while [ "$#" -gt 0 ]; do
     --no-gzip)
         gzip=
         ;;
+    --binary)
+        binary=y
+        ;;
+    --fixed-entry)
+        fixedentry=y
+        ;;
     -?)
 	usage
 	;;
@@ -214,6 +223,10 @@ if [ -n "$dtb" ]; then
     fi
 fi
 
+if [ -n "$fixedentry" ]; then
+	platformo="$object/fixed-head.o $platformo"
+fi
+
 if [ "$platform" != "miboot" ]; then
     ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
@@ -295,3 +308,8 @@ ps3)
     gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
     ;;
 esac
+
+if [ -n "$binary" ]; then
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
+fi
-- 
1.5.0.3
