Date: Mon, 20 Mar 2000 10:47:18 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Lanners <mlan@cpu.lu>
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound split
In-Reply-To: <200003190946.KAA00356@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10003201042240.3507-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > No comments whether it works on PowerMac and Atari?
> > I'd like to let this go in 2.4.0, since a driver for the Q40 is soon to be
> > added.
>
> With all the latest patches applied:
>
> 1. compiled-in doesn't work; it seems the low-level parts are not
> initialised:
>
> Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-slot-0, errno = 2
> Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-service-0-6, errno = 2

Funny enough, this is solved on my Lombard by modprobe dmasound_core &&
modprobe dmasound_awacs. The modules are still around from an eariler
build with modularized dmasound, and still load OK. I'd say the kernel
never tries to initialize the compiled in dmasound so the module can still
register its hooks.

The Makefile seems OK, and the following dmasound symbols appear in the
symtab:

c018788c ? __kstrtab_dmasound
c0187898 ? __kstrtab_dmasound_init
c01878a8 ? __kstrtab_dmasound_write_sq
c01878bc ? __kstrtab_dmasound_read_sq
c01878d0 ? __kstrtab_dmasound_catchRadius
c01878e8 ? __kstrtab_dmasound_ulaw2dma16
c01878fc ? __kstrtab_dmasound_alaw2dma16
c018a664 ? __ksymtab_dmasound
c018a66c ? __ksymtab_dmasound_init
c018a674 ? __ksymtab_dmasound_write_sq
c018a67c ? __ksymtab_dmasound_read_sq
c018a684 ? __ksymtab_dmasound_catchRadius
c018a68c ? __ksymtab_dmasound_ulaw2dma16
c018a694 ? __ksymtab_dmasound_alaw2dma16
c019fd24 D dmasound_ulaw2dma16
c019ff24 D dmasound_alaw2dma16
c01a9f00 D dmasound_catchRadius
c01bfabc T dmasound_init
c01bfb3c t dmasound_setup
c01bfcd8 T awacs_dmasound_init
c01c7bec d __setup_str_dmasound_setup
c01e24c8 ? __setup_dmasound_setup
c025f348 B dmasound
c025f40c B dmasound_read_sq
c025f480 B dmasound_write_sq

Anything missing, Geert?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
