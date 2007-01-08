Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA65DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 09:40:20 +1100 (EST)
In-Reply-To: <1168288352.22458.198.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Mon, 8 Jan 2007 23:40:24 +0100
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>                        For axon, thus, we have: "emac-axon","emac4"
>>
>> "ibm,emac-axon" etc. please.
>
> Why ?

To avoid name collisions.

> In the -content- of a compatible property ?

Yes.

> haven't seen that much before.

Didn't you read the OF spec?  All examples are like that.

I know that in "real life" (and esp. in Apple OF) this
isn't often done, sure -- but is there any reason for you
*not* to do the proper thing?

>>>  - local-mac-address : 6 bytes, MAC address
>>
>> Don't forget "mac-address", if the device is opened
>> in OF; and "max-frame-size" please.
>
> Yeah well, doesn't need to specify that, it's already specified :-) I'm
> talking about what the driver wants.

Oh okay, what the driver wants.  Please don't forget that
nuance when putting this stuff into the binding doc -- it
doesn't belong there ;-)

>>>  - cell-index        : 1 cell, hardware index of the EMAC cell on a
>>> given ASIC (typically
>>>                        0x00000000 and 0x00000001 for EMAC-0 and 
>>> EMAC-1
>>> on each Axon chip)
>>
>> Can you find a better name?  What is this used for, anyway?
>
> Propose one :-) There are various bits here or there where you have to
> know which EMAC in a chip you are talking about (clock control bits,
> that sort of thing).

So this is for accessing some shared SoC registers?  The emac
node has no business with that, you should have a separate
node for that (and you probably do already, you can use the
parent bus node in most such cases).

>>>  - max-mtu           : 1 cell, maximum MTU supported in bytes
>>
>> See "max-frame-size", MTU is on a higher level than device
>> level and as such shouldn't be here; the OF networking layer
>> can set something like this if it wants.
>
> Except that I don't want OF to set anything dynamically here. This is a
> way to prevent EMAC to do jumbo frames in fact.

MTU is dynamic, max-frame-size isn't.  max-frame-size is just
the maximum packet size you can tell the network controller to
put on the wire, not counting protocol overhead etc.


Segher
