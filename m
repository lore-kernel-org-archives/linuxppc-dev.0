Date: Thu, 20 Jan 2000 20:51:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Gabriel Paubert <paubert@iram.es>,
        Franz Sirl <Franz.Sirl@munich.netsurf.de>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012014395300.05824@localhost.localdomain>
Message-ID: <Pine.LNX.4.05.10001202050350.23608-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jan 2000, Kevin Hendricks wrote:
> > Actually if base_addr can be reused by the compiler for other accesses
> > to the same area (byte or big endian), it should be written as:
> >
> > "stwbrx %0,%1,%2": : "r" (regdata), "b" (base_addr), "r" (regindex)
> >
> > with a volatile qualifier on the asm statement but I disagree on the
> > "memory" clobber if this does not access areas the compiler will ever
> > touch and does not have side effect.
> >
> > There are already too many memory clobbers out there, they are bad because
> > they basically tell the compiler that it can not keep a single variable
> > in a register.
>
> In this particular case, the base address can change (but very very rarely
> such as writing to one Aperature or Another on the Rage 128 card) and all of
> the writes are made to either the card memory mapped io or the frame buffer
> itself.

The base_addr may change in between calls, but not while executing the asm
code. The memory clobber means that memory contents may change while
executing the asm code without gcc knowing about it.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
