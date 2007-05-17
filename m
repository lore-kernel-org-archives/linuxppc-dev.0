Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1BDDDDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:45:30 +1000 (EST)
In-Reply-To: <464CADBB.9050500@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
	<464CADBB.9050500@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1e7cedebed6b67737c68fa01d832c3f3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Thu, 17 May 2007 21:44:23 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +    - reg : Unshifted 7-bit I2C address for the device
>> What about 10-bit addressing, etc.?
>
> I specified 7-bit to address someone's question back when this first 
> came up of whether it was 7-bit unshifted or 8-bit shifted.  Perhaps 
> it should just say "Unshifted I2C address for the device"?

Better, yes.

>>> +    - compatible : The name of the Linux device driver that
>>> +      handles this device.  If unspecified, the name of the
>>> +      node will be used.
>> NO WAY
>
> Sorry, that was left in there from a while ago and I missed it.  It 
> should be defined the same way as any other compatible property (and 
> the i2c code in Linux should be fixed to allow drivers to specify 
> multiple match names).  No need for shouting. :-)

Oh yes there is :-)

>>> +    - interrupts : <a b> where a is the interrupt number and b is a
>> I2C doesn't do interrupts,
>
> ...but some I2C devices do.

So?  They do that outside of the I2C domain.

>> this doesn't belong in an I2C binding; it's redundant anyway
>
> I guess it's implicit that any device that generates interrupts will 
> have an interrupts property,

This is defined in the base spec as well as in the interrupt
mapping spec, yes.  The exact format of the "interrupts"
property for a device is defined in the binding for the
interrupt domain that interrupt lives in.

> though there are many other examples of this sort of redundancy in 
> booting-without-of.txt.  Its inclusion was mainly an example.
>
> > (and incorrect as well).
>
> How is it incorrect?

You specified that an interrupt specifier consists of two
cells.  This is wrong.


Segher
