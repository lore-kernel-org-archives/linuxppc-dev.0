Message-ID: <3CABD1E0.7020008@embeddededge.com>
Date: Wed, 03 Apr 2002 23:09:04 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com> <20020404034809.GL21034@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Oh, right, yes.  That was actually what I was meaning when I said
> "aligned" (sort of aligned at both ends), forgetting that the normal
> meaning only applies to the start address.

I guess if we can ensure a DMA-only pool, simple alignment will work.
You just can't kmalloc() because you don't know what may follow something
that isn't modulo cache line size.  You also have to be careful of code
that allocates a large object, then uses part of it for DMA and other
parts for processor core data.  I'm not sure we want to require kmalloc()
to always cache align due to the potential for wasted memory space.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
