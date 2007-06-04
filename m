Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E4C6FDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 01:52:32 +1000 (EST)
Message-ID: <4664359B.8060109@ru.mvista.com>
Date: Mon, 04 Jun 2007 19:54:03 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>	
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>	
	<4662EAA9.70104@ru.mvista.com>
	<1180905120.31677.22.camel@localhost.localdomain>
	<46640892.2030408@ru.mvista.com>
	<f24cbe6245fb2a52d153edb9be678f5a@kernel.crashing.org>
In-Reply-To: <f24cbe6245fb2a52d153edb9be678f5a@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>> You make no sense to me. It's like saying that knowing that a 8250 chip
>>> on ISA cannot be accessed if you don't know it's IO ports so it
>>> shouldn't say "8250" in compatible property ?!?!?!?

>>    No, it's a completely different case.  Base address and even flash 
>> size are not the only things that matter.  There's bus width

> Bus width is an (inherent) property of the _parent_
> node.  Device width is normally equal to that, and
> if not, it is obvious from the device model.

    Eh... obvious? From the bus controller node? Maybe and maybe not. Those 
are seem to be generally multifuntional and so don't have their "chip selects" 
fixed to some kind of interface, i.e. it's selectable, as well as the bus 
width even... at least it's so in my case (and nevertheless, the board has 
interleaved flash, so it's not a matter of a bus width fixed to 32 bits as you 
can see).

> Also, you need to know if the devices are byte-addressable
> or only per natural unit; and even more importantly,
> the same question for the flash bus.

>> and interleave factors

> Not a property of the flash chips really.

    Who said it is?

>> that influence the access (and possibly, byte-swapping too, although 
>> this is unlikely to happen in PPC world).

> Byte swapping?  1) This should _never_ be necessary,
> just swap the data on the device itself, duh;

    Oh, I'm afraid that's only wishful thinking after having some real life 
experience in bi-endian world.  Luckily, the PPC world seems to be (at least 
mostly) big-endian.

> 2) more likely this would be determined by the flash bus, not
> per flash device.

    Indeed, by wiring the bus pins to flash pins. :-)

> And, 3) why would you want to include this in the flash
> binding while we don't yet have a reasonable overview
> of in what circumstances byte swap is needed/used?

    This was just a real world example. I do hope PPC would never have to deal 
with it, though...

>>> Also, whatever shortcomings of the linux MTD drivers are totally
>>> irrelevant to what is correct to have in a device-tree. While we do
>>> tailor our device-tree specification around linux needs in most cases,
>>> there are cases like this one where common sense should be enough to
>>> understand that it's not because the linux MTD subsystem, as of today,
>>> cannot be told what programming interface to use, that we shouldn't
>>> provide that information in the tree.

>>    We did provide it, in the form of probing hints ("probe-type" prop).

> Which is 103% redundant.  That same information (and
> more!) is required in the "compatible" property, already.

    Yeah, but then we would have needed more than one node -- which I avoided 
back then... well, I have cheated and mistaken. :-)
    Anyway, the "rom" device node as it appeared in booting-without-of.txt
was based upon suggestions from Linux/MTD maintainer.

> Segher

WBR, Sergei
