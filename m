Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3400FDDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 09:59:01 +1100 (EST)
Date: Mon, 1 Dec 2008 14:57:46 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: i2c-mpc clocking scheme
In-Reply-To: <49346497.8050701@freescale.com>
Message-ID: <Pine.LNX.4.64.0812011438550.10176@t2.domain.actdsltmp>
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com> <49343DC2.3070601@matrix-vision.de>
	<Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
	<49346497.8050701@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?X-UNKNOWN?Q?Andr=C3=A9_Schwarz?= <Andre.Schwarz@matrix-vision.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 1 Dec 2008, Scott Wood wrote:
> Trent Piepho wrote:
>>  U-boot could pass in "bus-frequency" to let software know the speed of the
>>  I2C bus from Linux.  Seems like a standard property for bus nodes.
>
> clock-frequency is standard, though it should probably be the input frequency 
> rather than the bus frequency, in case the OS really does want to change it 
> (maybe making the bus run faster when accessing faster devices).

For a bus device like an i2c controller, you really have two clocks.  The
input clock the controller runs from and the speed it runs the bus at.  One
could say that one clock is for the device node and the other clock is for
the device's sub-nodes.

Linux doesn't have an API for setting I2C bus speed.  If it did, then
adding support for it to i2c-mpc if there was demand would really be
another patch.  Right now the problem is that Linux programs the I2C
controller stupidly and undoes u-boot's (better) settings.

>>  There could be a "current-speed" property that tells linux to keep the
>>  registers the same,
>
> That would be a bit different from the way it's used in serial nodes, where 
> current-speed is simply a description of the baud rate that corresponds to 
> the current divider setting.  I'm not sure that it makes as much sense for 
> i2c, as you don't have the shared state on the other end that depends on 
> maintaining the exact same speed.

The Linux code could use current-speed to know if it should program the
registers.  I.e., if current-speed is present and non-zero, then leave the
frequency registers alone.  Otherwise u-boot or whatever might not have
programmed the I2C controller and the driver can do what it's doing now.

> When does the guest really care what the specific i2c bus frequency is, if 
> it's not going to change it?

I don't know of a real reason.  Maybe an I2C device where the clock speed
makes a difference?  Maximum polling rate or something?  Is there reason
the CPU clock and the CCB frequency need to be in the device tree?
