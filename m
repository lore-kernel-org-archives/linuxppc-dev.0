Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EC64DDF4A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 18:57:28 +1000 (EST)
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080923143057.e3e54536.akpm@linux-foundation.org>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
	<20080923143057.e3e54536.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 10:56:25 +0200
Message-Id: <1222332986.10563.35.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, bugme-daemon@bugzilla.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> And here's the fix.

Well, that should of course remove that comment there too. New version
below.

From: Johannes Berg <johannes@sipsolutions.net>
Subject: powerpc: fix shutdown

I tracked down the shutdown regression to CPUs not dying
when being shut down during power-off. This turns out to
be due to the system_state being SYSTEM_POWER_OFF, which
this code doesn't take as a valid state for shutting off
CPUs in.

This has never made sense to me, but when I added hotplug
code to implement hibernate I only "made it work" and did
not question the need to check the system_state. Thomas
Gleixner helped me dig, but the only thing we found is
that it was added with the original commit that added CPU
hotplug support.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Schopp <jschopp@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/idle.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- everything.orig/arch/powerpc/kernel/idle.c	2008-09-01 12:28:37.000000000 +0200
+++ everything/arch/powerpc/kernel/idle.c	2008-09-25 10:55:45.000000000 +0200
@@ -34,11 +34,7 @@
 #include <asm/smp.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* this is used for software suspend, and that shuts down
- * CPUs even while the system is still booting... */
-#define cpu_should_die()	(cpu_is_offline(smp_processor_id()) && \
-				   (system_state == SYSTEM_RUNNING     \
-				 || system_state == SYSTEM_BOOTING))
+#define cpu_should_die()	cpu_is_offline(smp_processor_id())
 #else
 #define cpu_should_die()	0
 #endif
