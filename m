Message-ID: <3A64A751.8AA527CF@mvista.com>
Date: Tue, 16 Jan 2001 11:56:02 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Ralph Blach <rcblach@raleigh.ibm.com>, frowand@mvista.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com> <3A647BC7.15F669F3@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Ralph Blach wrote:
> >
> > Why do we need simulated bat registers.
>
> To improve performance.  Right now, on the 4xx there is the
> concept of "pinned" TLB entries to reduce/eliminate TLB misses
> on large mapped areas (like kernel text/data or I/O).  The 8xx
> does this in some custom applications as well.  These are just
> hacks that are headed down a disastrous maintenance path that
> need to be stopped now for a more generic solution.

At the moment, the 405 processors _require_ kernel memory to be
pinned because the tlb miss handlers use virtual addresses.  When
I started the 405 port I planned to move the TLB handlers into
assembly running in real mode.  Then when I started seeing info
about the 440 I backed away from that plan because the 440 always
runs with the MMU enabled.  I'm still thinking about the 440...

I pinned some IO ranges as a convenience when I was first porting
to the 405gp but plan to remove those pins.  Though I'm somewhat
tempted to leave a pin in place for the on-chip ethernet device
if performance measurements show a significant gain.


> I have been experimenting with many different methods of using
> the "large" page table sizes through the generic memory management
> methods that already exist in the kernel.  I believe I can wrap
> the concept of the pinned TLB entries into the same logic as BAT
> register management on the bigger processors.  Hence, I call them
> simulated BAT registers....the semantics aren't quite the same.

I think that's a good idea.  If you do so, please provide a way to
force an entry to be locked in the tlb.


> The BAT registers are a really good thing, and although the large
> page size TLB entries are more flexible, they require more software
> overhead.  I would like to make some generic Linux MM modifications
> to help us support variable page sizes, but I suspect that will
> never happen.
>
>         -- Dan

I've toyed with the variable pages sizes idea too, and it just hasn't
moved up high enough on my priority list.  I'm not sure I'm quite as
pessimistic as you about whether it will ever happen because several
other architecture support variable page sizes (including pa-risc
and (I think) IA-64).

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
