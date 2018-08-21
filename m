Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w4H53CfFzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 07:55:29 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so34755641oic.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:55:29 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc: build .dtb files in dts directory
Date: Tue, 21 Aug 2018 16:55:17 -0500
Message-Id: <20180821215524.23040-2-robh@kernel.org>
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Align powerpc with other architectures which build the dtb files in the
same directory as the dts files. This is also in line with most other
build targets which are located in the same directory as the source.
This move will help enable the 'dtbs' target which builds all the dtbs
regardless of kernel config.

This transition could break some scripts if they expect dtb files in the
old location.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/Makefile          |  2 +-
 arch/powerpc/boot/Makefile     | 49 ++++++++++++++++------------------
 arch/powerpc/boot/dts/Makefile |  1 +
 3 files changed, 25 insertions(+), 27 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7bd5880..9bacffa3b72e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -294,7 +294,7 @@ bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 %.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)
 
 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..b201d93e1725 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -381,11 +381,11 @@ $(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperb
 	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))
 
 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
-$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb)
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb)
 
 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
 # prefix
@@ -395,36 +395,33 @@ $(obj)/vmlinux.strip: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot)
 
-$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/uImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
+$(obj)/uImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb)
 
-$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/cuImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
+$(obj)/cuImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb)
 
-$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/simpleImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb)
+$(obj)/simpleImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb)
 
-$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/treeImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
+$(obj)/treeImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb)
 
-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
-	$(call if_changed_dep,dtc)
+# Needed for the above targets to work with dts/fsl/ files
+$(obj)/dts/%.dtb: $(obj)/dts/fsl/%.dtb
+	@cp $< $@
 
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/powerpc/boot/dts/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.17.1
