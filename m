Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id F31BD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 23:18:02 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 11 Apr 2005 15:17:50 +0200
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
	<1112808669.24673.304.camel@rhino.az.mvista.com>
In-Reply-To: <1112808669.24673.304.camel@rhino.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200504111517.50881.g.jaeger@sysgo.com>
Subject: Re: [PATCH 1/3] PPC440EP: IBM EMAC support for the Bamboo board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 06 April 2005 19:31, Wade Farnsworth wrote:
> This adds support for the Bamboo board in the EMAC driver.
> 
> Jason McMullan pointed out to me that for the Bamboo Rev. 0 to boot from
> ethernet, the ANEG pin on SW2 needs to be turned off.  If we use this,
> we can avoid using the PVR to determine which board rev, we're running
> on.  This patch addresses this.
> 
> Comments would be appreciated.
> 
> -Wade Farnsworth
> 
> Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>
> 
Hi Wade,

reading your patch, I think there's a small bug! Please see my patch
below. First part is for fixing a nasty warning and the second addresses
the mentioned bug.

Cheers,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

--- linux/drivers/net/ibm_emac/ibm_emac_phy.c.orig	2005-04-11 15:02:43.000000000 +0200
+++ linux/drivers/net/ibm_emac/ibm_emac_phy.c	2005-04-11 15:01:44.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/ethtool.h>
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
+#include <asm/io.h>
 
 #include "ibm_emac_phy.h"
 
@@ -90,7 +91,7 @@ static int ac104_init(struct mii_phy *ph
 	u8 *config2_addr, config2_val;
 	config2_addr = ioremap64(BAMBOO_FPGA_CONFIG2_REG_ADDR, 0x8);
 	config2_val = * config2_addr;
-	iounmap(*config2_addr);
+	iounmap(config2_addr);
 	if (BAMBOO_AUTONEGOTIATE(config2_val))
 		return 0;
 	phy->def->features = SUPPORTED_TP | SUPPORTED_MII;
