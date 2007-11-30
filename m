Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 501E8DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 05:11:57 +1100 (EST)
Message-ID: <47505271.8030102@anagramm.de>
Date: Fri, 30 Nov 2007 19:12:01 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
In-Reply-To: <20071130122055.729dd3f8@i1501.lan.towertech.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi, Alessandro!

Alessandro Zummo schrieb:
> On Fri, 30 Nov 2007 12:04:00 +0100
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
>> Modular doesn't make sense to me, because the filesystem check starts
>> to complain when last mount time was way to far in the past or in
>> the future. But I will try...
> 
>  It's just to see if there's any timing issue like module-coming-up-before-bus-and/or-rtc.
>  it should work anyway, but who knows...

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ modprobe rtc-ds1307

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by
rtc_ds1307              6944  0
i2c_core               29936  1 rtc_ds1307
rtc_core               24248  1 rtc_ds1307
rtc_lib                 3456  2 rtc_ds1307,rtc_core

i2c_core doesn't pull in i2c_mpc (the MPC107/85xx i2c driver)!

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ modprobe i2c-mpc

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by
i2c_mpc                 8128  0
rtc_ds1307              6944  0
i2c_core               29936  2 i2c_mpc,rtc_ds1307
rtc_core               24248  1 rtc_ds1307
rtc_lib                 3456  2 rtc_ds1307,rtc_core

it's still unused.
Doing it the other way around:

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ modprobe i2c-mpc

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by
i2c_mpc                 8128  0
i2c_core               29936  1 i2c_mpc

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ modprobe rtc-ds1307

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ lsmod
Module                  Size  Used by
rtc_ds1307              6944  0
rtc_core               24248  1 rtc_ds1307
rtc_lib                 3456  2 rtc_ds1307,rtc_core
i2c_mpc                 8128  0
i2c_core               29936  2 rtc_ds1307,i2c_mpc

root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/i2c/busses$ cd /dev

root@fox_1:/dev$ ls -la r*
crw-rw-rw- 1 root root 1, 8 Jan  1  1970 random


I guess I'll have to dig in the code now since this is a
100% road block for my project. :-(

Does it make sense to pickup some I2C people here?
Same story, next week... Have a nice weekend.

If you come up with some idea / patches, still let me know,
I'll be able to login remotely.

Thank you,
Regards,

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
