Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6B078DDF35
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 15:28:24 +1000 (EST)
Date: Wed, 4 Jul 2007 07:28:21 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707040707010.4300@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 4 Jul 2007, Segher Boessenkool wrote:

> Your device is an rs5c372b.  So, that's what you put in
> your device tree.  Simple so far, right?

Yep.

> Now some OF I2C code goes looking for IIC devices in the
> device tree.  It finds this thing, and from a table or
> something it derives that it has to tell the kernel I2C
> layer this is an "rtc-rs5c372".

(I2C ML cc'ed.)

This is where I WOULD disagree. These tables would rather live inside the 
i2c layer, be filled by respective drivers themselves. Noone except the 
rs5c372 driver can know which devices it can handle. Using the very same 
your argument - what if in a future version this driver disappears and 
another one will be used for these devices? Then that driver will have to 
register support for this device.

For this to work i2c would need something similar to what pci, usb do - 
register supported device ids. The only difference is that instead of 
numerical IDs we have to use plain text names for i2c devices...

> [It would be nicer if it
> could just instantiate the correct driver directly, but
> if that's how the Linux I2C layer works, so be it].
> 
> No change in the I2C "core" needed, just an OF "compatible"
> matching thing like is needed *everywhere else* too.

Yes, this is why I put "would". Looks like this is the common powerpc 
practice ATM - to make such a glue to map arbitrary "OF names" to what 
respective drivers react to. Like in the case of the serial driver. But - 
i2c is much more diverse and dynamic than serial, so, maybe it is worth 
thinking about "fixing" i2c? Once again my offer for the i2c folks - I 
could try to think about a design for this, but I would happily accept 
anybody else more proficient with i2c do it.

Thanks
Guennadi
---
Guennadi Liakhovetski
