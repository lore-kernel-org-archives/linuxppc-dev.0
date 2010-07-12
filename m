Return-Path: <mcuos.com@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id D681BB7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 17:08:42 +1000 (EST)
Received: by vws9 with SMTP id 9so3992564vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 00:08:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278909366-15903-1-git-send-email-tie-fei.zang@freescale.com>
References: <1278909366-15903-1-git-send-email-tie-fei.zang@freescale.com>
Date: Mon, 12 Jul 2010 15:08:40 +0800
Message-ID: <AANLkTikK7wsnSVa9Ww5swaAR828edz_zuiBHzV4WZjqw@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH v2] rtc: add support for DS3232 RTC
From: Wan ZongShun <mcuos.com@gmail.com>
To: rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mingkai.hu@freescale.com, linuxppc-dev@lists.ozlabs.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/7/12 Roy Zang <tie-fei.zang@freescale.com>:
> This patch adds the driver for RTC chip DS3232 via I2C bus.
>

I noted this patch is the second version, maybe you can describe which
modifications you have done here.
and add [PATCH v2] to mail subject.

> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Jingchang Lu <b22599@freescale.com>
> Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Tested on MPC8536DS and P4080DS board
>
> =C2=A0drivers/rtc/Kconfig =C2=A0 =C2=A0 =C2=A0| =C2=A0 11 ++
> =C2=A0drivers/rtc/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/rtc/rtc-ds3232.c | =C2=A0427 ++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A03 files changed, 439 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/rtc/rtc-ds3232.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 6a13037..13c2fdb 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -166,6 +166,17 @@ config RTC_DRV_DS1672
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a modu=
le. If so, the module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called rtc-ds1672.
>
> +config RTC_DRV_DS3232
> + =C2=A0 =C2=A0 =C2=A0 tristate "Dallas/Maxim DS3232"
> + =C2=A0 =C2=A0 =C2=A0 depends on RTC_CLASS && I2C
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you say yes here you get support for Dal=
las Semiconductor
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 DS3232 real-time clock chips. =C2=A0If an i=
nterrupt is associated
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 with the device, the alarm functionality is=
 supported.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a module. =
=C2=A0If so, the module
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called rtc-ds3232.
> +
> =C2=A0config RTC_DRV_MAX6900
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Maxim MAX6900"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 44ef194..0af190c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_DS1511) =C2=A0+=3D rtc-ds1511.o
> =C2=A0obj-$(CONFIG_RTC_DRV_DS1553) =C2=A0 +=3D rtc-ds1553.o
> =C2=A0obj-$(CONFIG_RTC_DRV_DS1672) =C2=A0 +=3D rtc-ds1672.o
> =C2=A0obj-$(CONFIG_RTC_DRV_DS1742) =C2=A0 +=3D rtc-ds1742.o
> +obj-$(CONFIG_RTC_DRV_DS3232) =C2=A0 +=3D rtc-ds3232.o
> =C2=A0obj-$(CONFIG_RTC_DRV_DS3234) =C2=A0 +=3D rtc-ds3234.o
> =C2=A0obj-$(CONFIG_RTC_DRV_EFI) =C2=A0 =C2=A0 =C2=A0+=3D rtc-efi.o
> =C2=A0obj-$(CONFIG_RTC_DRV_EP93XX) =C2=A0 +=3D rtc-ep93xx.o
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> new file mode 100644
> index 0000000..e36ec1c
> --- /dev/null
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -0,0 +1,427 @@
> +/*
> + * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2=
C
> + *
> + * Copyright (C) 2009-2010 Freescale Semiconductor.
> + *
> + * This program is free software; you can redistribute =C2=A0it and/or m=
odify it
> + * under =C2=A0the terms of =C2=A0the GNU General =C2=A0Public License a=
s published by the
> + * Free Software Foundation; =C2=A0either version 2 of the =C2=A0License=
, or (at your
> + * option) any later version.
> + */
> +/*
> + * It would be more efficient to use i2c msgs/i2c_transfer directly but,=
 as
> + * recommened in .../Documentation/i2c/writing-clients section
> + * "Sending and receiving", using SMBus level communication is preferred=
.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/rtc.h>
> +#include <linux/bcd.h>
> +#include <linux/workqueue.h>
> +#include <linux/slab.h>
> +
> +#define DS3232_REG_SECONDS =C2=A0 =C2=A0 0x00
> +#define DS3232_REG_MINUTES =C2=A0 =C2=A0 0x01
> +#define DS3232_REG_HOURS =C2=A0 =C2=A0 =C2=A0 0x02
> +#define DS3232_REG_AMPM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x02
> +#define DS3232_REG_DAY =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03
> +#define DS3232_REG_DATE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x04
> +#define DS3232_REG_MONTH =C2=A0 =C2=A0 =C2=A0 0x05
> +#define DS3232_REG_CENTURY =C2=A0 =C2=A0 0x05
> +#define DS3232_REG_YEAR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x06
> +#define DS3232_REG_ALARM1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x07 /* Alarm 1 BA=
SE */
> +#define DS3232_REG_ALARM2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0B /* Alarm 2 BA=
SE */
> +#define DS3232_REG_CR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0E =C2=A0 =C2=
=A0/* Control register */
> +# =C2=A0 =C2=A0 =C2=A0define DS3232_REG_CR_nEOSC =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x80
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_CR_INTCN =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x04
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_CR_A2IE =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x02
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_CR_A1IE =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x01
> +
> +#define DS3232_REG_SR =C2=A00x0F =C2=A0 =C2=A0/* control/status register=
 */
> +# =C2=A0 =C2=A0 =C2=A0define DS3232_REG_SR_OSF =C2=A0 0x80
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_SR_BSY =C2=A0 0x04
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_SR_A2F =C2=A0 0x02
> +# =C2=A0 =C2=A0 =C2=A0 define DS3232_REG_SR_A1F =C2=A0 0x01
> +
> +struct ds3232 {
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client;
> + =C2=A0 =C2=A0 =C2=A0 struct rtc_device *rtc;
> + =C2=A0 =C2=A0 =C2=A0 struct work_struct work;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* The mutex protects alarm operations, and preven=
ts a race
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* between the enable_irq() in the workqueue =
and the free_irq()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* in the remove function.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 struct mutex mutex;
> + =C2=A0 =C2=A0 =C2=A0 int exiting;
> +};
> +
> +static struct i2c_driver ds3232_driver;
> +
> +static int ds3232_check_rtc_status(struct i2c_client *client)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int control, stat;
> +
> + =C2=A0 =C2=A0 =C2=A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_R=
EG_SR);
> + =C2=A0 =C2=A0 =C2=A0 if (stat < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return stat;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stat & DS3232_REG_SR_OSF)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(&client->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "oscillator discontinuity flagged, "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "time unreliable\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 stat &=3D ~(DS3232_REG_SR_OSF | DS3232_REG_SR_A1F =
| DS3232_REG_SR_A2F);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_R=
EG_SR, stat);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* If the alarm is pending, clear it before reques=
ting
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the interrupt, so an interrupt event isn't=
 reported
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* before everything is initialized.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 control =3D i2c_smbus_read_byte_data(client, DS323=
2_REG_CR);
> + =C2=A0 =C2=A0 =C2=A0 if (control < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return control;
> +
> + =C2=A0 =C2=A0 =C2=A0 control &=3D ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_=
A2IE);
> + =C2=A0 =C2=A0 =C2=A0 control |=3D DS3232_REG_CR_INTCN;
> +
> + =C2=A0 =C2=A0 =C2=A0 return i2c_smbus_write_byte_data(client, DS3232_RE=
G_CR, control);
> +}
> +
> +static int ds3232_read_time(struct device *dev, struct rtc_time *time)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[7];
> + =C2=A0 =C2=A0 =C2=A0 unsigned int year, month, day, hour, minute, secon=
d;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int week, twelve_hr, am_pm;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int century, add_century =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_read_i2c_block_data(client, DS32=
32_REG_SECONDS, 7, buf);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 7)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 second =3D buf[0];
> + =C2=A0 =C2=A0 =C2=A0 minute =3D buf[1];
> + =C2=A0 =C2=A0 =C2=A0 hour =3D buf[2];
> + =C2=A0 =C2=A0 =C2=A0 week =3D buf[3];
> + =C2=A0 =C2=A0 =C2=A0 day =3D buf[4];
> + =C2=A0 =C2=A0 =C2=A0 month =3D buf[5];
> + =C2=A0 =C2=A0 =C2=A0 year =3D buf[6];
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Extract additional information for AM/PM and ce=
ntury */
> +
> + =C2=A0 =C2=A0 =C2=A0 twelve_hr =3D hour & 0x40;
> + =C2=A0 =C2=A0 =C2=A0 am_pm =3D hour & 0x20;
> + =C2=A0 =C2=A0 =C2=A0 century =3D month & 0x80;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Write to rtc_time structure */
> +
> + =C2=A0 =C2=A0 =C2=A0 time->tm_sec =3D bcd2bin(second);
> + =C2=A0 =C2=A0 =C2=A0 time->tm_min =3D bcd2bin(minute);
> + =C2=A0 =C2=A0 =C2=A0 if (twelve_hr) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Convert to 24 hr */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (am_pm)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 time->tm_hour =3D bcd2bin(hour & 0x1F) + 12;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 time->tm_hour =3D bcd2bin(hour & 0x1F);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time->tm_hour =3D bcd2=
bin(hour);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 time->tm_wday =3D bcd2bin(week);
> + =C2=A0 =C2=A0 =C2=A0 time->tm_mday =3D bcd2bin(day);
> + =C2=A0 =C2=A0 =C2=A0 time->tm_mon =3D bcd2bin(month & 0x7F);
> + =C2=A0 =C2=A0 =C2=A0 if (century)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_century =3D 100;
> +
> + =C2=A0 =C2=A0 =C2=A0 time->tm_year =3D bcd2bin(year) + add_century;
> +
> + =C2=A0 =C2=A0 =C2=A0 return rtc_valid_tm(time);
> +}
> +
> +static int ds3232_set_time(struct device *dev, struct rtc_time *time)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[7];
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Extract time from rtc_time and load into ds3232=
*/
> +
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D bin2bcd(time->tm_sec);
> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D bin2bcd(time->tm_min);
> + =C2=A0 =C2=A0 =C2=A0 buf[2] =3D bin2bcd(time->tm_hour);
> + =C2=A0 =C2=A0 =C2=A0 buf[3] =3D bin2bcd(time->tm_wday); /* Day of the w=
eek */
> + =C2=A0 =C2=A0 =C2=A0 buf[4] =3D bin2bcd(time->tm_mday); /* Date */
> + =C2=A0 =C2=A0 =C2=A0 buf[5] =3D bin2bcd(time->tm_mon);
> + =C2=A0 =C2=A0 =C2=A0 if (time->tm_year >=3D 100) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[5] |=3D 0x80;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[6] =3D bin2bcd(tim=
e->tm_year - 100);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[6] =3D bin2bcd(tim=
e->tm_year);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return i2c_smbus_write_i2c_block_data(client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DS3232_REG_SECONDS, 7, buf);
> +}
> +
> +/*
> + * DS3232 has two alarm, we only use alarm1
> + * According to linux specification, only support one-shot alarm
> + * no periodic alarm mode
> + */
> +static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alar=
m)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(clien=
t);
> + =C2=A0 =C2=A0 =C2=A0 int control, stat;
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[4];
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&ds3232->mutex);
> + =C2=A0 =C2=A0 =C2=A0 stat =3D ret =3D i2c_smbus_read_byte_data(client, =
DS3232_REG_SR);
> + =C2=A0 =C2=A0 =C2=A0 if (stat < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 control =3D ret =3D i2c_smbus_read_byte_data(clien=
t, DS3232_REG_CR);
> + =C2=A0 =C2=A0 =C2=A0 if (control < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_read_i2c_block_data(client, DS32=
32_REG_ALARM1, 4, buf);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_sec =3D bcd2bin(buf[0] & 0x7F);
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_min =3D bcd2bin(buf[1] & 0x7F);
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_hour =3D bcd2bin(buf[2] & 0x7F);
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_mday =3D bcd2bin(buf[3] & 0x7F);
> +
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_mon =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_year =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_wday =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_yday =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_isdst =3D -1;
> +
> + =C2=A0 =C2=A0 =C2=A0 alarm->enabled =3D !!(control & DS3232_REG_CR_A1IE=
);
> + =C2=A0 =C2=A0 =C2=A0 alarm->pending =3D !!(stat & DS3232_REG_SR_A1F);
> +out:
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&ds3232->mutex);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/*
> + * linux rtc-module does not support wday alarm
> + * and only 24h time mode supported indeed
> + */
> +static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(clien=
t);
> + =C2=A0 =C2=A0 =C2=A0 int control, stat;
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[4];
> +
> + =C2=A0 =C2=A0 =C2=A0 if (client->irq <=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&ds3232->mutex);
> +
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D bin2bcd(alarm->time.tm_sec);
> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D bin2bcd(alarm->time.tm_min);
> + =C2=A0 =C2=A0 =C2=A0 buf[2] =3D bin2bcd(alarm->time.tm_hour);
> + =C2=A0 =C2=A0 =C2=A0 buf[3] =3D bin2bcd(alarm->time.tm_mday);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* clear alarm interrupt enable bit */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D control =3D i2c_smbus_read_byte_data(clien=
t, DS3232_REG_CR);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 control &=3D ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_=
A2IE);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_R=
EG_CR, control);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* clear any pending alarm flag */
> + =C2=A0 =C2=A0 =C2=A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_R=
EG_SR);
> + =C2=A0 =C2=A0 =C2=A0 if (stat < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return stat;
> +
> + =C2=A0 =C2=A0 =C2=A0 stat &=3D ~(DS3232_REG_SR_A1F | DS3232_REG_SR_A2F)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_R=
EG_SR, stat);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_i2c_block_data(client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DS3232_REG_ALARM1, 4, buf);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (alarm->enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 control |=3D DS3232_RE=
G_CR_A1IE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_writ=
e_byte_data(client, DS3232_REG_CR, control);
> + =C2=A0 =C2=A0 =C2=A0 }
> +out:
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&ds3232->mutex);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static irqreturn_t ds3232_irq(int irq, void *dev_id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D dev_id;
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(clien=
t);
> +
> + =C2=A0 =C2=A0 =C2=A0 disable_irq_nosync(irq);
> + =C2=A0 =C2=A0 =C2=A0 schedule_work(&ds3232->work);
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +static void ds3232_work(struct work_struct *work)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232 =3D container_of(work, struc=
t ds3232, work);
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client =3D ds3232->client;
> + =C2=A0 =C2=A0 =C2=A0 int stat, control;
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&ds3232->mutex);
> +
> + =C2=A0 =C2=A0 =C2=A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_R=
EG_SR);
> + =C2=A0 =C2=A0 =C2=A0 if (stat < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stat & DS3232_REG_SR_A1F) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 control =3D i2c_smbus_=
read_byte_data(client, DS3232_REG_CR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (control < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* disable alarm1 inte=
rrupt */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 control &=3D ~(DS3232_=
REG_CR_A1IE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_smbus_write_byte_d=
ata(client, DS3232_REG_CR, control);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* clear the alarm pen=
d flag */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat &=3D ~DS3232_REG_=
SR_A1F;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_smbus_write_byte_d=
ata(client, DS3232_REG_SR, stat);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_update_irq(ds3232-=
>rtc, 1, RTC_AF | RTC_IRQF);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 if (!ds3232->exiting)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_irq(client->irq=
);
> +unlock:
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&ds3232->mutex);
> +}
> +
> +static const struct rtc_class_ops ds3232_rtc_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .read_time =3D ds3232_read_time,
> + =C2=A0 =C2=A0 =C2=A0 .set_time =3D ds3232_set_time,
> + =C2=A0 =C2=A0 =C2=A0 .read_alarm =3D ds3232_read_alarm,
> + =C2=A0 =C2=A0 =C2=A0 .set_alarm =3D ds3232_set_alarm,
> +};

I sew that you have discarded the .ioctl function, which is used to
enable/disable the alarm irq in previous driver patch.
but,at the same time, you didnot implement .alarm_irq_enable function
, so is there no need to enable or disable the alarm irq bit in
current version patch?

> +
> +static int __devinit ds3232_probe(struct i2c_client *client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct i2c_devic=
e_id *id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ds3232 =3D kzalloc(sizeof(struct ds3232), GFP_KERN=
EL);
> + =C2=A0 =C2=A0 =C2=A0 if (!ds3232)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 ds3232->client =3D client;
> + =C2=A0 =C2=A0 =C2=A0 i2c_set_clientdata(client, ds3232);
> +
> + =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&ds3232->work, ds3232_work);
> + =C2=A0 =C2=A0 =C2=A0 mutex_init(&ds3232->mutex);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D ds3232_check_rtc_status(client);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_free;
> +
> + =C2=A0 =C2=A0 =C2=A0 ds3232->rtc =3D rtc_device_register(client->name, =
&client->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &ds32=
32_rtc_ops, THIS_MODULE);
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ds3232->rtc)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D PTR_ERR(ds3232=
->rtc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, =
"unable to register the class device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_irq;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (client->irq >=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D request_irq(cl=
ient->irq, ds3232_irq, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"ds3232", client);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&client->dev, "unable to request IRQ\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto out_free;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +out_irq:
> + =C2=A0 =C2=A0 =C2=A0 if (client->irq >=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_irq(client->irq, =
client);
> +
> +out_free:
> + =C2=A0 =C2=A0 =C2=A0 i2c_set_clientdata(client, NULL);
> + =C2=A0 =C2=A0 =C2=A0 kfree(ds3232);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int __devexit ds3232_remove(struct i2c_client *client)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(clien=
t);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (client->irq >=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&ds3232->mu=
tex);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ds3232->exiting =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&ds3232->=
mutex);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_irq(client->irq, =
client);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work()=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_device_unregister(ds3232->rtc);
> + =C2=A0 =C2=A0 =C2=A0 i2c_set_clientdata(client, NULL);
> + =C2=A0 =C2=A0 =C2=A0 kfree(ds3232);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static const struct i2c_device_id ds3232_id[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { "ds3232", 0 },
> + =C2=A0 =C2=A0 =C2=A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds3232_id);
> +
> +static struct i2c_driver ds3232_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "rtc-ds3232"=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE=
,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .probe =3D ds3232_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(ds3232_remove),
> + =C2=A0 =C2=A0 =C2=A0 .id_table =3D ds3232_id,
> +};
> +
> +static int __init ds3232_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return i2c_add_driver(&ds3232_driver);
> +}
> +
> +static void __exit ds3232_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 i2c_del_driver(&ds3232_driver);
> +}
> +
> +module_init(ds3232_init);
> +module_exit(ds3232_exit);
> +
> +MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>")=
;
> +MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
> +MODULE_LICENSE("GPL");
> --
> 1.5.6.5
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



--=20
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
