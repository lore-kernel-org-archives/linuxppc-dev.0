Message-ID: <398FCA03.5EE01236@relog.ch>
Date: Tue, 08 Aug 2000 10:51:15 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: Michel Dänzer <daenzerm@student.ethz.ch>, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC
 XServer))
References: <Pine.LNX.4.21.0008072058480.21201-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:

> > > [...] you could run the r128 driver without fbdev to get 16 bits, but
> > > the code to switch the framebuffer to do byteswapping is missing so the
> > > colors will be wron (easy to add though).
> >
> > Where and how?
>
>   Somewhere in R128ModeInit (or the functions that get called from it) will
> do fine i think.

I'll be trying in R128{Save,Restore}Crtc... , adding a config field to the
...Save... struct for the CONFIG_CNTL register. Does that make sense?


> About how now look at the following code from aty128fb that does the same
> thing.
>
>     config = aty_ld_le32(CONFIG_CNTL) & ~3;
> #if defined(__BIG_ENDIAN)
>     if (par->crtc.bpp >= 24)
>         config |= 2;    /* make aperture do 32 byte swapping */
>     else if (par->crtc.bpp > 8)
>         config |= 1;    /* make aperture do 16 byte swapping */
> #endif
>     aty_st_le32(CONFIG_CNTL, config);

Thanks, that code also caught my eye this morning on the train :)


Michel


--
Why drink & drive when you can smoke and fly???
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
