Date: Tue, 29 Feb 2000 20:21:25 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
In-Reply-To: <20000229192430.018647@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10002292018001.5514-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >The way it fails booting is a bit entertaining: using BootX 1.1.3, it will
> >show a little more than half a page of messages (arch_exit or similar in
> >the last), then starts drawing funny color fringes on the screen until I
> >reset. Using BootX 1.2b3, it locks up after the first six or so lines of
> >text (before getting to the early console output). 2.3.29 worked fine. Any
> >ideas?
>
> I think I know what's going on:
>
>  - make sure setting the display BAT in arch/ppc/mm/init.c (MMU_Init) is
> commented out, this is a hack and need some alignement tricks to work in
> all cases. It should already be in #if 0/#endif

Check.

>  - in arch/ppc/kernel/pmac_setup.c, comment out the content of the
> function pmac_progress. (Or change pmac_init() so that it sets
> ppc_md.progress to NULL, and set it to pmac_progress only pmac_setup_arch()).

Tried both. I get the arch: exit if I set ppc_md.progress in pmac_setup
arch. Shortly after this output, the color fringe fun starts again.

I'll strip my .config to the bare minimum to narrow this down. Thanks for
getting me this far :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
