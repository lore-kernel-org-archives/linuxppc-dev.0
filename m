Date: Mon, 7 Aug 2000 21:09:12 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
In-Reply-To: <398E61C2.BF0ED1ED@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0008072058480.21201-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, Michel [iso-8859-1] Dänzer wrote:

>
> Kostas Gewrgiou wrote:
>
> > > The remaining problems are:
> > >
> > > 16 bit doesn't work neither with fbdev (colors completely off - does
> > > aty128fb still use 15 bit in fact?) nor without (at least the grey tones
> > > are right there - wrong endianness?)
> >
> > Yes aty128fb still doesn't support 16 bit, you could run the r128 driver
> > without fbdev to get 16 bits, but the code to switch the framebuffer to do
> > byteswapping is missing so the colors will be wrong
>
> Yep, that's the second thing I was referring to.
>
> > (easy to add though).
>
> Where and how?
>

  Somewhere in R128ModeInit (or the functions that get called from it) will
do fine i think.
About how now look at the following code from aty128fb that does the same
thing.

    config = aty_ld_le32(CONFIG_CNTL) & ~3;
#if defined(__BIG_ENDIAN)
    if (par->crtc.bpp >= 24)
        config |= 2;    /* make aperture do 32 byte swapping */
    else if (par->crtc.bpp > 8)
        config |= 1;    /* make aperture do 16 byte swapping */
#endif
    aty_st_le32(CONFIG_CNTL, config);

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
