Date: Tue, 27 Nov 2001 11:19:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Message-ID: <20011127111915.L13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111271634.AA24348@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111271634.AA24348@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 08:34:51AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Alright.  But what other magical bits do you need to shove in the
> > registers?
>
> None, I just have one register (R3, the first one) point to bi_recs.

Okay.

> > The wrappers do:
> > rec = (struct bi_record *)_ALIGN((ulong)zimage_size +
> > (1<<20)-1,(1<<20));
> >
> > Does the occult magic know the size?
>
> The booter doesn't know the size. You see, right now the user first loads the
> kernel using whatever means s/he wants, then runs my booter. The booter doesn't
> currently know the kernel size.

Maybe it's just me, but wouldn't you need to know the size to how much
to shove into memory?

> You want to give my users an extra hassle of
> stuffing the kernel size in a register before starting my booter so the latter
> can know it. Why? What's wrong with the other alternative (my yesterday's
> patch) which would keep me happy, keep my users happy, and keep the rest of the
> Linux/PPC community happy because it doesn't break anything and is completely
> transparent?

Because it's only a slightly less magical location than the current one
(in the wrapper, I don't know where yours puts it).

> > Well, the register magic is being deprecated in 2.5, or that's the plan
> > anyhow.
>
> I've heard a different plan, namely having one (1) register, no "magic", point
> to bi_recs. That's what I want.

Well, 'register magic' == 'cmd_line is rA, initrd is rB and rC'.  Sorry
for the confustion.

> > Why can't the occult load whatever the 2.5 bi_recs look like
> > into memory someplace?
>
> Where is that someplace? I don't see how you can come up with anything other
> than something tied to aspects of the vmlinux ELF image, which I have already
> shown to be not good.

Well, that's the fun part.  No one really like the current magic
location, but no one's come up with a better one.  After reading the
pmac/chrp stuff which shoves the initrd at the end of RAM (we _could_
overwrite our initrds that we place right after the kernel, if we have a
big kernel and low link addresss).  Not that i've tried it yet, it just
poped out at me.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
