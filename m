Return-Path: <tiefei.zang@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 9D946B709D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 18:41:17 +1000 (EST)
Received: by vws9 with SMTP id 9so4061529vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Jul 2010 01:41:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinBY5Gc_PGE-bsbkCHYB0pEApKm0-N-GEljQTNJ@mail.gmail.com>
References: <1278909366-15903-1-git-send-email-tie-fei.zang@freescale.com>
	<AANLkTikK7wsnSVa9Ww5swaAR828edz_zuiBHzV4WZjqw@mail.gmail.com>
	<AANLkTikv5coqQM4duVmexbOM6iIh-IG-wiCqSqjPHzV3@mail.gmail.com>
	<AANLkTinBY5Gc_PGE-bsbkCHYB0pEApKm0-N-GEljQTNJ@mail.gmail.com>
Date: Mon, 12 Jul 2010 16:41:15 +0800
Message-ID: <AANLkTikLpRPtOATvXtX6mWFn3hNmMOHpYAZXXaCxFoso@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH v2] rtc: add support for DS3232 RTC
From: Tiefei zang <tiefei.zang@gmail.com>
To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	B11780@freescale.com, Mingkai.hu@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 12, 2010 at 4:37 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> 2010/7/12 Tiefei zang <tiefei.zang@gmail.com>:
>> On Mon, Jul 12, 2010 at 3:08 PM, Wan ZongShun <mcuos.com@gmail.com> wrot=
e:
>>> 2010/7/12 Roy Zang <tie-fei.zang@freescale.com>:
>>>> This patch adds the driver for RTC chip DS3232 via I2C bus.
>>>>
>>>
>>> I noted this patch is the second version, maybe you can describe which
>>> modifications you have done here.
>>> and add [PATCH v2] to mail subject.
>> I do not think the modification comparing previous version should go
>> into the commit message.
>> I buy in your comments in original version patch and update:
>> 1. add rtc_valid_tm to check return value.
>> 2. remove ioctl function, which do not used and tested.
>> 3. add __devinit for ds3232 probe
>> 4. put request irq after driver registration.
>>
>>>
>>>> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>>>> Signed-off-by: Jingchang Lu <b22599@freescale.com>
>>>> Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
>>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>>>> ---
>>>> Tested on MPC8536DS and P4080DS board
>>>>
>>>> =A0drivers/rtc/Kconfig =A0 =A0 =A0| =A0 11 ++
>>>> =A0drivers/rtc/Makefile =A0 =A0 | =A0 =A01 +
>>>> =A0drivers/rtc/rtc-ds3232.c | =A0427 +++++++++++++++++++++++++++++++++=
+++++++++++++
>>>> =A03 files changed, 439 insertions(+), 0 deletions(-)
>>>> =A0create mode 100644 drivers/rtc/rtc-ds3232.c
>>>>
>>>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>>> index 6a13037..13c2fdb 100644
>>>> --- a/drivers/rtc/Kconfig
>>>> +++ b/drivers/rtc/Kconfig
>>>> @@ -166,6 +166,17 @@ config RTC_DRV_DS1672
>>>> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. If so, t=
he module
>>>> =A0 =A0 =A0 =A0 =A0will be called rtc-ds1672.
>>>>
>>>> +config RTC_DRV_DS3232
>>>> + =A0 =A0 =A0 tristate "Dallas/Maxim DS3232"
>>>> + =A0 =A0 =A0 depends on RTC_CLASS && I2C
>>>> + =A0 =A0 =A0 help
>>>> + =A0 =A0 =A0 =A0 If you say yes here you get support for Dallas Semic=
onductor
>>>> + =A0 =A0 =A0 =A0 DS3232 real-time clock chips. =A0If an interrupt is =
associated
>>>> + =A0 =A0 =A0 =A0 with the device, the alarm functionality is supporte=
d.
>>>> +
>>>> + =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so,=
 the module
>>>> + =A0 =A0 =A0 =A0 will be called rtc-ds3232.
>>>> +
>>>> =A0config RTC_DRV_MAX6900
>>>> =A0 =A0 =A0 =A0tristate "Maxim MAX6900"
>>>> =A0 =A0 =A0 =A0help
>>>> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
>>>> index 44ef194..0af190c 100644
>>>> --- a/drivers/rtc/Makefile
>>>> +++ b/drivers/rtc/Makefile
>>>> @@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_DS1511) =A0+=3D rtc-ds1511.o
>>>> =A0obj-$(CONFIG_RTC_DRV_DS1553) =A0 +=3D rtc-ds1553.o
>>>> =A0obj-$(CONFIG_RTC_DRV_DS1672) =A0 +=3D rtc-ds1672.o
>>>> =A0obj-$(CONFIG_RTC_DRV_DS1742) =A0 +=3D rtc-ds1742.o
>>>> +obj-$(CONFIG_RTC_DRV_DS3232) =A0 +=3D rtc-ds3232.o
>>>> =A0obj-$(CONFIG_RTC_DRV_DS3234) =A0 +=3D rtc-ds3234.o
>>>> =A0obj-$(CONFIG_RTC_DRV_EFI) =A0 =A0 =A0+=3D rtc-efi.o
>>>> =A0obj-$(CONFIG_RTC_DRV_EP93XX) =A0 +=3D rtc-ep93xx.o
>>>> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
>>>> new file mode 100644
>>>> index 0000000..e36ec1c
>>>> --- /dev/null
>>>> +++ b/drivers/rtc/rtc-ds3232.c
>>>> @@ -0,0 +1,427 @@
>>>> +/*
>>>> + * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over=
 I2C
>>>> + *
>>>> + * Copyright (C) 2009-2010 Freescale Semiconductor.
>>>> + *
>>>> + * This program is free software; you can redistribute =A0it and/or m=
odify it
>>>> + * under =A0the terms of =A0the GNU General =A0Public License as publ=
ished by the
>>>> + * Free Software Foundation; =A0either version 2 of the =A0License, o=
r (at your
>>>> + * option) any later version.
>>>> + */
>>>> +/*
>>>> + * It would be more efficient to use i2c msgs/i2c_transfer directly b=
ut, as
>>>> + * recommened in .../Documentation/i2c/writing-clients section
>>>> + * "Sending and receiving", using SMBus level communication is prefer=
red.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/rtc.h>
>>>> +#include <linux/bcd.h>
>>>> +#include <linux/workqueue.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#define DS3232_REG_SECONDS =A0 =A0 0x00
>>>> +#define DS3232_REG_MINUTES =A0 =A0 0x01
>>>> +#define DS3232_REG_HOURS =A0 =A0 =A0 0x02
>>>> +#define DS3232_REG_AMPM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02
>>>> +#define DS3232_REG_DAY =A0 =A0 =A0 =A0 0x03
>>>> +#define DS3232_REG_DATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
>>>> +#define DS3232_REG_MONTH =A0 =A0 =A0 0x05
>>>> +#define DS3232_REG_CENTURY =A0 =A0 0x05
>>>> +#define DS3232_REG_YEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x06
>>>> +#define DS3232_REG_ALARM1 =A0 =A0 =A0 =A0 0x07 /* Alarm 1 BASE */
>>>> +#define DS3232_REG_ALARM2 =A0 =A0 =A0 =A0 0x0B /* Alarm 2 BASE */
>>>> +#define DS3232_REG_CR =A0 =A0 =A0 =A0 =A00x0E =A0 =A0/* Control regis=
ter */
>>>> +# =A0 =A0 =A0define DS3232_REG_CR_nEOSC =A0 =A0 =A0 =A00x80
>>>> +# =A0 =A0 =A0 define DS3232_REG_CR_INTCN =A0 =A0 =A0 =A00x04
>>>> +# =A0 =A0 =A0 define DS3232_REG_CR_A2IE =A0 =A0 =A0 =A00x02
>>>> +# =A0 =A0 =A0 define DS3232_REG_CR_A1IE =A0 =A0 =A0 =A00x01
>>>> +
>>>> +#define DS3232_REG_SR =A00x0F =A0 =A0/* control/status register */
>>>> +# =A0 =A0 =A0define DS3232_REG_SR_OSF =A0 0x80
>>>> +# =A0 =A0 =A0 define DS3232_REG_SR_BSY =A0 0x04
>>>> +# =A0 =A0 =A0 define DS3232_REG_SR_A2F =A0 0x02
>>>> +# =A0 =A0 =A0 define DS3232_REG_SR_A1F =A0 0x01
>>>> +
>>>> +struct ds3232 {
>>>> + =A0 =A0 =A0 struct i2c_client *client;
>>>> + =A0 =A0 =A0 struct rtc_device *rtc;
>>>> + =A0 =A0 =A0 struct work_struct work;
>>>> +
>>>> + =A0 =A0 =A0 /* The mutex protects alarm operations, and prevents a r=
ace
>>>> + =A0 =A0 =A0 =A0* between the enable_irq() in the workqueue and the f=
ree_irq()
>>>> + =A0 =A0 =A0 =A0* in the remove function.
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 struct mutex mutex;
>>>> + =A0 =A0 =A0 int exiting;
>>>> +};
>>>> +
>>>> +static struct i2c_driver ds3232_driver;
>>>> +
>>>> +static int ds3232_check_rtc_status(struct i2c_client *client)
>>>> +{
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 int control, stat;
>>>> +
>>>> + =A0 =A0 =A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_REG_SR)=
;
>>>> + =A0 =A0 =A0 if (stat < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return stat;
>>>> +
>>>> + =A0 =A0 =A0 if (stat & DS3232_REG_SR_OSF)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&client->dev,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "oscilla=
tor discontinuity flagged, "
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "time un=
reliable\n");
>>>> +
>>>> + =A0 =A0 =A0 stat &=3D ~(DS3232_REG_SR_OSF | DS3232_REG_SR_A1F | DS32=
32_REG_SR_A2F);
>>>> +
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_REG_SR,=
 stat);
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>> +
>>>> + =A0 =A0 =A0 /* If the alarm is pending, clear it before requesting
>>>> + =A0 =A0 =A0 =A0* the interrupt, so an interrupt event isn't reported
>>>> + =A0 =A0 =A0 =A0* before everything is initialized.
>>>> + =A0 =A0 =A0 =A0*/
>>>> +
>>>> + =A0 =A0 =A0 control =3D i2c_smbus_read_byte_data(client, DS3232_REG_=
CR);
>>>> + =A0 =A0 =A0 if (control < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return control;
>>>> +
>>>> + =A0 =A0 =A0 control &=3D ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
>>>> + =A0 =A0 =A0 control |=3D DS3232_REG_CR_INTCN;
>>>> +
>>>> + =A0 =A0 =A0 return i2c_smbus_write_byte_data(client, DS3232_REG_CR, =
control);
>>>> +}
>>>> +
>>>> +static int ds3232_read_time(struct device *dev, struct rtc_time *time=
)
>>>> +{
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>>>> + =A0 =A0 =A0 int ret;
>>>> + =A0 =A0 =A0 u8 buf[7];
>>>> + =A0 =A0 =A0 unsigned int year, month, day, hour, minute, second;
>>>> + =A0 =A0 =A0 unsigned int week, twelve_hr, am_pm;
>>>> + =A0 =A0 =A0 unsigned int century, add_century =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_read_i2c_block_data(client, DS3232_REG=
_SECONDS, 7, buf);
>>>> +
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>> + =A0 =A0 =A0 if (ret < 7)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>>>> +
>>>> + =A0 =A0 =A0 second =3D buf[0];
>>>> + =A0 =A0 =A0 minute =3D buf[1];
>>>> + =A0 =A0 =A0 hour =3D buf[2];
>>>> + =A0 =A0 =A0 week =3D buf[3];
>>>> + =A0 =A0 =A0 day =3D buf[4];
>>>> + =A0 =A0 =A0 month =3D buf[5];
>>>> + =A0 =A0 =A0 year =3D buf[6];
>>>> +
>>>> + =A0 =A0 =A0 /* Extract additional information for AM/PM and century =
*/
>>>> +
>>>> + =A0 =A0 =A0 twelve_hr =3D hour & 0x40;
>>>> + =A0 =A0 =A0 am_pm =3D hour & 0x20;
>>>> + =A0 =A0 =A0 century =3D month & 0x80;
>>>> +
>>>> + =A0 =A0 =A0 /* Write to rtc_time structure */
>>>> +
>>>> + =A0 =A0 =A0 time->tm_sec =3D bcd2bin(second);
>>>> + =A0 =A0 =A0 time->tm_min =3D bcd2bin(minute);
>>>> + =A0 =A0 =A0 if (twelve_hr) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Convert to 24 hr */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (am_pm)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time->tm_hour =3D bcd2bi=
n(hour & 0x1F) + 12;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time->tm_hour =3D bcd2bi=
n(hour & 0x1F);
>>>> + =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 time->tm_hour =3D bcd2bin(hour);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 time->tm_wday =3D bcd2bin(week);
>>>> + =A0 =A0 =A0 time->tm_mday =3D bcd2bin(day);
>>>> + =A0 =A0 =A0 time->tm_mon =3D bcd2bin(month & 0x7F);
>>>> + =A0 =A0 =A0 if (century)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_century =3D 100;
>>>> +
>>>> + =A0 =A0 =A0 time->tm_year =3D bcd2bin(year) + add_century;
>>>> +
>>>> + =A0 =A0 =A0 return rtc_valid_tm(time);
>>>> +}
>>>> +
>>>> +static int ds3232_set_time(struct device *dev, struct rtc_time *time)
>>>> +{
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>>>> + =A0 =A0 =A0 u8 buf[7];
>>>> +
>>>> + =A0 =A0 =A0 /* Extract time from rtc_time and load into ds3232*/
>>>> +
>>>> + =A0 =A0 =A0 buf[0] =3D bin2bcd(time->tm_sec);
>>>> + =A0 =A0 =A0 buf[1] =3D bin2bcd(time->tm_min);
>>>> + =A0 =A0 =A0 buf[2] =3D bin2bcd(time->tm_hour);
>>>> + =A0 =A0 =A0 buf[3] =3D bin2bcd(time->tm_wday); /* Day of the week */
>>>> + =A0 =A0 =A0 buf[4] =3D bin2bcd(time->tm_mday); /* Date */
>>>> + =A0 =A0 =A0 buf[5] =3D bin2bcd(time->tm_mon);
>>>> + =A0 =A0 =A0 if (time->tm_year >=3D 100) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[5] |=3D 0x80;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[6] =3D bin2bcd(time->tm_year - 100);
>>>> + =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[6] =3D bin2bcd(time->tm_year);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 return i2c_smbus_write_i2c_block_data(client,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DS3232_REG_SECONDS, 7, buf);
>>>> +}
>>>> +
>>>> +/*
>>>> + * DS3232 has two alarm, we only use alarm1
>>>> + * According to linux specification, only support one-shot alarm
>>>> + * no periodic alarm mode
>>>> + */
>>>> +static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *a=
larm)
>>>> +{
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>>>> + =A0 =A0 =A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(client);
>>>> + =A0 =A0 =A0 int control, stat;
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 u8 buf[4];
>>>> +
>>>> + =A0 =A0 =A0 mutex_lock(&ds3232->mutex);
>>>> + =A0 =A0 =A0 stat =3D ret =3D i2c_smbus_read_byte_data(client, DS3232=
_REG_SR);
>>>> + =A0 =A0 =A0 if (stat < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> +
>>>> + =A0 =A0 =A0 control =3D ret =3D i2c_smbus_read_byte_data(client, DS3=
232_REG_CR);
>>>> + =A0 =A0 =A0 if (control < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_read_i2c_block_data(client, DS3232_REG=
_ALARM1, 4, buf);
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> +
>>>> + =A0 =A0 =A0 alarm->time.tm_sec =3D bcd2bin(buf[0] & 0x7F);
>>>> + =A0 =A0 =A0 alarm->time.tm_min =3D bcd2bin(buf[1] & 0x7F);
>>>> + =A0 =A0 =A0 alarm->time.tm_hour =3D bcd2bin(buf[2] & 0x7F);
>>>> + =A0 =A0 =A0 alarm->time.tm_mday =3D bcd2bin(buf[3] & 0x7F);
>>>> +
>>>> + =A0 =A0 =A0 alarm->time.tm_mon =3D -1;
>>>> + =A0 =A0 =A0 alarm->time.tm_year =3D -1;
>>>> + =A0 =A0 =A0 alarm->time.tm_wday =3D -1;
>>>> + =A0 =A0 =A0 alarm->time.tm_yday =3D -1;
>>>> + =A0 =A0 =A0 alarm->time.tm_isdst =3D -1;
>>>> +
>>>> + =A0 =A0 =A0 alarm->enabled =3D !!(control & DS3232_REG_CR_A1IE);
>>>> + =A0 =A0 =A0 alarm->pending =3D !!(stat & DS3232_REG_SR_A1F);
>>>> +out:
>>>> + =A0 =A0 =A0 mutex_unlock(&ds3232->mutex);
>>>> +
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> +/*
>>>> + * linux rtc-module does not support wday alarm
>>>> + * and only 24h time mode supported indeed
>>>> + */
>>>> +static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *al=
arm)
>>>> +{
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>>>> + =A0 =A0 =A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(client);
>>>> + =A0 =A0 =A0 int control, stat;
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 u8 buf[4];
>>>> +
>>>> + =A0 =A0 =A0 if (client->irq <=3D 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>> +
>>>> + =A0 =A0 =A0 mutex_lock(&ds3232->mutex);
>>>> +
>>>> + =A0 =A0 =A0 buf[0] =3D bin2bcd(alarm->time.tm_sec);
>>>> + =A0 =A0 =A0 buf[1] =3D bin2bcd(alarm->time.tm_min);
>>>> + =A0 =A0 =A0 buf[2] =3D bin2bcd(alarm->time.tm_hour);
>>>> + =A0 =A0 =A0 buf[3] =3D bin2bcd(alarm->time.tm_mday);
>>>> +
>>>> + =A0 =A0 =A0 /* clear alarm interrupt enable bit */
>>>> + =A0 =A0 =A0 ret =3D control =3D i2c_smbus_read_byte_data(client, DS3=
232_REG_CR);
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 control &=3D ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_REG_CR,=
 control);
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> +
>>>> + =A0 =A0 =A0 /* clear any pending alarm flag */
>>>> + =A0 =A0 =A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_REG_SR)=
;
>>>> + =A0 =A0 =A0 if (stat < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return stat;
>>>> +
>>>> + =A0 =A0 =A0 stat &=3D ~(DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
>>>> +
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, DS3232_REG_SR,=
 stat);
>>>> + =A0 =A0 =A0 if (ret < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D i2c_smbus_write_i2c_block_data(client,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 DS3232_REG_ALARM1, 4, buf);
>>>> +
>>>> + =A0 =A0 =A0 if (alarm->enabled) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D DS3232_REG_CR_A1IE;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client=
, DS3232_REG_CR, control);
>>>> + =A0 =A0 =A0 }
>>>> +out:
>>>> + =A0 =A0 =A0 mutex_unlock(&ds3232->mutex);
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> +static irqreturn_t ds3232_irq(int irq, void *dev_id)
>>>> +{
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D dev_id;
>>>> + =A0 =A0 =A0 struct ds3232 *ds3232 =3D i2c_get_clientdata(client);
>>>> +
>>>> + =A0 =A0 =A0 disable_irq_nosync(irq);
>>>> + =A0 =A0 =A0 schedule_work(&ds3232->work);
>>>> + =A0 =A0 =A0 return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static void ds3232_work(struct work_struct *work)
>>>> +{
>>>> + =A0 =A0 =A0 struct ds3232 *ds3232 =3D container_of(work, struct ds32=
32, work);
>>>> + =A0 =A0 =A0 struct i2c_client *client =3D ds3232->client;
>>>> + =A0 =A0 =A0 int stat, control;
>>>> +
>>>> + =A0 =A0 =A0 mutex_lock(&ds3232->mutex);
>>>> +
>>>> + =A0 =A0 =A0 stat =3D i2c_smbus_read_byte_data(client, DS3232_REG_SR)=
;
>>>> + =A0 =A0 =A0 if (stat < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>>>> +
>>>> + =A0 =A0 =A0 if (stat & DS3232_REG_SR_A1F) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 control =3D i2c_smbus_read_byte_data(cli=
ent, DS3232_REG_CR);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (control < 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable alarm1 interrupt */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 control &=3D ~(DS3232_REG_CR_A1IE);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_smbus_write_byte_data(client, DS3232=
_REG_CR, control);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear the alarm pend flag */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat &=3D ~DS3232_REG_SR_A1F;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_smbus_write_byte_data(client, DS3232=
_REG_SR, stat);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_update_irq(ds3232->rtc, 1, RTC_AF | =
RTC_IRQF);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> +out:
>>>> + =A0 =A0 =A0 if (!ds3232->exiting)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(client->irq);
>>>> +unlock:
>>>> + =A0 =A0 =A0 mutex_unlock(&ds3232->mutex);
>>>> +}
>>>> +
>>>> +static const struct rtc_class_ops ds3232_rtc_ops =3D {
>>>> + =A0 =A0 =A0 .read_time =3D ds3232_read_time,
>>>> + =A0 =A0 =A0 .set_time =3D ds3232_set_time,
>>>> + =A0 =A0 =A0 .read_alarm =3D ds3232_read_alarm,
>>>> + =A0 =A0 =A0 .set_alarm =3D ds3232_set_alarm,
>>>> +};
>>>
>>> I sew that you have discarded the .ioctl function, which is used to
>>> enable/disable the alarm irq in previous driver patch.
>>> but,at the same time, you didnot implement .alarm_irq_enable function
>>> , so is there no need to enable or disable the alarm irq bit in
>>> current version patch?
>> Right. This is not needed in current patch. Alarm is not used and tested=
.
>> Thanks.
>
> Sorry for forgetting to comment this,
> If the alarm is not used, please remove all the alarm parts, should
> not we make sure all drivers submitted to linux mainline
> can work good?
>
> When you want to use the alarm, you can send one patch to add it again.
This makes sense to me. I will send a new patch.
Roy
