Date: Sat, 3 Jun 2000 11:22:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Takashi Oe <toe@unlserve.unl.edu>, Michel Lanners <mlan@cpu.lu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <3938C6A2.8FB95D17@student.ethz.ch>
Message-ID: <Pine.LNX.4.05.10006031120360.1278-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Jun 2000, Michel Dänzer wrote:
> Geert Uytterhoeven wrote:
> > > XF4's fbdev is not working right for me either.  The weird displacement
> > > occurs on both of display cards (control, matrox) I have.  I think the
> > > current XF4 is of no use for fbdev only people.
> >
> > Probably XF4 handles fix.smem_start being not on a page boundary
> > incorrectly.
>
> What would it have to do to handle it?

Round down smem_start and mmap() it, and readd the offset. Cfr.

    ati_smem_start = (unsigned long)fb_fix.smem_start & PAGE_MASK;
    ati_smem_offset = (unsigned long)fb_fix.smem_start & ~PAGE_MASK;
    ati_smem_len = (ati_smem_offset+fb_fix.smem_len+~PAGE_MASK) & PAGE_MASK;

    addr = (unsigned long)mmap(NULL, ati_smem_len, PROT_READ | PROT_WRITE,
				MAP_SHARED, fb_fd, 0);

    ati_smem = addr+ati_smem_offset;

    ...

    munmap((caddr_t)(ati_smem & PAGE_MASK), ati_smem_len);


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
