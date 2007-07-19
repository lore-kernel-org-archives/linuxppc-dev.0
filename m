Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F939DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:32:19 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0707180010330.3535@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Thu, 19 Jul 2007 17:32:10 +0200
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

>> Your device is an rs5c372b.  So, that's what you put in
>> your device tree.  Simple so far, right?
>>
>> Now some OF I2C code goes looking for IIC devices in the
>> device tree.  It finds this thing, and from a table or
>> something it derives that it has to tell the kernel I2C
>> layer this is an "rtc-rs5c372".  [It would be nicer if it
>> could just instantiate the correct driver directly, but
>> if that's how the Linux I2C layer works, so be it].
>>
>> No change in the I2C "core" needed, just an OF "compatible"
>> matching thing like is needed *everywhere else* too.
>
> How about the patch below?

Looks good.  It should later be moved to a more generic
I2C OF matching layer, but fine for now.  Thanks!

You might want to put vendor names in the "compatible"
entries, dunno though, maybe these are "cross-vendor"
ICs?


Segher
