Date: Fri, 29 Jun 2001 08:11:03 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Paul White <pwhite@networkrobots.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <200106291749.f5THnQ810464@stimpy.networkrobots.com>
Message-ID: <Pine.LNX.3.95.1010629080637.13096A-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All true- except that I'm on a 603e :) It was someone else that was on the
4xx. I'm fairly sure that the 603e has 32 byte lines.

I think that I've hunted down all of the dcbz instructions, but I should
go and check align.c. I've not had a chance to look through the book to
see if there are other non-usable functions- I want to say that everything
else is a nop on the 603e, but I'll double check when I get the chance.

Fingers crossed,
--Gus

On Fri, 29 Jun 2001, Paul White wrote:

> Justin,
>
> I seen in a previous e-mail that you are using a 4xx proccessor.  I'm assuming
> that this processor only has 16 bytes cache lines.  When you went through the
> code I sent you, did you change it to only zero out 16 bytes instead of 32?
>
> Also, Make sure in your CPU book that dcbz is the only instruction that
> can't be done when data cache is disabled.
>
> You also may want to check arch/ppc/kernel/align.c to make sure it still
> simply "returns" from an alignment excepetion caused by a dcbz.  My
> tree (base line 2.4.4) has it.  Otherwise, you may want to grep your
> code (in the arch/ppc/*, and in include/asm/*) for any other occurences
> of dcbz.  Any at bootup time must be replaced with assembly instructions
> to zero out the memory locations,  but ones that will happen during runtime
> should be OK if your alignment handler ignores them.
>
> Again, be sure to check your CPU manual.  Maybe the 4xx CPU handles
> the data cache instructions differently from the 7410.
>
> Also..  Make absolutely sure you made the right changes in the
> arch/ppc/mm/init.c file as well.
>
> SInce its crapping out uncompressing the ramdisk, I am assuming
> that the copy_pages or copy_tofrom_user stuff isn't working right
> (Maybe you still have it zero'ing out 32 bytes instead of 16?)
>
> Paul W.
>
>
> At 05:16 AM 6/29/2001 -0400, Justin (Gus) Hurwitz wrote:
> >On Thu, 28 Jun 2001, Paul White wrote:
> >
> >>
> >> Justin,
> >>
> >> I was able to get Data cache disabled today, after playing around with it
> >> for a while.
> >>
> >> There were several things I had to do.  Now, I don't recall what CPU you
> >> are using, so I'll just tell you what I found with mine.
> >>
> >> First off, I'm using the 7410, which has 32 byte cache lines.  Note that
> the
> >> 8xx and such have 16 byte cache lines.  In my manual, under "Enabling
> >> and Disabling Data Cache", it states that the dcbz instruction will
> cause an
> >> alignment exception, and that all others are nop'd.  So the first thing
> I did,
> >> was search for dcbz throughout my code, and I found two files that had
> >> several matches:
> >
> >I went through and made the same set of changes that you did- I am on a
> >603e, so I would expect the L1 cache behaviour to be about the same.
> >Indeed, the kernel does boot properly, up until id decompresses the
> >ramdisk. I am getting a crc error decompressing the ramdisk, however-
> >presumably because of a problem with the caches. I'd like to set the MMU
> >to caching inhibited to tighten up the processor's load and store
> >ordering. I think that I only need to set this in the pte entries- the
> >errors are only occuring after the MMU has been brought up. Irony of
> >ironies, I know how to do this with the BATs, but not in the PTEs. It
> >looks like there is a field in the PTE struct (in asm/mmu.h), but I can't
> >find where that structure is initialised. It looks like, from my
> >meandering through the kernel's memory management code that this might wee
> >be a good step towards allowing chunks of non cachable memory to be
> >allocated.
> >
> >Thoughts?
> >
> >--Gus
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
