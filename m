Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 84060DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 20:54:46 +1000 (EST)
Message-ID: <48904863.7050902@scram.de>
Date: Wed, 30 Jul 2008 12:54:27 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: I2C node in device tree breaks old-style drivers
References: <488F72C8.8010909@freescale.com>
In-Reply-To: <488F72C8.8010909@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur,

> So my conclusion is that specifying an I2C node in the device tree *requires*
> that the driver be new-style.  Is there any way we can fix this?  I'm not going
> to have time to update the CS4270 driver to a new-style interface before the
> 2.6.27 window closes.

This conclusion is correct. One possible way to fix this is to add support for
blacklisting to drivers/of/base.c (untested):

[RFC] of: Support blacklisting and blacklist cs4270.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/of/base.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..8c53b2c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -404,13 +404,16 @@ EXPORT_SYMBOL(of_find_matching_node);
  * assumed that the data size is small and that the compatible values
  * should already be distinct enough to differentiate between SPI, I2C
  * and other devices.
+ *
+ * Blacklisting devices is supported by using NULL as modalias.
  */
 struct of_modalias_table {
 	char *of_device;
 	char *modalias;
 };
 static struct of_modalias_table of_modalias_table[] = {
-	/* Empty for now; add entries as needed */
+	/* Blacklisting cs4270 as this driver is currently old-style. */
+	{ "cirrus,cs4270",	NULL }
 };

 /**
@@ -441,6 +444,9 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 		compatible = of_modalias_table[i].of_device;
 		if (!of_device_is_compatible(node, compatible))
 			continue;
+		/* Check for blacklisting */
+		if (!of_modalias_table[i].modalias)
+			return -ENODEV;
 		strlcpy(modalias, of_modalias_table[i].modalias, len);
 		return 0;
 	}
-- 
1.5.6.3
