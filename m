Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72211A03C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 04:54:08 +1100 (AEDT)
Received: by oigj1 with SMTP id j1so1776149oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2015 10:54:07 -0700 (PDT)
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 12/13] powerpc: enable building of all dtbs
Date: Thu,  8 Oct 2015 12:53:46 -0500
Message-Id: <1444326827-3565-13-git-send-email-robh@kernel.org>
In-Reply-To: <1444326827-3565-1-git-send-email-robh@kernel.org>
References: <1444326827-3565-1-git-send-email-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable building all dtb files when CONFIG_OF_ALL_DTBS is enabled. The dtbs
are not really dependent on a platform being enabled or any other kernel
config, so for testing coverage it is convenient to build all of the dtbs.
This builds all dts files in the tree, not just targets listed.

Supporting this requires adding 'dtbs' make target which was not yet
supported on powerpc.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Makefile          | 6 ++++++
 arch/powerpc/boot/Makefile     | 5 ++++-
 arch/powerpc/boot/dts/Makefile | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/dts/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b9b4af2..0ec35ff 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -273,6 +273,11 @@ bootwrapper_install:
 %.dtb: scripts
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
+PHONY += dtbs
+
+dtbs: prepare scripts
+	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot)/dts
+
 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
 # and the second argument as a space separated list of .config files to merge,
@@ -317,6 +322,7 @@ define archhelp
   @echo '  dtbImage.<dt>   - zImage with an embedded device tree blob'
   @echo '  simpleImage.<dt> - Firmware independent image.'
   @echo '  treeImage.<dt>  - Support for older IBM 4xx firmware (not U-Boot)'
+  echo  '  dtbs            - Build device tree blobs for enabled boards'
   @echo '  install         - Install kernel using'
   @echo '                    (your) ~/bin/$(INSTALLKERNEL) or'
   @echo '                    (distribution) /sbin/$(INSTALLKERNEL) or'
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4eec430..381df1a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -402,7 +402,7 @@ zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.miboot zImage.pmac zImage.pseries \
-	zImage.maple simpleImage.* otheros.bld *.dtb
+	zImage.maple simpleImage.* otheros.bld
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
@@ -410,6 +410,9 @@ clean-kernel += $(addsuffix .gz,$(clean-kernel))
 # If not absolute clean-files are relative to $(obj).
 clean-files += $(addprefix $(objtree)/, $(clean-kernel))
 
+# Let clean descend into subdirs
+subdir- := dts
+
 WRAPPER_OBJDIR := /usr/lib/kernel-wrapper
 WRAPPER_DTSDIR := /usr/lib/kernel-wrapper/dts
 WRAPPER_BINDIR := /usr/sbin
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
new file mode 100644
index 0000000..f121775
--- /dev/null
+++ b/arch/powerpc/boot/dts/Makefile
@@ -0,0 +1,5 @@
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+
+always		:= $(dtb-y)
+clean-files	:= *.dtb
-- 
2.1.4
