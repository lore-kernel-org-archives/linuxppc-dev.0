Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4560B67A95
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 06:26:46 +1100 (EST)
In-Reply-To: <420A4CF3.5090902@anagramm.de>
References: <420A4CF3.5090902@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <86EC2676-7AD0-11D9-B269-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 9 Feb 2005 13:26:41 -0600
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
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

One issue with the 2.6.10 driver was it was very slow.  I changed some=20=

sleep calls in 2.6.11 to improve its performance.  You may want to try=20=

grabbing the driver out of 2.6.11-rc3 and see if that helps also.

- kumar

On Feb 9, 2005, at 11:48 AM, Clemens Koller wrote:

> Hello,
>
> My questions:
>  Is I2C and the Real Time Clock stuff working for the MPC8540
>  in Kernel 2.6.10?
>  Are there any hidden bugs/traps/features I need to tweak?
>  Does anybody work successfully with the I2C in
>  this configuration?
>
> My problems:
>  I try to get a I2C Philips PCF8563 Real Time Clock working which
>  is connected to the I2C of my MPC8540 processor.
>  The chip should be sw-compatible with the Epson RTC8564 component
>  (according to the datasheets), so I tried to enable the MPC85xx
>  I2C bus, the EPSON RTC8564 and the Kernel RTC support.
>  I tried several configs - compiled i2c into the kernel or as a
>  modules to load and unload them with debug=3D1
>
> I cannot access /dev/misc/rtc with the hwclock (latest version=3D2.23):
>  -----8<------------------------------------
>  hwclock -w
>  hwclock: ioctl() (RTC_SET_TIME) to /dev/misc/rtc to set time failed,
> errno =3D Invalid argument (22).
> -----8<------------------------------------
>
> Now I try to work with the modules and try to track down
>  the problem:
>
> after a modprobe rtc8564:
>  -----8<------------------------------------
>  i2c_adapter i2c-0: examining adapter
>  i2c-core: driver unregistered: RTC8564
>  i2c-core: driver RTC8564 registered.
>  i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
>  i2c_adapter i2c-0: master_xfer: with 1 msgs.
>  Doing write 0 bytes to 0x51 - 1 of 1 messages
>  rtc8564_attach: client=3Dc02c1e00
> rtc8564_attach: client.id=3D61440
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
>  Doing write 2 bytes to 0x51 - 1 of 1 messages
>  I2C: No RXAK
>  rtc8564: cant init ctrl1
>  i2c-core: unregister_driver - looking for clients.
>  i2c_adapter i2c-0: examining adapter
>  i2c-core: driver unregistered: RTC8564
>  i2c_adapter i2c-0: adapter unregistered
>  i2c-core: driver RTC8564 registered.
>  -----8<------------------------------------
>  Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 =
Used by
>  rtc8564=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6660=A0 0
>  i2c_core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25264=A0 1 rtc8564
>  -----8<------------------------------------
>
> and after a modprobe i2c-mpc I get:
>  -----8<------------------------------------
>  i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
>  i2c_adapter i2c-0: master_xfer: with 1 msgs.
>  Doing write 0 bytes to 0x51 - 1 of 1 messages
>  rtc8564_attach: client=3Dc02c1200
> rtc8564_attach: client.id=3D61440
> i2c_adapter i2c-0: master_xfer: with 1 msgs.
>  Doing write 2 bytes to 0x51 - 1 of 1 messages
>  I2C: No RXAK
>  rtc8564: cant init ctrl1
>  i2c_adapter i2c-0: registered as adapter #0
>  -----8<------------------------------------
>  Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 =
Used by
>  i2c_mpc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5376=A0 0
>  rtc8564=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6660=A0 0
>  i2c_core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25264=A0 2 =
i2c_mpc,rtc8564
> -----8<------------------------------------
>
> So, the output looks basically fine, except of the
>
> I2C: No RXAK
>  rtc8564: cant init ctrl1
>
> Which means that I don't get an ACK from my RTC.
>  I connected an oscilloscope to the I2C - there
> is a lot of traffic. So I believe that the problem
>  is more on the protocol side?
>
> Does somebody have any suggestions before I dig into
>  the code?
>  Thank you in advance!
>
> Best greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
>  Anagramm GmbH
>  Rupert-Mayer-Str. 45/1
>  81379 Muenchen
>  Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
>  Fax: +49-89-741518-19
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
