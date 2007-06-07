Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B31E3DDF1B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:00:29 +1000 (EST)
In-Reply-To: <1181233610.5674.167.camel@rhino>
References: <1181148145.5674.121.camel@rhino>
	<2a56a9d008269d393c68959f1804c21d@kernel.crashing.org>
	<1181233610.5674.167.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cd1e655423140dbb20af2821d5c3955f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] When checking I8042 io port,
	use of_find_compatible_node() instead of of_find_node_by_type()
Date: Thu, 7 Jun 2007 18:59:48 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> In check_legacy_ioport(), instead of using of_find_node_by_type() to
>>> find the 8042 node, use of_find_compatible_node() to find either the
>>> keyboard or mouse node.
>>
>> Why?

^^^^^^^^

Why do you need/want this at all?

>>>  	switch(base_port) {
>>>  	case I8042_DATA_REG:
>>> -		np = of_find_node_by_type(NULL, "8042");
>>> +		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
>>> +		if (!np)
>>> +			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
>>> +		if (np) {
>>> +			parent = of_get_parent(np);
>>> +			of_node_put(np);
>>> +			np = parent;
>>> +		}
>>
>> This breaks other boards using 8042, if those exist --
>> if this code is board-specific, it is in the wrong file.
>
> Perhaps I was a little too bold here.
>
> I guess if this breaks other boards

I don't know, but neither do you ;-)

> then I should leave the check for
> the device type, or perhaps just drop this patch altogether.

Maybe you want to test for _either_ of the three devices?

> In the latter case, the 8042 node would need to have device_type =
> "8042".  This contradicts what you posted in an earlier conversation we
> had regarding the 8641 device tree:
>
> On Thu, 2007-05-17 at 01:40 +0200, Segher Boessenkool wrote:
>>>>>> +                                8042@60 {
>>>>>> +                                        device_type = "8042";
>>>>
>>>> Drop the device_type.  A number as a name isn't
>>>> all that great, either.
>>>
>>> Currently in order for the i8042 devices to be initialized,
>>> check_legacy_ioport() must find a node with device_type "8042".
>>
>> So fix that :-)
>
> This is my attempt to fix it :)

A bit too harsh though...  Deprecate first, remove
later.

> Now if you prefer that the 8042 node on the 8641 has the device_type
> "8042", I will gladly add it back and drop this patch.

Never ever device_type.  "compatible" perhaps.  And
not a bare number, either.

I'm not sure what the Linux code here does exactly --
it seems to me you're allowing a legacy I/O port mapping
when legacy drivers probe for it, right?  Instead you
should change those drivers to not probe (perhaps by
refusing the I/O range access here), and be explicitly
instantiated from your device tree parsing code.


Segher
