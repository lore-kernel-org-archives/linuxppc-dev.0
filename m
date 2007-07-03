Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA5B8DDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 09:02:42 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0707032356270.3876@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Wed, 4 Jul 2007 01:02:12 +0200
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

>> Just use "compatible" exactly the way it is meant to be
>> used and your life will be so much simpler.  And don't
>> even think about using a very generic property like "model"
>> for a purpose totally different from its intended purpose.
>
> AFAIU, the only way currently to attach an i2c device to a driver  
> is to
> match against driver's name. Let's take the rtc-rs5c372.c example. It
> services rs5c372a, rs5c372b, rv5c386, rv5c387a. And it registers  
> itself
> with the name "rtc-rs5c372". We want to just specify in our dts, e.g.,
> 'compatible = "rs5c372b";', right? And ask the i2c layer to find a
> suitable driver for us. Which means a pretty big change to i2c  
> core. Is
> this what you think is the proper solution? I could try to think  
> about it
> / discuss on i2c and eventually cook up a patch, just want to make  
> sure I
> understand you right.

Your device is an rs5c372b.  So, that's what you put in
your device tree.  Simple so far, right?

Now some OF I2C code goes looking for IIC devices in the
device tree.  It finds this thing, and from a table or
something it derives that it has to tell the kernel I2C
layer this is an "rtc-rs5c372".  [It would be nicer if it
could just instantiate the correct driver directly, but
if that's how the Linux I2C layer works, so be it].

No change in the I2C "core" needed, just an OF "compatible"
matching thing like is needed *everywhere else* too.


Segher
