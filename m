Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 7469567A76
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 18:35:34 +1100 (EST)
Received: from edge1.siol.net ([10.10.10.210]) by mta1.siol.net with ESMTP
	id <20050214073531.JMIX5451.mta1.siol.net@edge1.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 Feb 2005 08:35:31 +0100
Received: from linux.asist ([193.95.241.43]) by edge1.siol.net with ESMTP
	id <20050214073526.BFNK1150.edge1.siol.net@linux.asist>
	for <linuxppc-embedded@ozlabs.org>; Mon, 14 Feb 2005 08:35:26 +0100
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id 0A25D644A9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 08:35:17 +0100 (CET)
Message-ID: <421054B5.9030805@asist-traffic.com>
Date: Mon, 14 Feb 2005 08:35:17 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <420A4CF3.5090902@anagramm.de>
In-Reply-To: <420A4CF3.5090902@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Are the I2C drivers on MPC8540 Kernel 2.6.10 working?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clemens Koller wrote:

> Hello,
>
> My questions:
> Is I2C and the Real Time Clock stuff working for the MPC8540
> in Kernel 2.6.10?
> Are there any hidden bugs/traps/features I need to tweak?
> Does anybody work successfully with the I2C in
> this configuration?
>
Don't know about bugs/traps ... I guess you will need to test it out
I managed to get things working on my MPC5200 board and for
EPSON RX-8025 RTC chip that sits on I2C bus. Driver needs some
more tweaking but it basically works. All this was based on
Stefan Eletzhofer's work on RTC8564 and some other stuff I read about
on LKML archives.

> My problems:
> I try to get a I2C Philips PCF8563 Real Time Clock working which
> is connected to the I2C of my MPC8540 processor.
> The chip should be sw-compatible with the Epson RTC8564 component
> (according to the datasheets), so I tried to enable the MPC85xx
> I2C bus, the EPSON RTC8564 and the Kernel RTC support.
> I tried several configs - compiled i2c into the kernel or as a
> modules to load and unload them with debug=1
>
> I cannot access /dev/misc/rtc with the hwclock (latest version=2.23):
> -----8<------------------------------------
> hwclock -w
> hwclock: ioctl() (RTC_SET_TIME) to /dev/misc/rtc to set time failed, 
> errno = Invalid argument (22).
> -----8<------------------------------------
>
This is probably because you included RTC driver that is for BIOS based
RTC clocks. ( and the Kernel RTC support.)
You need to write one that will access routines in RTC8564 driver.
IIRC BIOS RTC driver gets up pretty fast after boot up. You don't need
that because you have an I2C based RTC device. Your RTC driver
needs to get initialized only after you have initialized I2C protocol first.
What I did basicaly is this:
-I modified RTC8564 driver to fit mine RTC chip (EPSON RX=8025),
-I modified a RTC driver I got from Stefan Eletzhofer. It  creates 
/dev/misc/rtc
device and accesses routines in my RTC8025 driver,
-Added a function 2c_get_client() to i2c-core.c . This function
was removed from from i2c-core.c at some point but was still
listed in include/linux/i2c.h .
I read that from LKML archives.
hwclock works just fine right now. :D

> Now I try to work with the modules and try to track down
> the problem:
>
> after a modprobe rtc8564:
> -----8<------------------------------------
> i2c_adapter i2c-0: examining adapter
> i2c-core: driver unregistered: RTC8564
> i2c-core: driver RTC8564 registered.
> i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
> Doing write 0 bytes to 0x51 - 1 of 1 messages
> rtc8564_attach: client=c02c1e00
> rtc8564_attach: client.id=61440
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
> Doing write 2 bytes to 0x51 - 1 of 1 messages
> I2C: No RXAK
> rtc8564: cant init ctrl1
> i2c-core: unregister_driver - looking for clients.
> i2c_adapter i2c-0: examining adapter
> i2c-core: driver unregistered: RTC8564
> i2c_adapter i2c-0: adapter unregistered
> i2c-core: driver RTC8564 registered.
> -----8<------------------------------------
> Module                  Size  Used by
> rtc8564                 6660  0
> i2c_core               25264  1 rtc8564
> -----8<------------------------------------
>
> and after a modprobe i2c-mpc I get:
> -----8<------------------------------------
> i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
> Doing write 0 bytes to 0x51 - 1 of 1 messages
> rtc8564_attach: client=c02c1200
> rtc8564_attach: client.id=61440
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
> Doing write 2 bytes to 0x51 - 1 of 1 messages
> I2C: No RXAK
> rtc8564: cant init ctrl1
> i2c_adapter i2c-0: registered as adapter #0
> -----8<------------------------------------
> Module                  Size  Used by
> i2c_mpc                 5376  0
> rtc8564                 6660  0
> i2c_core               25264  2 i2c_mpc,rtc8564
> -----8<------------------------------------
>
> So, the output looks basically fine, except of the
>
> I2C: No RXAK
> rtc8564: cant init ctrl1
>
> Which means that I don't get an ACK from my RTC.
> I connected an oscilloscope to the I2C - there
> is a lot of traffic. So I believe that the problem
> is more on the protocol side?
>
As suggested earlier try checking your I2C address of
the RTC chip. I had exactly the same problem until
I found the address. The manual said one thing but
I guess board designers had different ideas. I didn't go
into details but somehow address changed from 0x64 to 0x32.
I would also suggests you cross compile the following tools.
i2cdetect, i2cdump and i2cset . They can help a lot.
You will get them at http://secure.netroedge.com/~lm78/ .

I hope this helps. I can also send you mine dirty hacks if you want
but they aren't ready for public yet. :D

regards,
Ivica
