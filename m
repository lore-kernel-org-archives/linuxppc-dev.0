Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B02D8DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 08:00:29 +1100 (EST)
Message-ID: <472F8267.8070106@freescale.com>
Date: Mon, 05 Nov 2007 14:51:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
In-Reply-To: <9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
>> Jon Smirl wrote:
>>> This is my first pass at reworking the Freescale i2c driver. It
>>> switches the driver from being a platform driver to an open firmware
>>> one. I've checked it out on my hardware and it is working.
>> We may want to hold off on this until arch/ppc goes away (or at least
>> all users of this driver in arch/ppc).
> 
> How about renaming the old driver file and leaving it hooked to ppc?
> Then it would get deleted when ppc goes away. That would let work
> progress on the powerpc version.

Or we could have one driver that has two probe methods.  I don't like 
forking the driver.

> I'm working on this because I'm adding codecs under powerpc that use
> i2c and I want consistent device tree use.

We already support i2c clients in the device tree, via the code in 
fsl_soc.c.

>>>       cell-index = <1>;
>> What is cell-index for?
> 
> I was using it to control the bus number, is that the wrong attribute?

It shouldn't be specified at all -- the hardware has no concept of a 
device number.

>>>       rtc@32 {
>>>               device_type = "rtc";
>> This isn't really necessary.
> 
> Code doesn't access it. I copied it from a pre-existing device tree.

I'm just trying to keep the damage from spreading. :-)

>>> One side effect is that legacy style i2c drivers won't work anymore.
>> If you mean legacy-style client drivers, why not?
> 
> i2c_new_device() doesn't work with legacy-style client drivers.

No, but they should still work the old way.

>>> Or push these strings into the chip drivers and modify
>>> i2c-core to also match on the device tree style names.
>> That would be ideal; it just hasn't been done yet.
> 
> This is not hard to do but the i2c people will have to agree. I need
> to change the i2c_driver structure to include the additional names.

I got a fair bit of resistance from them on the topic of multiple match 
names for i2c clients.

>> Most of this code should be made generic and placed in drivers/of.
> 
> How so, it is specific to adding i2c drivers.

I meant generic with respect to the type of i2c controller, not generic 
to all device types. :-)

It could be drivers/of/i2c.c, or drivers/i2c/of.c, etc.

>> We might as well just use i2c_new_device() instead of messing around
>> with bus numbers.  Note that this is technically no longer platform
>> code, so it's harder to justify claiming the static numberspace.
> 
> I was allowing control of the bus number with "cell-index" and
> i2c_add_numbered_adapter().
> Should I get rid of this and switch to i2c_add_adapter()?

Yes.

>>> +     i2c->base = ioremap((phys_addr_t)mem.start, MPC_I2C_REGION);
>>>       if (!i2c->base) {
>>>               printk(KERN_ERR "i2c-mpc - failed to map controller\n");
>> Use of_iomap().
> 
> I didn't write this, how should it be done? MPC_I2C_REGION can be
> eliminated by using mem.start - mem.end.

i2c->base = of_iomap(op->node, 0);

of_address_to_resource() and ioremap() are combined into one.

>> Let's take this opportunity to stop matching on device_type here
>> (including updating booting-without-of.txt).
> 
> Remove the .type line and leave .compatible?

Yes.

>>> +static struct of_platform_driver mpc_i2c_driver = {
>>> +     .owner          = THIS_MODULE,
>>> +     .name           = DRV_NAME,
>>> +     .match_table    = mpc_i2c_of_match,
>>> +     .probe          = mpc_i2c_probe,
>>> +     .remove         = __devexit_p(mpc_i2c_remove),
>>> +     .driver         = {
>>> +             .name   = DRV_NAME,
>>>       },
>>>  };
>> Do we still need .name if we have .driver.name?
> 
> Yes, i2c-core is matching on mpc_i2c_driver.name, i2c-core would need
> to be changed to use mpc_i2c_driver.driver.name.

How can i2c-core be matching on a field in an OF-specific struct?

-Scott
