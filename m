Return-Path: <shawn.guo@linaro.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64A8E2C0123
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 12:44:25 +1000 (EST)
Date: Tue, 10 Sep 2013 10:44:06 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
Message-ID: <20130910024404.GC5815@S2101-09.ap.freescale.net>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
 <522D93D7.4010307@arm.com>
 <20130909143253.GD4624@S2101-09.ap.freescale.net>
 <522DE822.3030907@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <522DE822.3030907@arm.com>
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

On Mon, Sep 09, 2013 at 04:24:18PM +0100, Sudeep KarkadaNagesha wrote:
> Hi Shawn,
> 
> Ok. But I am bit suspicious about devm_clk_get(cpu_dev, NULL).
> I don't understand completely as how the clock are registered(whether
> with dev_id or with connection_id).

As the connection_id of devm_clk_get() call here is NULL, the clock
lookup should be registered with a proper dev_id in clk_register_clkdev()
call.  And that's what you have seen with imx and shmobile code.


> A quick grep revealed that i.mx and shmobile is using conection id while
> registering.

They are using dev_id.

> If the clock is registered with connection id and retrieved
> with cpu_dev(now dev_id is cpu0 and not cpufreq-cpu0), IIUC that would
> break. If we pass pdev->dev for clk_get, it should be fine but again
> IIUC it breaks highbank which gets all the information from DT.

If the clock lookup is from DT, we should be just fine, since it will
work as long as the DT node with 'clocks' property (/cpus/cpu@0 in this
case) is attached to the struct device pointer of devm_clk_get() call.

> So only solution I can think of is to continue to have the code
> assigning (&pdev->dev)->of_node with cpu device node which is not clean
> and arguable as incorrect since there is no DT node for cpufreq-cpu0.
> I don't have a strong opinion though.
> 
> Let me know how would you like to fix this.

So we only need to change all clkdev registration to use "cpu0" as
dev_id intstead of "cpufreq-cpu0.0", something like below.

And for imx, it should work even without the changes, because we have
device tree lookup ready there, and those clk_register_clkdev() calls
can just be removed now.  But I prefer to include the change and leave
the cleanup to another patch for keeping the change log clear.

Shawn

---8<----------

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index c3cfa41..c6b40f3 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -285,7 +285,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
 	clk_register_clkdev(clk[rtc_ipg_gate], NULL, "imx21-rtc");
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
-	clk_register_clkdev(clk[cpu_div], NULL, "cpufreq-cpu0.0");
+	clk_register_clkdev(clk[cpu_div], NULL, "cpu0");
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
 
 	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 1a56a33..de1964c 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -328,7 +328,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
-	clk_register_clkdev(clk[cpu_podf], NULL, "cpufreq-cpu0.0");
+	clk_register_clkdev(clk[cpu_podf], NULL, "cpu0");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.1");
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 8ea5ef6..5bd2e85 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -555,7 +555,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pll2h",			&pll2h_clk),
 
 	/* CPU clock */
-	CLKDEV_DEV_ID("cpufreq-cpu0",		&z_clk),
+	CLKDEV_DEV_ID("cpu0",			&z_clk),
 
 	/* DIV6 */
 	CLKDEV_CON_ID("zb",			&div6_clks[DIV6_ZB]),
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 1942eae..c92c023 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -616,7 +616,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("smp_twd", &twd_clk), /* smp_twd */
 
 	/* DIV4 clocks */
-	CLKDEV_DEV_ID("cpufreq-cpu0", &div4_clks[DIV4_Z]),
+	CLKDEV_DEV_ID("cpu0", &div4_clks[DIV4_Z]),
 
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
