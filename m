Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C2B8DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 15:03:05 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7H52xiw020451
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 00:03:00 -0500
Date: Fri, 17 Aug 2007 00:03:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Add interrupt resource for RTC CMOS driver
Message-ID: <Pine.LNX.4.64.0708170002400.21006@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The RTC CMOS driver expects the interrupt to be a resource of the platform
device.  Use a fixed interrupt value of 8 since on PPC if we are using this
its off an i8259 which we ensure has interrupt numbers 0..15.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/rtc_cmos_setup.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c b/arch/powerpc/sysdev/rtc_cmos_setup.c
index e276048..1d2be7d 100644
--- a/arch/powerpc/sysdev/rtc_cmos_setup.c
+++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
@@ -20,14 +20,16 @@ static int  __init add_rtc(void)
 {
 	struct device_node *np;
 	struct platform_device *pd;
-	struct resource res;
+	struct resource res[2];
 	int ret;

+	memset(&res, 0, sizeof(res));
+
 	np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
 	if (!np)
 		return -ENODEV;

-	ret = of_address_to_resource(np, 0, &res);
+	ret = of_address_to_resource(np, 0, &res[0]);
 	of_node_put(np);
 	if (ret)
 		return ret;
@@ -36,11 +38,16 @@ static int  __init add_rtc(void)
 	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
 	 * address provided by the device node matches.
 	 */
-	if (res.start != RTC_PORT(0))
+	if (res[0].start != RTC_PORT(0))
 		return -EINVAL;

+	res[1].start = 8;
+	res[1].end = 8;
+	res[1].flags = IORESOURCE_IRQ;
+
 	pd = platform_device_register_simple("rtc_cmos", -1,
-					     &res, 1);
+					     &res[0], 2);
+
 	if (IS_ERR(pd))
 		return PTR_ERR(pd);

-- 
1.5.2.2
