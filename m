Message-ID: <3B802482.80086FC8@mvista.com>
Date: Sun, 19 Aug 2001 16:41:38 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using IDMA1 ( or IDMA2 ) on 860
References: <20010819203359.28639.qmail@web20104.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Francis wrote:

> May be I should have been more specific, yes I have
> setup the PC15 pin to have correct direction.

Well, your description indicated you were expecting the
transition of DREQ to generate an interrupt.  This isn't
the case.  Have you connected a logic analyzer to the bus
and determined the DMA is working correctly?

> /* version2 of GetChipAddress this WORKS why? */

Because you can't directly access physical bus addresses from
the kernel.  They have to be mapped to some virtual address.
The IMMR is mapped to a well known address that can generally
be used anywhere in the kernel.  Anything else must be mapped,
as your example shows.  Just make sure you do this _once_,
don't keep calling ioremap() over and over or you will exhaust
the VM space and get a different address every time.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
