Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 488A8DDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 16:13:03 +1000 (EST)
Date: Mon, 28 May 2007 16:12:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] create a zImage for legacy iSeries
Message-Id: <20070528161259.713c21b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This zImage is really just the stripped vmlinux, but it means that there
is one less special case for iSeries and also that the zImages will be
built for a combined kernel build that happens to include iSeries.

This zImage boots fine on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Makefile      |    1 -
 arch/powerpc/boot/Makefile |    4 ++++
 2 files changed, 4 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6238b58..fbafd96 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -142,7 +142,6 @@ drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 # Default to zImage, override when needed
 defaultimage-y			:= zImage
-defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
 defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8378898..da58d1f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -136,6 +136,7 @@ image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_PPC_HOLLY)		+= zImage.holly-elf
 image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
+image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
@@ -185,6 +186,9 @@ $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
+$(obj)/zImage.iseries: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
-- 
1.5.1.4
