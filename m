Date: Fri, 29 Sep 2000 21:40:13 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>, Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.21.0009291917490.1084-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10009292135080.7428-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > That's not fixable at the X level (well, technically it is but I can't
> > figure out how and the X people refuse to consider that method). You will
> > need to boot via OF and yaboot (or equivalent oldworld) directly, not via
> > BootX to avoid the PCI resource conflict. Alternative: fix the resource
> > conflict at the kernel level, new patch by me in the works.
>
> Hmm if you think that its fixable in the X level then we should give it
> a try, i can't see how though unless we get X to accept this allocations
> (are they legal ?). Any relocation is going to break the fbdev side since
> there is no way to inform the atyfb driver about this changes.

I think it is fixable at the X PCI probe level, I just don't know how to
do it (can you say entangled web of maze?).

Another idea (strictly in the Unix tradition): X knows how to mess up the
PCI config from user space so why shouldn't we, before X gets a shot at
it? 'Just' write the correct mapping to the offending BAR from a rc
script. Obvious drawback: the kernel OF tree won't be updated, and the
kernel can't safeguard against insane BAR settings (at least I can't tell
how that would work, one of the PCI gurus please enlighten me). Makes a
nice local DOS tool.

(Don't tell me that's been done already - something like PCI PNP utils
for Linux, anyone?)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
