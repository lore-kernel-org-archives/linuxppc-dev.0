Date: Mon, 20 Mar 2000 11:09:03 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound split
In-Reply-To: <Pine.LNX.4.10.10003201042240.3507-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003201107330.17246-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 2000, Michael Schmitz wrote:
> > > No comments whether it works on PowerMac and Atari?
> > > I'd like to let this go in 2.4.0, since a driver for the Q40 is soon to be
> > > added.
> >
> > With all the latest patches applied:
> >
> > 1. compiled-in doesn't work; it seems the low-level parts are not
> > initialised:
> >
> > Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-slot-0, errno = 2
> > Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-service-0-6, errno = 2
>
> Funny enough, this is solved on my Lombard by modprobe dmasound_core &&
> modprobe dmasound_awacs. The modules are still around from an eariler
> build with modularized dmasound, and still load OK. I'd say the kernel
> never tries to initialize the compiled in dmasound so the module can still
> register its hooks.
>
> The Makefile seems OK, and the following dmasound symbols appear in the
> symtab:
>
> c01bfabc T dmasound_init
>
> Anything missing, Geert?

Isn't this the problem where dmasound_init() is no longer called? I forgot to
update the #ifdef CONFIG_DMASOUND since I never tried it builtin.

I received a patch to call it on #ifdef CONFIG_DMASOUND_*.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
