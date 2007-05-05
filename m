Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18177DDEE3
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 06:44:20 +1000 (EST)
In-Reply-To: <1178388746.3393.47.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
	<1178388746.3393.47.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76e38f13b63a2cf4c793299e73671db5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Sat, 5 May 2007 22:44:12 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +/ {
>>> +	model = "ppc750-tsi109";
>>
>> "model" should be something really specific; typically
>> a (unique!) model number.  This means you can't use the
>> same device tree for Holly and Hickory (but there are
>> more reasons for that; see below).
>>
>>> +	compatible = "ppc750-tsi";
>>
>> The needs to be more specific as well; "ibm,holly"
>> or something.
>
> Why?  Holly and Hickory share the same memory map and devices.  The 
> only
> thing that differs from what I can tell is the actual CPU itself.

And the model number I suspect.

"ppc750-tsi" really isn't good enough as a "compatible"
property, there are many many more boards with some 750
and some TSI bridge.

>>> +  	tsi109@c0000000 {
>>> +		device_type = "tsi-bridge";
>>
>> Don't put a "device_type" here, it is useless
>> (and undefined).  There are more like this, but
>> perhaps Linux (wrongly) probes on "device_type"
>> for those, so the kernel would need updating
>> first.
>
> It's not useless.  The TSI code probes by device_type all over the
> place.  Do you have an example of how to probe for something like this
> without using device_type?

Sure: use "compatible" instead.

This problem is all over the place, don't worry
about it too much.  It would be good if new ports
could stop adding to the madness though ;-)

>>> +	  	MPIC: pic@7400 {
>>> +			built-in;
>>
>> Why say this for MPIC only, not for most other nodes?
>> What binding defines "built-in", anyway?
>
> http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps

But this isn't a CHRP compatible board, that binding
doesn't apply.


Segher
