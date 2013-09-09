Return-Path: <shawn.guo@linaro.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C6662C0113
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 00:32:57 +1000 (EST)
Date: Mon, 9 Sep 2013 22:32:55 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
Message-ID: <20130909143253.GD4624@S2101-09.ap.freescale.net>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
 <522D93D7.4010307@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <522D93D7.4010307@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sudeep,

On Mon, Sep 09, 2013 at 10:24:39AM +0100, Sudeep KarkadaNagesha wrote:
> Hi Shawn,
> 
> Can you please clarify ? The fix would be as below but I would like to
> know if setting cpu_dev to get_cpu_device(0) instead of &pdev->dev has
> any impact on other parts of code using cpu_dev ?

I'm sorry.  I should have given it a test on hardware before ACKing the
changes.

The fix below should not have other impact except the prefix of dev_err
[info, dbg] message output ('cpufreq-cpu0:' to 'cpu cpu0:'), which
shouldn't be a problem.

> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index cbfffa9..871c336 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -177,7 +177,7 @@ static int cpu0_cpufreq_probe(struct platform_device
> *pdev)
>         struct device_node *np;
>         int ret;
> 
> -       cpu_dev = &pdev->dev;
> +       cpu_dev = get_cpu_device(0);
> 
>         np = of_node_get(cpu_dev->of_node);
>         if (!np) {
> 

The imx6q-cpufreq driver needs a similar fixing.  Please include the
following changes into your fixing patches.  Thanks.

Shawn

---8<---------

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85a1b51..69fd4b6 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -233,9 +233,10 @@ put_node:
 	of_node_put(np);
 }
 
-static void __init imx6q_opp_init(struct device *cpu_dev)
+static void __init imx6q_opp_init(void)
 {
 	struct device_node *np;
+	struct device *cpu_dev = get_cpu_device(0);
 
 	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
@@ -268,7 +269,7 @@ static void __init imx6q_init_late(void)
 		imx6q_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-		imx6q_opp_init(&imx6q_cpufreq_pdev.dev);
+		imx6q_opp_init();
 		platform_device_register(&imx6q_cpufreq_pdev);
 	}
 }
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 3e39654..d7ebd91 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -202,7 +203,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	unsigned long min_volt, max_volt;
 	int num, ret;
 
-	cpu_dev = &pdev->dev;
+	cpu_dev = get_cpu_device(0);
 
 	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
