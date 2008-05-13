Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A3167DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 01:55:10 +1000 (EST)
Date: Tue, 13 May 2008 19:55:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [WATCHDOG] mpc8xxx_wdt: add support for MPC8xx watchdogs
Message-ID: <20080513155507.GA25624@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<8C355C2C-C029-4F02-A5B0-DA8173FAFF69@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <8C355C2C-C029-4F02-A5B0-DA8173FAFF69@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only build-tested.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, May 13, 2008 at 09:50:26AM -0500, Kumar Gala wrote:
>
> On May 13, 2008, at 9:14 AM, Anton Vorontsov wrote:
>
>> Hi all,
>>
>> Thanks for the review, here is the new version.
>>
>> Changes since v1:
>>
>> - Scott Wood asked for mpc83xx_wdt on multiplatform kernels. Done via
>>  OF platform driver;
>> - Kumar Gala asked for mpc83xx_wdt -> mpc8xxx_wdt rename. Done in two
>>  steps;
>> - Segher Boessenkool noticed a negligence in the wdt device tree node.
>>  Fixed by removing mpc83xx_wdt compatible entry.
>
> any possibility of making this work on 8xx per Jochen's comment?  (see  
> mpc8xx_wdt.c)

[ Oops. Jochen, sorry I forgot to Cc you this time. ]

I think it should work with the patch inlined here, and this node
in the device tree.

soc@ff000000 {
	....
	wdt@0 {
		device_type = "watchdog";
		compatible = "fsl,mpc885-wdt";
		reg = <0 0x100>;
	};
	....
};

Not tested though. And also no support for RTC-driven timer tweak
(anybody willing are welcomed to implement this ;-).

 drivers/watchdog/Kconfig       |    2 +-
 drivers/watchdog/mpc8xxx_wdt.c |   31 +++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index bd9044f..06b1119 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -684,7 +684,7 @@ config 8xx_WDT
 
 config 8xxx_WDT
 	tristate "MPC8xxx Watchdog Timer"
-	depends on PPC_83xx || PPC_86xx
+	depends on FSL_SOC
 
 config MV64X60_WDT
 	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index b582441..a93b512 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -42,6 +42,11 @@ struct mpc8xxx_wdt {
 	u8 res2[0xF0];
 };
 
+struct mpc8xxx_wdt_type {
+	int prescaler;
+	bool hw_enabled;
+};
+
 static struct mpc8xxx_wdt __iomem *wd_base;
 
 static u16 timeout = 0xffff;
@@ -182,6 +187,7 @@ static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 {
 	int ret;
 	struct device_node *np = ofdev->node;
+	struct mpc8xxx_wdt_type *wdt_type = match->data;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 
@@ -193,7 +199,7 @@ static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 		return -ENOMEM;
 
 	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
-	if (!enabled && of_device_is_compatible(np, "fsl,mpc8610-wdt")) {
+	if (!enabled && wdt_type->hw_enabled) {
 		pr_info("mpc8xxx_wdt: could not be enabled in software\n");
 		ret = -ENOSYS;
 		goto err_unmap;
@@ -208,7 +214,7 @@ static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 
 	/* Calculate the timeout in seconds */
 	if (prescale)
-		timeout_sec = (timeout * 0x10000) / freq;
+		timeout_sec = (timeout * wdt_type->prescaler) / freq;
 	else
 		timeout_sec = timeout / freq;
 
@@ -240,8 +246,25 @@ static int __devexit mpc8xxx_wdt_remove(struct of_device *ofdev)
 }
 
 static const struct of_device_id mpc8xxx_wdt_match[] = {
-	{ .compatible = "mpc83xx_wdt", },
-	{ .compatible = "fsl,mpc8610-wdt", },
+	{
+		.compatible = "mpc83xx_wdt",
+		.data = &(struct mpc8xxx_wdt_type) {
+			.prescaler = 0x10000,
+		},
+	},
+	{
+		.compatible = "fsl,mpc8610-wdt",
+		.data = &(struct mpc8xxx_wdt_type) {
+			.prescaler = 0x10000,
+			.hw_enabled = true,
+		},
+	},
+	{
+		.compatible = "fsl,mpc885-wdt",
+		.data = &(struct mpc8xxx_wdt_type) {
+			.prescaler = 0x800,
+		},
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
-- 
1.5.5.1
