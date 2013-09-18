Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8A872C01B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 23:27:08 +1000 (EST)
Received: by mail-bk0-f49.google.com with SMTP id r7so2754551bkg.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 06:26:34 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 10/10] gpio: tegra: Use module_platform_driver()
Date: Wed, 18 Sep 2013 15:24:52 +0200
Message-Id: <1379510692-32435-11-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the driver core now resolving interrupt references at probe time,
it is no longer necessary to force explicit probe ordering using
initcalls.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that there are potentially many more drivers that can be switched
to the generic module_*_driver() interfaces now that interrupts can be
resolved later and deferred probe should be able to handle all the
ordering issues.

 drivers/gpio/gpio-tegra.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 9a62672..766e6ef 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -513,12 +513,7 @@ static struct platform_driver tegra_gpio_driver = {
 	},
 	.probe		= tegra_gpio_probe,
 };
-
-static int __init tegra_gpio_init(void)
-{
-	return platform_driver_register(&tegra_gpio_driver);
-}
-postcore_initcall(tegra_gpio_init);
+module_platform_driver(tegra_gpio_driver);
 
 #ifdef	CONFIG_DEBUG_FS
 
-- 
1.8.4
