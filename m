Date: Mon, 25 Sep 2000 20:39:34 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <reshapiro@mediaone.net>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <Pine.LNX.4.10.10009241541130.421-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0009251945050.1113-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Sep 2000, Geert Uytterhoeven wrote:

>
> On Sun, 24 Sep 2000, Michael Schmitz wrote:
> > >  > 	/* hack */
> > >  > 	pScrn->videoRam = 2048;
> > >  > [...]
> > >  > The hack to unconditionally set pScrn->videoRam to 2M should be removed,
> > >
> > >
> > > The rsync of atimach64ppc.c I got earlier today doesn't have this
> > > unconditonal assignment hack anymore.  The hardwired vram setting
> >
> > It was too obvious to go undetected for long :-). Now if the kernel
> > framebuffer driver (atyfb, and don't check the 'no video driver' option
> > when using BootX) reportds the correct vram size the X server should see
> > the correct size as well.
>
> However, I see a problem. Atyfb reports the video RAM size minus the cursor
> area. If you divide that number of bytes by 1024 to get pScrn->videoRam, you
> end up with 1 MB too few :-(
>

  Hmm does this mean that mmapping the framebuffer doesn't give you the
start of vram but vram+offset ? if yes then we have a big problem here.

BTW you'll end up 1KB too few not 1MB, pScrn->videoRam is in KBytes :)

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
