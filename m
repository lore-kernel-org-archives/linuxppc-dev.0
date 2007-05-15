Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 12:40:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix make rules rules for treeImage.initrd
Message-ID: <20070515024023.GA8868@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present attempting to build treeImage.initrd.* boot images will
fail, because make will select the treeImage.% rule which also matches
instead of the correct and more specific treeImage.initrd.% rule.
This patch corrects the problem by listing the more specific rule
first.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-15 11:39:18.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-15 11:39:27.000000000 +1000
@@ -204,12 +204,12 @@ dts = $(if $(shell echo $(CONFIG_DEVICE_
 $(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dts))
 
-$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dts))
-
 $(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
 
+$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,$(dts))
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
