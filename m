Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4CD81DE1D8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:45:13 +1100 (EST)
Date: Thu, 21 Feb 2008 22:45:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
Message-ID: <20080221194508.GA12896@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m8xx_setup.c says:
   /* Force all 8xx processors to use divide by 16 processor clock. */

And at the same time it is using bus-frequency for calculating
timebase. It is okay for most setups because bus-frequency is
equal to clock-frequency.

The problem emerges when cpu frequency is > 66MHz, quoting
u-boot/cpu/mpc8xx/speed.c:

        if (gd->cpu_clk <= 66000000) {
                sccr_reg |= SCCR_EBDF00;        /* bus division factor = 1 */
                gd->bus_clk = gd->cpu_clk;
        } else {
                sccr_reg |= SCCR_EBDF01;        /* bus division factor = 2 */
                gd->bus_clk = gd->cpu_clk / 2;
        }

So in case of cpu clock > 66MHz, bus_clk = cpu_clk / 2. An then, from
Linux, we calculate timebase frequency as tb_freq = bus_clk / 16,
that is cpu_clk / 2 / 16, which is wrong.

This patch fixes system time drifting problem on the EP885C board
running at 133MHz.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/8xx/m8xx_setup.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 184f998..0d9f75c 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -111,17 +111,12 @@ void __init mpc8xx_calibrate_decr(void)
 
 	/* Processor frequency is MHz.
 	 */
-	ppc_tb_freq = 50000000;
-	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-		                "(not found)\n");
-	}
-	ppc_tb_freq /= 16;
 	ppc_proc_freq = 50000000;
 	if (!get_freq("clock-frequency", &ppc_proc_freq))
 		printk(KERN_ERR "WARNING: Estimating processor frequency "
 		                "(not found)\n");
 
+	ppc_tb_freq = ppc_proc_freq / 16;
 	printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
 
 	/* Perform some more timer/timebase initialization.  This used
-- 
1.5.2.2
