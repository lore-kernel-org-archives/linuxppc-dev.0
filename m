Message-ID: <39D85ADB.312E1199@student.ethz.ch>
Date: Mon, 02 Oct 2000 11:52:27 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        eich@XFree86.Org, Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.10.10010011855010.1560-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > Another idea (strictly in the Unix tradition): X knows how to mess up
> > > the PCI config from user space so why shouldn't we, before X gets a shot
> > > at it? 'Just' write the correct mapping to the offending BAR from a rc
> > > script. Obvious drawback: the kernel OF tree won't be updated, and the
> > > kernel can't safeguard against insane BAR settings (at least I can't
> > > tell how that would work, one of the PCI gurus please enlighten me).
> > > Makes a nice local DOS tool.
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
>
> Other solution (on part of X): if relocating one of the two conflicting
> resources, pick the one that looks like it isn't video RAM. This only
> works with atyfb I guess.

Yes. If X had to apply a special treatment for each PCI device...

I wouldn't be surprised if it had been a quirk like this which lead to X
acting like it does now.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
