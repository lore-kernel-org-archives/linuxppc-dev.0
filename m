Return-Path: <florisla@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id A9C29DDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 21:38:28 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s19so1677472wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 04:38:26 -0700 (PDT)
Message-ID: <576210b90704230438h168e15a7q5fc309d791db52b6@mail.gmail.com>
Date: Mon, 23 Apr 2007 13:38:26 +0200
From: "Floris Lambrechts" <florisla@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: PCF8563 realtime clock does not initialize
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a custom board with an ppc8540 cpu.  I'm using a vanilla Linux
kernel 2.6.20.3.

The RTC chip is a PCF8563, connected to 8540's i2c controller at
address 0x51. In u-boot the clock works fine ('date' command) so the
hardware is alright.

In Linux however, I get this at boot:

(...)
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
(...)

I have compiled in the PCF8563 rtc driver (not as module), and have
support for RTC class, /dev, /proc and /sys. However, the entries in
/proc and /sys relevant to the RTC remain empty.

I have created a device node /dev/rtc0 with major/minor 254, 0 (254
being what is listed as rtc in /proc/devices).

For some reason, PCF8563 driver does not initialize correctly. I'm
looking for a hint where to look for finding the cause of this...

Some further info:
ARCH=ppc, CROSS_COMPILE=ppc_85xx- (from ELDK 4), boot loader is u-boot 1.2.0.

Thansk for any help.
Regards
Floris
