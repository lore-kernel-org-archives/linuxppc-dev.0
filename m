Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id 36D8B2C0095
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2013 03:12:58 +1100 (EST)
From: Luis Henriques <luis.henriques@canonical.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [ 3.5.y.z extended stable ] Patch "uprobes/powerpc: Add dependency on
 single step emulation" has been added to staging queue
Date: Tue, 26 Feb 2013 16:12:53 +0000
Message-Id: <1361895173-26950-1-git-send-email-luis.henriques@canonical.com>
Cc: Luis Henriques <luis.henriques@canonical.com>, linuxppc-dev@ozlabs.org,
 kernel-team@lists.ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a note to let you know that I have just added a patch titled

    uprobes/powerpc: Add dependency on single step emulation

to the linux-3.5.y-queue branch of the 3.5.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.5.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.5.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 8f290ba295f6a2ecf5d1e2d9c80080b1407b8634 Mon Sep 17 00:00:00 2001
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Mon, 7 Jan 2013 00:26:57 +0000
Subject: [PATCH] uprobes/powerpc: Add dependency on single step emulation

commit 5e249d4528528c9a77da051a89ec7f99d31b83eb upstream.

Uprobes uses emulate_step in sstep.c, but we haven't explicitly specified
the dependency. On pseries HAVE_HW_BREAKPOINT protects us, but 44x has no
such luxury.

Consolidate other users that depend on sstep and create a new config option.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[ luis: adjust context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/Kconfig      | 4 ++++
 arch/powerpc/lib/Makefile | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 050cb37..4d8336c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -264,6 +264,10 @@ config PPC_ADV_DEBUG_DAC_RANGE
 	depends on PPC_ADV_DEBUG_REGS && 44x
 	default y

+config PPC_EMULATE_SSTEP
+	bool
+	default y if KPROBES || UPROBES || XMON || HAVE_HW_BREAKPOINT
+
 source "init/Kconfig"

 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 7735a2c..3230bc1 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,9 +18,7 @@ obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   checksum_wrappers_64.o hweight_64.o \
 			   copyuser_power7.o
-obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
-obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
+obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o

 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
--
1.8.1.2
