Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB418DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 23:05:49 +1100 (EST)
Date: Thu, 26 Mar 2009 13:05:42 +0100
From: Adrian Reber <adrian@lisas.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] Fix RTAS watchdog driver temperature read functionality
Message-ID: <20090326120542.GD24889@lisas.de>
References: <20090316123543.GG15530@lisas.de>
	<1237868838.25062.712.camel@pasglop>
	<20090324114505.GB24724@lisas.de>
	<1237928433.25062.725.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1237928433.25062.725.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Utz Bacher <utz.bacher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using the RTAS watchdog driver to read out the temperature crashes
on a PXCAB:

Unable to handle kernel paging request for data at address 0xfe347b50
Faulting instruction address: 0xc00000000001af64
Oops: Kernel access of bad area, sig: 11 [#1]

The wrong usage of "(void *)__pa(&temperature)" in rtas_call() is
removed by using the function rtas_get_sensor() which does the
right thing.

Signed-off-by: Adrian Reber <adrian@lisas.de>
---
v2: use rtas_get_sensor(); typo fixed
---
 drivers/watchdog/wdrtas.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 5d3b1a8..a9f00dc 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -214,16 +214,14 @@ static void wdrtas_timer_keepalive(void)
  */
 static int wdrtas_get_temperature(void)
 {
-	long result;
+	int result;
 	int temperature = 0;
 
-	result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
-			   (void *)__pa(&temperature),
-			   WDRTAS_THERMAL_SENSOR, 0);
+	result = rtas_get_sensor(WDRTAS_THERMAL_SENSOR, 0, &temperature);
 
 	if (result < 0)
 		printk(KERN_WARNING "wdrtas: reading the thermal sensor "
-		       "faild: %li\n", result);
+		       "failed: %i\n", result);
 	else
 		temperature = ((temperature * 9) / 5) + 32; /* fahrenheit */
 
-- 
1.5.6.6
