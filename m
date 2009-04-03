Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 927FFDDDB2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 07:49:36 +1100 (EST)
Date: Fri, 3 Apr 2009 15:48:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] cpm_uart: Initialize port.dev before it's used.
Message-ID: <20090403204844.GA20017@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, this caused NULL to sometimes be passed as a device
to the DMA code.  With recent DMA changes, that now causes a BUG().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This is a regression triggered by DMA changes; please apply for 2.6.30.

 drivers/serial/cpm_uart/cpm_uart_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 5c6ef51..4dd00be 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1339,13 +1339,13 @@ static int __devinit cpm_uart_probe(struct of_device *ofdev,
 
 	dev_set_drvdata(&ofdev->dev, pinfo);
 
+	/* initialize the device pointer for the port */
+	pinfo->port.dev = &ofdev->dev;
+
 	ret = cpm_uart_init_port(ofdev->node, pinfo);
 	if (ret)
 		return ret;
 
-	/* initialize the device pointer for the port */
-	pinfo->port.dev = &ofdev->dev;
-
 	return uart_add_one_port(&cpm_reg, &pinfo->port);
 }
 
-- 
1.5.6.rc1.6.gc53ad.dirty
