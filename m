Date: Sun, 24 Sep 2000 15:42:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: R Shapiro <reshapiro@mediaone.net>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <Pine.LNX.4.10.10009240021310.17347-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10009241541130.421-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Sep 2000, Michael Schmitz wrote:
> >  > 	/* hack */
> >  > 	pScrn->videoRam = 2048;
> >  > [...]
> >  > The hack to unconditionally set pScrn->videoRam to 2M should be removed,
> >
> >
> > The rsync of atimach64ppc.c I got earlier today doesn't have this
> > unconditonal assignment hack anymore.  The hardwired vram setting
>
> It was too obvious to go undetected for long :-). Now if the kernel
> framebuffer driver (atyfb, and don't check the 'no video driver' option
> when using BootX) reportds the correct vram size the X server should see
> the correct size as well.

However, I see a problem. Atyfb reports the video RAM size minus the cursor
area. If you divide that number of bytes by 1024 to get pScrn->videoRam, you
end up with 1 MB too few :-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
