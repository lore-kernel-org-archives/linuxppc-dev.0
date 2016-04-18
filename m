Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qpJMD3fXTzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 16:36:23 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH 1/1] powerpc/fsl: Fix build of the dtb embedded kernel images
Date: Mon, 18 Apr 2016 08:36:19 +0200
Message-Id: <1460961379-1951-1-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1460857857.32510.176.camel@buserror.net>
References: <1460857857.32510.176.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit dc37374 move a lot of device tree files into fsl directory
fixing Makefile for cuImage target only. Unfortunately there are others
target which require to embebbed device tree into the kernel image
(i.e. dtbImage.%). So use a more generic approach.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 6116510..8fe78a3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -362,9 +362,6 @@ $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
-$(obj)/cuImage.%: vmlinux $(obj)/fsl/%.dtb $(wrapperbits)
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/fsl/$*.dtb)
-
 $(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
@@ -381,6 +378,9 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 $(obj)/%.dtb: $(src)/dts/%.dts FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
+	$(call if_changed_dep,dtc)
+
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
 image-y := vmlinux.strip
-- 
2.8.0
