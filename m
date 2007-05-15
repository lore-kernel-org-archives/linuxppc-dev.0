Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8CA8DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:59:55 +1000 (EST)
In-Reply-To: <20070515011704.GB565@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
	<3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
	<20070515011704.GB565@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b353b330365fd9ede35fb1cbbbf09aec@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 06:59:49 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		SRAM0: sram {
>>> +			compatible = "ibm,sram440gp";
>>> +			dcr-reg = <020 8 00a 1>;
>>> +		};
>>
>> Is this thing _only_ addressable over DCRs?  Weird.
>
> Well... the control registers are certainly DCR only.  I guess there's
> the actual SRAM itself, though whether this belongs in this node, or
> elsewhere isn't immediately clear.  I haven't yet investigated how the
> SRAM is mapped (it depends on DIP switch settings) so I'm certainly
> not considering this node complete yet.

If it is supposed to have a "reg" property, and it doesn't
yet, it might be a good idea to comment it out in the DTS
for now, so later kernels can work with the older device
tree correctly.

>>>  		MAL0: mcmal {
>>> -			device_type = "mcmal-dma";
>>> +			device_type = "dma-controller";
>>>  			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
>>
>> Remove "device_type", change name to "dma-controller"?
>
> Don't really want to remove the device_type, because the MAL driver
> looks for it at present.

Fair enough.  But you change the "device_type" in
this patch, so presumably you change it in the kernel
driver as well -- can't you just *fix* the kernel driver,
instead?

> Don't really want to change the name, since
> that might encourage confusion with the other (more conventional) DMA
> controller.

Nah, just look at the other properties in the node and
you know what is what.  It is quite common to have nodes
with the same name representing different devices (for
example, "ethernet" devices -- "dma-controller" would be
a bit more unusual, sure).

I have no strong feelings about the name, "mcmal" is
generic enough a name as far as I'm concerned.

>>>  			EBC0: ebc {
>>> -				device_type = "ibm,ebc";
>>>  				compatible = "ibm,ebc-440gp";
>>
>> You forgot "ibm,ebc" here.
>
> Hmm.. yeah, I guess.

Well that's what the kernel code matches on ;-)

> Revised patch coming shortly.

Looking forward to it!


Segher
