Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D8E5EDDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 14:56:11 +1100 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUV0054HHLI5K20@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 20:56:06 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUV00D4NHLI8F70@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Jan 2008 20:56:07 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUV00ACNHLH2X50@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 20:56:05 -0700 (MST)
Date: Fri, 18 Jan 2008 20:55:40 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH/RFC] [POWERPC] Allow multiple images to be built when
	CONFIG_DEFAULT_UIMAGE set
To: linuxppc-dev@ozlabs.org, paulus@samba.org, scottwood@freescale.com,
	david@gibson.dropbear.id.au
Message-id: <20080119035528.4286.67752.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Most of the embedded board ports select CONFIG_DEFAULT_UIMAGE so that
uImage files get built by default.  However, the current code casues
the arch/powerpc/boot/Makefile to be called with the 'uImage' target
and adds 'uImage' to the 'image-y' make variable.  If CONFIG_DEFAULT_UIMAGE
is not set, then the boot makefile is called with target 'zImage'.

However, the zImage target already automatically causes all targets
listed in 'image-y' to be built, which includes uImage.

This patch makes the default build target alwasy call the boot makefile
using the 'zImage' target, regardless of if CONFIG_DEFAULT_UIMAGE is set.
Making this change allows multiple boot images to be built from a single
kernel compile.  An example of where this is useful is with the Efika
and lite5200 boards.  Both boards can use the same kernel image (vmlinux),
but they use different boot image files (zImage.chrp vs. uImage).  By
making this change, the boot makefile now builds both by default so a
single defconfig can be used for testing both platforms.

This patch also eliminates the BOOTIMAGE variable because it doesn't
appear to be used anywhere.  (Someone please correct me if I'm wrong)

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/Makefile |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f70df9b..6451c2f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -151,10 +151,7 @@ core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 # Default to zImage, override when needed
-defaultimage-y			:= zImage
-defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
-KBUILD_IMAGE := $(defaultimage-y)
-all: $(KBUILD_IMAGE)
+all: zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
@@ -180,7 +177,7 @@ define archhelp
 endef
 
 install: vdso_install
-	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+	$(Q)$(MAKE) $(build)=$(boot) install
 
 vdso_install:
 ifeq ($(CONFIG_PPC64),y)
