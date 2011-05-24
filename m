Return-Path: <fweisbec@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DF97B6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:52:38 +1000 (EST)
Received: by wyg36 with SMTP id 36so5990445wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:52:34 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] hw_breakpoints: Split hardware breakpoints config
Date: Tue, 24 May 2011 23:52:22 +0200
Message-Id: <1306273947-8410-2-git-send-email-fweisbec@gmail.com>
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

The hardware breakpoint config is only made of an ability. An
arch that support this feature selects HAVE_HW_BREAKPOINT. If so,
the feature is definetly built-in, the user can't decide to turn
it off. As hw_breakpoints depend on perf, it also makes perf
a mandatory feature. The whole is quite a piece of code and
may not be desired on some embedded systems.

In order to prepare to make this optable by the user, split the
config into the more traditional couple (ability, user choice) by
providing a new HW_BREAKPOINT config. It is default on and depends
on CONFIG_EXPERT because breakpoint ptrace requests are part of the
usual user ABI. The user must know what he's doing before turning
that off.

For now, only the archs that already implemented a conditional
HAVE_HW_BREAKPOINT can turn off HW_BREAKPOINT. x86 and sh have it
always selected because they need more background work to support
this new modularity.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/sh/Kconfig  |    1 +
 arch/x86/Kconfig |    1 +
 init/Kconfig     |   10 ++++++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4b89da2..0d4d124 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -44,6 +44,7 @@ config SUPERH32
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_ARCH_KGDB
 	select HAVE_HW_BREAKPOINT
+	select HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cc6c53a..8b49bff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -54,6 +54,7 @@ config X86
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
 	select HAVE_HW_BREAKPOINT
+	select HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI
diff --git a/init/Kconfig b/init/Kconfig
index d886b1e..76ae53e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -924,6 +924,16 @@ menuconfig EXPERT
           environments which can tolerate a "non-standard" kernel.
           Only use this if you really know what you are doing.
 
+config HW_BREAKPOINT
+	bool "Hardware breakpoints" if EXPERT
+	depends on HAVE_HW_BREAKPOINT
+	default y
+	help
+	  Hardware breakpoints are a feature implemented by most CPUs
+	  to trigger an event when an instruction or data fetch
+	  matches a given pattern. This is typically used by ptrace
+	  and perf events.
+
 config UID16
 	bool "Enable 16-bit UID system calls" if EXPERT
 	depends on ARM || BLACKFIN || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && COMPAT) || UML || (X86_64 && IA32_EMULATION)
-- 
1.7.3.2
