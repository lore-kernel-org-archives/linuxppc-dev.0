Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id A6A10DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 21:59:58 +1100 (EST)
Date: Thu, 27 Nov 2008 11:59:52 +0100
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pseries: Fix cpu hotplug
Message-ID: <20081127115952.1f7db89d@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Currently, pseries_cpu_die() calls msleep() while polling RTAS for
the status of the dying cpu.

  However if the cpu that is going down also happens to be the one doing
the tick then we're hosed as the tick_do_timer_cpu 'baton' is only passed
later on in tick_shutdown() when _cpu_down() does the CPU_DEAD notification.
Therefore jiffies won't be updated anymore.

  This patch replaces that msleep() with a cpu_relax() to make sure we're
not going to schedule at that point.

  With this patch my test box survives a 100k iterations hotplug stress
test on _all_ cpus, whereas without it, it quickly dies after ~50 iterations.


Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 1f03248..a20ead8 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -116,7 +116,7 @@ static void pseries_cpu_die(unsigned int cpu)
 		cpu_status = query_cpu_stopped(pcpu);
 		if (cpu_status == 0 || cpu_status == -1)
 			break;
-		msleep(200);
+		cpu_relax();
 	}
 	if (cpu_status != 0) {
 		printk("Querying DEAD? cpu %i (%i) shows %i\n",
-- 
1.6.0.1.308.gede4c
