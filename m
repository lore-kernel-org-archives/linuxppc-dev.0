Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2FAC8DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 08:21:50 +1100 (EST)
Date: Wed, 15 Oct 2008 01:21:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: pca9539 I2C gpio expander
Message-ID: <20081014212147.GA7483@oksana.dev.rtsoft.ru>
References: <48F4E091.7080105@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48F4E091.7080105@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 02:10:25PM -0400, Steven A. Falco wrote:
> I am attempting to use a pca9539 I2C gpio driver on a PPC440EPx board.  The
> driver is "drivers/gpio/pca953x.c".  I've added an entry to the .dts file:
> 
> IIC0: i2c@ef600700 {
> 	compatible = "ibm,iic-440epx", "ibm,iic";
> 	...
> 	pca9539@76 {
> 		compatible = "ti,pca9539";
> 		reg = <76>;
> 	};
> };
> 
> of_register_i2c_devices sees this entry and calls i2c_new_device.
> i2c_new_device copies info->platform_data to client->dev.platform_data, but
> I think that this structure is empty (at least I don't see where
> of_register_i2c_devices would set it).

Currently there is no way to pass platform_data to I2C devices
(using device tree, that is). This is known limitation.

> pca953x_probe is eventually called, but it expects to find its "lowest gpio
> number" in client->dev.platform_data->gpio_base, which has not been set.  So
> pca953x_probe returns -ENODEV.
> 
> I don't understand where the disconnect is.  Should I be able to use the
> pca953x.c driver, or is it somehow incompatible?
> 
> If it is incompatible, is there a strategy for making it compatible?

We should write OF bindings for that driver. Unfortunately
this isn't easy for I2C devices, since they don't (and probably
should not) know anything about OF...

I have some ideas on how to teach all the I2C GPIO drivers
about the OF (without actually showing them any OF details).
I'll post it soon.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
