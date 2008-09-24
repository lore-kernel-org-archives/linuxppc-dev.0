Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95456DDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 20:08:48 +1000 (EST)
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080923143057.e3e54536.akpm@linux-foundation.org>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
	<20080923143057.e3e54536.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 12:07:52 +0200
Message-Id: <1222250872.18015.69.camel@johannes.berg>
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

On Tue, 2008-09-23 at 14:30 -0700, Andrew Morton wrote:

> > Steps to reproduce:
> > shut down the machine, see it fail.
> > 
> > http://johannes.sipsolutions.net/files/dsc_2274.jpg
> > 
> 
> That went splat in the clockevents code.

This is still strange, it appears that when the CPUs fail to offline, we
still call into the clockevents code and it rightfully crashes, but I'll
check that out separately.

I've found the problem, below is a tentative fix. The problem has been
around for quite a while, here's the whole commit that "caused" it
(because it's so short):

commit 4047727e5ae33f9b8d2b7766d1994ea6e5ec2991
Author: Mark Lord <lkml@rtr.ca>
Date:   Mon Oct 1 01:20:10 2007 -0700

    Fix SMP poweroff hangs
    
    We need to disable all CPUs other than the boot CPU (usually 0) before
    attempting to power-off modern SMP machines.  This fixes the
    hang-on-poweroff issue on my MythTV SMP box, and also on Thomas Gleixner's
    new toybox.
    
    Signed-off-by: Mark Lord <mlord@pobox.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/sys.c b/kernel/sys.c
index 1b33b05..8ae2e63 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -32,6 +32,7 @@
 #include <linux/getcpu.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/seccomp.h>
+#include <linux/cpu.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -878,6 +879,7 @@ void kernel_power_off(void)
        kernel_shutdown_prepare(SYSTEM_POWER_OFF);
        if (pm_power_off_prepare)
                pm_power_off_prepare();
+       disable_nonboot_cpus();
        sysdev_shutdown();
        printk(KERN_EMERG "Power down.\n");
        machine_power_off();


And here's the fix.

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
 arch/powerpc/kernel/idle.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -36,9 +36,7 @@
 #ifdef CONFIG_HOTPLUG_CPU
 /* this is used for software suspend, and that shuts down
  * CPUs even while the system is still booting... */
-#define cpu_should_die()	(cpu_is_offline(smp_processor_id()) && \
-				   (system_state == SYSTEM_RUNNING     \
-				 || system_state == SYSTEM_BOOTING))
+#define cpu_should_die()	cpu_is_offline(smp_processor_id())
 #else
 #define cpu_should_die()	0
 #endif
