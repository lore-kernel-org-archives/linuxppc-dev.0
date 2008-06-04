Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 26B89DE1C5
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 02:11:36 +1000 (EST)
Date: Wed, 4 Jun 2008 20:11:34 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] [POWERPC] rtc_cmos_setup: assign interrupts only if
	there is i8259 PIC
Message-ID: <20080604161134.GA7233@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sometimes we want IRQ-less CMOS RTC for the boards without (or disabled)
i8259 PIC. That is, on MPC8610HPCD i8259 is disabled, and rtc-cmos driver
will fail to probe the RTC.

To fix this, we lookup the device tree for "chrp,iic" and "pnpPNP,000"
compatible devices, and if not found we do not assign RTC IRQ and assuming
that i8259 was disabled.

Though this patch fixes RTC on some boards (and surely should not break
any other), the whole approach is still broken. We can't easily fix this
though, because old device trees do not specify i8259 interrupts for the
cmos rtc node.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is for next tree, not sure who would pick it up though.

Changes since v1:

- Added pnpPNP,000 compatible matching.

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
1.5.5.1
