Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D085DDE44
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 03:01:13 +1000 (EST)
In-Reply-To: <20070807154307.GA27504@ld0162-tx32.am.freescale.net>
References: <20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
	<20070807032806.GE15619@localhost.localdomain>
	<20070807154307.GA27504@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <859cd2176734de861073cff5ecf3c255@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Tue, 7 Aug 2007 19:01:01 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It would be possible, I guess, to define a 'swizzled-ranges' property
>> or something which allows child devices to be embedded in the parent's
>> address range in a not-direct way.  However, the swizzling on the
>> flash bank is really a property of the flash bank, not of the parent
>> bus - requiring it to be encoded in the parent is pretty yucky -
>> especially if the flash bank is just part of a larger chunk of bus
>> address space, defined by a single large ranges entry in the parent.
>
> It's more a property of the connection between the bus and the flash
> chips, and that connection could be described as its own "bus" node,
> something like:

But it's not a bus in reality.  There is no need to introduce
a fake bus here, it won't help anything AFAICS.

> Similar intermediary buses could be used for flashes with indirect
> access (SPI and such).

There are perfectly good mechanisms already for describing
those, too (you make a device node for the controller, and
it defines its own address space).


Segher
