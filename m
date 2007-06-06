Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 090CEDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:01:15 +1000 (EST)
Date: Wed, 6 Jun 2007 17:01:15 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Create a dummy zImage if no valid platform has been selected.
Message-ID: <20070606070115.GW15955@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
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
This is mostly aimed at getting allnoconfig to complete.

 arch/powerpc/boot/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: working/arch/powerpc/boot/Makefile
===================================================================
--- working.orig/arch/powerpc/boot/Makefile
+++ working/arch/powerpc/boot/Makefile
@@ -188,6 +188,9 @@ $(obj)/zImage.%: vmlinux $(wrapperbits)
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
+$(obj)/zImage.strip: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
@@ -213,6 +216,11 @@ $(obj)/treeImage.initrd.%: vmlinux $(dts
 $(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts))
 
+# If we don't have a platform selected then just strip the vmlinux.
+ifeq ("$(image-y)", "")
+image-y := zImage.strip
+endif
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))


Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
