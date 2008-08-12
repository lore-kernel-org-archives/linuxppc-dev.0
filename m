Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4A3A6DE67C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 02:17:36 +1000 (EST)
Date: Tue, 12 Aug 2008 20:17:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] rtc: rtc-ds1374: fix 'no irq' case handling
Message-ID: <20080812161733.GA32164@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On a PowerPC board with ds1374 RTC I'm getting this error while
RTC tries to probe:

rtc-ds1374 0-0068: unable to request IRQ

This happens because I2C probing code (drivers/of/of_i2c.c) is
specifying IRQ0 for 'no irq' case, which is correct.

The driver handles this incorrectly, though. This patch fixes it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/rtc/rtc-ds1374.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 640acd2..a150418 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -173,7 +173,7 @@ static int ds1374_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int cr, sr;
 	int ret = 0;
 
-	if (client->irq < 0)
+	if (client->irq <= 0)
 		return -EINVAL;
 
 	mutex_lock(&ds1374->mutex);
@@ -212,7 +212,7 @@ static int ds1374_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int cr;
 	int ret = 0;
 
-	if (client->irq < 0)
+	if (client->irq <= 0)
 		return -EINVAL;
 
 	ret = ds1374_read_time(dev, &now);
@@ -381,7 +381,7 @@ static int ds1374_probe(struct i2c_client *client,
 	if (ret)
 		goto out_free;
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = request_irq(client->irq, ds1374_irq, 0,
 		                  "ds1374", client);
 		if (ret) {
@@ -401,7 +401,7 @@ static int ds1374_probe(struct i2c_client *client,
 	return 0;
 
 out_irq:
-	if (client->irq >= 0)
+	if (client->irq > 0)
 		free_irq(client->irq, client);
 
 out_free:
@@ -414,7 +414,7 @@ static int __devexit ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		mutex_lock(&ds1374->mutex);
 		ds1374->exiting = 1;
 		mutex_unlock(&ds1374->mutex);
-- 
1.5.6.3
