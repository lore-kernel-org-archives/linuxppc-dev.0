Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMkwx3cCqzDvh9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:14:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/boot: All uses of if_changed should depend on
 FORCE
Date: Mon, 21 Nov 2016 21:14:34 +1100
Message-Id: <1479723275-11736-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
References: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ka3.ozlabs.ibm.com>

If we're using if_changed then we must depend on FORCE, so that
if_changed gets a chance to check if something changed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8bc218..7f3faa6255a8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -356,17 +356,17 @@ $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
-$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
+$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
-$(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperbits)
+$(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))
 
 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
-$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
 	$(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
 	$(call if_changed,wrap,$*,,$(obj)/$*.dtb)
 
 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
@@ -374,31 +374,31 @@ $(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb
 $(obj)/vmlinux.strip: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
-$(obj)/uImage: vmlinux $(wrapperbits)
+$(obj)/uImage: vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot)
 
-$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
 
-$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
-$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb)
 
-$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
-$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
 	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
 
 # Rule to build device tree blobs
-- 
2.7.4
