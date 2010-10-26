Return-Path: <B32167@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH][v0] RTC driver(Linux) for PT7C4338 chip.
Date: Mon, 25 Oct 2010 23:19:15 -0700
Message-ID: <470DB7CE2CD0944E9436E7ADEFC02FE3C17D@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <1287994138-31771-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1287994138-31771-1-git-send-email-Priyanka.Jain@freescale.com>
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Cc: Linuxppc-dev@ozlabs.org, Jain Priyanka-B32167 <B32167@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Kumar,

As there is no feedback on this patch. Please pull this upstream.

Thanks
Priyanka

-----Original Message-----
From: Jain Priyanka-B32167=20
Sent: Monday, October 25, 2010 1:39 PM
To: Linuxppc-dev@ozlabs.org
Cc: Jain Priyanka-B32167
Subject: [PATCH][v0] RTC driver(Linux) for PT7C4338 chip.

PT7C4338 chip is manufactured by Pericom Technology Inc.
It is a serial real-time clock which provides:
1)Low-power clock/calendar.
2)Programmable square-wave output.
It has 56 bytes of nonvolatile RAM.

Freescale P1010RDB uses PT7C4338 as RTC.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Based of unified git(next branch) for P1010 RDB.
 drivers/rtc/Kconfig        |    9 ++
 drivers/rtc/Makefile       |    1 +
 drivers/rtc/rtc-pt7c4338.c |  215
++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 0 deletions(-)  create mode 100644
drivers/rtc/rtc-pt7c4338.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig index
10ba12c..6ff0901 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -324,6 +324,15 @@ config RTC_DRV_RX8025
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rx8025.
=20
+config RTC_DRV_PT7C4338
+	tristate "Pericom Technology Inc. PT7C4338 RTC"
+	help
+	  If you say yes here you get support for the Pericom Technology
+	  Inc. PT7C4338 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pt7c4338.
+
 endif # I2C
=20
 comment "SPI RTC drivers"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile index
5adbba7..4014607 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_RTC_DRV_PCF50633)	+=3D
rtc-pcf50633.o
 obj-$(CONFIG_RTC_DRV_PL030)	+=3D rtc-pl030.o
 obj-$(CONFIG_RTC_DRV_PL031)	+=3D rtc-pl031.o
 obj-$(CONFIG_RTC_DRV_PS3)	+=3D rtc-ps3.o
+obj-$(CONFIG_RTC_DRV_PT7C4338)	+=3D rtc-pt7c4338.o
 obj-$(CONFIG_RTC_DRV_PXA)	+=3D rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R9701)	+=3D rtc-r9701.o
 obj-$(CONFIG_RTC_DRV_RP5C01)	+=3D rtc-rp5c01.o
diff --git a/drivers/rtc/rtc-pt7c4338.c b/drivers/rtc/rtc-pt7c4338.c new
file mode 100644 index 0000000..fca52cd
--- /dev/null
+++ b/drivers/rtc/rtc-pt7c4338.c
@@ -0,0 +1,215 @@
+/*
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * Author:	Priyanka Jain <Priyanka.Jain@freescale.com>
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+/*
+ * This file provides Date & Time support (no alarms) for PT7C4338
chip.
+ *
+ * This file is based on drivers/rtc/rtc-ds1307.c
+ *
+ * PT7C4338 chip is manufactured by Pericom Technology Inc.
+ * It is a serial real-time clock which provides
+ * 1)Low-power clock/calendar.
+ * 2)Programmable square-wave output.
+ * It has 56 bytes of nonvolatile RAM.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+
+/* RTC register addresses */
+#define PT7C4338_REG_SECONDS          0x00
+#define PT7C4338_REG_MINUTES          0x01
+#define PT7C4338_REG_HOURS            0x02
+#define PT7C4338_REG_AMPM             0x02
+#define PT7C4338_REG_DAY              0x03
+#define PT7C4338_REG_DATE             0x04
+#define PT7C4338_REG_MONTH            0x05
+#define PT7C4338_REG_YEAR             0x06
+#define PT7C4338_REG_CTRL_STAT        0x07
+
+/* RTC second register address bit */
+#define PT7C4338_SEC_BIT_CH           0x80	/*Clock Halt (in
Register 0)*/
+
+/* RTC control and status register bits */
+#define PT7C4338_CTRL_STAT_BIT_RS0    0x1	/*Rate select 0*/
+#define PT7C4338_CTRL_STAT_BIT_RS1    0x2	/*Rate select 1*/
+#define PT7C4338_CTRL_STAT_BIT_SQWE   0x10	/*Square Wave Enable*/
+#define PT7C4338_CTRL_STAT_BIT_OSF    0x20	/*Oscillator Stop Flag*/
+#define PT7C4338_CTRL_STAT_BIT_OUT    0x80	/*Output Level Control*/
+
+static const struct i2c_device_id pt7c4338_id[] =3D {
+	{ "pt7c4338", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pt7c4338_id);
+
+struct pt7c4338{
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+};
+
+static int pt7c4338_read_time(struct device *dev, struct rtc_time=20
+*time) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+	int ret;
+	u8 buf[7];
+	u8 year, month, day, hour, minute, second;
+	u8 week, twelve_hr, am_pm;
+
+	ret =3D i2c_smbus_read_i2c_block_data(client,
+			PT7C4338_REG_SECONDS, 7, buf);
+	if (ret < 0)
+		return ret;
+	if (ret < 7)
+		return -EIO;
+
+	second =3D buf[0];
+	minute =3D buf[1];
+	hour =3D buf[2];
+	week =3D buf[3];
+	day =3D buf[4];
+	month =3D buf[5];
+	year =3D buf[6];
+
+	/* Extract additional information for AM/PM */
+	twelve_hr =3D hour & 0x40;
+	am_pm =3D hour & 0x20;
+
+	/* Write to rtc_time structure */
+	time->tm_sec =3D bcd2bin(second & 0x7f);
+	time->tm_min =3D bcd2bin(minute & 0x7f);
+	if (twelve_hr) {
+		/* Convert to 24 hr */
+		if (am_pm)
+			time->tm_hour =3D bcd2bin(hour & 0x10) + 12;
+		else
+			time->tm_hour =3D bcd2bin(hour & 0xBF);
+	} else {
+		time->tm_hour =3D bcd2bin(hour);
+	}
+
+	time->tm_wday =3D bcd2bin(week & 0x07) - 1;
+	time->tm_mday =3D bcd2bin(day & 0x3f);
+	time->tm_mon =3D bcd2bin(month & 0x1F) - 1;
+	/* assume 20YY not 19YY */
+	time->tm_year =3D bcd2bin(year) + 100;
+
+	return 0;
+}
+
+static int pt7c4338_set_time(struct device *dev, struct rtc_time *time)

+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	u8 buf[7];
+
+	/* Extract time from rtc_time and load into pt7c4338*/
+	buf[0] =3D bin2bcd(time->tm_sec);
+	buf[1] =3D bin2bcd(time->tm_min);
+	buf[2] =3D bin2bcd(time->tm_hour);
+	buf[3] =3D bin2bcd(time->tm_wday + 1); /* Day of the week */
+	buf[4] =3D bin2bcd(time->tm_mday); /* Date */
+	buf[5] =3D bin2bcd(time->tm_mon + 1);
+
+	/* assume 20YY not 19YY */
+	if (time->tm_year >=3D 100)
+		buf[6] =3D bin2bcd(time->tm_year - 100);
+	else
+		buf[6] =3D bin2bcd(time->tm_year);
+
+	return i2c_smbus_write_i2c_block_data(client,
+					PT7C4338_REG_SECONDS, 7, buf);
+}
+
+static const struct rtc_class_ops pt7c4338_rtc_ops =3D {
+	.read_time =3D pt7c4338_read_time,
+	.set_time =3D pt7c4338_set_time,
+};
+
+static int pt7c4338_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct pt7c4338 *pt7c4338;
+	struct i2c_adapter *adapter =3D
to_i2c_adapter(client->dev.parent);
+	int ret;
+
+	pt7c4338 =3D kzalloc(sizeof(struct pt7c4338), GFP_KERNEL);
+	if (!pt7c4338)
+		return -ENOMEM;
+
+	pt7c4338->client =3D client;
+	i2c_set_clientdata(client, pt7c4338);
+	pt7c4338->rtc =3D rtc_device_register(client->name, &client->dev,
+					&pt7c4338_rtc_ops, THIS_MODULE);
+	if (IS_ERR(pt7c4338->rtc)) {
+		ret =3D PTR_ERR(pt7c4338->rtc);
+		dev_err(&client->dev, "unable to register the class
device\n");
+		goto out_free;
+	}
+
+	return 0;
+out_free:
+	i2c_set_clientdata(client, NULL);
+	kfree(pt7c4338);
+	return ret;
+}
+
+static int __devexit pt7c4338_remove(struct i2c_client *client) {
+	struct pt7c4338 *pt7c4338 =3D i2c_get_clientdata(client);
+
+	rtc_device_unregister(pt7c4338->rtc);
+	i2c_set_clientdata(client, NULL);
+	kfree(pt7c4338);
+	return 0;
+}
+
+static struct i2c_driver pt7c4338_driver =3D {
+	.driver =3D {
+		.name =3D "rtc-pt7c4338",
+		.owner =3D THIS_MODULE,
+	},
+	.probe =3D pt7c4338_probe,
+	.remove =3D __devexit_p(pt7c4338_remove),
+	.id_table =3D pt7c4338_id,
+};
+
+static int __init pt7c4338_init(void)
+{
+	return i2c_add_driver(&pt7c4338_driver); }
+
+static void __exit pt7c4338_exit(void)
+{
+	i2c_del_driver(&pt7c4338_driver);
+}
+
+module_init(pt7c4338_init);
+module_exit(pt7c4338_exit);
+
+MODULE_AUTHOR("Priyanka Jain <Priyanka.Jain@freescale.com>");=20
+MODULE_DESCRIPTION("pericom Technology Inc. PT7C4338 RTC Driver");=20
+MODULE_LICENSE("GPL");
--
1.6.5.6
