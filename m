Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 42714DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 22:04:21 +1100 (EST)
Message-ID: <474FEE20.6070606@anagramm.de>
Date: Fri, 30 Nov 2007 12:04:00 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
In-Reply-To: <20071129211912.46da8f5b@i1501.lan.towertech.it>
Content-Type: multipart/mixed; boundary="------------050406090006040509090601"
Cc: rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050406090006040509090601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Alessandro!

Alessandro Zummo schrieb:
 > On Thu, 29 Nov 2007 21:03:49 +0100
 > Clemens Koller <clemens.koller@anagramm.de> wrote:
 >
 >>>> My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
 >>>> and it also breaks the deprecated SENSORS_DS1337. :-(
 >> One more update:
 >> I am back to mainline (linus' .git) on 2.6.24-rc3-g09f345da to
 >> verify that the problem with the RTC still persists.
 >>
 >> I startet to bisect, but ran quickly into other crashes.
 >> (no console on 2.6.23-rc2 and 2.6.23)
 >> So, I just can tell that it broke in between 2.6.22-rc6-gb75ae860 and
 >> and 2.6.24-rc2-ge6a5c27f.
 >
 >  did you tried compiling it modular? you might even check with
 >  i2cdetect if the chip is there

A kernel upgrade doesn't make the chip to disappear ;-)
The I2C bus is/was basically working fine all the time... see below.

Modular doesn't make sense to me, because the filesystem check starts
to complain when last mount time was way to far in the past or in
the future. But I will try...

I can:

$ uname -a
Linux fox_1 2.6.24-rc3-g09f345da #1 Thu Nov 29 21:21:39 CET 2007 ppc e500 GNU/Linux
$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
50: UU -- -- -- -- -- -- UU -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

At 0x68 is the DS1337,
at 0x48 I have an LM75
at 0x50 and 0x57 there is some EEPROM attached

$ i2cdump 0 0x68 b
Error: Could not set address to 0x68: Device or resource busy

That would tell me AFAICT that the ds1307 driver claimed that
address already... But...
Well, I've attached the config again.
(Note, I enabled the SENSORS_x during my manual bisecting again to
find where it doesn't work anymore. Disabling them didn't work for
sure, but will retry now...)

Regards,
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


--------------050406090006040509090601
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
/wHtduZk7m0AAA==
--------------050406090006040509090601--
