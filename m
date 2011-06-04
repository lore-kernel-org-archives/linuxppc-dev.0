Return-Path: <christian.dietrich@informatik.uni-erlangen.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FA00B6FD8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  5 Jun 2011 01:45:50 +1000 (EST)
Date: Sat, 4 Jun 2011 17:35:47 +0200
From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 1/8] powerpc/rtas-rtc: remove sideeffects of printk_ratelimit
Message-ID: <f9c3e5aaf1d7819e06667f2575ca9623711d03e6.1307199715.git.christian.dietrich@informatik.uni-erlangen.de>
References: <cover.1307199715.git.christian.dietrich@informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1307199715.git.christian.dietrich@informatik.uni-erlangen.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't use printk_ratelimit() as an additional condition for returning
on an error. Because when the ratelimit is reached, printk_ratelimit
will return 0 and e.g. in rtas_get_boot_time won't check for an error
condition.

Signed-off-by: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
---
 arch/powerpc/kernel/rtas-rtc.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-rtc.c b/arch/powerpc/kernel/rtas-rtc.c
index 77578c0..c57c193 100644
--- a/arch/powerpc/kernel/rtas-rtc.c
+++ b/arch/powerpc/kernel/rtas-rtc.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/delay.h>
+#include <linux/ratelimit.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/time.h>
@@ -29,9 +30,10 @@ unsigned long __init rtas_get_boot_time(void)
 		}
 	} while (wait_time && (get_tb() < max_wait_tb));
 
-	if (error != 0 && printk_ratelimit()) {
-		printk(KERN_WARNING "error: reading the clock failed (%d)\n",
-			error);
+	if (error != 0) {
+		printk_ratelimited(KERN_WARNING
+				   "error: reading the clock failed (%d)\n",
+				   error);
 		return 0;
 	}
 
@@ -55,19 +57,21 @@ void rtas_get_rtc_time(struct rtc_time *rtc_tm)
 
 		wait_time = rtas_busy_delay_time(error);
 		if (wait_time) {
-			if (in_interrupt() && printk_ratelimit()) {
+			if (in_interrupt()) {
 				memset(rtc_tm, 0, sizeof(struct rtc_time));
-				printk(KERN_WARNING "error: reading clock"
-				       " would delay interrupt\n");
+				printk_ratelimited(KERN_WARNING
+						   "error: reading clock "
+						   "would delay interrupt\n");
 				return;	/* delay not allowed */
 			}
 			msleep(wait_time);
 		}
 	} while (wait_time && (get_tb() < max_wait_tb));
 
-        if (error != 0 && printk_ratelimit()) {
-                printk(KERN_WARNING "error: reading the clock failed (%d)\n",
-		       error);
+	if (error != 0) {
+		printk_ratelimited(KERN_WARNING
+				   "error: reading the clock failed (%d)\n",
+				   error);
 		return;
         }
 
@@ -99,9 +103,10 @@ int rtas_set_rtc_time(struct rtc_time *tm)
 		}
 	} while (wait_time && (get_tb() < max_wait_tb));
 
-        if (error != 0 && printk_ratelimit())
-                printk(KERN_WARNING "error: setting the clock failed (%d)\n",
-		       error);
+	if (error != 0)
+		printk_ratelimited(KERN_WARNING
+				   "error: setting the clock failed (%d)\n",
+				   error);
 
         return 0;
 }
-- 
1.7.1
