Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C12DDE0EE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:59 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l47ITtjB024254
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:55 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITspr017506
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:54 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I88BK022254
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:08 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id DF8A7AEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:53 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITrcu026958
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:53 -0500
Date: Mon, 7 May 2007 13:29:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/13] fsl_soc: Factor fsl_get_bus_freq() out of the wdt init.
Message-ID: <20070507182953.GH26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   44 ++++++++++++++++++++++------------------
 arch/powerpc/sysdev/fsl_soc.h |    1 +
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 8a123c7..3b99433 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -64,6 +64,27 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
+u32 fsl_get_bus_freq(void)
+{
+	struct device_node *soc = of_find_node_by_type(NULL, "soc");
+	const u32 *freq;
+	u32 ret = 0;
+
+	if (!soc)
+		goto err;
+
+	freq = of_get_property(soc, "bus-frequency", NULL);
+	if (!freq)
+		goto err;
+
+	ret = *freq;
+
+err:
+	of_node_put(soc);
+	return ret;
+}
+EXPORT_SYMBOL(fsl_get_bus_freq);
+
 #if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
 
 static u32 brgfreq = -1;
@@ -356,9 +377,9 @@ arch_initcall(fsl_i2c_of_init);
 static int __init mpc83xx_wdt_init(void)
 {
 	struct resource r;
-	struct device_node *soc, *np;
+	struct device_node *np;
 	struct platform_device *dev;
-	const unsigned int *freq;
+	u32 freq = fsl_get_bus_freq();
 	int ret;
 
 	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
@@ -368,19 +389,6 @@ static int __init mpc83xx_wdt_init(void)
 		goto nodev;
 	}
 
-	soc = of_find_node_by_type(NULL, "soc");
-
-	if (!soc) {
-		ret = -ENODEV;
-		goto nosoc;
-	}
-
-	freq = of_get_property(soc, "bus-frequency", NULL);
-	if (!freq) {
-		ret = -ENODEV;
-		goto err;
-	}
-
 	memset(&r, 0, sizeof(r));
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -393,20 +401,16 @@ static int __init mpc83xx_wdt_init(void)
 		goto err;
 	}
 
-	ret = platform_device_add_data(dev, freq, sizeof(int));
+	ret = platform_device_add_data(dev, &freq, sizeof(int));
 	if (ret)
 		goto unreg;
 
-	of_node_put(soc);
 	of_node_put(np);
-
 	return 0;
 
 unreg:
 	platform_device_unregister(dev);
 err:
-	of_node_put(soc);
-nosoc:
 	of_node_put(np);
 nodev:
 	return ret;
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..7a9502d 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -7,6 +7,7 @@
 extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
+extern u32 fsl_get_bus_freq(void);
 
 #endif
 #endif
-- 
1.5.0.3
