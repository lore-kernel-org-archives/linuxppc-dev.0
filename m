Message-ID: <39358E65.145F7EA3@embeddededge.com>
Date: Wed, 31 May 2000 18:12:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Dan Malek <dan@netx4.com>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com> <39357BC5.A0B3E713@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> ....does setting the _PAGE_NO_CACHE flag
> for a page table entry also invalidate any cached data for that page?

No.  It only ensures uncached behavior when the TLB is loaded.

> I am observing a write-though behavior when I write to addresses in
> the _PAGE_NO_CACHE page but when I read from addresses marked
> as _PAGE_NO_CACHE it appears to be retrieving data from the cache
> not from memory. Is this expected behavior?

That's a rhetorical, question, right :-)?  If not....of course that
isn't correct.

> .... How can I make it so that
> reads as well as writes to a particular page bypass the cache?

You need to invalidate the data cache for this address and the TLB
entry for this address when you set the flag.  Those drivers in your
example get away with it because the caches/TLB have been invalidated
and not yet touched at this point.  You also need to ensure you are not
multiple mapping the same physical address....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
