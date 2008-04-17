Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 31D49DEE07
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:03:02 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: a.zummo@towertech.it
Subject: [PATCH] rtc-pcf8563: Add device ids table
Date: Thu, 17 Apr 2008 17:02:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804171702.59562.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

here's a patch against 2.6.25-rc8-mm2 that adds support for device tree names
to the rtc-pcf8563 driver.

Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled for
2.6.26 ?

--

This patch adds support for device tree names via the i2c mod alias mechanism
to the rtc-pcf8563 driver.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/rtc/rtc-pcf8563.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index a1e2f39..9667a3f 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -299,12 +299,20 @@ static int pcf8563_remove(struct i2c_client *client)
 	return 0;
 }
 
+static struct i2c_device_id pcf8563_id[] = {
+	{ "pcf8563", 0 },
+	{ "rtc8564", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, pcf8563_id);
+
 static struct i2c_driver pcf8563_driver = {
 	.driver		= {
 		.name	= "rtc-pcf8563",
 	},
 	.probe		= pcf8563_probe,
 	.remove		= pcf8563_remove,
+	.id_table	= pcf8563_id,
 };
 
 static int __init pcf8563_init(void)
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
