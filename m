Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D56BB7D6B
	for <linuxppc-dev@ozlabs.org>; Mon, 31 May 2010 22:57:16 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH] drivers: remove all i2c_set_clientdata(client, NULL)
Date: Mon, 31 May 2010 14:55:48 +0200
Message-Id: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	devel@driverdev.osuosl.org, Samuel Ortiz <sameo@linux.intel.com>,
	lm-sensors@lm-sensors.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, Paul Gortmaker <p_gortmaker@yahoo.com>,
	Riku Voipio <riku.voipio@iki.fi>, rtc-linux@googlegroups.com,
	Alessandro Rubini <rubini@ipvvis.unipv.it>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Jean Delvare <khali@linux-fr.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Guillaume Ligneul <guillaume.ligneul@gmail.com>,
	George Joseph <george.joseph@fairview5.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Richard Purdie <rpurdie@rpsys.net>, Colin Leroy <colin@colino.net>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I2C-drivers can use the clientdata-pointer to point to private data. As I2C
devices are not really unregistered, but merely detached from their driver, it
used to be the drivers obligation to clear this pointer during remove() or a
failed probe(). As a couple of drivers forgot to do this, it was agreed that it
was cleaner if the i2c-core does this clearance when appropriate, as there is
no guarantee for the lifetime of the clientdata-pointer after remove() anyhow.
This feature was added to the core with commit
e4a7b9b04de15f6b63da5ccdd373ffa3057a3681 to fix the faulty drivers.

As there is no need anymore to clear the clientdata-pointer, remove all current
occurrences in the drivers to simplify the code and prevent confusion.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jean Delvare <khali@linux-fr.org>
---

Some more notes:

I waited for rc1 as I knew there were some drivers/patches coming along which
needed to be processed, too.

I'd suggest that this goes via the i2c-tree, so we get rid of all occurences at
once.

I used get_maintainers with --no-git, otherwise the cc-list would have gotten
too excessive IMHO. I think the number of included mailing-lists will do.

The removal was done using coccinelle and reviewed manually.

 drivers/hwmon/adt7411.c                       |    2 --
 drivers/hwmon/asc7621.c                       |    2 --
 drivers/hwmon/f75375s.c                       |    2 --
 drivers/hwmon/g760a.c                         |    2 --
 drivers/hwmon/lm73.c                          |    1 -
 drivers/hwmon/lm75.c                          |    2 --
 drivers/hwmon/lm95241.c                       |    1 -
 drivers/hwmon/tmp102.c                        |    2 --
 drivers/hwmon/tmp421.c                        |    2 --
 drivers/hwmon/w83781d.c                       |    2 --
 drivers/i2c/i2c-smbus.c                       |    1 -
 drivers/input/keyboard/adp5588-keys.c         |    1 -
 drivers/input/keyboard/lm8323.c               |    2 --
 drivers/input/keyboard/max7359_keypad.c       |    1 -
 drivers/input/keyboard/qt2160.c               |    1 -
 drivers/input/keyboard/tca6416-keypad.c       |    2 --
 drivers/input/misc/ad714x-i2c.c               |    1 -
 drivers/input/misc/pcf8574_keypad.c           |    2 --
 drivers/input/mouse/synaptics_i2c.c           |    1 -
 drivers/input/touchscreen/ad7879.c            |    5 +----
 drivers/input/touchscreen/eeti_ts.c           |    2 --
 drivers/input/touchscreen/mcs5000_ts.c        |    1 -
 drivers/input/touchscreen/tsc2007.c           |    2 --
 drivers/leds/leds-bd2802.c                    |    2 --
 drivers/leds/leds-lp3944.c                    |    1 -
 drivers/leds/leds-pca9532.c                   |    5 +----
 drivers/leds/leds-pca955x.c                   |    2 --
 drivers/macintosh/therm_adt746x.c             |    2 --
 drivers/macintosh/windfarm_lm75_sensor.c      |    5 +----
 drivers/macintosh/windfarm_max6690_sensor.c   |    1 -
 drivers/macintosh/windfarm_smu_sat.c          |    1 -
 drivers/media/radio/si470x/radio-si470x-i2c.c |    1 -
 drivers/media/video/mt9m001.c                 |    2 --
 drivers/media/video/mt9m111.c                 |    2 --
 drivers/media/video/mt9t031.c                 |    2 --
 drivers/media/video/mt9t112.c                 |    2 --
 drivers/media/video/mt9v022.c                 |    2 --
 drivers/media/video/ov772x.c                  |    2 --
 drivers/media/video/ov9640.c                  |    2 --
 drivers/media/video/rj54n1cb0c.c              |    2 --
 drivers/media/video/tcm825x.c                 |    8 +-------
 drivers/media/video/tw9910.c                  |    2 --
 drivers/mfd/88pm860x-i2c.c                    |    2 --
 drivers/mfd/ab3100-core.c                     |    2 --
 drivers/mfd/ab3550-core.c                     |    1 -
 drivers/mfd/adp5520.c                         |    2 --
 drivers/mfd/da903x.c                          |    2 --
 drivers/mfd/max8925-i2c.c                     |    1 -
 drivers/mfd/menelaus.c                        |    2 --
 drivers/mfd/pcf50633-core.c                   |    2 --
 drivers/mfd/tc35892.c                         |    2 --
 drivers/mfd/tps65010.c                        |    1 -
 drivers/mfd/wm8350-i2c.c                      |    2 --
 drivers/mfd/wm8400-core.c                     |    2 --
 drivers/misc/eeprom/at24.c                    |    1 -
 drivers/mtd/maps/pismo.c                      |    2 --
 drivers/power/max17040_battery.c              |    2 --
 drivers/regulator/lp3971.c                    |    2 --
 drivers/regulator/max1586.c                   |    1 -
 drivers/regulator/max8649.c                   |    2 --
 drivers/regulator/max8660.c                   |    1 -
 drivers/regulator/tps65023-regulator.c        |    3 ---
 drivers/rtc/rtc-ds1374.c                      |    2 --
 drivers/rtc/rtc-rx8025.c                      |    2 --
 drivers/rtc/rtc-s35390a.c                     |    2 --
 drivers/staging/dream/synaptics_i2c_rmi.c     |    2 --
 drivers/staging/go7007/wis-saa7113.c          |    2 --
 drivers/staging/go7007/wis-saa7115.c          |    2 --
 drivers/staging/go7007/wis-sony-tuner.c       |    1 -
 drivers/staging/go7007/wis-tw2804.c           |    1 -
 drivers/staging/go7007/wis-tw9903.c           |    2 --
 drivers/staging/iio/adc/max1363_core.c        |    2 --
 drivers/staging/iio/light/tsl2563.c           |    2 --
 drivers/video/backlight/adp8860_bl.c          |    2 --
 drivers/video/backlight/tosa_bl.c             |    2 --
 75 files changed, 4 insertions(+), 141 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 4086c72..f13c843 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -316,7 +316,6 @@ static int __devinit adt7411_probe(struct i2c_client *client,
  exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
  exit_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return ret;
 }
@@ -327,7 +326,6 @@ static int __devexit adt7411_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 0f388ad..3b973f3 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -1141,7 +1141,6 @@ exit_remove:
 				   &(asc7621_params[i].sda.dev_attr));
 	}
 
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return err;
 }
@@ -1196,7 +1195,6 @@ static int asc7621_remove(struct i2c_client *client)
 				   &(asc7621_params[i].sda.dev_attr));
 	}
 
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index bad2cf3..0f58ecc 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -662,7 +662,6 @@ exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &f75375_group);
 exit_free:
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 	return err;
 }
 
@@ -672,7 +671,6 @@ static int f75375_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &f75375_group);
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 09ea12e..1f63d1a 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -236,7 +236,6 @@ error_hwmon_device_register:
 	sysfs_remove_group(&client->dev.kobj, &g760a_group);
 error_sysfs_create_group:
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 
 	return err;
 }
@@ -247,7 +246,6 @@ static int g760a_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &g760a_group);
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 4d1b76b..29b9030 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -136,7 +136,6 @@ static int lm73_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm73_group);
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5646342..393f354 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -192,7 +192,6 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 exit_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return status;
 }
@@ -204,7 +203,6 @@ static int lm75_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 8fc8eb8..94741d4 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -399,7 +399,6 @@ static int lm95241_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm95241_group);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 8013895..93187c3 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -224,7 +224,6 @@ fail_remove_sysfs:
 fail_restore_config:
 	tmp102_write_reg(client, TMP102_CONF_REG, tmp102->config_orig);
 fail_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(tmp102);
 
 	return status;
@@ -247,7 +246,6 @@ static int __devexit tmp102_remove(struct i2c_client *client)
 					 config | TMP102_CONF_SD);
 	}
 
-	i2c_set_clientdata(client, NULL);
 	kfree(tmp102);
 
 	return 0;
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 738c472..6b4165c 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -295,7 +295,6 @@ exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
 
 exit_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return err;
@@ -308,7 +307,6 @@ static int tmp421_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return 0;
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 32d4ade..c84b9b4 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1197,7 +1197,6 @@ ERROR4:
 	if (data->lm75[1])
 		i2c_unregister_device(data->lm75[1]);
 ERROR3:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 ERROR1:
 	return err;
@@ -1219,7 +1218,6 @@ w83781d_remove(struct i2c_client *client)
 	if (data->lm75[1])
 		i2c_unregister_device(data->lm75[1]);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return 0;
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index a24e0bf..f61ccc1 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -173,7 +173,6 @@ static int smbalert_remove(struct i2c_client *ara)
 
 	cancel_work_sync(&alert->alert);
 
-	i2c_set_clientdata(ara, NULL);
 	kfree(alert);
 	return 0;
 }
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 4771ab1..744600e 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -287,7 +287,6 @@ static int __devexit adp5588_remove(struct i2c_client *client)
 	free_irq(client->irq, kpad);
 	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
-	i2c_set_clientdata(client, NULL);
 	kfree(kpad);
 
 	return 0;
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index bc69693..40b032f 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -778,8 +778,6 @@ static int __devexit lm8323_remove(struct i2c_client *client)
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
 
-	i2c_set_clientdata(client, NULL);
-
 	disable_irq_wake(client->irq);
 	free_irq(client->irq, lm);
 	cancel_work_sync(&lm->work);
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 7fc8185..9091ff5 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -265,7 +265,6 @@ static int __devexit max7359_remove(struct i2c_client *client)
 
 	free_irq(client->irq, keypad);
 	input_unregister_device(keypad->input_dev);
-	i2c_set_clientdata(client, NULL);
 	kfree(keypad);
 
 	return 0;
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 31f3008..fac6951 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -358,7 +358,6 @@ static int __devexit qt2160_remove(struct i2c_client *client)
 	input_unregister_device(qt2160->input);
 	kfree(qt2160);
 
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 493c93f..00137be 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -316,8 +316,6 @@ static int __devexit tca6416_keypad_remove(struct i2c_client *client)
 	input_unregister_device(chip->input);
 	kfree(chip);
 
-	i2c_set_clientdata(client, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index e9adbe4..2bef8fa 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -97,7 +97,6 @@ static int __devexit ad714x_i2c_remove(struct i2c_client *client)
 	struct ad714x_chip *chip = i2c_get_clientdata(client);
 
 	ad714x_remove(chip);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 5c3ac4e..0ac47d2 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -168,8 +168,6 @@ static int __devexit pcf8574_kp_remove(struct i2c_client *client)
 	input_unregister_device(lp->idev);
 	kfree(lp);
 
-	i2c_set_clientdata(client, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 8291e73..0ae62f0 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -613,7 +613,6 @@ static int __devexit synaptics_i2c_remove(struct i2c_client *client)
 		free_irq(client->irq, touch);
 
 	input_unregister_device(touch->input);
-	i2c_set_clientdata(client, NULL);
 	kfree(touch);
 
 	return 0;
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 794d070..4b32fb4 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -812,10 +812,8 @@ static int __devinit ad7879_probe(struct i2c_client *client,
 	ts->bus = client;
 
 	error = ad7879_construct(client, ts);
-	if (error) {
-		i2c_set_clientdata(client, NULL);
+	if (error)
 		kfree(ts);
-	}
 
 	return error;
 }
@@ -825,7 +823,6 @@ static int __devexit ad7879_remove(struct i2c_client *client)
 	struct ad7879 *ts = dev_get_drvdata(&client->dev);
 
 	ad7879_destroy(client, ts);
-	i2c_set_clientdata(client, NULL);
 	kfree(ts);
 
 	return 0;
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 75f8b73..7a3a916 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -238,7 +238,6 @@ err2:
 	input = NULL; /* so we dont try to free it below */
 err1:
 	input_free_device(input);
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 err0:
 	return err;
@@ -256,7 +255,6 @@ static int __devexit eeti_ts_remove(struct i2c_client *client)
 	enable_irq(priv->irq);
 
 	input_unregister_device(priv->input);
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index ce8ab02..1fb0c2f 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -256,7 +256,6 @@ static int __devexit mcs5000_ts_remove(struct i2c_client *client)
 	free_irq(client->irq, data);
 	input_unregister_device(data->input_dev);
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 769b479..be23780 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -347,8 +347,6 @@ static int __devexit tsc2007_remove(struct i2c_client *client)
 	struct tsc2007	*ts = i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata = client->dev.platform_data;
 
-	i2c_set_clientdata(client, NULL);
-
 	tsc2007_free_irq(ts);
 
 	if (pdata->exit_platform_hw)
diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index 286b501..5dcdf9d 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -742,7 +742,6 @@ failed_unregister_dev_file:
 	for (i--; i >= 0; i--)
 		device_remove_file(&led->client->dev, bd2802_attributes[i]);
 failed_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(led);
 
 	return ret;
@@ -759,7 +758,6 @@ static int __exit bd2802_remove(struct i2c_client *client)
 		bd2802_disable_adv_conf(led);
 	for (i = 0; i < ARRAY_SIZE(bd2802_attributes); i++)
 		device_remove_file(&led->client->dev, bd2802_attributes[i]);
-	i2c_set_clientdata(client, NULL);
 	kfree(led);
 
 	return 0;
diff --git a/drivers/leds/leds-lp3944.c b/drivers/leds/leds-lp3944.c
index 932a58d..9010c05 100644
--- a/drivers/leds/leds-lp3944.c
+++ b/drivers/leds/leds-lp3944.c
@@ -432,7 +432,6 @@ static int __devexit lp3944_remove(struct i2c_client *client)
 		}
 
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 6682175..43d0875 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -320,10 +320,8 @@ static int pca9532_probe(struct i2c_client *client,
 	mutex_init(&data->update_lock);
 
 	err = pca9532_configure(client, data, pca9532_pdata);
-	if (err) {
+	if (err)
 		kfree(data);
-		i2c_set_clientdata(client, NULL);
-	}
 
 	return err;
 }
@@ -351,7 +349,6 @@ static int pca9532_remove(struct i2c_client *client)
 		}
 
 	kfree(data);
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 8ff50f2..66aa3e8 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -342,7 +342,6 @@ exit:
 	}
 
 	kfree(pca955x);
-	i2c_set_clientdata(client, NULL);
 
 	return err;
 }
@@ -358,7 +357,6 @@ static int __devexit pca955x_remove(struct i2c_client *client)
 	}
 
 	kfree(pca955x);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 16d82f1..c42eeb4 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -182,7 +182,6 @@ remove_thermostat(struct i2c_client *client)
 
 	thermostat = NULL;
 
-	i2c_set_clientdata(client, NULL);
 	kfree(th);
 
 	return 0;
@@ -400,7 +399,6 @@ static int probe_thermostat(struct i2c_client *client,
 	rc = read_reg(th, CONFIG_REG);
 	if (rc < 0) {
 		dev_err(&client->dev, "Thermostat failed to read config!\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(th);
 		return -ENODEV;
 	}
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index d8257d3..647c6ad 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -107,10 +107,8 @@ static int wf_lm75_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, lm);
 
 	rc = wf_register_sensor(&lm->sens);
-	if (rc) {
-		i2c_set_clientdata(client, NULL);
+	if (rc)
 		kfree(lm);
-	}
 
 	return rc;
 }
@@ -216,7 +214,6 @@ static int wf_lm75_remove(struct i2c_client *client)
 	/* release sensor */
 	wf_unregister_sensor(&lm->sens);
 
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index b486eb9..8204113 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -81,7 +81,6 @@ static int wf_max6690_probe(struct i2c_client *client,
 
 	rc = wf_register_sensor(&max->sens);
 	if (rc) {
-		i2c_set_clientdata(client, NULL);
 		kfree(max);
 	}
 
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index e20330a..65a8ff3 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -376,7 +376,6 @@ static int wf_sat_remove(struct i2c_client *client)
 	/* XXX TODO */
 
 	sat->i2c = NULL;
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index a5844d0..67a4ec8 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -482,7 +482,6 @@ static __devexit int si470x_i2c_remove(struct i2c_client *client)
 	cancel_work_sync(&radio->radio_work);
 	video_unregister_device(radio->videodev);
 	kfree(radio);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/media/video/mt9m001.c b/drivers/media/video/mt9m001.c
index b62c0bd..e3b9a8a 100644
--- a/drivers/media/video/mt9m001.c
+++ b/drivers/media/video/mt9m001.c
@@ -785,7 +785,6 @@ static int mt9m001_probe(struct i2c_client *client,
 	ret = mt9m001_video_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(mt9m001);
 	}
 
@@ -799,7 +798,6 @@ static int mt9m001_remove(struct i2c_client *client)
 
 	icd->ops = NULL;
 	mt9m001_video_remove(icd);
-	i2c_set_clientdata(client, NULL);
 	client->driver = NULL;
 	kfree(mt9m001);
 
diff --git a/drivers/media/video/mt9m111.c b/drivers/media/video/mt9m111.c
index d35f536..e42162c 100644
--- a/drivers/media/video/mt9m111.c
+++ b/drivers/media/video/mt9m111.c
@@ -1068,7 +1068,6 @@ static int mt9m111_probe(struct i2c_client *client,
 	ret = mt9m111_video_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(mt9m111);
 	}
 
@@ -1081,7 +1080,6 @@ static int mt9m111_remove(struct i2c_client *client)
 	struct soc_camera_device *icd = client->dev.platform_data;
 
 	icd->ops = NULL;
-	i2c_set_clientdata(client, NULL);
 	client->driver = NULL;
 	kfree(mt9m111);
 
diff --git a/drivers/media/video/mt9t031.c b/drivers/media/video/mt9t031.c
index 78b4e09..9f5ff25 100644
--- a/drivers/media/video/mt9t031.c
+++ b/drivers/media/video/mt9t031.c
@@ -883,7 +883,6 @@ static int mt9t031_probe(struct i2c_client *client,
 	if (ret) {
 		if (icd)
 			icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(mt9t031);
 	}
 
@@ -897,7 +896,6 @@ static int mt9t031_remove(struct i2c_client *client)
 
 	if (icd)
 		icd->ops = NULL;
-	i2c_set_clientdata(client, NULL);
 	client->driver = NULL;
 	kfree(mt9t031);
 
diff --git a/drivers/media/video/mt9t112.c b/drivers/media/video/mt9t112.c
index 7438f8d..aa4fce9 100644
--- a/drivers/media/video/mt9t112.c
+++ b/drivers/media/video/mt9t112.c
@@ -1119,7 +1119,6 @@ static int mt9t112_probe(struct i2c_client *client,
 	ret = mt9t112_camera_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(priv);
 	}
 
@@ -1132,7 +1131,6 @@ static int mt9t112_remove(struct i2c_client *client)
 	struct soc_camera_device *icd = client->dev.platform_data;
 
 	icd->ops = NULL;
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 	return 0;
 }
diff --git a/drivers/media/video/mt9v022.c b/drivers/media/video/mt9v022.c
index e5bae4c..fb44ff0 100644
--- a/drivers/media/video/mt9v022.c
+++ b/drivers/media/video/mt9v022.c
@@ -920,7 +920,6 @@ static int mt9v022_probe(struct i2c_client *client,
 	ret = mt9v022_video_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(mt9v022);
 	}
 
@@ -934,7 +933,6 @@ static int mt9v022_remove(struct i2c_client *client)
 
 	icd->ops = NULL;
 	mt9v022_video_remove(icd);
-	i2c_set_clientdata(client, NULL);
 	client->driver = NULL;
 	kfree(mt9v022);
 
diff --git a/drivers/media/video/ov772x.c b/drivers/media/video/ov772x.c
index 7f8ece3..c33acc9 100644
--- a/drivers/media/video/ov772x.c
+++ b/drivers/media/video/ov772x.c
@@ -1159,7 +1159,6 @@ static int ov772x_probe(struct i2c_client *client,
 	ret = ov772x_video_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(priv);
 	}
 
@@ -1172,7 +1171,6 @@ static int ov772x_remove(struct i2c_client *client)
 	struct soc_camera_device *icd = client->dev.platform_data;
 
 	icd->ops = NULL;
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 	return 0;
 }
diff --git a/drivers/media/video/ov9640.c b/drivers/media/video/ov9640.c
index 36599a6..035e9ec 100644
--- a/drivers/media/video/ov9640.c
+++ b/drivers/media/video/ov9640.c
@@ -783,7 +783,6 @@ static int ov9640_probe(struct i2c_client *client,
 
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(priv);
 	}
 
@@ -794,7 +793,6 @@ static int ov9640_remove(struct i2c_client *client)
 {
 	struct ov9640_priv *priv = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 	return 0;
 }
diff --git a/drivers/media/video/rj54n1cb0c.c b/drivers/media/video/rj54n1cb0c.c
index bbd9c11..2c3b58c 100644
--- a/drivers/media/video/rj54n1cb0c.c
+++ b/drivers/media/video/rj54n1cb0c.c
@@ -1444,7 +1444,6 @@ static int rj54n1_probe(struct i2c_client *client,
 	ret = rj54n1_video_probe(icd, client, rj54n1_priv);
 	if (ret < 0) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(rj54n1);
 		return ret;
 	}
@@ -1461,7 +1460,6 @@ static int rj54n1_remove(struct i2c_client *client)
 	icd->ops = NULL;
 	if (icl->free_bus)
 		icl->free_bus(icl);
-	i2c_set_clientdata(client, NULL);
 	client->driver = NULL;
 	kfree(rj54n1);
 
diff --git a/drivers/media/video/tcm825x.c b/drivers/media/video/tcm825x.c
index b90e9da..54681a5 100644
--- a/drivers/media/video/tcm825x.c
+++ b/drivers/media/video/tcm825x.c
@@ -850,7 +850,6 @@ static int tcm825x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *did)
 {
 	struct tcm825x_sensor *sensor = &tcm825x;
-	int rval;
 
 	if (i2c_get_clientdata(client))
 		return -EBUSY;
@@ -871,11 +870,7 @@ static int tcm825x_probe(struct i2c_client *client,
 	sensor->pix.height = tcm825x_sizes[QVGA].height;
 	sensor->pix.pixelformat = V4L2_PIX_FMT_RGB565;
 
-	rval = v4l2_int_device_register(sensor->v4l2_int_device);
-	if (rval)
-		i2c_set_clientdata(client, NULL);
-
-	return rval;
+	return v4l2_int_device_register(sensor->v4l2_int_device);
 }
 
 static int tcm825x_remove(struct i2c_client *client)
@@ -886,7 +881,6 @@ static int tcm825x_remove(struct i2c_client *client)
 		return -ENODEV;	/* our client isn't attached */
 
 	v4l2_int_device_unregister(sensor->v4l2_int_device);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/media/video/tw9910.c b/drivers/media/video/tw9910.c
index 76be733..6eb3395 100644
--- a/drivers/media/video/tw9910.c
+++ b/drivers/media/video/tw9910.c
@@ -977,7 +977,6 @@ static int tw9910_probe(struct i2c_client *client,
 	ret = tw9910_video_probe(icd, client);
 	if (ret) {
 		icd->ops = NULL;
-		i2c_set_clientdata(client, NULL);
 		kfree(priv);
 	}
 
@@ -990,7 +989,6 @@ static int tw9910_remove(struct i2c_client *client)
 	struct soc_camera_device *icd = client->dev.platform_data;
 
 	icd->ops = NULL;
-	i2c_set_clientdata(client, NULL);
 	kfree(priv);
 	return 0;
 }
diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index c933b64..bc02e6b 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -200,8 +200,6 @@ static int __devexit pm860x_remove(struct i2c_client *client)
 
 	pm860x_device_exit(chip);
 	i2c_unregister_device(chip->companion);
-	i2c_set_clientdata(chip->client, NULL);
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 53ebfee..66379b4 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -957,7 +957,6 @@ static int __init ab3100_probe(struct i2c_client *client,
 	i2c_unregister_device(ab3100->testreg_client);
  exit_no_testreg_client:
  exit_no_detect:
-	i2c_set_clientdata(client, NULL);
 	kfree(ab3100);
 	return err;
 }
@@ -979,7 +978,6 @@ static int __exit ab3100_remove(struct i2c_client *client)
 	 * their notifiers so deactivate IRQ
 	 */
 	free_irq(client->irq, ab3100);
-	i2c_set_clientdata(client, NULL);
 	kfree(ab3100);
 	return 0;
 }
diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 1060f8e..f54ab62 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -1362,7 +1362,6 @@ static int __exit ab3550_remove(struct i2c_client *client)
 	 * their notifiers so deactivate IRQ
 	 */
 	free_irq(client->irq, ab);
-	i2c_set_clientdata(client, NULL);
 	kfree(ab);
 	return 0;
 }
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index 0055328..3122139 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -302,7 +302,6 @@ out_free_irq:
 		free_irq(chip->irq, chip);
 
 out_free_chip:
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 
 	return ret;
@@ -317,7 +316,6 @@ static int __devexit adp5520_remove(struct i2c_client *client)
 
 	adp5520_remove_subdevs(chip);
 	adp5520_write(chip->dev, ADP5520_MODE_STATUS, 0);
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 3ad915d..c07aece 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -534,7 +534,6 @@ static int __devinit da903x_probe(struct i2c_client *client,
 out_free_irq:
 	free_irq(client->irq, chip);
 out_free_chip:
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return ret;
 }
@@ -544,7 +543,6 @@ static int __devexit da903x_remove(struct i2c_client *client)
 	struct da903x_chip *chip = i2c_get_clientdata(client);
 
 	da903x_remove_subdevs(chip);
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index e73f3f5..0219115 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -173,7 +173,6 @@ static int __devexit max8925_remove(struct i2c_client *client)
 	max8925_device_exit(chip);
 	i2c_unregister_device(chip->adc);
 	i2c_unregister_device(chip->rtc);
-	i2c_set_clientdata(chip->i2c, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 721948b..a3fb4bc 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1228,7 +1228,6 @@ fail2:
 	free_irq(client->irq, menelaus);
 	flush_scheduled_work();
 fail1:
-	i2c_set_clientdata(client, NULL);
 	kfree(menelaus);
 	return err;
 }
@@ -1238,7 +1237,6 @@ static int __exit menelaus_remove(struct i2c_client *client)
 	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
 
 	free_irq(client->irq, menelaus);
-	i2c_set_clientdata(client, NULL);
 	kfree(menelaus);
 	the_menelaus = NULL;
 	return 0;
diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 704736e..23e5855 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -336,7 +336,6 @@ static int __devinit pcf50633_probe(struct i2c_client *client,
 	return 0;
 
 err_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(pcf);
 
 	return ret;
@@ -357,7 +356,6 @@ static int __devexit pcf50633_remove(struct i2c_client *client)
 	for (i = 0; i < PCF50633_NUM_REGULATORS; i++)
 		platform_device_unregister(pcf->regulator_pdev[i]);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(pcf);
 
 	return 0;
diff --git a/drivers/mfd/tc35892.c b/drivers/mfd/tc35892.c
index 715f095..e619e2a 100644
--- a/drivers/mfd/tc35892.c
+++ b/drivers/mfd/tc35892.c
@@ -296,7 +296,6 @@ out_freeirq:
 out_removeirq:
 	tc35892_irq_remove(tc35892);
 out_free:
-	i2c_set_clientdata(i2c, NULL);
 	kfree(tc35892);
 	return ret;
 }
@@ -310,7 +309,6 @@ static int __devexit tc35892_remove(struct i2c_client *client)
 	free_irq(tc35892->i2c->irq, tc35892);
 	tc35892_irq_remove(tc35892);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(tc35892);
 
 	return 0;
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 9b22a77..d0016b6 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -530,7 +530,6 @@ static int __exit tps65010_remove(struct i2c_client *client)
 	cancel_delayed_work(&tps->work);
 	flush_scheduled_work();
 	debugfs_remove(tps->file);
-	i2c_set_clientdata(client, NULL);
 	kfree(tps);
 	the_tps = NULL;
 	return 0;
diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index 7795af4..5fe5de1 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -80,7 +80,6 @@ static int wm8350_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err:
-	i2c_set_clientdata(i2c, NULL);
 	kfree(wm8350);
 	return ret;
 }
@@ -90,7 +89,6 @@ static int wm8350_i2c_remove(struct i2c_client *i2c)
 	struct wm8350 *wm8350 = i2c_get_clientdata(i2c);
 
 	wm8350_device_exit(wm8350);
-	i2c_set_clientdata(i2c, NULL);
 	kfree(wm8350);
 
 	return 0;
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index e08aafa..1bfef48 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -415,7 +415,6 @@ static int wm8400_i2c_probe(struct i2c_client *i2c,
 	return 0;
 
 struct_err:
-	i2c_set_clientdata(i2c, NULL);
 	kfree(wm8400);
 err:
 	return ret;
@@ -426,7 +425,6 @@ static int wm8400_i2c_remove(struct i2c_client *i2c)
 	struct wm8400 *wm8400 = i2c_get_clientdata(i2c);
 
 	wm8400_release(wm8400);
-	i2c_set_clientdata(i2c, NULL);
 	kfree(wm8400);
 
 	return 0;
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f7ca3a4..559b0b3 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -643,7 +643,6 @@ static int __devexit at24_remove(struct i2c_client *client)
 
 	kfree(at24->writebuf);
 	kfree(at24);
-	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index eb476b7..f4ce273 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -234,7 +234,6 @@ static int __devexit pismo_remove(struct i2c_client *client)
 	/* FIXME: set_vpp needs saner arguments */
 	pismo_setvpp_remove_fix(pismo);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(pismo);
 
 	return 0;
@@ -286,7 +285,6 @@ static int __devinit pismo_probe(struct i2c_client *client,
 	return 0;
 
  exit_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(pismo);
 	return ret;
 }
diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index f3e22c9..2f2f9a6 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -225,7 +225,6 @@ static int __devinit max17040_probe(struct i2c_client *client,
 	ret = power_supply_register(&client->dev, &chip->battery);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(chip);
 		return ret;
 	}
@@ -245,7 +244,6 @@ static int __devexit max17040_remove(struct i2c_client *client)
 
 	power_supply_unregister(&chip->battery);
 	cancel_delayed_work(&chip->work);
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index 671a7d1..8ae3732 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -519,8 +519,6 @@ static int __devexit lp3971_i2c_remove(struct i2c_client *i2c)
 	struct lp3971 *lp3971 = i2c_get_clientdata(i2c);
 	int i;
 
-	i2c_set_clientdata(i2c, NULL);
-
 	for (i = 0; i < lp3971->num_regulators; i++)
 		regulator_unregister(lp3971->rdev[i]);
 
diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index b3c1afc..2b54d9d 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -244,7 +244,6 @@ static int __devexit max1586_pmic_remove(struct i2c_client *client)
 	for (i = 0; i <= MAX1586_V6; i++)
 		if (rdev[i])
 			regulator_unregister(rdev[i]);
-	i2c_set_clientdata(client, NULL);
 	kfree(rdev);
 
 	return 0;
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index bfc4c5f..4520ace 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -357,7 +357,6 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 	dev_info(info->dev, "Max8649 regulator device is detected.\n");
 	return 0;
 out:
-	i2c_set_clientdata(client, NULL);
 	kfree(info);
 	return ret;
 }
@@ -369,7 +368,6 @@ static int __devexit max8649_regulator_remove(struct i2c_client *client)
 	if (info) {
 		if (info->regulator)
 			regulator_unregister(info->regulator);
-		i2c_set_clientdata(client, NULL);
 		kfree(info);
 	}
 
diff --git a/drivers/regulator/max8660.c b/drivers/regulator/max8660.c
index 3790b21..d97220e 100644
--- a/drivers/regulator/max8660.c
+++ b/drivers/regulator/max8660.c
@@ -471,7 +471,6 @@ static int __devexit max8660_remove(struct i2c_client *client)
 	for (i = 0; i < MAX8660_V_END; i++)
 		if (rdev[i])
 			regulator_unregister(rdev[i]);
-	i2c_set_clientdata(client, NULL);
 	kfree(rdev);
 
 	return 0;
diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
index 8e2f209..f50afc9 100644
--- a/drivers/regulator/tps65023-regulator.c
+++ b/drivers/regulator/tps65023-regulator.c
@@ -538,9 +538,6 @@ static int __devexit tps_65023_remove(struct i2c_client *client)
 	struct tps_pmic *tps = i2c_get_clientdata(client);
 	int i;
 
-	/* clear the client data in i2c */
-	i2c_set_clientdata(client, NULL);
-
 	for (i = 0; i < TPS65023_NUM_REGULATOR; i++)
 		regulator_unregister(tps->rdev[i]);
 
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 6194573..1f0007f 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -403,7 +403,6 @@ out_irq:
 		free_irq(client->irq, client);
 
 out_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(ds1374);
 	return ret;
 }
@@ -422,7 +421,6 @@ static int __devexit ds1374_remove(struct i2c_client *client)
 	}
 
 	rtc_device_unregister(ds1374->rtc);
-	i2c_set_clientdata(client, NULL);
 	kfree(ds1374);
 	return 0;
 }
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index b65c82f..789f62f 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -632,7 +632,6 @@ errout_reg:
 	rtc_device_unregister(rx8025->rtc);
 
 errout_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(rx8025);
 
 errout:
@@ -656,7 +655,6 @@ static int __devexit rx8025_remove(struct i2c_client *client)
 
 	rx8025_sysfs_unregister(&client->dev);
 	rtc_device_unregister(rx8025->rtc);
-	i2c_set_clientdata(client, NULL);
 	kfree(rx8025);
 	return 0;
 }
diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index def4d39..f789e00 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -275,7 +275,6 @@ exit_dummy:
 		if (s35390a->client[i])
 			i2c_unregister_device(s35390a->client[i]);
 	kfree(s35390a);
-	i2c_set_clientdata(client, NULL);
 
 exit:
 	return err;
@@ -292,7 +291,6 @@ static int s35390a_remove(struct i2c_client *client)
 
 	rtc_device_unregister(s35390a->rtc);
 	kfree(s35390a);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/staging/dream/synaptics_i2c_rmi.c
index 1f020da..3320359 100644
--- a/drivers/staging/dream/synaptics_i2c_rmi.c
+++ b/drivers/staging/dream/synaptics_i2c_rmi.c
@@ -519,7 +519,6 @@ err_input_register_device_failed:
 err_input_dev_alloc_failed:
 err_detect_failed:
 err_power_failed:
-	i2c_set_clientdata(client, NULL);
 	kfree(ts);
 err_alloc_data_failed:
 err_check_functionality_failed:
@@ -537,7 +536,6 @@ static int synaptics_ts_remove(struct i2c_client *client)
 	else
 		hrtimer_cancel(&ts->timer);
 	input_unregister_device(ts->input_dev);
-	i2c_set_clientdata(client, NULL);
 	kfree(ts);
 	return 0;
 }
diff --git a/drivers/staging/go7007/wis-saa7113.c b/drivers/staging/go7007/wis-saa7113.c
index bd92545..72f5c1f 100644
--- a/drivers/staging/go7007/wis-saa7113.c
+++ b/drivers/staging/go7007/wis-saa7113.c
@@ -289,7 +289,6 @@ static int wis_saa7113_probe(struct i2c_client *client,
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR
 			"wis-saa7113: error initializing SAA7113\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
@@ -301,7 +300,6 @@ static int wis_saa7113_remove(struct i2c_client *client)
 {
 	struct wis_saa7113 *dec = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(dec);
 	return 0;
 }
diff --git a/drivers/staging/go7007/wis-saa7115.c b/drivers/staging/go7007/wis-saa7115.c
index b2eb804..cd950b6 100644
--- a/drivers/staging/go7007/wis-saa7115.c
+++ b/drivers/staging/go7007/wis-saa7115.c
@@ -422,7 +422,6 @@ static int wis_saa7115_probe(struct i2c_client *client,
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR
 			"wis-saa7115: error initializing SAA7115\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
@@ -434,7 +433,6 @@ static int wis_saa7115_remove(struct i2c_client *client)
 {
 	struct wis_saa7115 *dec = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(dec);
 	return 0;
 }
diff --git a/drivers/staging/go7007/wis-sony-tuner.c b/drivers/staging/go7007/wis-sony-tuner.c
index b101329..981c9b3 100644
--- a/drivers/staging/go7007/wis-sony-tuner.c
+++ b/drivers/staging/go7007/wis-sony-tuner.c
@@ -684,7 +684,6 @@ static int wis_sony_tuner_remove(struct i2c_client *client)
 {
 	struct wis_sony_tuner *t = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(t);
 	return 0;
 }
diff --git a/drivers/staging/go7007/wis-tw2804.c b/drivers/staging/go7007/wis-tw2804.c
index 315268d..ee28a99 100644
--- a/drivers/staging/go7007/wis-tw2804.c
+++ b/drivers/staging/go7007/wis-tw2804.c
@@ -323,7 +323,6 @@ static int wis_tw2804_remove(struct i2c_client *client)
 {
 	struct wis_tw2804 *dec = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(dec);
 	return 0;
 }
diff --git a/drivers/staging/go7007/wis-tw9903.c b/drivers/staging/go7007/wis-tw9903.c
index 2afea09..80d4726 100644
--- a/drivers/staging/go7007/wis-tw9903.c
+++ b/drivers/staging/go7007/wis-tw9903.c
@@ -294,7 +294,6 @@ static int wis_tw9903_probe(struct i2c_client *client,
 
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR "wis-tw9903: error initializing TW9903\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
@@ -306,7 +305,6 @@ static int wis_tw9903_remove(struct i2c_client *client)
 {
 	struct wis_tw9903 *dec = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(dec);
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 20e2674..905f856 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1011,7 +1011,6 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 error_free_st:
-	i2c_set_clientdata(client, NULL);
 	kfree(st);
 
 error_ret:
@@ -1030,7 +1029,6 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	i2c_set_clientdata(client, NULL);
 	kfree(st);
 
 	return 0;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 43aaacf..e4b0a5e 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -694,7 +694,6 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 fail2:
 	iio_device_unregister(chip->indio_dev);
 fail1:
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return err;
 }
@@ -705,7 +704,6 @@ static int tsl2563_remove(struct i2c_client *client)
 
 	iio_device_unregister(chip->indio_dev);
 
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 921ca37..3ec2460 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -756,7 +756,6 @@ out:
 out1:
 	backlight_device_unregister(bl);
 out2:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return ret;
@@ -776,7 +775,6 @@ static int __devexit adp8860_remove(struct i2c_client *client)
 			&adp8860_bl_attr_group);
 
 	backlight_device_unregister(data->bl);
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return 0;
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index e03e60b..2a04b38 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -119,7 +119,6 @@ static int __devinit tosa_bl_probe(struct i2c_client *client,
 
 err_reg:
 	data->bl = NULL;
-	i2c_set_clientdata(client, NULL);
 err_gpio_dir:
 	gpio_free(TOSA_GPIO_BL_C20MA);
 err_gpio_bl:
@@ -133,7 +132,6 @@ static int __devexit tosa_bl_remove(struct i2c_client *client)
 
 	backlight_device_unregister(data->bl);
 	data->bl = NULL;
-	i2c_set_clientdata(client, NULL);
 
 	gpio_free(TOSA_GPIO_BL_C20MA);
 
-- 
1.7.0
