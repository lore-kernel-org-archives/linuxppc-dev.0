Return-Path: <sboyd@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine01.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CD334B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 05:31:25 +1000 (EST)
From: Stephen Boyd <sboyd@codeaurora.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib: Consolidate DEBUG_PER_CPU_MAPS
Date: Thu,  7 Apr 2011 12:20:46 -0700
Message-Id: <1302204046-2481-1-git-send-email-sboyd@codeaurora.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DEBUG_PER_CPU_MAPS is used in lib/cpumask.c as well as in
inlcude/linux/cpumask.h and thus it has outgrown its use within x86
and powerpc alone. Any arch with SMP support may want to get some
more debugging, so make this option generic.

Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I don't know what tree to send this through, so I'm sending it to
Andrew. I suppose mm is as good as anything.

 arch/powerpc/Kconfig.debug |   12 ------------
 arch/x86/Kconfig.debug     |   11 -----------
 lib/Kconfig.debug          |   11 +++++++++++
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 2d38a50..12a8d18 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -44,18 +44,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_PER_CPU_MAPS
-	bool "Debug access to per_cpu maps"
-	depends on DEBUG_KERNEL
-	depends on SMP
-	default n
-	---help---
-	  Say Y to verify that the per_cpu map being accessed has
-	  been setup.  Adds a fair amount of code to kernel memory
-	  and decreases performance.
-
-	  Say N if unsure.
-
 config HCALL_STATS
 	bool "Hypervisor call instrumentation"
 	depends on PPC_PSERIES && DEBUG_FS && TRACEPOINTS
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 615e188..1bf8839 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -75,17 +75,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_PER_CPU_MAPS
-	bool "Debug access to per_cpu maps"
-	depends on DEBUG_KERNEL
-	depends on SMP
-	---help---
-	  Say Y to verify that the per_cpu map being accessed has
-	  been setup.  Adds a fair amount of code to kernel memory
-	  and decreases performance.
-
-	  Say N if unsure.
-
 config X86_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c768bcd..c792431 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -993,6 +993,17 @@ config DEBUG_FORCE_WEAK_PER_CPU
 	  To ensure that generic code follows the above rules, this
 	  option forces all percpu variables to be defined as weak.
 
+config DEBUG_PER_CPU_MAPS
+	bool "Debug access to per_cpu maps"
+	depends on DEBUG_KERNEL
+	depends on SMP
+	help
+	  Say Y to verify that the per_cpu map being accessed has
+	  been set up. This adds a fair amount of code to kernel memory
+	  and decreases performance.
+
+	  Say N if unsure.
+
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
