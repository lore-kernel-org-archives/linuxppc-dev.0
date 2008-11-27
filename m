Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id AAAF8DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 01:52:10 +1100 (EST)
Date: Thu, 27 Nov 2008 15:52:03 +0100
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pseries: fix idle sleep early exit state
Message-ID: <20081127155203.2a1d6af9@bull.net>
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


  In pseries_dedicated_idle_sleep(), if we need to exit idle during the
snooze period (i.e. need_resched or cpu has been offlined), then we should
re-disable the interrupts and clear TIF_POLLING_NRFLAG before leaving.

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/platforms/pseries/setup.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ec34170..8270f04 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -504,8 +504,13 @@ static void pseries_dedicated_idle_sleep(void)
 		set_thread_flag(TIF_POLLING_NRFLAG);
 
 		while (get_tb() < start_snooze) {
-			if (need_resched() || cpu_is_offline(cpu))
-				goto out;
+			if (need_resched() || cpu_is_offline(cpu)) {
+				HMT_medium();
+				clear_thread_flag(TIF_POLLING_NRFLAG);
+				smp_mb();
+				local_irq_disable();
+				goto out2;
+			}
 			ppc64_runlatch_off();
 			HMT_low();
 			HMT_very_low();
@@ -523,6 +528,7 @@ static void pseries_dedicated_idle_sleep(void)
 
 out:
 	HMT_medium();
+out2:
 	out_purr = mfspr(SPRN_PURR);
 	get_lppaca()->wait_state_cycles += out_purr - in_purr;
 	get_lppaca()->donate_dedicated_cpu = 0;
-- 
1.6.0.1.308.gede4c
