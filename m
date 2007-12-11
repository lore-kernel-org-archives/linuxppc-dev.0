Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:39:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/8] powerpc: mv64x60 - Update i2c DTS properties
Message-ID: <20071211003912.GG4995@mag.az.mvista.com>
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

DTS files should not specify the default timeout value for the
mv64360 i2c controller.  Also, remove deprecated 'retries' property.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
FYI, the 'retries' property use and related platform_data will be
removed in a patch that is working its way through the i2c community.

 arch/powerpc/boot/dts/prpmc2800.dts |    2 --
 arch/powerpc/sysdev/mv64x60_dev.c   |    6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index e670e3f..b608e6c 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -236,8 +236,6 @@
 			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
 			freq_n = <3>;
-			timeout = <1000>;		/* 1000 = 1 second */
-			retries = <1>;
 			interrupts = <37>;
 			interrupt-parent = <&PIC>;
 		};
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 587c40f..e0244d8 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -355,11 +355,7 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 		return -ENODEV;
 	pdata.freq_n = *prop;
 
-	prop = of_get_property(np, "timeout", NULL);
-	if (prop)
-		pdata.timeout = *prop;
-	else
-		pdata.timeout = 1000;	/* 1 second */
+	pdata.timeout = 1000;	/* 1 second */
 
 	prop = of_get_property(np, "retries", NULL);
 	if (prop)
