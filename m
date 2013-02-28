Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id B63962C02B2
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Mar 2013 01:46:20 +1100 (EST)
From: Luis Henriques <luis.henriques@canonical.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@lists.ubuntu.com
Subject: [PATCH 014/139] uprobes/powerpc: Add dependency on single step
 emulation
Date: Thu, 28 Feb 2013 14:42:44 +0000
Message-Id: <1362062689-2567-15-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1362062689-2567-1-git-send-email-luis.henriques@canonical.com>
References: <1362062689-2567-1-git-send-email-luis.henriques@canonical.com>
Cc: Luis Henriques <luis.henriques@canonical.com>, linuxppc-dev@ozlabs.org,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

3.5.7.7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Suzuki K. Poulose" <suzuki@in.ibm.com>

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
