Date: Wed, 15 Aug 2001 01:43:37 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Dan Malek <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flush_dcache_range problems
In-Reply-To: <3B79C1DA.9C8DA308@mvista.com>
Message-ID: <Pine.LNX.4.33.0108150124050.4298-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 14 Aug 2001, Dan Malek wrote:

> "Justin (Gus) Hurwitz" wrote:
>
> > Our driver works perfectly with L1 disabled.
>
> I don't believe you :-).  You can't call dcb* instructions on
> memory that isn't cache enabled......they crash.

I change the CC macro when running without the L1 (to do{}while(0)). I'm
quite certain that it works- I'm mounting an NFS root partition and
performing as much IO as possible to test the board- it remains stable
under multiple flood pings, while doing heavy NFS reading (as much as the
board can generate) and while maxing out the the serial console.

> > If you need any more info, let me know what you need, and I'll get it to
> > you ASAP :)
>
> I told you in the last message......backtrace and register dumps :-).

I unfortunately don't have any with me- and I won't have them until around
9A EST tomorrow.

Remembering the backtrace, the crash was at NIP=c0006048 (which was the
dcbst instruction), and the backtrace was from i82965_probe, which was
called from probe_list (IIRC), called from ethif_probe.

But you do raise an interesting point- my memory is currently being
allocated with:
dev->mem_start = (int)pci_alloc_consistent( NULL, sizeof(struct i596_pri
vate), &dma_addr);

which might be allocating the memory as non-cacheable (despite the fact
that it is not working as non-cacheable memory should). I'll make some
modifications to the code now and test them when I get in in the morning
to revert to allocating non-non-cacheable memory, which might prevent the
dcbst from crashing, eh?

Any recommendations for other things I should look at/for? I'll gladly get
you backtrace.


---

Hold a second- I lied, and I lied bigtime. I forgot that I had a hole
punched in the firewall at work, and and ftp server running on the PC that
had my logs on it (don't tell anyone):

Oops: kernel access of bad area, sig: 11
NIP: C0006048 XER: 20000000 LR: C01366D8 SP: C03C5F20 REGS: c03c5e70 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C8000000, DSISR: 20000000
TASK = c03c4000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C03C5F20 C03C4000 C8000000 01C0228D 0000001F C7FBD19C C009F638
GPR08: C009F62C 07FBC000 C009E3E8 C009D73C 44002024 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 00000000 C0130000 C0100000 C0126528 C03C5F30 C01264B8 C7FBC000
Call backtrace:
C0136614 C013623C C0136350 C0136A40 C0135170 C012E7B0 C012E7F8
C0003AF8 C00064CC


Those last three addresses in the bt correspond the the functions I
mentioned above.

I'm going to go grab my notebook and spend some time mucking with the code
(removing my attempts to allocte the memory as non-cacheable (or,
ifdef'ing it out)).

Thanks again,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
