Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 83CB6DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 19:15:16 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8K9FEEX028609
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 02:15:15 -0700 (PDT)
Message-ID: <46F238BB.4040007@windriver.com>
Date: Thu, 20 Sep 2007 17:09:15 +0800
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: The  ds1337 chip on fsl_mp8313E RDB REVA 3 doesn't  work properly
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,
The same u-boot/kernel/rootfs on fsl_mp8313E RDB REVA 2, DS1337  RTC
chip can work,
but on sl_mp8313E RDB REVA 3, it doesn't work, its time don't change.

This RTC chip  specific bad behavior on sl_mp8313E RDB REVA 3  as follows:
(1) On U-Boot (from Freescale), run command:
=> i2c md 0x68 0x0
0000: 32 33 10 04 20 89 08 84 00 20 53 00 42 16 18 80    23.. .... S.B...
after a while
=> i2c md 0x68 0x0
0000: 32 33 10 04 20 89 08 84 00 20 53 00 42 16 18 80    23.. .... S.B...

The first value(second value) is unchanged always, but on  fsl_mp8313E
RDB REVA 2, it changes.
meanwhile, we can change this value through i2c nm 0x68  0xX on 
fsl_mp8313E RDB REVA 3.

SO the core of this problem is the time always keeps same.

(2) during Linux kernel bootup, we can see:
 oing write 0 bytes to 0x68 - 1 of 1 messages
i2c_adapter i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c_adapter i2c-0: master_xfer[1] R, addr=0x68, len=8
Doing write 1 bytes to 0x68 - 1 of 2 messages
Doing read 8 bytes to 0x68 - 2 of 2 messages
i2c_adapter i2c-0: client [ds1307] registered with bus id 0-0068
ds1307 0-0068: rtc intf: sysfs
ds1307 0-0068: rtc intf: proc
ds1307 0-0068: rtc intf: dev (254:0)
ds1307 0-0068: rtc core: registered ds1307 as rtc0
i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x68
i2c_adapter i2c-1: master_xfer[0] W, addr=0x68, len=0
Doing write 0 bytes to 0x68 - 1 of 1 messages
I2C: No RXAK
..............................
i2c_adapter i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c_adapter i2c-0: master_xfer[1] R, addr=0x68, len=7
Doing write 1 bytes to 0x68 - 1 of 2 messages
Doing read 7 bytes to 0x68 - 2 of 2 messages
ds1307 0-0068: read: 32 33 10 04 20 89 08
ds1307 0-0068: read secs=32, mins=33, hours=10, mday=20, mon=8,
year=108, wday=3
ds1307 0-0068: setting the system clock to 2008-09-20 10:33:32 (1221906812)

it indicates can  read and write RTC chip through I2C. but after system
boot up,  we can see the time always same.

After  adjusting these configurations on  U-Boot environment according
to fsl_mp8313E RDB REVA 2, it still doesn't work.

Who can give me some advice or suggestion ?  currently I doubt this
hardware, but  what a shame I have only one fsl_mp8313E RDB REVA 3 board,
can't  do comparison experiment.
 
Thanks in advance.
Andrew Liu
