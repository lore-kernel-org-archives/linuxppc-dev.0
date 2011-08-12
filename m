Return-Path: <holt@sgi.com>
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v12 4/6] flexcan: Add of_match to platform_device definition.
Date: Fri, 12 Aug 2011 03:45:50 -0500
Message-Id: <1313138752-24006-5-git-send-email-holt@sgi.com>
In-Reply-To: <1313138752-24006-1-git-send-email-holt@sgi.com>
References: <1313138752-24006-1-git-send-email-holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
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
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Cc: U Bhaskar-B22300 <B22300@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: socketcan-core@lists.berlios.de
Cc: netdev@vger.kernel.org
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
Cc: devicetree-discuss@lists.ozlabs.org
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
