Date: Fri, 29 Jun 2001 05:16:16 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Paul White <pwhite@networkrobots.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
In-Reply-To: <200106290009.f5T09C823337@stimpy.networkrobots.com>
Message-ID: <Pine.LNX.3.95.1010629042746.5292E-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 28 Jun 2001, Paul White wrote:

>
> Justin,
>
> I was able to get Data cache disabled today, after playing around with it
> for a while.
>
> There were several things I had to do.  Now, I don't recall what CPU you
> are using, so I'll just tell you what I found with mine.
>
> First off, I'm using the 7410, which has 32 byte cache lines.  Note that the
> 8xx and such have 16 byte cache lines.  In my manual, under "Enabling
> and Disabling Data Cache", it states that the dcbz instruction will cause an
> alignment exception, and that all others are nop'd.  So the first thing I did,
> was search for dcbz throughout my code, and I found two files that had
> several matches:

I went through and made the same set of changes that you did- I am on a
603e, so I would expect the L1 cache behaviour to be about the same.
Indeed, the kernel does boot properly, up until id decompresses the
ramdisk. I am getting a crc error decompressing the ramdisk, however-
presumably because of a problem with the caches. I'd like to set the MMU
to caching inhibited to tighten up the processor's load and store
ordering. I think that I only need to set this in the pte entries- the
errors are only occuring after the MMU has been brought up. Irony of
ironies, I know how to do this with the BATs, but not in the PTEs. It
looks like there is a field in the PTE struct (in asm/mmu.h), but I can't
find where that structure is initialised. It looks like, from my
meandering through the kernel's memory management code that this might wee
be a good step towards allowing chunks of non cachable memory to be
allocated.

Thoughts?

--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
