Message-ID: <3E772F39.1090303@embeddededge.com>
Date: Tue, 18 Mar 2003 09:37:45 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Penn, John" <jpenn@magisnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8250  idma problem - cache?
References: <BD92DBD34D62AC4FA034933E33E53F7E1724D6@grog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Penn, John wrote:

> Much better!!

Cool.

> So for receiving, local bus to system memory, I assume
> I need to set DGBL?

Yes.

> What would be a wise choice?  Using system memory?

The system memory could be a better choice depending upon the
speed of the device since both the device and local memory
share the same bus.  It would just remove some contention and
latency.  There are other system architecture considerations
but usually pipelining the DMA like this is a performance advantage.

> ...  Should I be able to use DPRAM for the BDs and system
> memory for the buffers?

Yes.  Just ensure the address or whatever indicators are used to
point the parameter blocks to the BDs in the DPRAM (or local bus)
are set correctly.  Also verify that the BDs can reside in DPRAM,
IIRC some peripherals or configurations don't allow it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
