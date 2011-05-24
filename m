Return-Path: <fweisbec@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 458C6B6FF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:52:41 +1000 (EST)
Received: by mail-wy0-f179.google.com with SMTP id 36so5990445wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:52:41 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] hw_breakpoints: Only force perf events if breakpoints are
	selected
Date: Tue, 24 May 2011 23:52:26 +0200
Message-Id: <1306273947-8410-6-git-send-email-fweisbec@gmail.com>
In-Reply-To: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Prasad <prasad@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, arch were forced to always build perf events if they
supported hw_breakpoints.

Now that the user can choose not to build hw_breakpoints, let
only force perf events if hw_breakpoints are selected.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/sh/Kconfig  |    1 -
 arch/x86/Kconfig |    1 -
 init/Kconfig     |    1 +
 3 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0d4d124..d59e6c2 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -46,7 +46,6 @@ config SUPERH32
 	select HAVE_HW_BREAKPOINT
 	select HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
-	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select SPARSE_IRQ
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fb28dd9..5317f42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -55,7 +55,6 @@ config X86
 	select HAVE_KERNEL_LZO
 	select HAVE_HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
-	select PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI
 	select ANON_INODES
 	select HAVE_ARCH_KMEMCHECK
diff --git a/init/Kconfig b/init/Kconfig
index 76ae53e..9ae3555 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -927,6 +927,7 @@ menuconfig EXPERT
 config HW_BREAKPOINT
 	bool "Hardware breakpoints" if EXPERT
 	depends on HAVE_HW_BREAKPOINT
+	select PERF_EVENTS
 	default y
 	help
 	  Hardware breakpoints are a feature implemented by most CPUs
-- 
1.7.3.2
