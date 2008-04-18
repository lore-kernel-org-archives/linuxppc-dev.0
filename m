Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <c9ce31db788677b55c73cfdf81145fa3682859b1.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 09/11] Convert from DEBUG() to pr_debug() in
	platforms/pseries/rtasd.c
Date: Fri, 18 Apr 2008 17:54:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add "rtasd" to some messages to make it clear where they're coming from.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/rtasd.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/rtasd.c b/arch/powerpc/platforms/pseries/rtasd.c
index e3078ce..befadd4 100644
--- a/arch/powerpc/platforms/pseries/rtasd.c
+++ b/arch/powerpc/platforms/pseries/rtasd.c
@@ -29,11 +29,6 @@
 #include <asm/atomic.h>
 #include <asm/machdep.h>
 
-#if 0
-#define DEBUG(A...)	printk(KERN_ERR A)
-#else
-#define DEBUG(A...)
-#endif
 
 static DEFINE_SPINLOCK(rtasd_log_lock);
 
@@ -198,7 +193,7 @@ void pSeries_log_error(char *buf, unsigned int err_type, int fatal)
 	unsigned long s;
 	int len = 0;
 
-	DEBUG("logging event\n");
+	pr_debug("rtasd: logging event\n");
 	if (buf == NULL)
 		return;
 
@@ -409,7 +404,8 @@ static int rtasd(void *unused)
 	daemonize("rtasd");
 
 	printk(KERN_DEBUG "RTAS daemon started\n");
-	DEBUG("will sleep for %d milliseconds\n", (30000/rtas_event_scan_rate));
+	pr_debug("rtasd: will sleep for %d milliseconds\n",
+		 (30000 / rtas_event_scan_rate));
 
 	/* See if we have any error stored in NVRAM */
 	memset(logdata, 0, rtas_error_log_max);
@@ -428,9 +424,9 @@ static int rtasd(void *unused)
 	do_event_scan_all_cpus(1000);
 
 	if (surveillance_timeout != -1) {
-		DEBUG("enabling surveillance\n");
+		pr_debug("rtasd: enabling surveillance\n");
 		enable_surveillance(surveillance_timeout);
-		DEBUG("surveillance enabled\n");
+		pr_debug("rtasd: surveillance enabled\n");
 	}
 
 	/* Delay should be at least one second since some
-- 
1.5.5
