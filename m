Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 3785CDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 05:24:56 +1100 (EST)
Message-ID: <474DB27C.7020909@anagramm.de>
Date: Wed, 28 Nov 2007 19:25:00 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, rtc-linux@googlegroups.com,
	a.zummo@towertech.it
Subject: DS1337 RTC on I2C broken.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, there!

(Only subscribed to linuxppc-embedded and lkml; otherwise, please CC)


Well, as already mentioned, I have problems to get my DS1337 RTC on I2C
on my MPC8540(ads like) PowerPC working properly on
latest 2.6.24-rc2-ge6a5c27f kernels. A paulus.git 2.6.21-rc5-g9a5ee4cc
as well as a 2.6.22-rc6-gb75ae860 is working fine.
(mainstream's console is broken, so cannot test these, yet.)


My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
and it also breaks the deprecated SENSORS_DS1337. :-(


Before I start bisecting and digging in the code (I'm booting from
flash, so it isn't fun to change kernels on the fly), I just want
to verify that my configuration is correct.

I am using hwclock-2.31 from Bryan Henderson since the one
which comes with util-linux doesn't support to choose another
rtc device than /dev/rtc.

Here is a snippet from my .config which is similar among my kernels.
CONFIG_GEN_RTC=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MPC=y
CONFIG_SENSORS_DS1337=y
CONFIG_SENSORS_DS1374=y
CONFIG_SENSORS_EEPROM=y
CONFIG_SENSORS_M41T00=y
CONFIG_HWMON=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DEBUG=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_TEST=m
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_LIB=y

So, I enabled both, the new rtc-lib DS1307 (which is compatible to the DS1337)
and the deprecated SENSORS_DS1337.
Deselecting SENSORS_* doesn't help.

My /etc/udev/rules.d/50-udev-default.rules contains the line:
KERNEL=="rtc[0-9]*",            MODE="0666"


When the RTC is working, I get the following:

dmesg:
------
i2c /dev entries driver
ds1307 0-0068: rtc core: registered ds1307 as rtc0
ds1307 0-0068: setting the system clock to 2007-11-28 18:56:33 (1196276193)

and I get:

root@fox_1:/dev$ l rtc*
crw-r--r-- 1 root root  10, 135 Jan  1  2000 rtc
crw-rw---- 1 root root 239,   0 Jan  1  2000 rtc0
(Jan 1 2000 is the default date when the rtc chip was powered down, so the
rtc was read successfully.)

$hwclock --systohc --rtc /dev/rtc0
is working properly...

When it's NOT working (2.6.24-rc2-git with some debugging enabled) I get:

dmesg:
------
i2c /dev entries driver
device class 'i2c-dev': registering
bus i2c: add driver dev_driver
bus platform: add driver fsl-i2c
platform: Matched Device fsl-i2c.0 with Driver fsl-i2c
platform: Probing driver fsl-i2c with device fsl-i2c.0
DEV: registering device: ID = 'i2c-0'
DEV: registering device: ID = 'i2c-0'
bound device 'fsl-i2c.0' to driver 'fsl-i2c'
platform: Bound Device fsl-i2c.0 to Driver fsl-i2c
bus i2c: add driver ds1337
DEV: registering device: ID = '0-0068'
bus i2c: add device 0-0068
bound device '0-0068' to driver 'ds1337'
bus i2c: add driver lm75
DEV: registering device: ID = '0-0048'
bus i2c: add device 0-0048
bound device '0-0048' to driver 'lm75'
DEV: registering device: ID = 'hwmon0'
bus i2c: add driver max6650

$ ls /dev/rt*
crw-r--r-- 1 root root  10, 135 Jan  1  1970 rtc

and

$ cat /proc/driver/rtc
rtc_time        : 00:00:570426440
rtc_date        : 269131772-01-00
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 0
batt_status     : okay

shows up but these values never seem to get an update.
(==stable among reboots) :-(


My /etc/udev/50-udev-default.rules
contains
KERNEL=="rtc",                    MODE="0644"

Any ideas to debug?


-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
