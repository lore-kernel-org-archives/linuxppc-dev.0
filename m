Date: Tue, 6 Jun 2000 21:25:35 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Takashi Oe <toe@unlserve.unl.edu>, Michel Lanners <mlan@cpu.lu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <Pine.LNX.4.05.10006031120360.1278-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10006062123240.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Probably XF4 handles fix.smem_start being not on a page boundary
> > > incorrectly.
> >
> > What would it have to do to handle it?
>
> Round down smem_start and mmap() it, and readd the offset. Cfr.
>
>     addr = (unsigned long)mmap(NULL, ati_smem_len, PROT_READ | PROT_WRITE,
> 				MAP_SHARED, fb_fd, 0);
>
>     ati_smem = addr+ati_smem_offset;
>

Basically what we do in fbdev.c since two years or so (first happened on
Mac68k). But I don't think that's it: mmap would have barfed if you feed
it a start address that isn't page aligned.
Maybe a timing problem with the monitor?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
