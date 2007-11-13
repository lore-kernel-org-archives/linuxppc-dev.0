Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711131324g418b7764vc84ece40d78658d@mail.gmail.com>
Date: Tue, 13 Nov 2007 16:24:58 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: Makefile and COMMON_UIMAGE target
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If I select Efika (zImage.chrp) and my target (uImage, COMMON_UIMAGE)
at the same time. The chrp image doesn't get built.

This fixes it, but is it the right fix?
What the right to compare CONFIG_DEVICE_TREE to "" if it isn't defined?

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 4e16534..b291f53 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -149,7 +149,7 @@ drivers-$(CONFIG_OPROFILE)  += arch/powerpc/oprofile/

 # Default to zImage, override when needed
 defaultimage-y                 := zImage
-defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
+#defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..cbbc4ab 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -147,6 +147,7 @@ image-$(CONFIG_PPC_PRPMC2800)               +=
zImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)            += zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)         += uImage

+ifdef CONFIG_DEVICE_TREE
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)                        += cuImage.8xx
 image-$(CONFIG_PPC_EP88XC)             += zImage.ep88xc
@@ -160,6 +161,7 @@ image-$(CONFIG_BAMBOO)                      +=
treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)                        += cuImage.sequoia
 image-$(CONFIG_WALNUT)                 += treeImage.walnut
 endif
+endif

 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.


-- 
Jon Smirl
jonsmirl@gmail.com
