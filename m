Message-ID: <39A0EF0C.EDC3D3A1@student.ethz.ch>
Date: Mon, 21 Aug 2000 10:57:48 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
CC: dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <200008190718.JAA00823@piglet.grunz.lu> <399E898A.1564594C@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Michel Lanners wrote:
>
> > On  18 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
> > >> In fact, before, the line length was exactly hpixels * bytes/pixel,
> > >> whereas now there's an additional 0x20 bytes in each line. I have not
> > >> been able to boot a 2.4.0 kernel with any fix applied, but you could try
> > >> and build a version without those 0x20 bytes added (they are found in a
> > >> few spots inside controlfb.c).
> > >>
> > >> As to why these 0x20 bytes were added, anybody know an explanation? And,
> > >> if they do serve a purpose (I suppose so ;-), it would be better to add
> > >> the exact number of bytes as a #define somewhere...
> > >
> > > *sigh*
> > >
> > > I have no idea where this came from, but 0x20 means it has something to
> > > do with cursor support, I'd bet.  I seem to recall someone talking
> > > about that a few months ago... that is how hardware cursor is generally
> > > implemented, by a 32 pixel block at the end of the scanline.
> >
> > That's what I was thinking about. However, I'm not sure that XFree
> > supports a display with discontiguous lines in video memory. I think I
> > read that somewhere in some mailing list or X doc... Can any of the
> > XFree specialists confirm?
>
> It does support that, if not directly then certainly via shadowfb. Maybe the
> shadowfb RefreshArea function would have to be modified to take account of
> this.

That's not even needed, the fbdev driver is just broken. Line 430:

	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */

is indeed wrong. virtualX is obvious, but displayWidth should be the memory
pitch of a scanline.

Now you just have to find out where to get the correct value for displayWidth.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
