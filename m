Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3855DDF22
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 09:06:04 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0707022114020.3339@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Tue, 3 Jul 2007 01:06:00 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> of_for_each_child_node() or whatever it is called?
>
> Sure, would be nice, only I cannot find anything like that. I seem to
> remember seeing a patch like that, but maybe I'me mistaken... Do you
> remember details / can you find it?

Not right now, sorry.  Use grep?  :-)

>>> +		name = of_get_property(node, "compatible", NULL);
>>> +		if (!name)
>>> +			name = node->name;
>>> +		if (!name)
>>> +			continue;
>>
>> Look at "name" first, then look at "compatible", not
>> the other way around.
>
> ok

Which btw is what the "is_compatible()" stuff does
(or, ought to do).

>>> +		/* FIXME: the i2c code should allow drivers to specify
>>> +		 * multiple match names; board code shouldn't need to
>>> +		 * know what driver will handle a given type.
>>> +		 */
>>
>> This should be handled by the OF matching stuff, there
>> is no direct connection between device tree naming and
>> Linux driver naming.  I don't want to see this patch
>> going in without this problem being fixed first.
>
> Right, this one is interesting. But this time I cannot even vaguely
> remember seeing any "OF matching" code. I can only remember each driver
> (or OF glue to a generic driver) parsing compatible of entries, like
> legacy_serial.c. Or you mean we need to write such a matching layer?

The OF glue parsing stuff and setting up the data structures
the generic drivers want to see.  I say make it work for your
board first, then when later more boards need it we have a
better idea about what is needed from a more generic I2C glue
layer.

> AFAIK, i2c is not specified by OF standard.

Yes.

> So, we are free to chose any "compatible" fields for our dts.

Within bounds.  What goes into "compatible" properties is
well-defined for _any_ device.

> Which we then would need to match against
> drivers. So, why not make this a 1-to-1 match?

Because the device tree describes the hardware, not what
Linux (or anything else) is going to do with it.  Let me
give you an example of why this is a good thing for _you_:
say a future version of Linux drops the I2C driver for a
device you have, since some other driver should be used
preferably instead (maybe it is just a better driver for
the same device, maybe it supports more devices, whatever).
Suddenly boards with your old device tree cannot run that
new Linux version anymore.  Ouch.

Just use "compatible" exactly the way it is meant to be
used and your life will be so much simpler.  And don't
even think about using a very generic property like "model"
for a purpose totally different from its intended purpose.


Segher
