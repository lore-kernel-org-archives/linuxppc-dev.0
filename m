Date: Mon, 2 Oct 2000 17:00:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>, Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10010011855010.1560-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10010021659560.1581-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Oct 2000, Michael Schmitz wrote:
> > > Another idea (strictly in the Unix tradition): X knows how to mess up the
> > > PCI config from user space so why shouldn't we, before X gets a shot at
> > > it? 'Just' write the correct mapping to the offending BAR from a rc
> > > script. Obvious drawback: the kernel OF tree won't be updated, and the
> > > kernel can't safeguard against insane BAR settings (at least I can't tell
> > > how that would work, one of the PCI gurus please enlighten me). Makes a
> > > nice local DOS tool.
> > >
> > > (Don't tell me that's been done already - something like PCI PNP utils
> > > for Linux, anyone?)
> >
> > Hmm fixing the resources from userland wont help you, you have to do it
> > before atyfb starts up. If i remember right from your logs X didn't had
> > any problems doing the relocation.
>
> Wrong - X didn't relocate anything, X just disabled one of the overlapping
> regions IIRC (vram with the MMIO mirror region atyfb uses, in my case).
> Even assuming X relocates the vram region, atyfb would never know it.
> That's the root cause of our problem: X changing the PCI config while
> kernel drivers rely on the PCI config remaining unchanged once the driver
> inits.
>
> I know it doesn't sound like it can work, but in this particular case
> (MMIO regs being accessed not via the MMIO PCI mapping but via one of the
> MMIO register mirror areas in video RAM) the user space tool would
> actually work if we relocate the MMIO resource - it's not used by the
> kernel, and the video RAM mapping can remain untouched by X.

Ever tried setpci (from pciutils)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
