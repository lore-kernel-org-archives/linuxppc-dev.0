Date: Tue, 27 Nov 01 08:34:51 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111271634.AA24348@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Alright.  But what other magical bits do you need to shove in the
> registers?

None, I just have one register (R3, the first one) point to bi_recs.

> The wrappers do:
> rec = (struct bi_record *)_ALIGN((ulong)zimage_size +
> (1<<20)-1,(1<<20));
>
> Does the occult magic know the size?

The booter doesn't know the size. You see, right now the user first loads the
kernel using whatever means s/he wants, then runs my booter. The booter doesn't
currently know the kernel size. You want to give my users an extra hassle of
stuffing the kernel size in a register before starting my booter so the latter
can know it. Why? What's wrong with the other alternative (my yesterday's
patch) which would keep me happy, keep my users happy, and keep the rest of the
Linux/PPC community happy because it doesn't break anything and is completely
transparent?

> > No, it doesn't. The patch I posted yesterday doesn't and cannot break anything.
>
> Er, oh yeah, thanks.:w

So how about applying that patch then?

> Well, the register magic is being deprecated in 2.5, or that's the plan
> anyhow.

I've heard a different plan, namely having one (1) register, no "magic", point
to bi_recs. That's what I want.

> Why can't the occult load whatever the 2.5 bi_recs look like
> into memory someplace?

Where is that someplace? I don't see how you can come up with anything other
than something tied to aspects of the vmlinux ELF image, which I have already
shown to be not good.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
