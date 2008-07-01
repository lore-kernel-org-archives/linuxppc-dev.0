Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 75C91DEC80
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 03:59:19 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1228wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 10:59:17 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify additional
	default targets
To: linuxppc-dev@ozlabs.org, john.linn@xilinx.com
Date: Tue, 01 Jul 2008 11:59:10 -0600
Message-ID: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

It is inconvenient to add additional default targets to the bootwrapper
Makefile for each new board supported which just needs a different dts
file.  This change allows the defconfig to specify additional build
targets.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/Kconfig       |   13 +++++++++++++
 arch/powerpc/boot/Makefile |    3 +++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..f09f617 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -458,6 +458,19 @@ config CMDLINE
 	  some command-line options at build time by entering them here.  In
 	  most cases you will need to specify the root device here.
 
+config EXTRA_TARGETS
+	string "Additional default image types"
+	help
+	  List additional targets to be built by the bootwrapper here (separated
+	  by spaces).  This is useful for targets that depend of device tree
+	  files in the .dts directory.
+
+	  Targets in this list will be build as part of the default build
+	  target, or when the user does a 'make zImage' or a
+	  'make zImage.initrd'.
+
+	  If unsure, leave blank
+
 if !44x || BROKEN
 config ARCH_WANTS_FREEZER_CONTROL
 	def_bool y
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1cee2f9..1e38237 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -270,6 +270,9 @@ ifeq ($(CONFIG_PPC32),y)
 image-$(CONFIG_PPC_PMAC)	+= zImage.coff zImage.miboot
 endif
 
+# Allow extra targets to be added to the defconfig
+image-y	+= $(subst ",,$(CONFIG_EXTRA_TARGETS))
+
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
 		$(patsubst dtbImage%, dtbImage.initrd%, \
