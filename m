Return-Path: <Dongsheng.Wang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04BCD2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:28:11 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <a.zummo@towertech.it>
Subject: [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup source
Date: Tue, 21 Jan 2014 13:24:51 +0800
Message-ID: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 rtc-linux@googlegroups.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Add suspend/resume and device_init_wakeup to enable ds3232 as
wakeup source, /sys/class/rtc/rtcX/wakealarm for set wakeup alarm.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b83bb5a5..a3c40d5 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -57,6 +57,7 @@ struct ds3232 {
 	 * in the remove function.
 	 */
 	struct mutex mutex;
+	bool suspended;
 	int exiting;
 };
 
@@ -345,7 +346,15 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 	struct ds3232 *ds3232 = i2c_get_clientdata(client);
 
 	disable_irq_nosync(irq);
-	schedule_work(&ds3232->work);
+
+	/*
+	 * If rtc as a wakeup source, can't schedule the work
+	 * at system resume flow, because at this time the i2c bus
+	 * has not been resumed.
+	 */
+	if (!ds3232->suspended)
+		schedule_work(&ds3232->work);
+
 	return IRQ_HANDLED;
 }
 
@@ -363,22 +372,26 @@ static void ds3232_work(struct work_struct *work)
 
 	if (stat & DS3232_REG_SR_A1F) {
 		control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-		if (control < 0)
-			goto out;
-		/* disable alarm1 interrupt */
-		control &= ~(DS3232_REG_CR_A1IE);
-		i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
-
-		/* clear the alarm pend flag */
-		stat &= ~DS3232_REG_SR_A1F;
-		i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
-
-		rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
+		if (control < 0) {
+			pr_warn("Read DS3232 Control Register error."
+				"Disable IRQ%d.\n", client->irq);
+		} else {
+			/* disable alarm1 interrupt */
+			control &= ~(DS3232_REG_CR_A1IE);
+			i2c_smbus_write_byte_data(client, DS3232_REG_CR,
+						control);
+
+			/* clear the alarm pend flag */
+			stat &= ~DS3232_REG_SR_A1F;
+			i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
+
+			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
+
+			if (!ds3232->exiting)
+				enable_irq(client->irq);
+		}
 	}
 
-out:
-	if (!ds3232->exiting)
-		enable_irq(client->irq);
 unlock:
 	mutex_unlock(&ds3232->mutex);
 }
@@ -411,23 +424,21 @@ static int ds3232_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
-					  &ds3232_rtc_ops, THIS_MODULE);
-	if (IS_ERR(ds3232->rtc)) {
-		dev_err(&client->dev, "unable to register the class device\n");
-		return PTR_ERR(ds3232->rtc);
-	}
-
-	if (client->irq >= 0) {
+	if (client->irq != NO_IRQ) {
 		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq, 0,
 				 "ds3232", client);
 		if (ret) {
 			dev_err(&client->dev, "unable to request IRQ\n");
 			return ret;
 		}
+
+		device_init_wakeup(&client->dev, 1);
+
 	}
 
-	return 0;
+	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
+					  &ds3232_rtc_ops, THIS_MODULE);
+	return PTR_ERR_OR_ZERO(ds3232->rtc);
 }
 
 static int ds3232_remove(struct i2c_client *client)
@@ -446,6 +457,42 @@ static int ds3232_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ds3232_suspend(struct device *dev)
+{
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_can_wakeup(dev)) {
+		ds3232->suspended = true;
+		irq_set_irq_wake(client->irq, 1);
+	}
+
+	return 0;
+}
+
+static int ds3232_resume(struct device *dev)
+{
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (ds3232->suspended) {
+		ds3232->suspended = false;
+
+		/* Clear the hardware alarm pend flag */
+		schedule_work(&ds3232->work);
+
+		irq_set_irq_wake(client->irq, 0);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops ds3232_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
+};
+
 static const struct i2c_device_id ds3232_id[] = {
 	{ "ds3232", 0 },
 	{ }
@@ -456,6 +503,7 @@ static struct i2c_driver ds3232_driver = {
 	.driver = {
 		.name = "rtc-ds3232",
 		.owner = THIS_MODULE,
+		.pm	= &ds3232_pm_ops,
 	},
 	.probe = ds3232_probe,
 	.remove = ds3232_remove,
-- 
1.8.5
