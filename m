Message-ID: <3BA79D3E.E5BA495A@mvista.com>
Date: Tue, 18 Sep 2001 15:15:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx icache and tlb flushing
References: <20010918143359.B817@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> First on icache flushing.  I noticed that flush_icache_page() has been
> changed to a no-op, wheras it used to flush the whole icache on 4xx.

It is now done when we detect a PTE change that affects an executable
region.

> Now two questions on tlb flushing.  First, 4xx uses a __tlbia() macro
> in local_flush_tlb_*().  Is there a reason we don't use the _tlbia()
> function already included in misc.S?

I dunno, avoids the function call?  We keep swapping between macros
and functions.  Whatever.

> ... Is this a bug, or am I missing something?

I thought I checked that in....maybe it's still hanging out in my
with a bunch of other random 4xx patches.  I'll look again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
