Message-ID: <3E765932.7040206@embeddededge.com>
Date: Mon, 17 Mar 2003 18:24:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Penn, John" <jpenn@magisnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8250  idma problem - cache?
References: <BD92DBD34D62AC4FA034933E33E53F7E1724D5@grog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Penn, John wrote:

> ...I seem
> to have a transmit problem that could be explained
> by the dcache holding the packet,

I guess you mean you wrote something into memory and
the IDMA didn't move it to the device on the local bus?
Can you use a bus analyzer to ensure the IDMA actually
ran as expected?  What DMA mode are you using?

> 	snooping - tried enabling it on tx DGBL, no difference
> 			SIUMCR - ESE is enabled

If I understand "transmitting", that would be from main memory
to the device, so you need to set SGBL.

> 	using local bus memory instead of 603 memory for buffers
> 		I would rather use 603 memory

If you have a device on the local bus, that would be a wise choice. :-)

> 	the 8260 is fully cache coherent so you don't have
> 		to invalidate the dcache.

That's true, but in the case of transmitting you wouldn't want to
invalidate, you would want to flush.

> Now I am at the point of needing some clarification.
>
> 1. 	Do I have to invalidate dcache and if so how?

You do not need to do this.

> 2. 	Has anyone used the IDMA with 603 memory or must
> 	I use local bus memory?

The system (603) memory works fine, it just sounds like you
need to ensure the channel is correctly configured and your
device protocol on the local bus is working correctly.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
