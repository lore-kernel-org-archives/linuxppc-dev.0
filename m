Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 30263DDEBB
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 14:04:16 +1000 (EST)
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id 7F79F13BAF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 12:04:15 +0800 (WST)
To: <linuxppc-dev@ozlabs.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 04 Jul 2007 14:04:31 +1000
Subject: [PATCH 1/3] Create a dummy zImage if no valid platform has been
	selected.
In-Reply-To: <1183521871.36329.499255149967.qpush@thor>
Message-Id: <20070704040431.1427B32C46C@thor>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: working/arch/powerpc/boot/Makefile
===================================================================
--- working.orig/arch/powerpc/boot/Makefile
+++ working/arch/powerpc/boot/Makefile
@@ -184,6 +184,11 @@ $(obj)/zImage.initrd.%: vmlinux $(wrappe
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
+# This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
+# prefix
+$(obj)/vmlinux.strip: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
 $(obj)/zImage.iseries: vmlinux

 	$(STRIP) -s -R .comment $< -o $@
 
@@ -215,6 +220,11 @@ $(obj)/treeImage.initrd.%: vmlinux $(dts
 $(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts))
 
+# If there isn't a platform selected then just strip the vmlinux.
+ifeq (,$(image-y))
+image-y := vmlinux.strip
+endif
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
