Date: Mon, 1 Dec 2003 12:16:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Remco Post <r.post@sara.nl>
Cc: Christian Kujau <evil@g-house.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP issues, still freezing
Message-ID: <20031201191617.GF1166@stop.crashing.org>
References: <3FC9EEC6.8040507@g-house.de> <20031201121119.768fb4c1.r.post@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031201121119.768fb4c1.r.post@sara.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 01, 2003 at 12:11:19PM +0100, Remco Post wrote:
>
> On Sun, 30 Nov 2003 14:21:10 +0100
> Christian Kujau <evil@g-house.de> wrote:
>
> >
> > hi,
> >
> > after more days of compiling (at least now i know my ppc has good RAM
> > :-) ) and testing serveral kernels, i think now it's not a
> > network-related but a ppc-specific problem.
> >
> > Andrew Morton gave me the hint to just copy drivers/net/tulip/ from the
> > working 2.5.30 kernel to a recent one. i've done so; i've copied all
> > tulip stuff to a fresh 2.6.0-test11 kernel, after booting i was able to
> > load the module, but a following "ifconfig eth1 192.168.2.1" freezed the
> > machine -- as every kernel after 2.5.30 i was able to compile.
> >
> > a fix from Jeff Garzik went to linuxppc-dev (i saw it on lkml too),
> > subject was "2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT] de2104x
> > fixes])". i found out, that i can load 3 different modules for my card:
> >
> > 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
> > [FasterNet] (rev 22)
> >          Flags: bus master, medium devsel, latency 0, IRQ 11
> >          I/O ports at 1800 [size=128]
> >          Memory at c300a000 (32-bit, non-prefetchable) [size=128]
> >          Expansion ROM at c1040000 [disabled] [size=256K]
> >
> >
> > /lib/modules/2.6.0-test11/kernel/drivers/net/tulip:
> > de2104x.ko  de4x5.ko  tulip.ko
> >
> > /lib/modules/2.5.30/kernel/drivers/net/tulip:
> > de2104x.o  de4x5.o  tulip.o
> >
> > and every module gave me a freeze with 2.6.0-test11 (oh, i forgot to
> > test, if de2104x.o and de4x5.o are working correctly with 2.5.30 since
> > i've used always "tulip")
> >
> > and so, this makes me think it's a ppc-specific problem. no, i don't say
> > it's easier now to fix, perhaps it's even harder, because a lot has
> > changed in the ppc port too. if we could blame the device-driver, the
> > codesize to play with would be a lot smaller...
> >
> > but since really no other PReP people complain, i think i'll stay with
> > 2.4. a while. the machine is not that fast and i need a faster one
> > anyway...
> >
>
> I stopped complaining a while back (2.5.60 something) since I got absolutely
> no response. I'm one of the lucky (?) few who have a motorola powerstack
> (II) mobo.

I suppose part of the problem is that my PowerStack (Series E) doesn't
have any problems. :)

What I've just done is put up all of the patches I have pending to try
and get into 2.6.0, once Linus either becomes more open to !ia32 patches
or Andrew Morton takes over.  They're over at:
http://stop.crashing.org:16080/~trini/

The combination of 011 and 012 should allow for kgdb to work on any PReP
box, and this should help people debug problems, if they have the time.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
