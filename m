Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C5B8EDE091
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:04:32 +1000 (EST)
Date: Thu, 12 Jun 2008 03:04:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if
	there is i8259 PIC
Message-ID: <20080611230431.GC21351@polina.dev.rtsoft.ru>
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080611230250.GA13412@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i8259 PIC is disabled on MPC8610HPCD boards, thus currently rtc-cmos
driver fails to probe.

To fix the issue, we lookup the device tree for "chrp,iic" and
"pnpPNP,000" compatible devices, and if not found we do not assign RTC
IRQ and assuming that i8259 was disabled.

Though this patch fixes RTC on some boards (and surely should not break
any other), the whole approach is still broken. We can't easily fix this
though, because old device trees do not specify i8259 interrupts for the
cmos rtc node.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/rtc_cmos_setup.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c b/arch/powerpc/sysdev/rtc_cmos_setup.c
index c09ddc0..c1879eb 100644
--- a/arch/powerpc/sysdev/rtc_cmos_setup.c
+++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
@@ -21,6 +21,7 @@ static int  __init add_rtc(void)
 	struct device_node *np;
 	struct platform_device *pd;
 	struct resource res[2];
+	unsigned int num_res = 1;
 	int ret;
 
 	memset(&res, 0, sizeof(res));
@@ -41,14 +42,24 @@ static int  __init add_rtc(void)
 	if (res[0].start != RTC_PORT(0))
 		return -EINVAL;
 
-	/* Use a fixed interrupt value of 8 since on PPC if we are using this
-	 * its off an i8259 which we ensure has interrupt numbers 0..15. */
-	res[1].start = 8;
-	res[1].end = 8;
-	res[1].flags = IORESOURCE_IRQ;
+	np = of_find_compatible_node(NULL, NULL, "chrp,iic");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL, "pnpPNP,000");
+	if (np) {
+		of_node_put(np);
+		/*
+		 * Use a fixed interrupt value of 8 since on PPC if we are
+		 * using this its off an i8259 which we ensure has interrupt
+		 * numbers 0..15.
+		 */
+		res[1].start = 8;
+		res[1].end = 8;
+		res[1].flags = IORESOURCE_IRQ;
+		num_res++;
+	}
 
 	pd = platform_device_register_simple("rtc_cmos", -1,
-					     &res[0], 2);
+					     &res[0], num_res);
 
 	if (IS_ERR(pd))
 		return PTR_ERR(pd);
-- 
1.5.5.4
