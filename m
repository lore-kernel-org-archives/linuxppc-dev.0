Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10AFFDDEC0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:26:17 +1000 (EST)
In-Reply-To: <46630256.8050909@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <daa1b6f2e18f06f053d538d28d3c046a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 20:25:50 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Which Linux driver to use is not something that should
>> be (directly) communicated in a device tree -- even if
>
>    Bah... what's "name" and "compatible" properties are for then.

They communicate to the kernel what exactly a certain device
is.  Nothing more, nothing less.  The kernel is supposed to
use this information to select what device driver to use for
it.  Any extra information the kernel might need/want to drive
the device is described in other properties (or, in some cases,
in different device nodes, even).

> Nobody's talking about the direct match but making the task of 
> selecting a proper driver more complex by specifying the details that 
> don't help (if not hinder) the correct selection is certainly not a 
> way to go.

Nonsense.  If the kernel doesn't care about certain details,
it can just ignore them.

>> -- the device tree on your board doesn't necessarily
>> change when your kernel version does.
>
>    Well, I'm not anticipating any changes either in this case...

That's a problem then.

>>> the CFI/JEDEC interface then can be deduced by probing
>
>> Most of the time, sure.  Not always.
>
>    That's the way the cookie crumbles in Linux MTD for now. It's 
> *always* detecting this by probing -- you only can say what [not] to 
> probe.

So go fix that :-)

>> Who is talking about "probe-type"?  We are talking about "compatible".
>
>    See my other mail where I've told why I don't consider your example 
> of this prop valid...

I haven't read that yet, but I can tell you now that I'm already
very sceptical about the arguments.


Segher
