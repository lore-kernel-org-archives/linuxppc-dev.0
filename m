Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24659DDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 22:21:41 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0707040707010.4300@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707040707010.4300@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <030A74A7-7D15-46C3-9ACE-21A42D395E65@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Wed, 4 Jul 2007 14:19:18 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Now some OF I2C code goes looking for IIC devices in the
>> device tree.  It finds this thing, and from a table or
>> something it derives that it has to tell the kernel I2C
>> layer this is an "rtc-rs5c372".
>
> (I2C ML cc'ed.)
>
> This is where I WOULD disagree. These tables would rather live  
> inside the
> i2c layer,

Physical location doesn't matter, logical location is
a separate layer.

> be filled by respective drivers themselves.

That would be nicer yes, but a bigger change.

> Noone except the
> rs5c372 driver can know which devices it can handle.

I don't really agree but that's more a philosophical than
a technical argument.

> Using the very same
> your argument - what if in a future version this driver disappears and
> another one will be used for these devices? Then that driver will  
> have to
> register support for this device.

And it's all in the same kernel source tree so it would be
a trivial fixup -- quite different from keeping OF device
trees and Linux kernels in synch (which is pretty much
impossible).

> For this to work i2c would need something similar to what pci, usb  
> do -
> register supported device ids. The only difference is that instead of
> numerical IDs we have to use plain text names for i2c devices...

Yeah, that would be nice.  Are you suggesting the Linux I2C
layer should use "OF-style" names as its "native" naming
scheme?  I'd rather keep the namespaces separate, coupling
them always seems like a great idea and always turns out a
disaster.

>> [It would be nicer if it
>> could just instantiate the correct driver directly, but
>> if that's how the Linux I2C layer works, so be it].
>>
>> No change in the I2C "core" needed, just an OF "compatible"
>> matching thing like is needed *everywhere else* too.
>
> Yes, this is why I put "would". Looks like this is the common powerpc
> practice ATM - to make such a glue to map arbitrary "OF names" to what
> respective drivers react to. Like in the case of the serial driver.

Yes.  This is the most flexible scheme possible and allows
for all kinds of fixups/workarounds in case of broken device
trees (or broken kernel code, for that matter).

> But -
> i2c is much more diverse and dynamic than serial, so, maybe it is  
> worth
> thinking about "fixing" i2c?

Be my guest :-)  I care more about the OF side of things, but
let me ask anyway -- what do you see as "broken" in the Linux
IIC "core" that needs fixing here?


Segher
