Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA929DDEC5
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:28:56 +1000 (EST)
In-Reply-To: <20070905025907.GG17189@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
	<143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
	<20070905025907.GG17189@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a8b4282d0c58f1090c64591d387dae97@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding
Date: Thu, 6 Sep 2007 15:28:35 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +     - bank-width : Width (in bytes) of the flash bank.  Equal to 
>>> the
>>> +       device width times the number of interleaved chips.
>>> +     - device-width : (optional) Width of a single flash chip.  If
>>> +       omitted, assumed to be equal to 'bank-width'.
>>
>> Let's have bank-width optional instead, it's more natural
>> that way for the common case of just one chip.  Or, you can
>> say that either is optional.
>
> No, I'm disinclined to do that since bank-width is the primary bit of
> information that the driver needs.

Bzzzzt.  That's not what the device tree is about; it should
describe the hardware, it shouldn't be just a config file for
the current Linux drivers.

Besides, like I said, for the common case where your flash
chips aren't interleaved, it makes way more sense to talk
about device-width than it does to call it bank-width.

>>> +					OpenBIOS@0 {
>>
>> This show immediately why node name = partition name won't
>> work out.  You're not supposed to start a node name with a
>> capital like this.
>
> According to which?

It's just convention, really.

OTOH, spaces and commas and colons and a whole bunch of special
chars are completely disallowed here, so you need...

> Nonetheless, I've added a label property,

...something like that :-)


Segher
