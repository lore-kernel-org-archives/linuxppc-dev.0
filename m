Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ED49DE196
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:36:57 +1000 (EST)
Subject: [PATCH 1/2 v2] sysdev,mv64x60: I2C defaults
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 10:36:48 -0700
Message-Id: <1208799408.5789.52.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I2C parameters freq_m and freq_n are assigned default in the code
but if those properties are not found in the open firmware description 
the init returns an error => the code now uses the default
values if the properties are not found.

Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
---
This is the first part of the re-submission of my patch of 4/17/2008
titled "[PATCH] sysdev,mv64x60: initialization of mv64x60 ethernet, 
serial and I2C"

--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -338,15 +338,13 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 
 	pdata.freq_m = 8;	/* default */
 	prop = of_get_property(np, "freq_m", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.freq_m = *prop;
+	if (prop)
+		pdata.freq_m = *prop;
 
 	pdata.freq_m = 3;	/* default */
 	prop = of_get_property(np, "freq_n", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.freq_n = *prop;
+	if (prop)
+		pdata.freq_n = *prop;
 
 	pdata.timeout = 1000;				/* default: 1 second */
 
