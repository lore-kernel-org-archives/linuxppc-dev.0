Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C030DDDEE9
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 21:51:52 +1000 (EST)
In-Reply-To: <20070628100020.GA24215@iram.es>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070628100020.GA24215@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f778cbc9a05aafa7527bd14f9259aad2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Mon, 2 Jul 2007 13:51:42 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +			external-control;
>>
>> Really?
>
> Well, is anybody actually using eciwx/ecowx?

That's not the point -- the device tree should only
say "external-control" if the CPU actually supports
it; AFAIK, that's 601 only.

>> +	pci@80000000 {
>> +		device_type = "pci";
>> +		compatible = "prep";
>>
>> Is that specific enough?
>
> On the MVME5100, actually the mapping is more CHRP like, and PCI I/O
> space is smaller and at a higher address.

Right, so it's not; "compatible" should specify the
model of PCI host bridge, instead.

>> What is the plan here -- have the bootwrapper build the
>> device tree / fill in the details from the residual data?
>
> I think so.

Right, good.  What's the way forward then -- David, rename
this DTS file to <board name>.dts so you have something to
boot, and at the same time work on the bootwrapper?

>  I might have some time to try a more recent kernel
> on MVME2400/2600 boards next week.

Great!


Segher
