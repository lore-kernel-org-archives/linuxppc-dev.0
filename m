Return-Path: <mita@fixstars.com>
Received: from gw.fixstars.com (122x208x5x10.ap122.ftth.ucom.ne.jp
	[122.208.5.10]) by ozlabs.org (Postfix) with ESMTP id 28FAADDEFC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 21:01:43 +1000 (EST)
Received: from localhost.localdomain (unknown [192.168.10.109])
	by gw.fixstars.com (Postfix) with ESMTP id 726E1B01BF
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 19:55:09 +0900 (JST)
Date: Tue, 10 Apr 2007 20:05:31 +0900
From: Akinobu Mita <mita@fixstars.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: enable make install
Message-ID: <20070410110531.GA2813@localhost.localdomain>
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

make help on powerpc says make install is available.
But it failed due to no rule to make install.

This patch enables to work make install.

Signed-off-by: Akinobu Mita <mita@fixstars.com>

Index: 2.6-git-ps3/arch/powerpc/Makefile
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/Makefile
+++ 2.6-git-ps3/arch/powerpc/Makefile
@@ -167,6 +167,9 @@ define archhelp
   @echo '  *_defconfig     - Select default config from arch/$(ARCH)/configs'
 endef
 
+install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
Index: 2.6-git-ps3/arch/powerpc/boot/Makefile
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/boot/Makefile
+++ 2.6-git-ps3/arch/powerpc/boot/Makefile
@@ -192,7 +192,7 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(i
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
 
-install: $(CONFIGURE) $(image-y)
+install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip.gz)
