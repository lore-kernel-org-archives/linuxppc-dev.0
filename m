Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34CDF2C008C
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2013 21:27:05 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 7 Jan 2013 15:55:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0D308E004B
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2013 15:57:10 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r07AQtHC46661688
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2013 15:56:56 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r07AQvhE015564
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2013 21:26:58 +1100
Subject: [PATCH] uprobes/powerpc: Add dependency on single step emulation
To: benh@kernel.crashing.org
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Mon, 07 Jan 2013 15:56:57 +0530
Message-ID: <20130107102648.27826.85082.stgit@suzukikp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Uprobes uses emulate_step in sstep.c, but we haven't explicitly specified
the dependency. On pseries HAVE_HW_BREAKPOINT protects us, but 44x has no
such luxury.

Consolidate other users that depend on sstep and create a new config option.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Cc: stable@vger.kernel.org
---
 arch/powerpc/Kconfig      |    4 ++++
 arch/powerpc/lib/Makefile |    4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 17903f1..dabe429 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -275,6 +275,10 @@ config PPC_ADV_DEBUG_DAC_RANGE
 	depends on PPC_ADV_DEBUG_REGS && 44x
 	default y
 
+config PPC_EMULATE_SSTEP
+	bool
+	default y if KPROBES || UPROBES || XMON || HAVE_HW_BREAKPOINT
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 746e0c8..35baad9 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -19,9 +19,7 @@ obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   checksum_wrappers_64.o hweight_64.o \
 			   copyuser_power7.o string_64.o copypage_power7.o \
 			   memcpy_power7.o
-obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
-obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
+obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
