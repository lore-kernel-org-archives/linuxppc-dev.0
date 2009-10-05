Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9805AB7BC2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 04:44:29 +1100 (EST)
Date: Mon, 5 Oct 2009 21:44:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Make it possible to select hibernation on all
	PowerPCs
Message-ID: <20091005174427.GA21489@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just as with kexec, hibernation may fail even on well-tested platforms:
some PCI device, a driver of which doesn't play well with hibernation,
is enough to break resuming.

Hibernation code is not much platform dependent, and hiding features only
because these were not verified on a particular hardware is
counterproductive: we just prevent the features from being widely tested.

For example, with this patch I just tested hibernation on a MPC83xx
board, and it works quite well, modulo a few drivers that need some
fixing.

So, let's make it possible to select hibernation support for all
PowerPCs, then let's wait for any possible bug reports, and actually fix
(or just collect ;-) the bugs instead of hiding them. If some platforms
really can't stand hibernation, we can make a blacklist, with proper
comments why exactly hibernation doesn't work, whether it is possible to
fix, and what needs to be done to fix it.

CONFIG_HIBERNATION is still =n by default, so the commit doesn't change
anything apart from ability to set it to =y.

I'm not sure if EXPERIMENTAL dependency is needed, I'd rather not add it
for a few reasons:

1) It doesn't matter much, for distro kernels user has no clue that some
   feature is experimental. Majority of defconfigs enable EXPERIMENTAL
   anyway (90 vs. 4, which, btw, means that EXPERIMENTAL is overused
   in Kconfigs);

2) EXPERIMENTAL is a good thing for features that change default
   behaviour of a kernel, while for hibernation user has to explicitly
   issue 'echo disk > /sys/power/state' to trigger any hibernation bugs;

3) Per init/Kconfig, EXPERIMENTAL is a good thing to scare and discourage
   users from 'widespread use of a feature', while we want to encourage
   that use.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Build-tested on 8xx, 83xx and 85xx with CONFIG_HIBERNATION=y.

 arch/powerpc/Kconfig |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a2f66ed..85f140d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -199,19 +199,8 @@ config DEFAULT_UIMAGE
 config REDBOOT
 	bool
 
-config HIBERNATE_32
-	bool
-	depends on (PPC_PMAC && !SMP) || BROKEN
-	default y
-
-config HIBERNATE_64
-	bool
-	depends on BROKEN || (PPC_PMAC64 && EXPERIMENTAL)
-	default y
-
 config ARCH_HIBERNATION_POSSIBLE
 	bool
-	depends on (PPC64 && HIBERNATE_64) || (PPC32 && HIBERNATE_32)
 	default y
 
 config ARCH_SUSPEND_POSSIBLE
-- 
1.6.3.3
