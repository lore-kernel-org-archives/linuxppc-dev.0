Return-Path: <fweisbec@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49BC7B6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:52:39 +1000 (EST)
Received: by mail-wy0-f179.google.com with SMTP id 36so5990428wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:52:39 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] hw_breakpoints: Breakpoints arch ability don't need perf
	events
Date: Tue, 24 May 2011 23:52:25 +0200
Message-Id: <1306273947-8410-5-git-send-email-fweisbec@gmail.com>
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

The breakpoint support ability in an arch is not related
to the fact perf events is built or not. HAVE_HW_BREAKPOINT
only shows an ability so this dependency makes no sense
anymore. Archs that select HAVE_HW_BREAKPOINT already
ensure that perf event is built.

Remove that dependency.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f78c2be..ce4be89 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -149,7 +149,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
 
 config HAVE_HW_BREAKPOINT
 	bool
-	depends on PERF_EVENTS
 
 config HAVE_MIXED_BREAKPOINTS_REGS
 	bool
-- 
1.7.3.2
