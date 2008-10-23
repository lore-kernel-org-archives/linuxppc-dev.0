Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 906FDDDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 01:30:20 +1100 (EST)
Subject: [PATCH v2] powerpc: Specify GPIO number base for controller in DT
From: Wolfgang Ocker <weo@reccoware.de>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
References: <1224764850.4082.54.camel@galileo.recco.de>
	<5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 16:30:09 +0200
Message-Id: <1224772209.4082.61.camel@galileo.recco.de>
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

The GPIOLIB allows the specification of a base gpio number for a
controller. That is not possible using OF. Instead, free gpio numbers
are assigned.

In order to allow static, predefined gpio numbers, a base property in
the gpio controller node specifies the first gpio number.

v2: added description of base property in doc 

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.27.2/drivers/of/gpio.c.of_gpiospecbase	2008-10-18 19:57:22.000000000 +0200
+++ linux-2.6.27.2/drivers/of/gpio.c	2008-10-23 10:55:19.000000000 +0200
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
--- linux-2.6.27.2/Documentation/powerpc/booting-without-of.txt.of_gpiospecbase	2008-10-18 19:57:22.000000000 +0200
+++ linux-2.6.27.2/Documentation/powerpc/booting-without-of.txt	2008-10-23 16:23:07.000000000 +0200
@@ -2580,12 +2582,17 @@
 Every GPIO controller node must have #gpio-cells property defined,
 this information will be used to translate gpio-specifiers.
 
+Optional properties:
+	base: first GPIO number handled by this controller; default is -1,
+		meaning dynamic ID allocation
+
 Example of two SOC GPIO banks defined as gpio-controller nodes:
 
 	qe_pio_a: gpio-controller@1400 {
 		#gpio-cells = <2>;
 		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
 		reg = <0x1400 0x18>;
+		base = < 0x20 >;
 		gpio-controller;
 	};
 
