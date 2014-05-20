Return-Path: <f.fainelli@gmail.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95A311A092A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:57:34 +1000 (EST)
Received: by mail-yk0-f172.google.com with SMTP id 79so5178040ykr.31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 17:57:31 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 9/9] powerpc/fsl: fsl_soc: remove 'fixed-link'
 parsing code
Date: Mon, 19 May 2014 17:56:24 -0700
Message-Id: <1400547384-11363-10-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
References: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Grant Likely <grant.likely@linaro.org>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 davem@davemlof.net, Vitaly Bordug <vbordug@ru.mvista.com>,
 Kumar Gala <galak@codeaurora.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Parsing and registration of fixed PHY devices was needed with the use of
of_phy_connect_fixed_link() because this function was using the
designated PHY address identifier (first cell of the property) as the
address to bind the PHY on the emulated bus.

Since commit 3be2a49e5c08d268f8af0dd4fe89a24ea8cdc339 ("of: provide a
binding for fixed link PHYs") a new pair of functions has been
introduced which allows for dynamic address allocation of these fixed
PHY devices, but also parses the old 'fixed-link' 5-digit property.

Registration of fixed PHY early in platform code was needed because we
could not issue a fixed MDIO bus re-scan within network drivers. The
fixed PHYs had to be registered before the network drivers would call
of_phy_connect_fixed_link(). All of these caveats are solved now, such
that we can safely remove of_add_fixed_phys() now.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 228cf91b91c1..ffd1169ebaab 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -25,7 +25,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
-#include <linux/phy_fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
@@ -178,37 +177,6 @@ u32 get_baudrate(void)
 EXPORT_SYMBOL(get_baudrate);
 #endif /* CONFIG_CPM2 */
 
-#ifdef CONFIG_FIXED_PHY
-static int __init of_add_fixed_phys(void)
-{
-	int ret;
-	struct device_node *np;
-	u32 *fixed_link;
-	struct fixed_phy_status status = {};
-
-	for_each_node_by_name(np, "ethernet") {
-		fixed_link  = (u32 *)of_get_property(np, "fixed-link", NULL);
-		if (!fixed_link)
-			continue;
-
-		status.link = 1;
-		status.duplex = fixed_link[1];
-		status.speed = fixed_link[2];
-		status.pause = fixed_link[3];
-		status.asym_pause = fixed_link[4];
-
-		ret = fixed_phy_add(PHY_POLL, fixed_link[0], &status);
-		if (ret) {
-			of_node_put(np);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-arch_initcall(of_add_fixed_phys);
-#endif /* CONFIG_FIXED_PHY */
-
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
 
-- 
1.9.1
