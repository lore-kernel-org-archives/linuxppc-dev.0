Message-ID: <3E14797D.5050605@embeddededge.com>
Date: Thu, 02 Jan 2003 12:40:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
References: <20021230162621.1741CC6139@atlas.denx.de> <3E10EF1C.5040505@embeddededge.com> <20021231155241.GA12063@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Erm.  That sounds bad.  So the values can change under the functions
> feet?  Even if the values tested for are only tested by this function,
> that still sounds like a bad idea.

If you look at the code, you will notice that the object that is declared
volatile is part of a shared driver data structure.  It isn't a hardware
register.  The reason it was originally declared volatile (and is a valid
programming method) was the MII interrupt would set this value, and later
a normal thread of execution would read this value in another function.
These functions can, which is also a valid compiler optimization technique,
cache these global values in a processor register.  In order for the normal
thread of execution to see the update from the interrupt handler, you have
to do something to force it to use the shared data structure, not the
optimization.  It's no big deal, and quite a common multithreaded programming
practice.

I don't understand Wolfgang's original "multiple access" comment since it's
only accessing a data structure in memory, unless there was some weird software
timing that occurred here due to the additional memory accesses.  There shouldn't
be any race conditions even though the status is updated in multiple C program
statements.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
