Date: Sun, 1 Oct 2000 19:02:53 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>, Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.21.0009301652040.2538-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10010011855010.1560-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Another idea (strictly in the Unix tradition): X knows how to mess up the
> > PCI config from user space so why shouldn't we, before X gets a shot at
> > it? 'Just' write the correct mapping to the offending BAR from a rc
> > script. Obvious drawback: the kernel OF tree won't be updated, and the
> > kernel can't safeguard against insane BAR settings (at least I can't tell
> > how that would work, one of the PCI gurus please enlighten me). Makes a
> > nice local DOS tool.
> >
> > (Don't tell me that's been done already - something like PCI PNP utils
> > for Linux, anyone?)
>
> Hmm fixing the resources from userland wont help you, you have to do it
> before atyfb starts up. If i remember right from your logs X didn't had
> any problems doing the relocation.

Wrong - X didn't relocate anything, X just disabled one of the overlapping
regions IIRC (vram with the MMIO mirror region atyfb uses, in my case).
Even assuming X relocates the vram region, atyfb would never know it.
That's the root cause of our problem: X changing the PCI config while
kernel drivers rely on the PCI config remaining unchanged once the driver
inits.

I know it doesn't sound like it can work, but in this particular case
(MMIO regs being accessed not via the MMIO PCI mapping but via one of the
MMIO register mirror areas in video RAM) the user space tool would
actually work if we relocate the MMIO resource - it's not used by the
kernel, and the video RAM mapping can remain untouched by X.

Other solution (on part of X): if relocating one of the two conflicting
resources, pick the one that looks like it isn't video RAM. This only
works with atyfb I guess.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
