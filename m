Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:39:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 7/8] powerpc: mv64x60 - Remove timeout property for WDT
Message-ID: <20071211003929.GH4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Remove support for the DTS timeout property that's currently there for
the watchdog timer on mv64x60 hostbridges.  The platform_data remains
and can be modified by platform-specific code when necessary.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |    1 -
 arch/powerpc/sysdev/mv64x60_dev.c   |    5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index b608e6c..054f028 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -226,7 +226,6 @@
 		wdt@b410 {			/* watchdog timer */
 			compatible = "marvell,mv64360-wdt";
 			reg = <0xb410 0x8>;
-			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index e0244d8..f998330 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -403,10 +403,7 @@ static int __init mv64x60_wdt_device_setup(struct device_node *np, int id)
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	prop = of_get_property(np, "timeout", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.timeout = *prop;
+	pdata.timeout = 10;	/* Default: 10 seconds */
 
 	np = of_get_parent(np);
 	if (!np)
