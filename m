Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B544DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 23:27:37 +1100 (EST)
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.8/8.13.8/Recconet-2008030801) with ESMTP id
	m9NCQONO023006
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 14:26:24 +0200
Received: from [172.16.135.104] (galileo.recco.de [172.16.135.104])
	(authenticated bits=0)
	by trinity.recco.de (8.13.8/8.13.8/Reccoware-2008101201) with ESMTP id
	m9NCRUhM024907
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 14:27:31 +0200
Subject: [PATCH] powerpc: Specify GPIO number base for controller in DT
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 23 Oct 2008 14:27:30 +0200
Message-Id: <1224764850.4082.54.camel@galileo.recco.de>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The GPIOLIB allows the specification of a base gpio number for a
controller. That is not possible using OF. Instead, free gpio numbers
are assigned.

In order to allow static, predefined gpio numbers, a base property in
the gpio controller node specifies the first gpio number.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.27-rc7/drivers/of/gpio.c.of_gpiospecbase	2008-09-22 00:29:55.000000000 +0200
+++ linux-2.6.27-rc7/drivers/of/gpio.c	2008-09-29 13:50:28.000000000 +0200
@@ -164,6 +164,8 @@
 	int ret = -ENOMEM;
 	struct of_gpio_chip *of_gc = &mm_gc->of_gc;
 	struct gpio_chip *gc = &of_gc->gc;
+	const int *basep;
+	int baselen;
 
 	gc->label = kstrdup(np->full_name, GFP_KERNEL);
 	if (!gc->label)
@@ -173,7 +175,11 @@
 	if (!mm_gc->regs)
 		goto err1;
 
-	gc->base = -1;
+	basep = of_get_property(np, "base", &baselen);
+	if (!basep || baselen != sizeof(*basep))
+		gc->base = -1;
+	else
+		gc->base = *basep;
 
 	if (!of_gc->xlate)
 		of_gc->xlate = of_gpio_simple_xlate;
--- linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt.spi_gpio_doc	2008-09-29 14:14:08.000000000 +0200
+++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	2008-09-29 14:24:26.000000000 +0200
@@ -2586,6 +2588,7 @@
 		#gpio-cells = <2>;
 		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
 		reg = <0x1400 0x18>;
+		base = < 0x20 >;
 		gpio-controller;
 	};
 
