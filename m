Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6454E2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:03:01 +1000 (EST)
Message-ID: <1375477360.15999.19.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Sat, 03 Aug 2013 07:02:40 +1000
In-Reply-To: <1375462346.3852.42.camel@thor.local>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
 <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
 <1375462346.3852.42.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Jan Engelhardt <jengelh@inai.de>, Ben Hutchings <ben@decadent.org.uk>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 18:52 +0200, Michel Dänzer wrote:

> Thanks for the suggestion. The same windfarm modules were loaded in both
> cases, but i2c_powermac wasn't loaded with the newer kernels. Loading it
> manually fixes the problem.
> 
> How is i2c_powermac supposed to get loaded with current kernels?

It's a platform driver, but it's missing a module device-table

Can you try this completely untested patch ?

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 8dc90da..5af5153 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -458,9 +458,15 @@ static int i2c_powermac_probe(struct platform_device *dev)
 	return rc;
 }
 
+static const struct platform_device_id i2c_powermac_id = {
+	.name = "i2c-powermac"
+};
+MODULE_DEVICE_TABLE(platform, i2c_powermac_id);
+
 static struct platform_driver i2c_powermac_driver = {
 	.probe = i2c_powermac_probe,
 	.remove = i2c_powermac_remove,
+	.id_table = *i2c_powermac_id,
 	.driver = {
 		.name = "i2c-powermac",
 		.bus = &platform_bus_type,
@@ -468,5 +474,3 @@ static struct platform_driver i2c_powermac_driver = {
 };
 
 module_platform_driver(i2c_powermac_driver);
-
-MODULE_ALIAS("platform:i2c-powermac");
