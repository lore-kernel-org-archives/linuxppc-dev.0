Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47093DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 04:21:43 +1000 (EST)
In-Reply-To: <b6ecc5c703232a936eab8942de37e8ec@kernel.crashing.org>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org>
	<39A1A44F-CD73-4CC1-89DE-608A1041AAF7@kernel.crashing.org>
	<b6ecc5c703232a936eab8942de37e8ec@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96A13129-D16E-440D-B317-29BED85852D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Thu, 13 Sep 2007 13:24:38 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 12:06 PM, Segher Boessenkool wrote:

>>>> +		PowerPC,8572@0 {
>>>
>>> Maybe it would be good to use "PowerPC,e500" instead -- it would
>>> make it easier to probe for the actual CPU type, that way.  Not
>>> that Linux uses the name/compatible here at all ;-)
>>
>> I thought about this, not sure what the best solution is.
>
> Since the CPU cores on all these SoCs are identical (well, there
> might be a few revisions, or different cache sizes or such -- minor
> differences that can be probed for separately), it probably is a
> good idea to name them in the tree instead of having each client
> have its own table.
>
> Or is there anything about the CPU that can be derived from "8572"
> but not from "e500"?

Only in so much that we need something that states what the actual  
processor is.

>>>> +	soc8572@ffe00000 {
>>>
>>> You should put an interrupt-parent in here, so you can get rid of
>>> it in all the children.
>>
>> Are interrupt-parent's inherited by child nodes?
>
> A node without "interrupt-parent" uses the regular tree parent for
> walking the interrupt "tree".
>
>>> And then there's the pci_bridge thing we're discussing on IRC, of
>>> course -- basically, get rid of the pci_bridge pseudo-node, and
>>> move the interrupt-map for the south-bridge devices into the
>>> south-bridge node.
>>
>> Leaving the interrupt-map in the PHB because that works and moving  
>> it down has issues.
>
> Okay, fair enough.  Are you looking at resolving those kernel issues?

No.  I've had enough of this device tree foo for a while :)

[I'm happy to test any patches related to this, if someone else comes  
up with them]

- k
