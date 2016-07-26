Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz4t36BKGzDqdj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:30:19 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so12589169pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:30:19 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: e8248e: Select PHYLIB only if NETDEVICES is
 enabled
Date: Mon, 25 Jul 2016 21:30:10 -0700
Message-Id: <1469507410-6112-2-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1469507410-6112-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469507410-6112-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Select PHYLIB only if NETDEVICES is enabled and MDIO_BITBANG only if
PHYLIB is present to avoid warnings from Kconfig.

To prevent undefined references during linking register MDIO driver only
if CONFIG_MDIO_BITBANG is enabled.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/powerpc/platforms/82xx/Kconfig   | 4 ++--
 arch/powerpc/platforms/82xx/ep8248e.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 7c7df400..994d1a9 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -30,8 +30,8 @@ config EP8248E
 	select 8272
 	select 8260
 	select FSL_SOC
-	select PHYLIB
-	select MDIO_BITBANG
+	select PHYLIB if NETDEVICES
+	select MDIO_BITBANG if PHYLIB
 	help
 	  This enables support for the Embedded Planet EP8248E board.
 
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index cdab847..8fec050 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -298,7 +298,9 @@ static const struct of_device_id of_bus_ids[] __initconst = {
 static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-	platform_driver_register(&ep8248e_mdio_driver);
+
+	if (IS_ENABLED(CONFIG_MDIO_BITBANG))
+		platform_driver_register(&ep8248e_mdio_driver);
 
 	return 0;
 }
-- 
2.5.5
