Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070807032806.GE15619@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
	<20070807032806.GE15619@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e20238f937f1328cc3db88840b3c7fc3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Tue, 7 Aug 2007 18:43:35 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Aha!  Ok, now I understand the sorts of situations you're talking
>>> about.  By "not direct mapped", I thought you were talking about some
>>> kind of access via address/data registers on some indirect bus
>>> controller, rather than weird variations on endianness and
>>> bit-swizzling.
>>
>>     No, that would be just too ridiculous for a NOR flash -- I hope. 
>> :-)
>
> Heh.  In my experience, very little is so ridiculous that some
> embedded vendor won't do it.

True -- but if you can't map the NOR into the CPU address space,
there are cheaper alternatives.  Most embedded vendors care about
that, too ;-)

>>     So, you're saying that the 1:1 address correspondence rule stops 
>> to apply
>> here?
>
> Well.. it all depends what exactly you consider the address space of
> the flash bank.  By which I mean the whole shmozzle represented by the
> device node, not the individual flash chips.  It's not immediately
> obvious whether or not that should include any swizzling done by the
> bus wiring.

The parent device/bus shouldn't care, from its viewpoint the flash
bank is just one linear hunk of address space.  For reading or
writing the flash bank appears linear to the CPU as well (at least
that's the only thing our current proposed binding supports); the
only thing that gets "interesting" is sending commands to the flash
chips.

> It would be possible, I guess, to define a 'swizzled-ranges' property
> or something which allows child devices to be embedded in the parent's
> address range in a not-direct way.

Let's not even consider this please.

> However, the swizzling on the
> flash bank is really a property of the flash bank,

Yeah, it's the "fine structure" of the flash bank.  Something
only the flash driver has to deal with.  So no contaminating the
parent device node, thank you.

>>> Simplest option seems to me to add a property "endianness" or
>>
>>     And we even have a precedent of "big-endian" prop in the MPIC 
>> nodes
>> (although I'm not sure why it's needed there).

A single register read (32-bit registers) gives a big-endian value
on some MPIC implementations, and wrong-endian on others.  The
device driver really needs to know -- it really should just figure
it out from the "compatible" property though.


Segher
