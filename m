Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.189]) by ozlabs.org (Postfix) with ESMTP id A8DE367AC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 04:45:35 +1100 (EST)
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Cyvu9-0004s0-00
	for linuxppc-embedded@ozlabs.org; Wed, 09 Feb 2005 18:45:33 +0100
Received: from [84.154.121.20] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1Cyvu8-0006Ko-00
	for linuxppc-embedded@ozlabs.org; Wed, 09 Feb 2005 18:45:32 +0100
Message-ID: <420A4CF3.5090902@anagramm.de>
Date: Wed, 09 Feb 2005 18:48:35 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Are the I2C drivers on MPC8540 Kernel 2.6.10 working?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

My questions:
Is I2C and the Real Time Clock stuff working for the MPC8540
in Kernel 2.6.10?
Are there any hidden bugs/traps/features I need to tweak?
Does anybody work successfully with the I2C in
this configuration?

My problems:
I try to get a I2C Philips PCF8563 Real Time Clock working which
is connected to the I2C of my MPC8540 processor.
The chip should be sw-compatible with the Epson RTC8564 component
(according to the datasheets), so I tried to enable the MPC85xx
I2C bus, the EPSON RTC8564 and the Kernel RTC support.
I tried several configs - compiled i2c into the kernel or as a
modules to load and unload them with debug=1

I cannot access /dev/misc/rtc with the hwclock (latest version=2.23):
-----8<------------------------------------
hwclock -w
hwclock: ioctl() (RTC_SET_TIME) to /dev/misc/rtc to set time failed, 
errno = Invalid argument (22).
-----8<------------------------------------

Now I try to work with the modules and try to track down
the problem:

after a modprobe rtc8564:
-----8<------------------------------------
i2c_adapter i2c-0: examining adapter
i2c-core: driver unregistered: RTC8564
i2c-core: driver RTC8564 registered.
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
i2c_adapter i2c-0: master_xfer: with 1 msgs.
Doing write 0 bytes to 0x51 - 1 of 1 messages
rtc8564_attach: client=c02c1e00
rtc8564_attach: client.id=61440
i2c_adapter i2c-0: master_xfer: with 1 msgs.
Doing write 2 bytes to 0x51 - 1 of 1 messages
I2C: No RXAK
rtc8564: cant init ctrl1
i2c-core: unregister_driver - looking for clients.
i2c_adapter i2c-0: examining adapter
i2c-core: driver unregistered: RTC8564
i2c_adapter i2c-0: adapter unregistered
i2c-core: driver RTC8564 registered.
-----8<------------------------------------
Module                  Size  Used by
rtc8564                 6660  0
i2c_core               25264  1 rtc8564
-----8<------------------------------------

and after a modprobe i2c-mpc I get:
-----8<------------------------------------
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
i2c_adapter i2c-0: master_xfer: with 1 msgs.
Doing write 0 bytes to 0x51 - 1 of 1 messages
rtc8564_attach: client=c02c1200
rtc8564_attach: client.id=61440
i2c_adapter i2c-0: master_xfer: with 1 msgs.
Doing write 2 bytes to 0x51 - 1 of 1 messages
I2C: No RXAK
rtc8564: cant init ctrl1
i2c_adapter i2c-0: registered as adapter #0
-----8<------------------------------------
Module                  Size  Used by
i2c_mpc                 5376  0
rtc8564                 6660  0
i2c_core               25264  2 i2c_mpc,rtc8564
-----8<------------------------------------

So, the output looks basically fine, except of the

I2C: No RXAK
rtc8564: cant init ctrl1

Which means that I don't get an ACK from my RTC.
I connected an oscilloscope to the I2C - there
is a lot of traffic. So I believe that the problem
is more on the protocol side?

Does somebody have any suggestions before I dig into
the code?
Thank you in advance!

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
