Message-ID: <3A647BC7.15F669F3@mvista.com>
Date: Tue, 16 Jan 2001 11:50:15 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: frowand@mvista.com, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach wrote:
>
> Why do we need simulated bat registers.

To improve performance.  Right now, on the 4xx there is the
concept of "pinned" TLB entries to reduce/eliminate TLB misses
on large mapped areas (like kernel text/data or I/O).  The 8xx
does this in some custom applications as well.  These are just
hacks that are headed down a disastrous maintenance path that
need to be stopped now for a more generic solution.

I have been experimenting with many different methods of using
the "large" page table sizes through the generic memory management
methods that already exist in the kernel.  I believe I can wrap
the concept of the pinned TLB entries into the same logic as BAT
register management on the bigger processors.  Hence, I call them
simulated BAT registers....the semantics aren't quite the same.

The BAT registers are a really good thing, and although the large
page size TLB entries are more flexible, they require more software
overhead.  I would like to make some generic Linux MM modifications
to help us support variable page sizes, but I suspect that will
never happen.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
