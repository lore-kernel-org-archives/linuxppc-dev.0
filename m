Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6F361DDECE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 15:01:00 +1100 (EST)
Date: Wed, 12 Dec 2007 15:00:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix unregistering HV event handlers.
Message-Id: <20071212150056.9a21c8a4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit fbd568a3e61a7decb8a754ad952aaa5b5c82e9e5 ("Change
synchronize_kernel to _rcu and _sched") changed the deprecated
synchronize_kernel() in HvLpEvent_unregisterHandler() to
synchronize_rcu().  It turns out that it should have been
synchronize_sched().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/lpevents.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
index 34bdbbe..02c1422 100644
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -226,7 +226,7 @@ int HvLpEvent_unregisterHandler(HvLpEvent_Type eventType)
 			 * other CPUs, and that the deleted handler isn't
 			 * still running on another CPU when we return.
 			 */
-			synchronize_rcu();
+			synchronize_sched();
 			return 0;
 		}
 	}
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
