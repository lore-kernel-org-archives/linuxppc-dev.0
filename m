Date: Tue, 27 Nov 2001 08:58:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Message-ID: <20011127085823.K13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111271533.AA24180@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111271533.AA24180@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 07:33:27AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Er, why can't you find the magic location for the bi_recs and set that
> > as well as the other registers you need to?
>
> Because that location is tied to the kernel's symbols (__bss_start in this
> case), and I have no way of knowing where that is. The kernel has already been
> loaded into memory (by occult) by the time my booter runs, and my booter
> doesn't have access to the original vmlinux ELF header or to System.map.

Alright.  But what other magical bits do you need to shove in the
registers?  The wrappers do:
rec = (struct bi_record *)_ALIGN((ulong)zimage_size +
(1<<20)-1,(1<<20));

Does the occult magic know the size?

> > > The patch below makes the K2 vmlinux expect a pointer to bi_recs in R3 like I
> > > do on the Adirondack and makes the "simple" zImage goo pass a pointer to its
> > > magic bi_recs in R3.
> >
> > And breaks all of the other ports which use 'simple' and expect bi_recs
> > in the 'normal' place.
>
> No, it doesn't. The patch I posted yesterday doesn't and cannot break anything.

Er, oh yeah, thanks.:w


> > For 2.5 we can agree on a less magical and more predictable
> > location.  Would somewhere around the end of memory work for you?
>
> But why won't you just let me put it where I want and tell the kernel where I
> put it? I'll fork Linux if I have to, but I would prefer not to.

Well, the register magic is being deprecated in 2.5, or that's the plan
anyhow.  Why can't the occult load whatever the 2.5 bi_recs look like
into memory someplace?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
