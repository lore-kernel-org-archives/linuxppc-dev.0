Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90539DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 18:21:10 +1000 (EST)
Date: Wed, 28 Mar 2007 02:21:04 -0600 (CST)
Subject: Re: Patch: [PATCH 3/4] bootwrapper: no gzip fixes
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-3-03.miltonm@bga.com>
In-Reply-To: <boot-3-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit a9903811bf8d130a26004f9cb27b66513a267908 missed two uses of the
the .gz suffix in the wrapper script and didn't clean the additonal
possibly cached files.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/wrapper
===================================================================
--- kernel.orig/arch/powerpc/boot/wrapper	2007-03-28 01:09:04.000000000 -0500
+++ kernel/arch/powerpc/boot/wrapper	2007-03-28 01:10:26.000000000 -0500
@@ -144,7 +144,7 @@ miboot|uboot)
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-if [ -z "$cacheit" -o ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
+if [ -z "$cacheit" -o ! -f "$vmz$gzip" -o "$vmz$gzip" -ot "$kernel" ]; then
     ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
 
     if [ -n "$gzip" ]; then
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-03-28 01:09:05.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-03-28 01:23:20.000000000 -0500
@@ -170,5 +170,11 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)
 install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
-clean-files += $(addprefix $(objtree)/, vmlinux.strip.gz vmlinux.bin.gz)
+# anything not in $(targets)
 clean-files += $(image-) $(initrd-) zImage zImage.initrd
+
+# clean up files cached by wrapper
+clean-kernel := vmlinux.strip vmlinux.bin
+clean-kernel += $(addsuffix .gz,$(clean-kernel))
+# If not absolute clean-files are relative to $(obj).
+clean-files += $(addprefix $(objtree)/, $(clean-kernel))
