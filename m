Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 42A18B6F87
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 16:01:06 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [RFC 3/4] [flexcan] Add of_match to platform_device definition.
Date: Tue,  9 Aug 2011 00:55:12 -0500
Message-Id: <1312869313-22434-4-git-send-email-holt@sgi.com>
In-Reply-To: <1312869313-22434-1-git-send-email-holt@sgi.com>
References: <1312869313-22434-1-git-send-email-holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	PPC list <linuxppc-dev@lists.ozlabs.org>, Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc, the OpenFirmware devices are not matched without specifying
an of_match array.  Introduce that array as that is used for matching
on the Freescale P1010 processor.

Signed-off-by: Robin Holt <holt@sgi.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
To: U Bhaskar-B22300 <B22300@freescale.com>
Cc: socketcan-core@lists.berlios.de
Cc: netdev@vger.kernel.org
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
---
 drivers/net/can/flexcan.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 68cbe52..662f832 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1027,8 +1027,19 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id flexcan_of_match[] = {
+	{
+		.compatible = "fsl,flexcan",
+	},
+	{},
+};
+
 static struct platform_driver flexcan_driver = {
-	.driver.name = DRV_NAME,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = flexcan_of_match,
+	},
 	.probe = flexcan_probe,
 	.remove = __devexit_p(flexcan_remove),
 };
-- 
1.7.2.1
