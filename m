Message-ID: <38BC513A.9893292D@pop.agri.ch>
Date: Wed, 01 Mar 2000 00:07:39 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
References: <Pine.LNX.4.10.10002292018001.5514-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Michael Schmitz wrote:
>
> > >The way it fails booting is a bit entertaining: using BootX 1.1.3, it will
> > >show a little more than half a page of messages (arch_exit or similar in
> > >the last), then starts drawing funny color fringes on the screen until I
> > >reset. Using BootX 1.2b3, it locks up after the first six or so lines of
> > >text (before getting to the early console output). 2.3.29 worked fine. Any
> > >ideas?
> >
> > I think I know what's going on:
> >
> >  - make sure setting the display BAT in arch/ppc/mm/init.c (MMU_Init) is
> > commented out, this is a hack and need some alignement tricks to work in
> > all cases. It should already be in #if 0/#endif
>
> Check.
>
> >  - in arch/ppc/kernel/pmac_setup.c, comment out the content of the
> > function pmac_progress. (Or change pmac_init() so that it sets
> > ppc_md.progress to NULL, and set it to pmac_progress only pmac_setup_arch()).
>
> Tried both. I get the arch: exit if I set ppc_md.progress in pmac_setup
> arch. Shortly after this output, the color fringe fun starts again.
>
> I'll strip my .config to the bare minimum to narrow this down. Thanks for
> getting me this far :-)
Well, I wanted to reply earlier, but unfortunately my telco dropped my
line for two hours and I was thinking about having destroied my modems
until I had a look to my /var/log/messages arghhhh.

What I did: I have both trees living around on my PB. I did a diff
against the linux-pmac-devel/arch/ppc and patched the missing things. I
know a bit dangerous, but it did the trick. It's not only the things Ben
mentioned, also the drawx vs. prom_drawx are necessary I think. So it
boots on an Wallstreet I, AND on an ancient pm7200!!

I may post a patch, but I'm not quite satiesfied with since I don't know
at all what's really necessary. Sorry, but I think it's better not to
distribute a wrong patch.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
