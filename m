Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A948CDDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:29 +1000 (EST)
Date: Mon, 20 Aug 2007 12:40:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 18/20] bootwrapper: Add a zImage.bin.<platform> target.
Message-ID: <20070820174010.GQ30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This target produces a flat binary rather than an ELF file, and prints
the start address for the user to jump to (since it is unfortunately not
fixed).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile |    5 ++++-
 arch/powerpc/boot/wrapper  |   11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index cd00711..6e7f518 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -124,7 +124,7 @@ endif
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
-		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
+		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) $6 vmlinux
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
@@ -177,6 +177,9 @@ endif
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
 
+$(obj)/zImage.bin.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts),,,--binary)
+
 $(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
 	$(call if_changed,wrap,$*,$(dts))
 
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 65f6854..09c17fb 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -30,6 +30,7 @@ dtb=
 dts=
 cacheit=
 gzip=.gz
+binary=
 
 # cross-compilation prefix
 CROSS=
@@ -44,6 +45,7 @@ usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
     echo '       [-D datadir] [-W workingdir] [--no-gzip] [vmlinux]' >&2
+    echo '       [--binary]' >&2
     exit 1
 }
 
@@ -95,6 +97,9 @@ while [ "$#" -gt 0 ]; do
     --no-gzip)
         gzip=
         ;;
+    --binary)
+        binary=y
+        ;;
     -?)
 	usage
 	;;
@@ -295,3 +300,9 @@ ps3)
     gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
     ;;
 esac
+
+if [ -n "$binary" ]; then
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
+    echo Entry point for $ofile is $entry.
+fi
-- 
1.5.0.3
