Return-Path: <josh@joshtriplett.org>
Received: from slow3-v.mail.gandi.net (slow3-v.mail.gandi.net [217.70.178.89])
	by ozlabs.org (Postfix) with ESMTP id 8BFEF1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 13:45:20 +1000 (EST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
	[217.70.183.195])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 973A437E9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 05:42:15 +0200 (CEST)
Date: Tue, 5 Jul 2011 20:41:40 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>,
	Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH] sm501: When registering the GPIO, turn on the GPIO unit's
	power
Message-ID: <20110706034138.GA8987@leaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: psas-avionics@lists.psas.pdx.edu, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When attempting to use GPIO via the sm501 unit on the TQM5200 board,
GPIO operations would only function if during the same boot u-boot's
"fkt led" command had initialized the sm501.  Comparing the sm501's
registers with and without running the "fkt led" command turned up one
significant difference: u-boot had enabled the GPIO power gate.
Changing the Linux sm501 driver to enable the GPIO power gate allows
GPIO to work without first initializing it with u-boot.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/mfd/sm501.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index df3702c..d7a0ab9 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1089,6 +1089,7 @@ static int __devinit sm501_register_gpio(struct sm501_devdata *sm)
 		goto err_low_chip;
 	}
 
+	sm501_unit_power(sm->dev, SM501_GATE_GPIO, 1);
 	gpio->registered = 1;
 
 	return 0;
@@ -1118,6 +1119,8 @@ static void sm501_gpio_remove(struct sm501_devdata *sm)
 	if (!sm->gpio.registered)
 		return;
 
+	sm501_unit_power(sm->dev, SM501_GATE_GPIO, 0);
+
 	ret = gpiochip_remove(&gpio->low.gpio);
 	if (ret)
 		dev_err(sm->dev, "cannot remove low chip, cannot tidy up\n");
-- 
1.7.5.4
