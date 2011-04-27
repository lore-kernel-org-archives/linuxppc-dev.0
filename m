Return-Path: <fweisbec@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BB1C10083C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 03:00:27 +1000 (EST)
Received: by wwi36 with SMTP id 36so1682907wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 10:00:23 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] hw_breakpoints: Drop remaining misplaced dependency on
	perf
Date: Wed, 27 Apr 2011 19:00:02 +0200
Message-Id: <1303923602-2923-7-git-send-email-fweisbec@gmail.com>
In-Reply-To: <1303923602-2923-1-git-send-email-fweisbec@gmail.com>
References: <1303923602-2923-1-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Prasad <prasad@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	LPPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Powerpc and Arm select breakpoint support ability only if
Perf is built. This is not necessary anymore now that we
enable perf once breakpoints support is selected.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/arm/Kconfig     |    2 +-
 arch/powerpc/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..1d3a0b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,7 +24,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
+	select HAVE_HW_BREAKPOINT if (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8f4d50b..e944eb8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,7 +134,7 @@ config PPC
 	select HAVE_IRQ_WORK
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_HW_BREAKPOINT if PPC_BOOK3S_64
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
 	select IRQ_PER_CPU
-- 
1.7.3.2
